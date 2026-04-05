{========================================================================}
{                          N E X U S  Library                            }
{                                                                        }
{     A General-Purpose Library of Routines for Reading and Writing      }
{                      Text Files in NEXUS Format                        }
{                                                                        }  
{                      Version 1.1, December 2019                        }
{                      Version 1.2, December 2025                        }
{                                                                        } 
{          Author: Mauro J. Cavalcanti, Rio de Janeiro, BRASIL           }
{                    E-mail: <maurobio@gmail.com>                        }
{                                                                        } 
{  This program is free software; you can redistribute it and/or modify  }
{  it under the terms of the GNU Lesser General Public License as        }
{  published by the Free Software Foundation; either version 3 of the    }
{  License, or (at your option) any later version.                       }
{                                                                        }
{  This program is distributed in the hope that it will be useful,       }
{  but WITHOUT ANY WARRANTY; without even the implied warranty of        }
{  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         }
{  GNU General Public License for more details.                          }
{========================================================================}
unit Nexus;

{$MODE DELPHI}

interface

uses
  Classes, SysUtils, StrUtils, RegExpr;

const
  { Return value constants }
  dt_OK = 0;
  dt_NexusFileNotFound = -1;
  dt_InvalidNexusFile = -2;
  dt_CharListEmpty = -3;
  dt_ItemListEmpty = -4;
  dt_DirectiveNotFound = -5;
  dt_InvalidDataType = -6;

  { NEXUS directives }
  nexusDirective = '#NEXUS';
  taxaDirective = 'BEGIN TAXA;';
  taxLabelsDirective = 'TAXLABELS';
  charDirective = 'BEGIN CHARACTERS;';
  charLabelsDirective = 'CHARLABELS';
  stateLabelsDirective = 'STATELABELS';
  charStateLabelsDirective = 'CHARSTATELABELS';
  matrixDirective = 'MATRIX';
  treesDirective = 'TREES;';
  dataDirective = 'DATA';
  dataTypeDirective = 'DATATYPE';
  endDirective = 'ENDBLOCK;';
  dimTaxaDirective = 'DIMENSIONS NTAX=';
  dimCharsDirective = 'DIMENSIONS NCHARS=';
  fmtDirective = 'FORMAT DATATYPE=STANDARD GAP=- MISSING=? SYMBOLS="0123456789";';

type
  { Type definitions }

  { Stores a taxon }
  TTaxon = record
    taxonName: string;
    taxonAttributes: TStringList;
  end;

  { A list of taxa }
  TTaxaList = array of TTaxon;

  { Stores a character }
  TCharacter = record
    charName: string;
    charNote: string;
    charStates: TStringList;
  end;

  { A list of characters }
  TCharList = array of TCharacter;

  TNexus = class(TObject)
  public
    TaxaList: TTaxaList;
    CharList: TCharList;
    constructor Create;
    destructor Destroy; override;
    function ReadTaxaBlock(nexusFile: string): integer;
    function ReadCharactersBlock(nexusFile: string): integer;
    function ReadStateLabels(nexusFile: string): integer;
    function ReadMatrix(nexusFile: string): integer;
  end;

var
  LabelsList: TStringList;

{ High-level calls }
function ReadNexus(const nexusFile: string): TNexus;

implementation

function ParseQuotedLabels(const Text: string; Delimiter: char = ' '): TStringList;
var
  i: integer;
  InQuotes: boolean;
  CurrentLabel: string;
begin
  Result := TStringList.Create;
  CurrentLabel := '';
  InQuotes := False;

  i := 1;
  while i <= Length(Text) do
  begin
    if Text[i] = '''' then
    begin
      if InQuotes then
      begin
        // Closing quote
        if (i < Length(Text)) and (Text[i + 1] = '''') then
        begin
          // Escaped quote (two single quotes)
          CurrentLabel := CurrentLabel + '''';
          Inc(i); // Skip the next quote
        end
        else
        begin
          InQuotes := False;
        end;
      end
      else
      begin
        // Opening quote
        InQuotes := True;
      end;
    end
    else if (Text[i] = Delimiter) and not InQuotes then
    begin
      // Delimiter outside quotes - end of current label
      if CurrentLabel <> '' then
      begin
        Result.Add(CurrentLabel);
        CurrentLabel := '';
      end;
    end
    else
    begin
      CurrentLabel := CurrentLabel + Text[i];
    end;
    Inc(i);
  end;

  // Add the last label if any
  if CurrentLabel <> '' then
    Result.Add(CurrentLabel);
end;

{ Internal routines }

function Frequency(const C: char; const S: string): integer;
var
  i: integer;
begin
  Result := 0;
  for i := 1 to Length(S) do
    if S[i] = C then
      Inc(Result);
end;

function IsDigit(Ch: char): boolean;
begin
  Result := Ch in ['0'..'9'];
end;

function IsAlpha(St: string): boolean;
var
  i: integer;
begin
  Result := False;
  for i := 1 to Length(St) do
    Result := not IsDigit(St[i]);
end;

function IsLetter(Ch: char): boolean;
begin
  Result := Ch in ['A'..'Z', 'a'..'z'];
end;

function StripChars(const Text: string; InValidChars: TSysCharSet): string;
var
  S: string;
  i: integer;
begin
  Result := '';
  if (Length(Text) > 0) then
  begin
    S := '';
    for i := 1 to Length(Text) do
      if not CharInSet(Text[i], InValidChars) then
        S := S + Text[i];
    Result := S;
  end;
end;

{ TNexus }

constructor TNexus.Create;
begin
  SetLength(TaxaList, 0);
  SetLength(CharList, 0);
end;

destructor TNexus.Destroy;
var
  RecNo: integer;
begin
  for RecNo := 0 to Length(TaxaList) - 1 do
    TaxaList[RecNo].taxonAttributes.Free;
  for RecNo := 0 to Length(CharList) - 1 do
    CharList[RecNo].charStates.Free;
  inherited Destroy;
end;

{==========================================================================}
{          Reads the NEXUS file and extracts the taxon names               }
{==========================================================================}
function TNexus.ReadTaxaBlock(nexusFile: string): integer;
var
  i, itemCount, NChars: integer;
  nexusFound, itemsFound: boolean;
  line, newLine, names, Name: string;
  infile: TextFile;

  procedure ExpandDataWhenNeeded(RecNo: integer);
  begin
    if (Length(TaxaList) >= RecNo) then
      Exit;
    SetLength(TaxaList, RecNo);
  end;

begin
  itemCount := 0;
  nexusFound := False;
  itemsFound := False;

  NChars := Length(CharList);
  if (NChars = 0) then
  begin
    Result := dt_CharListEmpty;  { List empty }
    Exit;
  end;

  { Open the NEXUS file }
  if FileExists(nexusFile) then
  begin
    AssignFile(infile, nexusFile);
    Reset(infile);
  end
  else
  begin
    Result := dt_NexusFileNotFound;  { File not found }
    Exit;
  end;

  while (not nexusFound) and not EOF(infile) do
  begin
    ReadLn(infile, line);

    { Makes sure that the '#NEXUS' directive is present in the file }
    if (Pos(NEXUSDirective, line) > 0) then
      nexusFound := True;

    { Will run along the items file until it sees a 'BEGIN TAXA;'
    directive, then read in the item names }
    if (nexusFound) then
    begin

      { Read in the TAXA data block }
      while not EOF(infile) do
      begin
        ReadLn(infile, line);
        if (Pos(taxaDirective, line) > 0) then
        begin
          itemsFound := True;
          line := '';
          repeat
            ReadLn(infile, line);
            line := Trim(line);
            if (Pos(endDirective, line) = 0) then
            begin

        (*
        if (Pos(taxLabelsDirective, line) > 0) then
              begin
                names := Copy(line, Pos(' ', line) + 1);
                if (Pos(';', names) = 0) then
                begin
                  names := '';
                  repeat
                    ReadLn(infile, newLine);
                    names := names + ' ' + Trim(newLine);
                  until (Length(newLine) = 0) or (Pos(';', newLine) > 0) or
                    (EOF(infile));
                end;
                RemoveTrailingChars(names, [';']);
                names := Trim(names);
                { Store taxa }
                for i := 1 to Frequency(' ', names) + 1 do
                begin
                  Name := ExtractWord(i, names, [' ']);
                  Inc(itemCount);
                  ExpandDataWhenNeeded(itemCount);
                  TaxaList[itemCount - 1].taxonName := Name;
                  TaxaList[itemCount - 1].taxonAttributes := TStringList.Create;
                end;
                for i := 0 to NChars - 1 do
                  TaxaList[itemCount - 1].taxonAttributes.Add('?');
              end;
        *)

              if (Pos(taxLabelsDirective, line) > 0) then
              begin
                names := Copy(line, Pos(' ', line) + 1);
                if (Pos(';', names) = 0) then
                begin
                  names := '';
                  repeat
                    ReadLn(infile, newLine);
                    names := names + ' ' + Trim(newLine);
                  until (Length(newLine) = 0) or (Pos(';', newLine) > 0) or
                    (EOF(infile));
                end;
                RemoveTrailingChars(names, [';']);
                names := Trim(names);

                { Store taxa using the new parsing function }
                LabelsList := ParseQuotedLabels(names);
                try
                  for i := 0 to LabelsList.Count - 1 do
                  begin
                    Name := LabelsList[i];
                    Inc(itemCount);
                    ExpandDataWhenNeeded(itemCount);
                    TaxaList[itemCount - 1].taxonName := Name;
                    TaxaList[itemCount - 1].taxonAttributes := TStringList.Create;
                  end;
                finally
                  LabelsList.Free;
                end;

                for i := 0 to NChars - 1 do
                  TaxaList[itemCount - 1].taxonAttributes.Add('?');
              end;

            end;
          until (Pos(endDirective, line) > 0) or (EOF(infile));
        end;
      end;
    end;
  end;
  CloseFile(infile);

  { Return the number of taxa in the file, otherwise an error code }
  if itemsFound then
    Result := itemCount
  else
    Result := dt_InvalidNexusFile;  { Invalid file }
end;  { ReadTaxaBlock }

{==========================================================================}
{          Reads the NEXUS file and extracts the character names           }
{==========================================================================}
function TNexus.ReadCharactersBlock(nexusFile: string): integer;
var
  charCount, i: integer;
  nexusFound, charsFound: boolean;
  line, newLine, {dtype,} character, names: string;
  infile: TextFile;

  procedure ExpandDataWhenNeeded(RecNo: integer);
  begin
    if (Length(CharList) >= RecNo) then
      Exit;
    SetLength(CharList, RecNo);
  end;

begin
  charCount := 0;
  nexusFound := False;
  charsFound := False;

  { Open the NEXUS file }
  if FileExists(nexusFile) then
  begin
    AssignFile(infile, nexusFile);
    Reset(infile);
  end
  else
  begin
    Result := dt_NexusFileNotFound;  { File not found }
    Exit;
  end;

  while (not nexusFound) and not EOF(infile) do
  begin
    ReadLn(infile, line);

    { Makes sure that the '#NEXUS' directive is present in the file }
    if (Pos(NEXUSDirective, line) > 0) then
      nexusFound := True;

    { Will run along the items file until it sees a 'BEGIN CHARACTERS;'
    directive, then read in the item names }
    if (nexusFound) then
    begin

      { Read in the CHARACTERS data block }
      while not EOF(infile) do
      begin
        ReadLn(infile, line);
        if (Pos(charLabelsDirective, line) > 0) then
        begin
          if (Pos(';', line) = 0) then
          begin
            names := Copy(line, Pos(' ', line) + 1);
            repeat
              ReadLn(infile, newLine);
              newLine := Trim(newLine);
              names := names + ' ' + newLine;
            until (Length(newLine) = 0) or (Pos(';', newLine) > 0) or (EOF(infile));
          end
          else
            names := Copy(line, Pos(' ', line) + 1);

          RemoveTrailingChars(names, [';']);
          names := Trim(names);

          { Parse quoted character names }
          LabelsList := ParseQuotedLabels(names);
          try
            for i := 0 to LabelsList.Count - 1 do
            begin
              character := LabelsList[i];
              { Store character }
              if (Length(character) > 0) then
              begin
                Inc(charCount);
                ExpandDataWhenNeeded(charCount);
                CharList[charCount - 1].charName := character;
                CharList[charCount - 1].charNote := '';
                CharList[charCount - 1].charStates := TStringList.Create;
              end;
            end;
          finally
            LabelsList.Free;
          end;
        end;

        (*
        if (Pos(charDirective, line) > 0) then
        begin
          charsFound := True;
          repeat
            ReadLn(infile, line);
            line := Trim(line);
            if (Pos(endDirective, line) = 0) then
            begin
              if (Pos(dataTypeDirective, line) > 0) then
              begin
                dtype := Trim(Copy(line, Pos('=', line) + 1, Pos(' ', line) + 1));
                if (Pos('STANDARD', UpperCase(dtype)) = 0) then
                begin
                  Result := dt_InvalidDataType;
                  Exit;
                end;
              end;
              if (Pos(charLabelsDirective, line) > 0) then
              begin
                if (Pos(';', line) = 0) then
                begin
                  repeat
                    ReadLn(infile, newLine);
                    newLine := Trim(newLine);
                    character := ExtractWord(2, newLine, [' ']);
                    character := StripChars(Trim(character), ['''']);
                    RemoveTrailingChars(character, [';']);
                    { Store character }
                    if (Length(character) > 0) then
                    begin
                      Inc(charCount);
                      ExpandDataWhenNeeded(charCount);
                      CharList[charCount - 1].charName := character;
                      CharList[charCount - 1].charNote := '';
                      CharList[charCount - 1].charStates := TStringList.Create;
                    end;
                  until (Length(newLine) = 0) or (Pos(';', newLine) > 0) or
                    (EOF(infile));
                end;
              end;
            end;
          until (Pos(endDirective, line) > 0) or (EOF(infile));
        end;
        *)

      end;
    end;
  end;
  CloseFile(infile);

  { Return the number of characters in the file, otherwise an error code }
  if charsFound then
    Result := charCount
  else
    Result := dt_InvalidNexusFile;  { Invalid file }
end;  { ReadCharactersBlock }

{==========================================================================}
{        Reads the NEXUS file and extracts the character state names       }
{==========================================================================}
function TNexus.ReadStateLabels(nexusFile: string): integer;
var
  j, charCount: integer;
  nexusFound, charsFound: boolean;
  line, newLine, {states,} state, statesLine, CharNum, labels: string;
  infile: TextFile;
begin
  charCount := 0;
  nexusFound := False;
  charsFound := False;

  if (Length(CharList) = 0) then
  begin
    Result := dt_CharListEmpty;  { List empty }
    Exit;
  end;

  { Open the NEXUS file }
  if FileExists(nexusFile) then
  begin
    AssignFile(infile, nexusFile);
    Reset(infile);
  end
  else
  begin
    Result := dt_NexusFileNotFound;  { File not found }
    Exit;
  end;

  while (not nexusFound) and not EOF(infile) do
  begin
    ReadLn(infile, line);

    { Makes sure that the '#NEXUS' directive is present in the file }
    if (Pos(NEXUSDirective, line) > 0) then
      nexusFound := True;

    { Will run along the items file until it sees a 'BEGIN CHARACTERS;'
    directive, then read in the item names }
    if (nexusFound) then
    begin

      { Read in the CHARACTERS data block }
      while not EOF(infile) do
      begin
        ReadLn(infile, line);
        if (Pos(stateLabelsDirective, line) > 0) then
        begin
          if (Pos(';', line) = 0) then
          begin
            statesLine := Copy(line, Pos(' ', line) + 1);
            repeat
              ReadLn(infile, newLine);
              newLine := Trim(newLine);
              statesLine := statesLine + ' ' + newLine;
            until (Length(newLine) = 0) or (Pos(';', newLine) > 0) or (EOF(infile));
          end
          else
            statesLine := Copy(line, Pos(' ', line) + 1);

          RemoveTrailingChars(statesLine, [';']);

          { Parse state labels for current character }
          Inc(charCount);

          { Extract character number and labels }
          CharNum := ExtractWord(1, statesLine, [' ']);
          labels := Copy(statesLine, Length(CharNum) + 2);

          LabelsList := ParseQuotedLabels(labels, ',');
          try
            for j := 0 to LabelsList.Count - 1 do
            begin
              state := LabelsList[j];
              CharList[charCount - 1].charStates.Add(state);
            end;
          finally
            LabelsList.Free;
          end;
        end;


        (*
        if (Pos(charDirective, line) > 0) then
        begin
          charsFound := True;
          repeat
            ReadLn(infile, line);
            line := Trim(line);
            if (Pos(endDirective, line) = 0) then
            begin
              if (Pos(stateLabelsDirective, line) > 0) then
              begin
                if (Pos(';', line) = 0) then
                begin
                  repeat
                    ReadLn(infile, newLine);
                    newLine := Trim(newLine);
                    states := Copy(newLine, Pos(' ', newLine) + 1, Pos(',', newLine));
                    RemoveTrailingChars(states, [',', ';']);
                    { Store state labels }
                    if Length(states) > 0 then
                    begin
                      Inc(charCount);
                      states := StripChars(Trim(states), ['''']);
                      for j := 1 to Frequency(' ', states) + 1 do
                      begin
                        state := ExtractWord(j, states, [' ']);
                        CharList[charCount - 1].charStates.Insert(j - 1, state);
                      end;
                    end;
                  until (Length(newLine) = 0) or (Pos(';', newLine) > 0) or
                    (EOF(infile));
                end;
              end;
            end;
          until (Pos(endDirective, line) > 0) or (EOF(infile));
        end;
        *)

      end;
    end;
  end;
  CloseFile(infile);

  { Return the number of characters in the file, otherwise an error code }
  if charsFound then
    Result := charCount
  else
    Result := dt_InvalidNexusFile;  { Invalid file }
end;  { ReadStateLabels }

{==========================================================================}
{          Reads the NEXUS file and extracts the data matrix               }
{==========================================================================}
function TNexus.ReadMatrix(nexusFile: string): integer;
var
  itemCount, NChars: integer;
  nexusFound, charsFound: boolean;
  line, newLine: string;
  infile: TextFile;
  L: TStringList;

  procedure ExtractData(const AStr: string; const AList: TStringList);
  var
    E: TRegExpr;
  begin
    E := TRegExpr.Create('\(\d+\)|.');
    try
      if E.Exec(AStr) then
        repeat
          if E.Match[0][1] = '(' then
            AList.Append(Copy(E.Match[0], 2, Length(E.Match[0]) - 2))
          else
            AList.Append(E.Match[0]);
        until not E.ExecNext;
    finally
      E.Free;
    end;
  end;

begin
  itemCount := 0;
  nexusFound := False;
  charsFound := False;

  NChars := Length(CharList);
  if (NChars = 0) then
  begin
    Result := dt_CharListEmpty;  { List empty }
    Exit;
  end;

  { Open the NEXUS file }
  if FileExists(nexusFile) then
  begin
    AssignFile(infile, nexusFile);
    Reset(infile);
  end
  else
  begin
    Result := dt_NexusFileNotFound;  { File not found }
    Exit;
  end;

  while (not nexusFound) and not EOF(infile) do
  begin
    ReadLn(infile, line);

    { Makes sure that the '#NEXUS' directive is present in the file }
    if (Pos(NEXUSDirective, line) > 0) then
      nexusFound := True;

    { Will run along the items file until it sees a 'BEGIN CHARACTERS;'
    directive, then read in the item names }
    if (nexusFound) then
    begin

      { Read in the CHARACTERS data block }
      while not EOF(infile) do
      begin
        ReadLn(infile, line);
        if (Pos(charDirective, line) > 0) then
        begin
          charsFound := True;
          repeat
            ReadLn(infile, line);
            line := Trim(line);
            if (Pos(endDirective, line) = 0) then
            begin
              if (Pos(matrixDirective, line) > 0) then
              begin
                if (Pos(';', line) = 0) then
                begin
                  repeat
                    ReadLn(infile, newLine);
                    newLine := Trim(newLine);
                    { Store character data }
                    if IsLetter(newLine[1]) then
                    begin
                      ReadLn(infile, newLine);
                      Inc(itemCount);
                      L := TStringList.Create;
                      ExtractData(Trim(newLine), L);
                      TaxaList[itemCount - 1].taxonAttributes.Assign(L);
                      L.Free;
                    end;
                  until (Length(newLine) = 0) or (Pos(';', newLine) > 0) or
                    (EOF(infile));
                end;
              end;
            end;
          until (Pos(endDirective, line) > 0) or (EOF(infile));
        end;
      end;
    end;
  end;
  CloseFile(infile);

  { Return the number of taxa in the file, otherwise an error code }
  if charsFound then
    Result := itemCount
  else
    Result := dt_InvalidNexusFile;  { Invalid file }
end;  { ReadMatrix }

{==========================================================================}
{                     Reads a full NEXUS dataset                           }
{==========================================================================}
function ReadNexus(const nexusFile: string): TNexus;
var
  ExitCode: integer;
  Dataset: TNexus;
begin
  Dataset := TNexus.Create;
  ExitCode := Dataset.ReadCharactersBlock(nexusFile);
  if (ExitCode < 0) then
    Result := nil;
  ExitCode := Dataset.ReadStateLabels(nexusFile);
  if (ExitCode < 0) then
    Result := nil;
  ExitCode := Dataset.ReadTaxaBlock(nexusFile);
  if (ExitCode < 0) then
    Result := nil;
  ExitCode := Dataset.ReadMatrix(nexusFile);
  if (ExitCode < 0) then
    Result := nil;
  Result := Dataset;
end;  { ReadNexus }

end.

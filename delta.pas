{========================================================================}
{                          D E L T A  Library                            }
{                                                                        }
{     A General-Purpose Library of Routines for Reading and Writing      }
{      Text Files in DELTA (DEscription Language for TAxonomy) Format    }
{                                                                        }
{                      Version 1.0, November 1994                        }
{              Version 2.1, August 1996, Updated May 1998                }
{    Version 3.3, June 2016, Updated July 2020, June 2021, December 2023 }
{                      Version 4.0, March 2025                           }
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
unit Delta;

{$MODE DELPHI}

interface

uses
  Classes, SysUtils, StrUtils, RegExpr;

const
  { Return value constants }
  dt_OK = 0;
  dt_CharsFileNotFound = -1;
  dt_InvalidCharsFile = -2;
  dt_CharListEmpty = -3;
  dt_ItemsFileNotFound = -4;
  dt_InvalidItemsFile = -5;
  dt_ItemListEmpty = -6;
  dt_SpecsFileNotFound = -7;
  dt_DirectiveNotFound = -8;
  dt_NotesFileNotFound = -9;
  dt_InvalidNotesFile = -10;

  { CONFOR directives }
  showDirective = '*SHOW';
  itemDirective = '*ITEM DESCRIPTIONS';
  charDirective = '*CHARACTER LIST';
  typeDirective = '*CHARACTER TYPES';
  noteDirective = '*CHARACTER NOTES';
  dependentDirective = '*DEPENDENT CHARACTERS';
  inapplicableDirective = '*INAPPLICABLE CHARACTERS';
  weightDirective = '*CHARACTER RELIABILITIES';
  mandatoryDirective = '*MANDATORY CHARACTERS';
  implicitDirective = '*IMPLICIT VALUES';
  keyDirective = '*KEY STATES';
  cimgDirective = '*CHARACTER IMAGES';
  timgDirective = '*TAXON IMAGES';
  numCharsDirective = '*NUMBER OF CHARACTERS';
  maxNumStatesDirective = '*MAXIMUM NUMBER OF STATES';
  numStatesDirective = '*NUMBERS OF STATES';
  maxNumItemsDirective = '*MAXIMUM NUMBER OF ITEMS';
  dataBufferSizeDirective = '*DATA BUFFER SIZE';
  subHeadingsDirective = '*ITEM SUBHEADINGS';

  { PANKEY directives }
  headingDirective = '*HEADING';
  altCharDirective = '*CHARACTER DESCRIPTIONS';
  altWeightDirective = '*CHARACTER WEIGHTS';
  endDirective = '*END';

type
  { Type definitions }

  { Stores an item }
  TItem = record
    itemName: string;
    itemComment: string;
    itemAttributes: TStringList;
  end;

  { A list of items }
  TItemList = array of TItem;

  { Stores a character }
  TCharacter = record
    charName: string;
    charType: string;
    charUnit: string;
    charWeight: byte;
    charMandatory: boolean;
    charImplicit: integer;
    charDependent: string; {TStringList;}
    charNote: string;
    charStates: TStringList;
  end;

  { A list of characters }
  TCharacterList = array of TCharacter;

  TDelta = class(TObject)
  public
    Heading: string;
    DataBufferSize: integer;
    ItemList: TItemList;
    CharacterList: TCharacterList;
    constructor Create;
    destructor Destroy; override;
    procedure ReadTitle(anyFile: string);
    function ReadItems(itemsFile: string): integer;
    function ReadChars(charsFile: string): integer;
    function ReadSpecs(specsFile: string; const targetDirective: string): integer;
    function ReadNotes(notesFile: string): integer;
    function WriteChars(charsFile: string): integer;
    function WriteItems(itemsFile: string): integer;
    function WriteSpecs(specsFile: string): integer;
    function WriteNotes(notesFile: string): integer;
  end;

{ High-level calls }
function ReadDelta(const charsFile, itemsFile, specsFile: string;
  cnotesFile: string = ''): TDelta;
procedure WriteDelta(Dataset: TDelta; const charsFile, itemsFile, specsFile: string;
  cnotesFile: string = '');

{ General-purpose routines }
function GetSubHeadings(const specsFile: string): string;
function GetDataBufferSize(const specsFile: string): integer;
function ReadDirective(const specsFile, targetDirective: string;
  getValue: boolean = False): string;
function RemoveComments(const S: string): string;
function OmitTypesettingMarks(const S: string): string;
function OmitInnerComments(const S: string): string;
function CheckBrackets(const str: string): boolean;
function ExpandRange(const Range: string): TStringList;
function CompressRange(const Numbers: string): string;

{ Helper routines }
function Frequency(const C: char; const S: string): integer;
function LastPos(Ch: char; St: string): integer;
function StripChars(const Text: string; InValidChars: TSysCharSet): string;
function Iif(BoolVar: boolean; IfTrue, IfFalse: string): string;
function FirstChar(inString: string): char;
function ExtractText(const Str: string; const Delim1, Delim2: char): string;

implementation

{ Helper routines }

function Frequency(const C: char; const S: string): integer;
var
  i: integer;
begin
  Result := 0;
  for i := 1 to Length(S) do
    if S[i] = C then
      Inc(Result);
end;

function LastPos(Ch: char; St: string): integer;
var
  i: integer;
begin
  i := Length(St);
  while (i > 0) and (St[i] <> Ch) do
    Dec(i);
  Result := i;
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

function Iif(BoolVar: boolean; IfTrue, IfFalse: string): string;
begin
  if BoolVar then
    Result := IfTrue
  else
    Result := IfFalse;
end;

function FirstChar(inString: string): char;
begin
  Result := inString[1];
end;

function ExtractText(const Str: string; const Delim1, Delim2: char): string;
var
  pos1, pos2: integer;
begin
  Result := '';
  pos1 := Pos(Delim1, Str);
  pos2 := Pos(Delim2, Str);
  if (pos1 > 0) and (pos2 > pos1) then
    Result := Copy(Str, pos1 + 1, pos2 - pos1 - 1);
end;

{ TDelta }

constructor TDelta.Create;
begin
  Heading := '';
  DataBufferSize := 0;
  SetLength(ItemList, 0);
  SetLength(CharacterList, 0);
end;

destructor TDelta.Destroy;
var
  RecNo: integer;
begin
  for RecNo := 0 to Length(ItemList) - 1 do
  begin
    if ItemList[RecNo].itemAttributes <> nil then
      ItemList[RecNo].itemAttributes.Free;
  end;
  for RecNo := 0 to Length(CharacterList) - 1 do
  begin
    if CharacterList[RecNo].charStates <> nil then
      CharacterList[RecNo].charStates.Free;
    {if CharacterList[RecNo].charDependent <> nil then
      CharacterList[RecNo].charDependent.Free;}
  end;
  inherited Destroy;
end;

{==========================================================================}
{            Reads any DELTA file and extracts the database name           }
{==========================================================================}
procedure TDelta.ReadTitle(anyFile: string);
var
  Infile: TextFile;
  Line: string;
  title: string[80];

begin
  title := '';

  { Open the items file }
  if FileExists(anyFile) then
  begin
    AssignFile(Infile, anyFile);
    Reset(Infile);
  end
  else
    exit;

  while not EOF(Infile) do
  begin
    ReadLn(Infile, Line);

    { Makes sure that the '*SHOW' directive is present in the file }
    { If not found, look for the '*HEADING' or '(HEADING)' directives }
    if (Pos(showDirective, Line) > 0) then
      title := Copy(Line, Pos(showDirective, Line) + Length(showDirective), 80)
    else if (Pos(headingDirective, Line) > 0) then
      title := Copy(Line, Pos(headingDirective, Line) + Length(headingDirective), 80);

    if (Pos('.', title) > 0) then
      title := Copy(title, 1, Pos('.', title) - 1);
    if (Pos('/', title) > 0) then
      title := Copy(title, 1, Pos('/', title) - 1);
    if (Pos('-', title) > 0) then
      title := Copy(title, 1, Pos('-', title) - 1);
    if (title[1] = ':') then
      title := Copy(title, 2, 80);
    if (Pos(':', title) > 0) then
      title := Copy(title, 1, Pos(':', title) - 1);
    title := Trim(title);
    
    break;
    
  end;
  CloseFile(Infile);

  { Return the title name }
  Heading := title;
end;  { ReadTitle }

{==========================================================================}
{          Reads the ITEMS file and extracts the item names                }
{==========================================================================}
function TDelta.ReadItems(itemsFile: string): integer;
var
  Infile: TextFile;
  Line, Name, junk, Value, token: string;
  itemName, itemComment, itemAttribute: string;
  i, number, itemCount, NChars: integer;
  itemsFound, isComment: boolean;
  ch, aux: char;
  bracketDepth: integer; // Added to track nested brackets

  procedure ExpandDataWhenNeeded(RecNo: integer);
  begin
    if (Length(ItemList) >= RecNo) then
      Exit;
    SetLength(ItemList, RecNo);
  end;

begin
  itemCount := 0;
  itemsFound := False;
  isComment := False;
  bracketDepth := 0; // Initialize bracket depth counter
  token := '';
  junk := '';
  Value := '';

  NChars := Length(CharacterList);
  if (NChars = 0) then
  begin
    ReadItems := dt_CharListEmpty;  { List empty }
    Exit;
  end;

  { Open the items file }
  if FileExists(itemsFile) then
  begin
    AssignFile(Infile, itemsFile);
    Reset(Infile);
  end
  else
  begin
    ReadItems := dt_ItemsFileNotFound;  { File not found }
    Exit;
  end;

  while (not itemsFound) and not EOF(Infile) do
  begin
    ReadLn(Infile, Line);

    { Makes sure that the '*ITEM DESCRIPTIONS' directive
    is present in the file }
    if (Pos(itemDirective, Line) > 0) then
      itemsFound := True;

    { Will run along the ITEMS file until it sees a '#'
    then parse and read in the item descriptions }
    if (itemsFound) then
    begin
      while not EOF(Infile) do
      begin
        Read(Infile, ch);

        { Read the item name }
        if (ch = '#') and (not isComment) then
        begin
          Inc(itemCount);
          Read(Infile, ch);
          ReadLn(Infile, Name);
          RemoveTrailingChars(Name, ['/']);
          if (Pos('<', Name) > 0) then
          begin
            itemName := Trim(Copy(Name, Pos('#', Name) + 1, Pos('<', Name) - 2));
            itemComment := Trim(Copy(Name, Pos('<', Name), Pos('>', Name)));
          end
          else
          begin
            itemName := Trim(Copy(Name, Pos('#', Name) + 1, Length(Name)));
            itemComment := '';
          end;
          { Store item }
          ExpandDataWhenNeeded(itemCount);
          ItemList[itemCount - 1].itemName := itemName;
          ItemList[itemCount - 1].itemComment := itemComment;
          ItemList[itemCount - 1].itemAttributes := TStringList.Create;
          for i := 0 to NChars - 1 do
            ItemList[itemCount - 1].itemAttributes.Add('U');
        end;

        { Read item attributes }
        {case ch of
          '<': isComment := True;
          '>': isComment := False;
        end;}

		{ Read item attributes - modified to handle nested brackets }
        case ch of
          '<': begin
                 if not isComment then bracketDepth := 1
                 else Inc(bracketDepth);
                 isComment := True;
               end;
          '>': if isComment then
               begin
                 Dec(bracketDepth);
                 if bracketDepth = 0 then
                   isComment := False;
               end;
        end;

        if ((ch = ' ') or (ch = #10) or (ch = #13)) and (not isComment) then
        begin
          token := StringReplace(token, #10, #32, [rfReplaceAll]);
          token := StringReplace(token, #13, #32, [rfReplaceAll]);
          token := Trim(token);
          token := DelSpace1(token);

          if (Frequency(',', token) = 1) then
          begin
            aux := token[Pos(',', token) + 1];
            if (aux in ['0'..'9']) then
            begin
              junk := ExtractDelimited(1, token, [',']);
              Value := Copy(token, Pos(',', token) + 1, Length(token));
            end
            else
            begin
              junk := ExtractDelimited(1, token, ['<']);
              Value := Copy(token, Pos('<', token), Length(token));
            end;
          end
          else
          begin
            junk := ExtractDelimited(1, token, ['<']);
            Value := Copy(token, Pos('<', token), Length(token));
          end;

          if (Frequency(',', junk) > 0) then
          begin
            junk := ExtractDelimited(1, token, [',']);
            Value := Copy(token, Pos(',', token) + 1, Length(token));
          end;

          if (Frequency('<', junk) > 0) then
          begin
            Value := Concat(Copy(junk, Pos('<', junk), Length(token)), Value);
            junk := ExtractDelimited(1, junk, ['<']);
          end;

          { Store attribute }
          number := StrToIntDef(junk, 0);
          if (number > 0) then
          begin
            //if (Pos('<<', Value) > 0) then
              //Value := ExtractDelimited(1, Value, ['<']);
              //Value := OmitInnerComments(Value);
            itemAttribute := Value;
            ItemList[itemCount - 1].itemAttributes.Insert(number -
              1, itemAttribute);
          end;
          token := '';
        end;
        token := Concat(token, ch);
      end;
    end;
  end;
  CloseFile(Infile);

  for i := 0 to Length(ItemList) - 1 do
    ItemList[i].itemAttributes.Capacity := NChars;

  { Return the number of items in the file, otherwise an error code }
  if itemsFound then
    ReadItems := itemCount
  else
    ReadItems := dt_InvalidItemsFile;  { Invalid file }
end;  { ReadItems }

{==========================================================================}
{          Reads the CHARS file and extracts the character names           }
{==========================================================================}
function TDelta.ReadChars(charsFile: string): integer;
var
  infile: TextFile;
  Line, charName, stateName: string;
  charCount, RecNo: integer;
  charsFound, isComment, stop: boolean;
  ch: char;

  procedure ExpandDataWhenNeeded(RecNo: integer);
  begin
    if (Length(CharacterList) >= RecNo) then
      Exit;
    SetLength(CharacterList, RecNo);
  end;

  procedure GetCharAndStates;
  begin
    stateName := '';
    isComment := False;
    stop := False;
    while not EoLn(infile) do
    begin
      repeat
        { Read the character names }
        if (ch = '#') then
        begin
          Inc(charCount);
          charName := '';
          repeat
            if EoLn(infile) then
              ReadLn(infile);
            Read(infile, ch);
            case ch of
              '<': isComment := True;
              '>': isComment := False;
            end;
            if (ch <> #13) and (ch <> #10) then
              charName := Concat(charName, ch);
          until (((ch = '/') and not isComment) or EOF(infile));
          RemoveTrailingChars(charName, ['/']);
          charName := Copy(charName, Pos('.', charName) + 1, Length(charName));
          charName := DelSpace1(charName);
          charName := Trim(charName);
          { Store character }
          ExpandDataWhenNeeded(charCount);
          CharacterList[charCount - 1].charName := charName;
          CharacterList[charCount - 1].charType := 'UM';
          CharacterList[charCount - 1].charUnit := '';
          CharacterList[charCount - 1].charNote := '';
          CharacterList[charCount - 1].charWeight := 1;
          CharacterList[charCount - 1].charMandatory := False;
          CharacterList[charCount - 1].charImplicit := 0;
          CharacterList[charCount - 1].charDependent := ''; {TStringList.Create;}
          CharacterList[charCount - 1].charStates := TStringList.Create;
        end;
        { Read the state names }
        Read(infile, ch);
        case ch of
          '<': isComment := True;
          '>': isComment := False;
        end;
        if (ch = '/') and EoLn(infile) then
          stop := True;
        if (ch <> '#') and (ch <> #13) and (ch <> #10) then
          stateName := Concat(stateName, ch);
      until ((stop and not isComment) or EOF(infile));
      //until (((ch = '/') and not isComment) or EOF(infile));
      //until (EoLn(infile) or EOF(infile));
      if Length(stateName) > 0 then
      begin
        RemoveTrailingChars(stateName, ['/']);
        stateName := Copy(stateName, Pos('.', stateName) + 1, Length(stateName));
        stateName := DelSpace1(stateName);
        stateName := Trim(stateName);
        { Stores states }
        CharacterList[charCount - 1].charStates.Add(stateName);
      end;
    end;
  end;

begin
  charName := '';
  charCount := 0;
  charsFound := False;

  { Clear previous data }
  for RecNo := 0 to Length(CharacterList) - 1 do
    CharacterList[RecNo].charStates.Free;
  SetLength(CharacterList, 0);

  { Open the characters file }
  if FileExists(charsFile) then
  begin
    AssignFile(infile, charsFile);
    Reset(infile);
  end
  else
  begin
    ReadChars := dt_CharsFileNotFound;  { File not found }
    exit;
  end;

  while (not charsFound) and not EOF(infile) do
  begin
    ReadLn(infile, Line);

    { Makes sure that the '*CHARACTER LIST' directive is present
    in the file }
    if (Pos(charDirective, Line) > 0) or (Pos(altCharDirective, Line) > 0) then
      charsFound := True;

    { Will run along the characters file until it sees a '#'
    then read in the state names }
    if (charsFound) then
    begin
      while not EOF(infile) do
      begin
        while not EoLn(infile) do
        begin
          Read(infile, ch);
          GetCharAndStates;
          ReadLn(infile);
        end;
        ReadLn(infile);
      end;
    end;
  end;
  CloseFile(infile);

  { Return the number of characters in the file, otherwise an error code }
  if charsFound then
    ReadChars := charCount
  else
    ReadChars := dt_InvalidCharsFile; { Invalid file }
end;  { ReadChars }

{==========================================================================}
{  Reads the SPECS file and extracts the character types, or weights       }
{==========================================================================}
function TDelta.ReadSpecs(specsFile: string; const targetDirective: string): integer;
var
  Infile: TextFile;
  directiveFound: boolean;
  firstChars, nextChars, Buffer: string;
  Character: TCharacter;

  procedure ParseChars(Buffer: string; const targetDirective: string);
  { Parse and read in the character types, weights, or implicit values }
  var
    i, j, nchar, First, last: integer;
    aux, ctype, cdepend, charNum: string;
    cweight, cimpval: byte;
  begin
    if (Length(Buffer) > 0) then
    begin
      Buffer := Trim(Buffer);
      for i := 1 to WordCount(Buffer, StdWordDelims) do
      begin
        aux := ExtractWord(i, Buffer, [' ']);
        if (targetDirective = mandatoryDirective) then
          charNum := aux
        else
          charNum := Copy(aux, 1, Pos(',', aux) - 1);
        if (Pos('-', charNum) > 0) then
        begin
          First := StrToInt(Copy(charNum, 1, Pos('-', charNum) - 1));
          last := StrToInt(Copy(charNum, Pos('-', charNum) + 1, Length(charNum)));
          for j := First to last do
          begin
            nchar := j;
            Character := CharacterList[nchar - 1];
            if (targetDirective = typeDirective) then
            begin
              ctype := Copy(aux, Pos(',', aux) + 1, 2);
              Character.charType := ctype;
              if (ctype = 'IN') or (ctype = 'RN') then
                Character.charUnit :=
                  StringReplace(Character.charStates.Text, #13#10, ' ', [rfReplaceAll]);
            end
            else if (targetDirective = weightDirective) or
              (targetDirective = altWeightDirective) then
            begin
              cweight := StrToInt(Copy(aux, Pos(',', aux) + 1, 2));
              Character.charWeight := cweight;
            end
            else if (targetDirective = dependentDirective) or
              (targetDirective = inapplicableDirective) then
            begin
              cdepend := ExtractDelimited(2, aux, [',']);
              //Character.charDependent.Add(cdepend);
			  Character.charDependent := cdepend;
            end
            else if (targetDirective = implicitDirective) then
            begin
              cimpval := StrToInt(Copy(aux, Pos(',', aux) + 1, 2));
              Character.charImplicit := cimpval;
            end
            else if (targetDirective = mandatoryDirective) then
            begin
              Character.charMandatory := True;
            end;
            CharacterList[nchar - 1] := Character;
          end;
        end
        else
        begin
          if (targetDirective = mandatoryDirective) then
            nchar := StrToIntDef(aux, 0)
          else
            nchar := StrToIntDef(Copy(aux, 1, Pos(',', aux) - 1), 0);
          if (nchar > 0) then
          begin
            Character := CharacterList[nchar - 1];
            if (targetDirective = typeDirective) then
            begin
              ctype := Copy(aux, Pos(',', aux) + 1, 2);
              Character.charType := ctype;
              if (ctype = 'IN') or (ctype = 'RN') then
                Character.charUnit :=
                  StringReplace(Character.charStates.Text, #13#10, ' ', [rfReplaceAll]);
            end
            else if (targetDirective = weightDirective) or
              (targetDirective = altWeightDirective) then
            begin
              cweight := StrToInt(Copy(aux, Pos(',', aux) + 1, 2));
              Character.charWeight := cweight;
            end
            else if (targetDirective = dependentDirective) or
              (targetDirective = inapplicableDirective) then
            begin
              cdepend := ExtractDelimited(2, aux, [',']);
              //Character.charDependent.Add(cdepend);
			  Character.charDependent := cdepend;
            end
            else if (targetDirective = implicitDirective) then
            begin
              cimpval := StrToInt(Copy(aux, Pos(',', aux) + 1, 2));
              Character.charImplicit := cimpval;
            end
            else if (targetDirective = mandatoryDirective) then
            begin
              Character.charMandatory := True;
            end;
            CharacterList[nchar - 1] := Character;
          end;
        end;
      end;
    end;
  end;

begin
  if (Length(CharacterList) = 0) then
  begin
    ReadSpecs := dt_CharListEmpty;  { List empty }
    Exit;
  end;

  { Open the specifications file }
  if FileExists(specsFile) then
  begin
    AssignFile(Infile, specsFile);
    Reset(Infile);
  end
  else
  begin
    ReadSpecs := dt_SpecsFileNotFound;  { File not found }
    Exit;
  end;

  { Make sure that the target directive is present in the file }
  directiveFound := False;
  repeat
    ReadLn(Infile, Buffer);
    if (Pos(targetDirective, Buffer) > 0) then
      directiveFound := True
  until (directiveFound) or EOF(Infile);

  { Read in the character numbers }
  if EOF(Infile) and (not directiveFound) then
  begin
    ReadSpecs := dt_DirectiveNotFound;  { Invalid file }
    CloseFile(Infile);
    Exit;
  end
  else
  begin
    firstChars := Copy(Trim(Buffer), Length(targetDirective) + 1,
      Length(Trim(Buffer)) - Length(targetDirective));
    ParseChars(firstChars, targetDirective);
    repeat
      ReadLn(Infile, nextChars);
      if (Pos('*', nextChars) = 0) then
        ParseChars(nextChars, targetDirective);
    until (Pos('*', nextChars) > 0) or (Length(nextChars) = 0) or EOF(Infile);
  end;

  CloseFile(Infile);
  ReadSpecs := dt_OK;  { File OK }
end;  { ReadSpecs }

{==========================================================================}
{          Reads the CNOTES file and extracts a character note             }
{==========================================================================}
function TDelta.ReadNotes(notesFile: string): integer;
var
  Infile: TextFile;
  TxtLine: string;
  charNumber, noteCount: integer;
  notesFound: boolean;
  Buffer: array [0..2048] of char;
  Character: TCharacter;

  procedure GetNumber(var f: TextFile; var charNumber: integer);
  var
    S: string;
    Ch: char;
  begin
    S := '';
    repeat
      Read(f, Ch);
      if EoLn(f) then
        ReadLn(f);
      if not (Ch in ['#', '.', ' ']) then
        S := S + Ch;
    until (Ch = '.') or EOF(f);
    if (Pos('-', S) > 0) then
      S := Copy(S, 1, Pos('-', S) - 1);
    charNumber := StrToIntDef(S, 0);
  end;

  procedure GetField(var f: TextFile; Buffer: PChar; Size: word);
  var
    I: integer;
    Ch: char;
  begin
    Ch := #0;
    I := 0;
    while ((Ch <> '#') and not EOF(f) and (I < Size)) do
    begin
      Read(f, Ch);
      Buffer[I] := Ch;
      Inc(I);
    end;
    Buffer[I - 1] := Chr(0);
  end;

begin
  noteCount := 0;
  notesFound := False;
  Buffer[0] := Chr(0);
  charNUmber := 0;

  { Open the characters file }
  if FileExists(notesFile) then
  begin
    AssignFile(Infile, notesFile);
    Reset(Infile);
  end
  else
  begin
    ReadNotes := dt_NotesFileNotFound;  { File not found }
    Exit;
  end;

  while (not notesFound) and not EOF(Infile) do
  begin
    ReadLn(Infile, TxtLine);

    { Makes sure that the '*CHARACTER NOTES' directive is present
    in the file }
    if (Pos(noteDirective, TxtLine) > 0) then
      notesFound := True;

    { Will run along the notes file until it sees a '#'
    then read in the character notes }
    if (notesFound) then
    begin
      if EoLn(Infile) then
        ReadLn(Infile);
      while not EOF(Infile) do
      begin
        Inc(noteCount);
        GetNumber(Infile, charNumber);
        GetField(Infile, Buffer, SizeOf(Buffer));
        if (charNumber > 0) then
        begin
          Character := CharacterList[charNumber - 1];
          Character.charNote := Buffer;
          CharacterList[charNumber - 1] := Character;
        end;
      end;
    end;
  end;
  CloseFile(Infile);

  { Return the number of character notes in the file, otherwise an error code }
  if notesFound then
    ReadNotes := noteCount
  else
    ReadNotes := dt_InvalidNotesFile;  { Invalid file }
end;  { ReadNotes }

{==========================================================================}
{                          Writes the CHARS File                           }
{==========================================================================}
function TDelta.WriteChars(charsFile: string): integer;
var
  Outfile: TextFile;
  charStr, stateStr, unitStr: string;
  I, J, numChars: integer;
  Character: TCharacter;

begin
  if (Length(CharacterList) = 0) then
  begin
    WriteChars := dt_CharListEmpty;  { List empty }
    Exit;
  end;

  { Open the output file }
  AssignFile(Outfile, charsFile);
  Rewrite(Outfile);

  { Write header information }
  WriteLn(Outfile, showDirective, ' ', Heading, '. Revised ', DateTimeToStr(Now), '.');
  WriteLn(Outfile);
  WriteLn(Outfile, charDirective);
  WriteLn(Outfile);

  numChars := 0;
  charStr := '';
  stateStr := '';
  unitStr := '';

  { Write characters and states }
  for I := 0 to Length(CharacterList) - 1 do
  begin
    Character := CharacterList[I];
    //if (Character.charType = 'TE') then
    //begin
    //  Character.charName := StripChars(Character.charName, ['<', '>']);
    //  Character.charName := Concat('<', Character.charName, '>');
    //end;
    charStr := Concat('#', IntToStr(I + 1), '. ', Trim(Character.charName), '/');
    WriteLn(Outfile, WrapText(charStr, LineEnding + StringOfChar(' ', 8),
      [' ', #9, '-'], 79));
    if (Character.charType = 'RN') or (Character.charType = 'IN') then
    begin
      if not IsEmptyStr(Character.charUnit, [' ']) then
      begin
        unitStr := Concat(StringOfChar(' ', 7), Trim(Character.charUnit), '/');
        WriteLn(Outfile, unitStr);
      end;
    end;
    if (Character.charType = 'OM') or (Character.charType = 'UM') then
    begin
      for J := 0 to Character.charStates.Count - 1 do
      begin
        stateStr := Concat(StringOfChar(' ', 7), IntToStr(J + 1),
          '. ', Trim(Character.charStates[J]), '/');
        //WriteLn(Outfile, WrapText(stateStr, LineEnding + StringOfChar(' ', 8),
        //  [' ', #9, '-'], 79));
        WriteLn(Outfile, WrapText(stateStr, LineEnding + StringOfChar(' ', 8),
          [' ', #9], 79));
      end;
    end;
    Inc(numChars);
    WriteLn(Outfile);
  end;
  CloseFile(Outfile);

  { Return the number of characters written to the file }
  WriteChars := numChars;
end;  { WriteChars }

{==========================================================================}
{                          Writes the ITEMS File                           }
{==========================================================================}
function TDelta.WriteItems(itemsFile: string): integer;
var
  Outfile: TextFile;
  descStr, comment: string;
  I, J, numItems: integer;
  Item: TItem;
  Character: TCharacter;

begin
  if (Length(ItemList) = 0) then
  begin
    WriteItems := dt_ItemListEmpty;  { List empty }
    Exit;
  end;

  { Open the output file }
  AssignFile(Outfile, itemsFile);
  Rewrite(Outfile);

  { Write header information }
  WriteLn(Outfile, showDirective, ' ', Heading, '. Revised ', DateTimeToStr(Now), '.');
  WriteLn(Outfile);
  WriteLn(Outfile, itemDirective);
  WriteLn(Outfile);

  numItems := 0;
  descStr := '';

  { Write items and attributes }
  for I := 0 to Length(ItemList) - 1 do
  begin
    Item := ItemList[I];
    WriteLn(Outfile, '# ', Item.itemName + Iif(Length(Item.itemComment) >
      0, ' ' + Item.itemComment, '') + '/');
    for J := 0 to Item.itemAttributes.Count - 1 do
    begin
      Character := CharacterList[J];
      if (Item.itemAttributes[J] <> 'U') then
      begin
        if (Character.charType = 'TE') then
          descStr := Concat(descStr, IntToStr(J + 1), '', Item.itemAttributes[J], ' ')
        else
        begin
          if (FirstChar(Item.itemAttributes[J]) = '<') then
          begin
            if Frequency(',', Item.itemAttributes[J]) > 0 then
              descStr := Concat(descStr, IntToStr(J + 1), '',
                Item.itemAttributes[J], ' ')
            else
            begin
              comment := ExtractText(Item.itemAttributes[J], '<', '>');
              descStr := Concat(descStr, IntToStr(J + 1), '<' + comment +
                '>', ',', RemoveComments(Item.itemAttributes[J]), ' ');
            end;
          end
          else
            descStr := Concat(descStr, IntToStr(J + 1), ',',
              Item.itemAttributes[J], ' ');
        end;
      end;
    end;
    WriteLn(Outfile, WrapText(descStr, #13#10, [' '], 79));
    descStr := '';
    WriteLn(Outfile);
    Inc(numItems);
  end;
  CloseFile(Outfile);

  { Return the number of items written to the file }
  WriteItems := numItems;
end;  { WriteItems }

{==========================================================================}
{                          Writes the SPECS File                           }
{==========================================================================}
function TDelta.WriteSpecs(specsFile: string): integer;
var
  Outfile: TextFile;
  typeStr, numStr, valueStr, depStr: string;
  I, J, numChars, numStates, numItems, maxStates, charNum, RetVal: integer;
  //Size, DataBufferSize: integer;
  Character: TCharacter;

begin
  if (Length(CharacterList) = 0) or (Length(ItemList) = 0) then
  begin
    if (Length(CharacterList) = 0) then
      RetVal := dt_CharListEmpty
    else if (Length(ItemList) = 0) then
      RetVal := dt_ItemListEmpty;
    WriteSpecs := RetVal;  { List empty }
    Exit;
  end;

  { Open the output file }
  AssignFile(Outfile, specsFile);
  Rewrite(Outfile);

  numChars := Length(CharacterList);
  numItems := Length(ItemList);

  { Write header information }
  WriteLn(Outfile, showDirective, ' ', Heading, '. Revised ', DateTimeToStr(Now), '.');
  WriteLn(Outfile);
  WriteLn(Outfile, numCharsDirective, ' ', IntToStr(numChars));

  maxStates := 0;
  numStates := 0;

  for I := 0 to Length(CharacterList) - 1 do
  begin
    Character := CharacterList[I];
    if (Character.charType = 'UM') or (Character.charType = 'OM') then
    begin
      numStates := Character.charStates.Count;
      if (numStates > maxStates) then
        maxStates := numStates;
    end;
  end;

  { Write maximum number of states and number of items }
  if (maxStates = 0) then
    maxStates := 2;
  WriteLn(Outfile, maxNumStatesDirective, ' ', IntToStr(maxStates));
  WriteLn(Outfile, maxNumItemsDirective, ' ', IntToStr(numItems));
  WriteLn(Outfile);

  { Compute data buffer size }
  //Size := Length(CharacterList) * 20;
  //if Size > 2000 then
  //  DataBufferSize := Size
  //else
  //  DataBufferSize := 2000;
  //if DataBufferSize = 0 then
  //  DataBufferSize := 2000;
  WriteLn(Outfile, dataBufferSizeDirective, ' ', IntToStr(DataBufferSize));
  WriteLn(Outfile);

  { Write character types }
  Write(Outfile, typeDirective, ' ');
  typeStr := '';
  for I := 0 to Length(CharacterList) - 1 do
  begin
    Character := CharacterList[I];
    if (Character.charType <> 'UM') then
      typeStr := Concat(typeStr, IntToStr(I + 1), ',', Character.charType, ' ');
  end;
  
  if Length(typeStr) = 0 then
	typeStr := '1-' + IntToStr(Length(CharacterList)) + ',UM';
  
  WriteLn(Outfile, WrapText(typeStr, #13#10, [' '], 79));

  { Write number of states }
  if (maxStates > 2) then
  begin
    WriteLn(Outfile);
    Write(Outfile, numStatesDirective, ' ');
    numStates := 0;
    numStr := '';
    for I := 0 to Length(CharacterList) - 1 do
    begin
      Character := CharacterList[I];
      charNum := I + 1;
      if (Character.charType = 'UM') or (Character.charType = 'OM') then
      begin
        numStates := Character.charStates.Count;
        if (numStates > 2) then
          numStr := Concat(numStr, IntToStr(charNum), ',', IntToStr(numStates), ' ');
      end;
    end;
    if (Length(numStr) > 0) then
      WriteLn(Outfile, WrapText(numStr, #13#10, [' '], 79));
  end;

  { Write implicit values }
  WriteLn(Outfile);
  Write(Outfile, implicitDirective, ' ');
  valueStr := '';
  for I := 0 to Length(CharacterList) - 1 do
  begin
    Character := CharacterList[I];
    if (Character.charType = 'UM') or (Character.charType = 'OM') then
    begin
      if (Character.charImplicit > 0) and (Character.charImplicit <= maxStates) then
        valueStr := Concat(valueStr, IntToStr(I + 1), ',',
          IntToStr(Character.charImplicit), ' ');

    end;
  end;
  if (Length(valueStr) > 0) then
    Write(Outfile, WrapText(valueStr, #13#10, [' '], 79));

  { Write dependent characters }
  WriteLn(Outfile);
  WriteLn(Outfile);
  Write(Outfile, dependentDirective, ' ');
  depStr := '';
  for I := 0 to Length(CharacterList) - 1 do
  begin
    Character := CharacterList[I];
    {for J := 0 to Character.charDependent.Count - 1 do
    begin
      depStr := Concat(depStr, IntToStr(I + 1), ',',
        Character.charDependent[J], ' ');
    end;}
	if (Length(Character.charDependent) > 0) then
      depStr := Concat(depStr, IntToStr(I + 1), ',',
        Character.charDependent, ' ');
  end;
  WriteLn(Outfile, WrapText(depStr, #13#10, [' '], 49));
  CloseFile(Outfile);

  WriteSpecs := dt_OK;  { OK }
end;  { WriteSpecs }

{==========================================================================}
{                          Writes the NOTES File                           }
{==========================================================================}
function TDelta.WriteNotes(notesFile: string): integer;
var
  Outfile: TextFile;
  L: word;
  I, J, C: integer;
  Ch: char;
  Buffer: string;
  Character: TCharacter;

begin
  if Length(CharacterList) = 0 then
  begin
    WriteNotes := dt_CharListEmpty;  { List empty }
    Exit;
  end;

  { Open the output file }
  AssignFile(Outfile, notesFile);
  Rewrite(Outfile);

  { Write header information }
  WriteLn(Outfile, showDirective, ' ', Heading, '. Revised ', DateTimeToStr(Now), '.');
  WriteLn(Outfile);
  WriteLn(Outfile, noteDirective);

  C := 0;
  for I := 0 to Length(CharacterList) - 1 do
  begin
    Character := CharacterList[I];
    L := Length(Character.charNote);
    if (L > 0) then
    begin
      Buffer := Character.charNote;
      Inc(C);
      Write(Outfile, '#', IntToStr(I + 1), '.');
      for J := 1 to L do
      begin
        Ch := Buffer[J];
        //if not (Ch in [#0, #13]) then
        if not (Ch = #0) then
          Write(Outfile, Ch);
      end;
    end;
  end;
  Write(Outfile, #10);
  CloseFile(Outfile);

  { Return the number of character notes written to the file }
  WriteNotes := C;
end;  { WriteNotes }

{==========================================================================}
{                     Reads a full DELTA dataset                           }
{==========================================================================}
function ReadDelta(const charsFile, itemsFile, specsFile: string;
  cnotesFile: string = ''): TDelta;
var
  ExitCode: integer;
  Dataset: TDelta;
begin
  Dataset := TDelta.Create;
  Dataset.ReadTitle(specsFile);
  ExitCode := Dataset.ReadChars(charsFile);
  if (ExitCode < 0) then
    Result := nil;
  //Dataset.DataBufferSize := StrToIntDef(readDirective(specsFile,
  //  dataBufferSizeDirective, True), 0);
  Dataset.DataBufferSize := GetDataBufferSize(specsFile);
  ExitCode := Dataset.ReadSpecs(specsFile, typeDirective);
  if (ExitCode < 0) then
    Result := nil;
  ExitCode := Dataset.ReadSpecs(specsFile, implicitDirective);
  if (ExitCode < 0) then
    Result := nil;
  ExitCode := Dataset.ReadSpecs(specsFile, dependentDirective);
  if (ExitCode < 0) then
    Result := nil;
  ExitCode := Dataset.ReadItems(itemsFile);
  if (ExitCode < 0) then
    Result := nil;
  if (Length(cnotesFile) > 0) then
  begin
    ExitCode := Dataset.ReadNotes(cnotesFile);
    if (ExitCode < 0) then
      Result := nil;
  end;
  Result := Dataset;
end;  { ReadDelta }

{==========================================================================}
{                     Writes a full DELTA dataset                          }
{==========================================================================}
procedure WriteDelta(Dataset: TDelta; const charsFile, itemsFile, specsFile: string;
  cnotesFile: string = '');
var
  ExitCode: integer;
begin
  if (Dataset = nil) then
    Exit;
  ExitCode := Dataset.WriteSpecs(specsFile);
  if (ExitCode < 0) then
    Exit;
  ExitCode := Dataset.WriteChars(charsFile);
  if (ExitCode < 0) then
    Exit;
  ExitCode := Dataset.WriteItems(itemsFile);
  if (ExitCode < 0) then
    Exit;
  if (Length(cnotesFile) > 0) then
  begin
    ExitCode := Dataset.WriteNotes(cnotesFile);
    if (ExitCode < 0) then
      Exit;
  end;
end;  { WriteDelta }

{==========================================================================}
{          Read subheadings from a DELTA directives file                   }
{==========================================================================}
function GetSubHeadings(const specsFile: string): string;
var
  dirFile: TextFile;
  txtLine, Number, subHeading: string;
  AList: TStringList;
begin
  if not FileExists(specsFile) then
  begin
    Result := '';
    Exit;
  end;
  AList := TStringList.Create;
  AList.Delimiter := ';';
  AList.QuoteChar := '"';
  AList.StrictDelimiter := True;
  AssignFile(dirFile, specsFile);
  Reset(dirFile);
  while not EOF(dirFile) do
  begin
    ReadLn(dirFile, txtLine);
    if Pos(subHeadingsDirective, txtLine) > 0 then
    begin
      repeat
        ReadLn(dirFile, txtLine);
        Number := Copy(txtLine, 1, Pos('.', txtLine) - 1);
        Number := DelChars(Number, '#');
        subHeading := Trim(Copy(txtLine, Pos('.', txtLine) + 1, Length(txtLine)));
        subHeading := DelChars(subHeading, '.');
        if Length(subHeading) > 0 then
          AList.Add(Number + '. ' + subHeading);
      until (txtLine = '') or (EOF(dirfile));
    end;
  end;
  CloseFile(dirFile);
  if (AList <> nil) then
    Result := AList.DelimitedText
  else
    Result := '';
  AList.Free;
end;  { GetSubHeadings }

{==========================================================================}
{          Read a directive from a DELTA directives file                   }
{==========================================================================}
function GetDataBufferSize(const specsFile: string): integer;
var
  dirFile: TextFile;
  txtLine: string;
  Value: integer;

begin
  if not FileExists(specsFile) then
  begin
    Result := 0;
    Exit;
  end;
  Value := 0;
  AssignFile(dirFile, specsFile);
  Reset(dirFile);
  while not EOF(dirFile) do
  begin
    ReadLn(dirFile, txtLine);
    if Pos(dataBufferSizeDirective, txtLine) > 0 then
      Value := StrToIntDef(Trim(Copy(txtLine, Pos(dataBufferSizeDirective, txtLine) +
        Length(dataBufferSizeDirective), Length(txtLine))), 2000);
  end;
  Result := Value;
  CloseFile(dirFile);
end;

{==========================================================================}
{          Read a directive from a DELTA directives file                   }
{==========================================================================}
function ReadDirective(const specsFile, targetDirective: string;
  getValue: boolean = False): string;
var
  dirFile: TextFile;
  txtLine, Buffer: string;
begin
  if not FileExists(specsFile) then
  begin
    Result := '';
    Exit;
  end;
  AssignFile(dirFile, specsFile);
  Reset(dirFile);
  while not EOF(dirFile) do
  begin
    ReadLn(dirFile, txtLine);
    if Pos(targetDirective, txtLine) > 0 then
    begin
      Buffer := txtLine;
      repeat
        ReadLn(dirFile, txtLine);
        Buffer := Concat(Buffer, txtLine);
      until (txtLine = '') or (EOF(dirfile));
      if getValue then
        Result := Trim(Copy(Buffer, Pos(targetDirective, Buffer) +
          Length(targetDirective), Length(Buffer)))
      else
        Result := Trim(Buffer);
      Break;
    end
    else
      Result := '';
  end;
  CloseFile(dirFile);
end;  { ReadDirective }

{==========================================================================}
{          Remove DELTA style comments (delimited by < >) from a string    }
{==========================================================================}
function RemoveComments(const S: string): string;
var
  i: integer;
  InTag: boolean;
  tmpStr: string;
begin
  tmpStr := '';
  InTag := False;
  for i := 1 to Length(S) do
  begin
    if S[i] = '<' then
      inTag := True
    else if S[i] = '>' then
      inTag := False
    else if not InTag then
      tmpStr := tmpStr + S[i];
  end;
  Result := Trim(DelSpace1(tmpStr));
end;  { RemoveComments }

{==========================================================================}
{          Remove RTF markup from a string                                 }
{==========================================================================}
function OmitTypesettingMarks(const S: string): string;
begin
  Result := ReplaceRegExpr('\\\w+|\{.*?\}|}', S, '', True);
end;  { OmitTypesettingMarks }

{==========================================================================}
{          Remove inner comments                                           }
{==========================================================================}
function OmitInnerComments(const S: string): string;
var
  p1, p2: SizeInt;
  FreeOfInnerTags: string;
begin
  FreeOfInnerTags := S;
  p1 := Pos('<<', S);
  p2 := Pos('>>', S);
  if (p1 > 0) or (p2 > 0) then
  begin
    if (p1 > 0) and (p2 > 0) then
      FreeOfInnerTags := Copy(S, 1, p1) + Copy(S, Succ(p2), MaxInt)
    else if (p2 > 0) then
    begin
      p1 := p2;
      while (p1 > 1) and (S[p1] <> '<') do
        Dec(p1);
      FreeOfInnerTags := Trim(Copy(S, 1, Pred(p1))) + Copy(S, Succ(p2), MaxInt);
    end
    else
    begin
      p2 := p1;
      while (p2 < Length(S)) and (S[p2] <> '>') do
        Inc(p2);
      FreeOfInnerTags := Copy(S, 1, p1) + Trim(Copy(S, Succ(p2), MaxInt));
    end;
    if FreeOfInnerTags = '<>' then
      FreeOfInnerTags := '';
  end;
  Result := FreeOfInnerTags;
end;  { OmitInnerComments }

{==========================================================================}
{          Check opening and closing of brackets                           }
{==========================================================================}
function CheckBrackets(const str: string): boolean;
begin
  if (Pos('<', str) > 0) and (Pos('>', str) < 0) then
    Result := False
  else if (Pos('>', str) > 0) and (Pos('<', str) < 0) then
    Result := False
  else if (Pos('>', str) > 0) and (Pos('<', str) > 0) then
    Result := True;
end;  { CheckBrackets }

{==========================================================================}
{          Expand a range of characters or items numbers                   }
{==========================================================================}
function ExpandRange(const Range: string): TStringList;
var
  I, J, First, Last: word;
  S: string;
  L: TStringList;
begin
  L := TStringList.Create;
  if Pos('-', Range) = 0 then
    L.DelimitedText := Range
  else
  begin
    for I := 0 to WordCount(Range, StdWordDelims) do
    begin
      S := ExtractWord(I, Range, [' ']);
      if Pos('-', S) > 0 then
        if Pos('-', S) > 0 then
        begin
          First := StrToIntDef(Copy(S, 1, Pos('-', S) - 1), 0);
          Last := StrToIntDef(Copy(S, Pos('-', S) + 1, Length(S)), 0);
          for J := First to Last do
            L.Add(IntToStr(J));
        end
        else
          L.Add(S);
    end;
  end;
  Result := L;
end; { ExpandRange }

{==========================================================================}
{          Compress a range of characters or items numbers                 }
{==========================================================================}
function CompressRange(const Numbers: string): string;
var
  iFrom, iTo: SizeInt;
  HighA: SizeInt;
  L: TStringList;
  A: array of integer;
  I, J: integer;
  S: TStringArray;
begin
  S := Numbers.Split([' '], TStringSplitOptions.ExcludeEmpty);
  SetLength(A, Length(S));
  for I := 0 to High(S) do
    if TryStrToInt(S[I], J) then
      A[I] := J;
  L := TStringList.Create;
  try
    L.LineBreak := ' ';
    L.TrailingLineBreak := False;
    iFrom := Low(A);
    HighA := High(A);
    while iFrom <= HighA do
    begin
      iTo := iFrom + 1;
      while (iTo <= HighA) and ((A[iTo] - A[iTo - 1]) = 1) do
        Inc(iTo);
      if (iTo - iFrom) = 1 then
        L.Append(Format('%d', [A[iFrom]]))
      else
        L.Append(Format('%d-%d', [A[iFrom], A[iTo - 1]]));
      iFrom := iTo;
    end;
    for I := 0 to L.Count - 1 do
      if L[I] = '0' then
        L.Delete(I);
    Result := L.Text;
  finally
    L.Free;
  end;
end; { CompressRange }

end.

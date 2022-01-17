unit Prepare;

interface

uses
  Classes, SysUtils, FileUtil, StrUtils, Forms;

procedure CreateSUMMARY(const dirfile, header: string);
procedure CreateTONAT(const dirfile, header: string;
  replace_angle_brackets, omit_character_numbers, omit_inapplicables,
  omit_comments, omit_inner_comments, omit_final_comma, omit_typesetting_marks,
  translate_implicit_values: boolean;
  const omit_lower_for_characters, omit_or_for_characters,
  omit_period_for_characters, new_paragraphs_at_characters, emphasize_features,
  item_subheadings, link_characters, replace_semicolon_by_comma,
  exclude_items, exclude_characters: string; vocabulary: TStringList;
  print_width: integer; ext: string);
procedure CreateTOKEY(const dirfile, header, use_normal_values,
  character_reliabilities, key_states, include_items, include_characters: string);
procedure CreateTOINT(const dirfile, header: string);
procedure CreateTODIS(const dirfile, header: string);
procedure CreateTOHEN(const dirfile, header, key_states, exclude_items,
  exclude_characters, output_file: string);
procedure CreateTONEX(const dirfile, header, key_states, exclude_items,
  exclude_characters, output_file: string);
procedure CreateKEY(const dirfile, header: string;
  add_character_numbers, no_bracketted_key, no_tabular_key: boolean;
  number_of_confirmatory_characters: integer;
  const treat_characters_as_variable: string; abase, rbase, reuse, varywt: real;
  print_width: integer; ext: string);
procedure CreateDIST(const dirfile: string; match_overlap: boolean;
  minimum_comparisons: integer; phylip_format: boolean;
  const exclude_items, exclude_characters: string);
procedure CreateUNCODED(const dirfile, header: string);
procedure CreateINTKEY(const inifile, header: string);
procedure CreatePRINTC(const dirfile, header: string);
procedure CreatePRINTN(const dirfile, header: string);
procedure CreatePRINTI(const dirfile, header: string);
procedure CreateCHECKC(const dirfile: string);
procedure CreateCHECKI(const dirfile: string);
procedure CreateTIMAGES(const dirfile: string);
procedure CreateCIMAGES(const dirfile: string);
procedure CreateCluster(const scriptfile: string; notu, method: integer);
procedure CreatePCOA(const scriptfile: string; notu: integer);
procedure CharactersHtmMarkup;
procedure ItemsHtmMarkup;
procedure DescriptionHtmMarkup(header: string);
procedure KeyHtmMarkup;
procedure CharactersRtfMarkup;
procedure ItemsRtfMarkup;
procedure DescriptionRtfMarkup(header: string);

implementation

uses Main;

{$I resources.inc}

{--------------------------------------------------------------------------}
{          CreateSUMMARY                                                   }
{--------------------------------------------------------------------------}
procedure CreateSUMMARY(const dirfile, header: string);
var
  outfile: TextFile;
begin
  AssignFile(outfile, dirfile);
  Rewrite(outfile);
  WriteLn(outfile, '*SHOW Print summary');
  WriteLn(outfile, '*SHOW Generated on ', DateTimeToStr(Now));
  WriteLn(outfile, '*HEADING ', header);
  WriteLn(outfile, '*PRINT FILE summary.txt');
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE specs');
  WriteLn(outfile);
  WriteLn(outfile, '*PRINT SUMMARY');
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE items');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CreateTONAT                                                     }
{--------------------------------------------------------------------------}
procedure CreateTONAT(const dirfile, header: string;
  replace_angle_brackets, omit_character_numbers, omit_inapplicables,
  omit_comments, omit_inner_comments, omit_final_comma, omit_typesetting_marks,
  translate_implicit_values: boolean;
  const omit_lower_for_characters, omit_or_for_characters,
  omit_period_for_characters, new_paragraphs_at_characters, emphasize_features,
  item_subheadings, link_characters, replace_semicolon_by_comma,
  exclude_items, exclude_characters: string; vocabulary: TStringList;
  print_width: integer; ext: string);
var
  outfile: TextFile;
  I: integer;
  headings: TStringList;
begin
  AssignFile(outfile, dirfile);
  Rewrite(outfile);
  WriteLn(outfile, '*SHOW Translate into natural language');
  WriteLn(outfile, '*SHOW Generated on ', DateTimeToStr(Now));
  WriteLn(outfile, '*HEADING ', header, ' - item descriptions.');
  WriteLn(outfile, '*PRINT FILE description.', ext);
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE specs');
  WriteLn(outfile);
  WriteLn(outfile, '*TRANSLATE INTO NATURAL LANGUAGE');
  WriteLn(outfile);
  if (ext = 'htm') then
  begin
    DescriptionHtmMarkup(header);
    WriteLn(outfile, '*INPUT FILE markhtm');
  end
  else if (ext = 'rtf') then
  begin
    DescriptionRtfMarkup(header);
    WriteLn(outfile, '*INPUT FILE markrtf');
  end;
  WriteLn(outfile);
  if replace_angle_brackets then
    WriteLn(outfile, '*REPLACE ANGLE BRACKETS');
  if omit_character_numbers then
    WriteLn(outfile, '*OMIT CHARACTER NUMBERS');
  if omit_inapplicables then
    WriteLn(outfile, '*OMIT INAPPLICABLES');
  if omit_comments then
    WriteLn(outfile, '*OMIT COMMENTS');
  if omit_inner_comments then
    WriteLn(outfile, '*OMIT INNER COMMENTS');
  if omit_final_comma then
    WriteLn(outfile, '*OMIT FINAL COMMA');
  if omit_typesetting_marks and (ext <> 'rtf') then
    WriteLn(outfile, '*OMIT TYPESETTING MARKS');
  WriteLn(outfile, '*PRINT WIDTH ', IfThen(ext <> 'rtf', IntToStr(print_width), '0'));
  WriteLn(outfile);
  if Length(omit_lower_for_characters) > 0 then
    WriteLn(outfile, WrapText('*OMIT LOWER FOR CHARACTERS ' +
      omit_lower_for_characters, #13#10, [' '], 79), LineEnding);
  if Length(omit_or_for_characters) > 0 then
    WriteLn(outfile, WrapText('*OMIT OR FOR CHARACTERS ' + omit_or_for_characters,
      #13#10, [' '], 79), LineEnding);
  if Length(omit_period_for_characters) > 0 then
    WriteLn(outfile, WrapText('*OMIT PERIOD FOR CHARACTERS ' +
      omit_period_for_characters, #13#10, [' '], 79), LineEnding);
  if Length(new_paragraphs_at_characters) > 0 then
    WriteLn(outfile, WrapText('*NEW PARAGRAPHS AT CHARACTERS ' +
      new_paragraphs_at_characters, #13#10, [' '], 79), LineEnding);
  if Length(emphasize_features) > 0 then
    WriteLn(outfile, WrapText('*EMPHASIZE FEATURES ' + emphasize_features,
      #13#10, [' '], 79), LineEnding);
  if Length(item_subheadings) > 0 then
  begin
    WriteLn(outfile);
    WriteLn(outfile, '*ITEM SUBHEADINGS ');
    headings := TStringList.Create;
    Main.Split(headings, item_subheadings, [';']);
    for I := 1 to headings.Count - 1 do
      WriteLn(outfile, '#', headings[I]);
    headings.Free;
    WriteLn(outfile);
  end;
  if Length(link_characters) > 0 then
    WriteLn(outfile, WrapText('*LINK CHARACTERS ' + link_characters, #13#10, [' '], 79),
      LineEnding);
  if Length(replace_semicolon_by_comma) > 0 then
    WriteLn(outfile, WrapText('*REPLACE SEMICOLON BY COMMA ' +
      replace_semicolon_by_comma, #13#10, [' '], 79), LineEnding);
  if Length(exclude_items) > 0 then
    WriteLn(outfile, WrapText('*EXCLUDE ITEMS ' + exclude_items, #13#10, [' '], 79),
      LineEnding);
  if Length(exclude_characters) > 0 then
    WriteLn(outfile, WrapText('*EXCLUDE CHARACTERS ' + exclude_characters,
      #13#10, [' '], 79));
  WriteLn(outfile);
  for I := 0 to vocabulary.Count - 1 do
    WriteLn(outfile, vocabulary[I]);
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE chars');
  WriteLn(outfile);
  if translate_implicit_values then
    WriteLn(outfile, '*TRANSLATE IMPLICIT VALUES');
  WriteLn(outfile);
  if (ext = 'txt') then
    WriteLn(outfile, '*PRINT HEADING')
  else if (ext = 'rtf') then
  begin
    WriteLn(outfile, '*PRINT COMMENT');
    WriteLn(outfile,
      '\par\pard\plain\s2\qc\sb500\sa400\keepn\b\f2\fs28\kerning28{} Descriptions');
  end
  else if (ext = 'htm') then
  begin
    WriteLn(outfile, '*PRINT COMMENT');
    WriteLn(outfile,
      '<head><meta http-equiv="content-type" content="text/html; charset=utf8">');
    WriteLn(outfile, '<title>', header, '</title></head><body><h3>', header, '</h3>');
    WriteLn(outfile, '<h4>Descriptions</h4>');
  end;
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE items');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CreateTOKEY                                                     }
{--------------------------------------------------------------------------}
procedure CreateTOKEY(const dirfile, header, use_normal_values,
  character_reliabilities, key_states, include_items, include_characters: string);
var
  outfile: TextFile;
begin
  AssignFile(outfile, dirfile);
  Rewrite(outfile);
  WriteLn(outfile, '*SHOW Translate into KEY format');
  WriteLn(outfile, '*SHOW Generated on ', DateTimeToStr(Now));
  WriteLn(outfile, '*HEADING ', header);
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE specs');
  WriteLn(outfile);
  WriteLn(outfile, '*TRANSLATE INTO KEY FORMAT', LineEnding);
  if Length(use_normal_values) > 0 then
    WriteLn(outfile, WrapText('*USE NORMAL VALUES ' + use_normal_values,
      #13#10, [' '], 79), LineEnding);
  if Length(character_reliabilities) > 0 then
    WriteLn(outfile, WrapText('*CHARACTER RELIABILITIES ' +
      character_reliabilities, #13#10, [' '], 79), LineEnding);
  if Length(key_states) > 0 then
    WriteLn(outfile, WrapText('*KEY STATES ' + key_states, #13#10, [' '], 79),
      LineEnding);
  if Length(include_items) > 0 then
    WriteLn(outfile, WrapText('*INCLUDE ITEMS ' + include_items, #13#10, [' '], 79),
      LineEnding);
  if Length(include_characters) > 0 then
    WriteLn(outfile, WrapText('*INCLUDE CHARACTERS ' + include_characters,
      #13#10, [' '], 79));
  WriteLn(outfile);
  WriteLn(outfile, '*KEY OUTPUT FILE kchars');
  WriteLn(outfile, '*INPUT FILE chars');
  WriteLn(outfile);
  WriteLn(outfile, '*KEY OUTPUT FILE kitems');
  WriteLn(outfile, '*INPUT FILE items');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CreateTOINT                                                     }
{--------------------------------------------------------------------------}
procedure CreateTOINT(const dirfile, header: string);
var
  outfile: TextFile;
begin
  AssignFile(outfile, dirfile);
  Rewrite(outfile);
  WriteLn(outfile, '*SHOW Translate into INTKEY format');
  WriteLn(outfile, '*SHOW Generated on ', DateTimeToStr(Now));
  WriteLn(outfile, '*HEADING ', header);
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE specs');
  WriteLn(outfile);
  WriteLn(outfile, '*TRANSLATE INTO INTKEY FORMAT');
  WriteLn(outfile, '*OMIT TYPESETTING MARKS');
  WriteLn(outfile);
  if FileExists('cnotes') then
    WriteLn(outfile, '*INPUT FILE cnotes');
  if FileExists('cimages') then
    WriteLn(outfile, '*INPUT FILE cimages');
  if FileExists('timages') then
    WriteLn(outfile, '*INPUT FILE timages');
  WriteLn(outfile);
  WriteLn(outfile, '*KEY OUTPUT FILE ichars');
  WriteLn(outfile, '*INPUT FILE chars');
  WriteLn(outfile);
  WriteLn(outfile, '*KEY OUTPUT FILE iitems');
  WriteLn(outfile, '*INPUT FILE items');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CreateTODIS                                                     }
{--------------------------------------------------------------------------}
procedure CreateTODIS(const dirfile, header: string);
var
  outfile: TextFile;
begin
  AssignFile(outfile, dirfile);
  Rewrite(outfile);
  WriteLn(outfile, '*SHOW Translate into DIST format');
  WriteLn(outfile, '*SHOW Generated on ', DateTimeToStr(Now));
  WriteLn(outfile, '*HEADING ', header);
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE specs');
  WriteLn(outfile);
  WriteLn(outfile, '*OMIT TYPESETTING MARKS');
  WriteLn(outfile, '*TRANSLATE INTO DISTANCE FORMAT');
  WriteLn(outfile);
  WriteLn(outfile, '*DIST OUTPUT FILE ditems');
  WriteLn(outfile, '*INPUT FILE items');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CreateTOHEN                                                     }
{--------------------------------------------------------------------------}
procedure CreateTOHEN(const dirfile, header, key_states, exclude_items,
  exclude_characters, output_file: string);
var
  outfile: TextFile;
begin
  AssignFile(outfile, dirfile);
  Rewrite(outfile);
  WriteLn(outfile, '*SHOW Translate into TNT format');
  WriteLn(outfile, '*SHOW Generated on ', DateTimeToStr(Now));
  WriteLn(outfile, '*HEADING ', header);
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE specs');
  WriteLn(outfile);
  WriteLn(outfile, '*TRANSLATE INTO HENNIG FORMAT');
  WriteLn(outfile, '*OMIT TYPESETTING MARKS');
  WriteLn(outfile);
  if Length(key_states) > 0 then
    WriteLn(outfile, WrapText('*KEY STATES ' + key_states, #13#10, [' '], 79),
      LineEnding);
  if Length(exclude_items) > 0 then
    WriteLn(outfile, WrapText('*EXCLUDE ITEMS ' + exclude_items, #13#10, [' '], 79),
      LineEnding);
  if Length(exclude_characters) > 0 then
    WriteLn(outfile, WrapText('*EXCLUDE CHARACTERS ' + exclude_characters,
      #13#10, [' '], 79));
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE chars');
  WriteLn(outfile);
  WriteLn(outfile, '*OUTPUT FILE ', output_file);
  WriteLn(outfile, '*INPUT FILE items');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CreateTONEX                                                     }
{--------------------------------------------------------------------------}
procedure CreateTONEX(const dirfile, header, key_states, exclude_items,
  exclude_characters, output_file: string);
var
  outfile: TextFile;
begin
  AssignFile(outfile, dirfile);
  Rewrite(outfile);
  WriteLn(outfile, '*SHOW Translate into Nexus format');
  WriteLn(outfile, '*SHOW Generated on ', DateTimeToStr(Now));
  WriteLn(outfile);
  WriteLn(outfile, '*HEADING ', header);
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE specs');
  WriteLn(outfile);
  WriteLn(outfile, '*TRANSLATE INTO NEXUS FORMAT');
  WriteLn(outfile, '*OMIT TYPESETTING MARKS');
  WriteLn(outfile);
  if Length(key_states) > 0 then
    WriteLn(outfile, WrapText('*KEY STATES ' + key_states, #13#10, [' '], 79),
      LineEnding);
  if Length(exclude_items) > 0 then
    WriteLn(outfile, WrapText('*EXCLUDE ITEMS ' + exclude_items, #13#10, [' '], 79),
      LineEnding);
  if Length(exclude_characters) > 0 then
    WriteLn(outfile, WrapText('*EXCLUDE CHARACTERS ' + exclude_characters,
      #13#10, [' '], 79));
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE chars');
  WriteLn(outfile);
  WriteLn(outfile, '*OUTPUT FILE ', output_file);
  WriteLn(outfile, '*INPUT FILE items');
  WriteLn(outfile);
  WriteLn(outfile, '*OUTPUT PARAMETERS');
  WriteLn(outfile, '#NEXUS');
  WriteLn(outfile, '#DATA');
  WriteLn(outfile, '#DIMENSIONS');
  WriteLn(outfile, '#HEADING');
  WriteLn(outfile, '#FORMAT');
  WriteLn(outfile, '#CHARLABELS');
  WriteLn(outfile, '#STATELABELS');
  WriteLn(outfile, '#MATRIX');
  WriteLn(outfile, '#END');
  WriteLn(outfile, '#ASSUMPTIONS');
  WriteLn(outfile, 'OPTIONS DEFTYPE=unord PolyTCount=MINSTEPS;');
  WriteLn(outfile, '#TYPESET');
  WriteLn(outfile, '#WTSET');
  WriteLn(outfile, '#END');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CreateKEY                                                       }
{--------------------------------------------------------------------------}
procedure CreateKEY(const dirfile, header: string;
  add_character_numbers, no_bracketted_key, no_tabular_key: boolean;
  number_of_confirmatory_characters: integer;
  const treat_characters_as_variable: string; abase, rbase, reuse, varywt: real;
  print_width: integer; ext: string);
var
  outfile: TextFile;
begin
  AssignFile(outfile, dirfile);
  Rewrite(outfile);
  WriteLn(outfile, '*COMMENT Generate dichotomous key.');
  WriteLn(outfile, '*HEADING ', header);
  if (ext = 'txt') then
    WriteLn(outfile, '*KEY OUTPUT FILE key.', ext)
  else if (ext = 'htm') then
  begin
    KeyHtmMarkup;
    WriteLn(outfile, '*KEY TYPESETTING FILE key.', ext);
    WriteLn(outfile);
    WriteLn(outfile, '*INPUT FILE markhtm');
  end;
  {else if (ext = 'rtf') then
  begin
    KeyRtfMarkup;
    WriteLn(outfile, '*KEY TYPESETTING FILE key.', ext);
    WriteLn(outfile);
    WriteLn(outfile, '*INPUT FILE markrtf');
  end;}
  WriteLn(outfile);
  WriteLn(outfile, '*ABASE ', FloatToStr(abase));
  WriteLn(outfile, '*RBASE ', FloatToStr(rbase));
  WriteLn(outfile, '*REUSE ', FloatToStr(reuse));
  WriteLn(outfile, '*VARYWT ', FloatToStr(varywt));
  WriteLn(outfile, '*PRINT WIDTH ', IfThen(ext <> 'rtf', IntToStr(print_width), '0'));
  if add_character_numbers then
    WriteLn(outfile, '*ADD CHARACTER NUMBERS', LineEnding);
  if no_bracketted_key then
    WriteLn(outfile, '*NO BRACKETTED KEY', LineEnding);
  if no_tabular_key then
    WriteLn(outfile, '*NO TABULAR KEY', LineEnding);
  WriteLn(outfile, '*NUMBER OF CONFIRMATORY CHARACTERS ',
    IntToStr(number_of_confirmatory_characters));
  if Length(treat_characters_as_variable) > 0 then
    WriteLn(outfile, WrapText('*TREAT CHARACTERS AS VARIABLE ' +
      treat_characters_as_variable, #13#10, [' '], 79));
  WriteLn(outfile);
  if (ext = 'htm') then
  begin
    WriteLn(outfile, '*PRINT COMMENT');
    WriteLn(outfile,
      '<head><meta http-equiv="content-type" content="text/html; charset=windows-utf8">');
    WriteLn(outfile, '<title>', header, '</title></head><body><h3>', header, '</h3>');
    WriteLn(outfile, '<h4>Key', IfThen(number_of_confirmatory_characters > 0,
      ' - confirmatory characters'), '</h4>');
  end;
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CreateDIST                                                      }
{--------------------------------------------------------------------------}
procedure CreateDIST(const dirfile: string; match_overlap: boolean;
  minimum_comparisons: integer; phylip_format: boolean;
  const exclude_items, exclude_characters: string);
var
  outfile: TextFile;
begin
  AssignFile(outfile, dirfile);
  Rewrite(outfile);
  WriteLn(outfile, '*COMMENT Generate distance matrix.');
  WriteLn(outfile, '*ITEMS FILE ditems');
  WriteLn(outfile, '*OUTPUT FILE dist.dis');
  if Length(exclude_items) > 0 then
    WriteLn(outfile, WrapText('*EXCLUDE ITEMS ' + exclude_items, #13#10, [' '], 79),
      LineEnding);
  if Length(exclude_characters) > 0 then
    WriteLn(outfile, WrapText('*EXCLUDE CHARACTERS ' + exclude_characters,
      #13#10, [' '], 79),
      LineEnding);
  if match_overlap then
    WriteLn(outfile, '*MATCH OVERLAP', LineEnding);
  if minimum_comparisons > 0 then
    WriteLn(outfile, '*MINIMUM NUMBER OF COMPARISONS ',
      IntToStr(minimum_comparisons), LineEnding);
  if phylip_format then
    WriteLn(outfile, '*PHYLIP FORMAT');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CreateUNCODED                                                   }
{--------------------------------------------------------------------------}
procedure CreateUNCODED(const dirfile, header: string);
var
  outfile: TextFile;
begin
  AssignFile(outfile, dirfile);
  Rewrite(outfile);
  WriteLn(outfile, '*SHOW Print uncoded characters');
  WriteLn(outfile, '*SHOW Generated on ', DateTimeToStr(Now));
  WriteLn(outfile, '*HEADING ', header);
  WriteLn(outfile, '*PRINT FILE uncoded.txt');
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE specs');
  WriteLn(outfile);
  WriteLn(outfile, '*PRINT UNCODED CHARACTERS');
  WriteLn(outfile, '*OMIT TYPESETTING MARKS');
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE chars');
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE items');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CreateINTKEY                                                    }
{--------------------------------------------------------------------------}
procedure CreateINTKEY(const inifile, header: string);
var
  outfile: TextFile;
begin
  AssignFile(outfile, inifile);
  Rewrite(outfile);
  WriteLn(outfile, '*COMMENT Intkey initialization file.');
  WriteLn(outfile, '*COMMENT Generated on ', DateTimeToStr(Now));
  WriteLn(outfile, '*COMMENT ', header);
  WriteLn(outfile);
  WriteLn(outfile, '*FILE TAXA iitems');
  WriteLn(outfile, '*FILE CHARACTERS ichars');
  WriteLn(outfile);
  WriteLn(outfile, '*COMMENT Intkey settings.');
  WriteLn(outfile, '*SET RBASE 1.2');
  WriteLn(outfile);
  WriteLn(outfile, '*DISPLAY INAPPLICABLES off');
  WriteLn(outfile, '*DISPLAY UNKNOWNS off');
  WriteLn(outfile);
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CreatePRINTC                                                    }
{--------------------------------------------------------------------------}
procedure CreatePRINTC(const dirfile, header: string);
var
  outfile: TextFile;
begin
  AssignFile(outfile, dirfile);
  Rewrite(outfile);
  WriteLn(outfile, '*SHOW Print the character list - plain text.');
  WriteLn(outfile, '*SHOW Generated on ', DateTimeToStr(Now));
  WriteLn(outfile, '*HEADING ', header);
  WriteLn(outfile, '*PRINT FILE characters.txt');
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE specs');
  WriteLn(outfile);
  WriteLn(outfile, '*PRINT CHARACTER LIST');
  WriteLn(outfile, '*OMIT TYPESETTING MARKS');
  WriteLn(outfile);
  if FileExists('cnotes') then
  begin
    WriteLn(outfile);
    WriteLn(outfile, '*INPUT FILE cnotes');
    WriteLn(outfile);
  end;
  WriteLn(outfile);
  WriteLn(outfile, '*PRINT HEADING');
  WriteLn(outfile, '*PRINT COMMENT. CHARACTER LIST');
  WriteLn(outfile, '*INPUT FILE chars');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CreatePRINTN                                                    }
{--------------------------------------------------------------------------}
procedure CreatePRINTN(const dirfile, header: string);
var
  outfile: TextFile;
begin
  AssignFile(outfile, dirfile);
  Rewrite(outfile);
  WriteLn(outfile, '*SHOW Print the item names - plain text.');
  WriteLn(outfile, '*SHOW Generated on ', DateTimeToStr(Now));
  WriteLn(outfile, '*HEADING ', header);
  WriteLn(outfile, '*PRINT FILE names.txt');
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE specs');
  WriteLn(outfile);
  WriteLn(outfile, '*PRINT ITEM NAMES');
  WriteLn(outfile);
  WriteLn(outfile, '*OMIT TYPESETTING MARKS');
  WriteLn(outfile);
  WriteLn(outfile, '*PRINT HEADING');
  WriteLn(outfile, '*PRINT COMMENT. ITEM NAMES');
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE items');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CreatePRINTI                                                    }
{--------------------------------------------------------------------------}
procedure CreatePRINTI(const dirFile, header: string);
var
  outfile: TextFile;
begin
  AssignFile(outfile, dirfile);
  Rewrite(outfile);
  WriteLn(outfile, '*SHOW Print the items - plain text.');
  WriteLn(outfile, '*SHOW Generated on ', DateTimeToStr(Now));
  WriteLn(outfile, '*HEADING ', header);
  WriteLn(outfile, '*PRINT FILE items.txt');
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE specs');
  WriteLn(outfile);
  WriteLn(outfile, '*PRINT ITEM DESCRIPTIONS');
  WriteLn(outfile);
  WriteLn(outfile, '*OMIT TYPESETTING MARKS');
  WriteLn(outfile);
  WriteLn(outfile, '*PRINT HEADING');
  WriteLn(outfile, '*PRINT COMMENT. ITEM DESCRIPTIONS');
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE items');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CreateCHECKC                                                    }
{--------------------------------------------------------------------------}
procedure CreateCHECKC(const dirfile: string);
var
  outfile: TextFile;
begin
  AssignFile(outfile, dirfile);
  Rewrite(outfile);
  WriteLn(outfile, '*SHOW Check the characters');
  WriteLn(outfile, '*SHOW Generated on ', DateTimeToStr(Now));
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE specs');
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE chars');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CreateCHECKI                                                    }
{--------------------------------------------------------------------------}
procedure CreateCHECKI(const dirFile: string);
var
  outfile: TextFile;
begin
  AssignFile(Outfile, dirFile);
  Rewrite(outfile);
  WriteLn(outfile, '*SHOW Check the items');
  WriteLn(outfile, '*SHOW Generated on ', DateTimeToStr(Now));
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE specs');
  WriteLn(outfile);
  WriteLn(outfile, '*INPUT FILE items');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CreateTIMAGES                                                   }
{--------------------------------------------------------------------------}
procedure CreateTIMAGES(const dirfile: string);
var
  outfile: TextFile;
begin
  AssignFile(outfile, dirfile);
  Rewrite(outfile);
  WriteLn(outfile, '**COMMENT ~ Taxon images.');
  WriteLn(outfile, '*COMMENT Generated on ', DateTimeToStr(Now));
  WriteLn(outfile);
  WriteLn(outfile, '*TAXON IMAGES');
  WriteLn(outfile);
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CreateCIMAGES                                                   }
{--------------------------------------------------------------------------}
procedure CreateCIMAGES(const dirfile: string);
var
  outfile: TextFile;
begin
  AssignFile(outfile, dirfile);
  Rewrite(outfile);
  WriteLn(outfile, '**COMMENT ~ Character images.');
  WriteLn(outfile, '*COMMENT Generated on ', DateTimeToStr(Now));
  WriteLn(outfile);
  WriteLn(outfile, '*CHARACTER IMAGES');
  WriteLn(outfile);
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CreateCluster                                                   }
{--------------------------------------------------------------------------}
procedure CreateCluster(const scriptfile: string; notu, method: integer);
var
  meth: string;
  outfile: TextFile;
begin
  case method of
    0: meth := 'single';
    1: meth := 'complete';
    2: meth := 'average';
    3: meth := 'mcquitty';
    4: meth := 'centroid';
    5: meth := 'median';
    6: meth := 'ward.D2';
  end;
  AssignFile(outfile, scriptfile);
  Rewrite(outfile);
  WriteLn(outfile, 'options(warn=-1)');
  WriteLn(outfile, 'mat <- matrix(0, ', IntToStr(notu), ', ', IntToStr(notu), ')');
  WriteLn(outfile, 'mat[row(mat) >= col(mat)] <- scan("dist.dis")');
  WriteLn(outfile, 'names <- scan("dist.nam", what="character")');
  WriteLn(outfile, 'colnames(mat) <- names');
  WriteLn(outfile, 'df.dist <- as.dist(mat)');
  WriteLn(outfile, 'hc <- hclust(df.dist, method="', meth, '")');
  WriteLn(outfile, 'dc <- cophenetic(hc)');
  WriteLn(outfile, 'r <- cor(df.dist, dc)');
  WriteLn(outfile, 'ppi <- 100');
  WriteLn(outfile, 'png("cluster.png", width=6*ppi, height=6*ppi, res=ppi)');
  WriteLn(outfile, 'par(mar=c(4,4,4,4))');
  WriteLn(outfile,
    'plot(as.dendrogram(hc), xlab="' + strDistance + '", ylab="OTU''s", main=paste("' +
    strDendrogram +
    ' (r = ", format(r, digits=4), ")"), horiz=TRUE, edgePar=list(col="blue", lwd=3))');
  WriteLn(outfile, 'dev.off()');
  WriteLn(outfile, 'options(warn=0)');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CreatePCOA                                                      }
{--------------------------------------------------------------------------}
procedure CreatePCOA(const scriptfile: string; notu: integer);
var
  outfile: TextFile;
begin
  AssignFile(outfile, scriptfile);
  Rewrite(outfile);
  WriteLn(outfile, 'options(warn=-1)');
  WriteLn(outfile, 'mat <- matrix(0, ', IntToStr(notu), ', ', IntToStr(notu), ')');
  WriteLn(outfile, 'mat[row(mat) >= col(mat)] <- scan("dist.dis")');
  WriteLn(outfile, 'names <- scan("dist.nam", what="character")');
  WriteLn(outfile, 'colnames(mat) <- names');
  WriteLn(outfile, 'df.dist <- as.dist(mat)');
  WriteLn(outfile, 'pco <- cmdscale(df.dist, k=2, eig=TRUE)');
  WriteLn(outfile, 'pcovar <- pco$eig / sum(pco$eig[pco$eig > 0])');
  WriteLn(outfile, 'ppi <- 100');
  WriteLn(outfile, 'png("pcoa.png", width=6*ppi, height=6*ppi, res=ppi)');
  WriteLn(outfile, 'par(mar=c(4,4,4,4))');
  WriteLn(outfile,
    'plot(pco$points, main="' + strScatterplot + '", xlab=paste("' +
    strAxis + '1 (", round(pcovar[1], 3)*100, "%)", sep=""), ylab=paste("' +
    strAxis + '2 (", round(pcovar[2], 3)*100, "%)", sep=""), col="blue", pch=19)');
  WriteLn(outfile, 'text(pco$points[,1:2], labels=rownames(pco$points), pos=3, cex=0.7)');
  WriteLn(outfile, 'dev.off()');
  WriteLn(outfile, 'options(warn=0)');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CharactersHtmMarkup                                             }
{--------------------------------------------------------------------------}
procedure CharactersHtmMarkup;
var
  outfile: TextFile;
begin
  AssignFile(outfile, 'markhtm');
  Rewrite(outfile);
  WriteLn(outfile, '*COMMENT ~ Markup for HTML output.');
  WriteLn(outfile);
  WriteLn(outfile, '*OUTPUT FORMAT HTML');
  WriteLn(outfile);
  WriteLn(outfile, '*TYPESETTING MARKS |');
  WriteLn(outfile, '#1. <range symbol>');
  WriteLn(outfile, '|&ndash;|');
  WriteLn(outfile, '#2. <PRINT CHARACTER LIST: before each character (or character heading if');
  WriteLn(outfile, 'present)>');
  WriteLn(outfile,
    '#3. <PRINT CHARACTER LIST: before the first character (or character heading');
  WriteLn(outfile, 'if present) (and before 2) (it was used for TYPSET tabs and indentations)>');
  WriteLn(outfile, '#4. <PRINT CHARACTER LIST: before a character heading>');
  WriteLn(outfile, '|<h4>|');
  WriteLn(outfile, '#5. <PRINT CHARACTER LIST: after a character heading>');
  WriteLn(outfile, '|</h4>|');
  WriteLn(outfile, '#6. <PRINT CHARACTER LIST: before each character>');
  WriteLn(outfile, '|<p class=hanging>|');
  WriteLn(outfile, '#7. <PRINT CHARACTER LIST: before a state description>');
  WriteLn(outfile, '|<p class=hangingxt0>|');
  WriteLn(outfile, '#8. <PRINT CHARACTER LIST: before character notes>');
  WriteLn(outfile, '|<p>|');
  WriteLn(outfile, '#12. <not used>');
  WriteLn(outfile, '#40. <PRINT CHARACTER LIST: after the character list; precedes mark 29>');
  WriteLn(outfile, '||');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          ItemsHtmMarkup                                                  }
{--------------------------------------------------------------------------}
procedure ItemsHtmMarkup;
var
  outfile: TextFile;
begin
  AssignFile(outfile, 'markhtm');
  Rewrite(outfile);
  WriteLn(outfile, '*COMMENT ~ Markup for HTML output.');
  WriteLn(outfile);
  WriteLn(outfile, '*OUTPUT FORMAT HTML');
  WriteLn(outfile);
  WriteLn(outfile, '*TYPESETTING MARKS |');
  WriteLn(outfile, '#1. <range symbol>');
  WriteLn(outfile, '|&ndash;|');
  WriteLn(outfile, '#9. <PRINT ITEM DESCRIPTIONS: before item, with natural language>');
  WriteLn(outfile, '|<p>|');
  WriteLn(outfile, '#10. <PRINT ITEM DESCRIPTIONS: before item, without natural language>');
  WriteLn(outfile, '|<p>|');
  WriteLn(outfile, '#11. <PRINT ITEM DESCRIPTIONS: after item name>');
  WriteLn(outfile, '|<br>|');
  WriteLn(outfile, '#12. <not used>');
  WriteLn(outfile, '#23. <PRINT ITEM NAMES: before item name>');
  WriteLn(outfile, '|<p>|');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          DescriptionHtmMarkup                                            }
{--------------------------------------------------------------------------}
procedure DescriptionHtmMarkup(header: string);
var
  outfile: TextFile;
begin
  AssignFile(outfile, 'markhtm');
  Rewrite(outfile);
  WriteLn(outfile, '*COMMENT ~ Markup for HTML output.');
  WriteLn(outfile);
  WriteLn(outfile, '*OUTPUT FORMAT HTML');
  WriteLn(outfile);
  WriteLn(outfile, '*TYPESETTING MARKS |');
  WriteLn(outfile, '#1. <range symbol>');
  WriteLn(outfile, '|&ndash;|');
  WriteLn(outfile, '#12. <not used>');
  WriteLn(outfile, '#13. <NATURAL LANGUAGE: before each item (or item heading if present)>');
  WriteLn(outfile, '#14. <NATURAL LANGUAGE: before item name if at start of a file>');
  WriteLn(outfile, '|');
  WriteLn(outfile, '<head>');
  WriteLn(outfile, '<meta http-equiv="content-type" content="text/html; charset=utf8">');
  WriteLn(outfile, '<title>');
  WriteLn(outfile, header);
  WriteLn(outfile, '- @NAME');
  WriteLn(outfile, '</title>');
  WriteLn(outfile, '<meta name="description"');
  WriteLn(outfile, 'content="Description of @NAME, generated from a DELTA database.">');
  WriteLn(outfile, '</head>');
  WriteLn(outfile, '<body>');
  WriteLn(outfile);
  WriteLn(outfile, '<h3>');
  WriteLn(outfile, '|');
  WriteLn(outfile, '#15. <NATURAL LANGUAGE: after item name>');
  WriteLn(outfile, '|</h3>|');
  WriteLn(outfile, '#16. <NATURAL LANGUAGE: before a character which begins a new paragraph>');
  WriteLn(outfile, '|<p>|');
  WriteLn(outfile, '#17. <NATURAL LANGUAGE: before an emphasized feature>');
  WriteLn(outfile, '|<i>|');
  WriteLn(outfile, '#18. <NATURAL LANGUAGE: after an emphasized feature>');
  WriteLn(outfile, '|</i>|');
  WriteLn(outfile, '#19. <NATURAL LANGUAGE: before an emphasized character>');
  WriteLn(outfile, '|<b>|');
  WriteLn(outfile, '#20. <NATURAL LANGUAGE: after an emphasized character>');
  WriteLn(outfile, '|</b>|');
  WriteLn(outfile, '#21. <NATURAL LANGUAGE: before an emphasized state description>');
  WriteLn(outfile, '|<b>|');
  WriteLn(outfile, '#22. <NATURAL LANGUAGE: after an emphasized state description>');
  WriteLn(outfile, '|</b>|');
  WriteLn(outfile, '#25. <NATURAL LANGUAGE: before a non-comment section of an item name>');
  WriteLn(outfile, '#26. <NATURAL LANGUAGE: after non-comment section of an item name>');
  WriteLn(outfile, '#27. <NATURAL LANGUAGE: after each item; precedes mark 29>');
  WriteLn(outfile, '||');
  WriteLn(outfile, '#28. <NATURAL LANGUAGE, KEY: at the start of each file>');
  WriteLn(outfile, '|');
  WriteLn(outfile, '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">');
  WriteLn(outfile, '<html>');
  WriteLn(outfile, '|');
  WriteLn(outfile, '#29. <NATURAL LANGUAGE: after the last item in a file; follows mark 27.');
  WriteLn(outfile, '   PRINT CHARACTER LIST: after the character list; follows mark 40.');
  WriteLn(outfile, '   KEY: at the end of the key file; follows mark 50>');
  WriteLn(outfile, '</body>');
  WriteLn(outfile, '</html>');
  WriteLn(outfile, '|');
  WriteLn(outfile, '#30. <NATURAL LANGUAGE: before item heading>');
  WriteLn(outfile, '#31. <NATURAL LANGUAGE: after item heading>');
  WriteLn(outfile, '#32. <NATURAL LANGUAGE: before item subheading>');
  WriteLn(outfile, '|<span class=itemsubheading><b>|');
  WriteLn(outfile, '#33. <NATURAL LANGUAGE: after item subheading>');
  WriteLn(outfile, '|</b></span>|');
  WriteLn(outfile, '#34. <NATURAL LANGUAGE: before output file name in index file>');
  WriteLn(outfile, '|&bull;&nbsp;<a href="www/|');
  WriteLn(outfile,
    '#35. <NATURAL LANGUAGE: between output file name and taxon name in index file>');
  WriteLn(outfile, '|">|');
  WriteLn(outfile, '#36. <NATURAL LANGUAGE: after taxon name in index file>');
  WriteLn(outfile, '|</a>|');
  WriteLn(outfile,
    '#37. <NATURAL LANGUAGE: before image file name in "character for taxon images">');
  WriteLn(outfile, '|&bull;&nbsp;<a href="|');
  WriteLn(outfile, '#38. <NATURAL LANGUAGE: between image file name and subject>');
  WriteLn(outfile, '|">|');
  WriteLn(outfile, '#39. <NATURAL LANGUAGE: after subject in "character for taxon images">');
  WriteLn(outfile, '|</a>|');
  WriteLn(outfile, '#51. <NATURAL LANGUAGE: before item name if not at start of a file>');
  WriteLn(outfile, '|<h3>|');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          KeyHtmMarkup                                                    }
{--------------------------------------------------------------------------}
procedure KeyHtmMarkup;
var
  outfile: TextFile;
begin
  AssignFile(outfile, 'markhtm');
  Rewrite(outfile);
  WriteLn(outfile, '*COMMENT ~ Markup for HTML output.');
  WriteLn(outfile);
  WriteLn(outfile, '*OUTPUT FORMAT HTML');
  WriteLn(outfile);
  WriteLn(outfile, '*TYPESETTING MARKS |');
  WriteLn(outfile, '#1. <range symbol>');
  WriteLn(outfile, '|&ndash;|');
  WriteLn(outfile, '#12. <not used>');
  WriteLn(outfile, '#41. <KEY: parameters>');
  WriteLn(outfile, '|');
  WriteLn(outfile, '<p><i>Characters:</i> @nchar in data, @ncincl included, @ncinkey in key.');
  WriteLn(outfile, '<br><i>Items:</i> @ntaxa in data, @ntincl included, @ntinkey in key.');
  WriteLn(outfile,
    '<br><i>Parameters:</i> Rbase = @rbase Abase = @abase Reuse = @reuse Varywt = @varywt');
  WriteLn(outfile, '<br><i>Characters included:</i> @cmask');
  WriteLn(outfile, '|');
  WriteLn(outfile, '#42. <KEY: first lead of first node of key>');
  WriteLn(outfile, '|');
  WriteLn(outfile, '<p><table cellspacing=0 cellpadding=0 width=100%><tr valign="top">');
  WriteLn(outfile, '<td width=6%><a name="@node">@node</a>(0).</td>');
  WriteLn(outfile, '<td><ul type="disc">');
  WriteLn(outfile, '<li>@state');
  WriteLn(outfile, '|');
  WriteLn(outfile, '#43. <KEY: first lead of any node of key except the first node>');
  WriteLn(outfile, '|');
  WriteLn(outfile, '<p><table cellspacing=0 cellpadding=0 width=100%><tr valign="top">');
  WriteLn(outfile, '<td width=6%><a name="@node">@node</a>(<a href="#@from">@from</a>).</td>');
  WriteLn(outfile, '<td><ul type="disc">');
  WriteLn(outfile, '<li>@state');
  WriteLn(outfile, '|');
  WriteLn(outfile, '#44. <KEY: subsequent lead of any node>');
  WriteLn(outfile, '|<li>@state|');
  WriteLn(outfile, '#45. <KEY: first destination of a lead which is a taxon name>');
  WriteLn(outfile, '| ...&nbsp;<b>@to</b>|');
  WriteLn(outfile, '#46. <KEY: subsequent destination of a lead (which must be a taxon name)>');
  WriteLn(outfile, '|,&nbsp;<b>@to</b>|');
  WriteLn(outfile, '#47. <KEY: after taxon name(s)>');
  WriteLn(outfile, '|</li>|');
  WriteLn(outfile, '#48. <KEY: destination of a lead which is a node of the key>');
  WriteLn(outfile, '| ...&nbsp;<a href="#@to">@to</a></li>|');
  WriteLn(outfile, '#49. <KEY: after each node>');
  WriteLn(outfile, '|</ul></td></tr></table>|');
  WriteLn(outfile, '#50. <KEY: at end of key; precedes mark 29>');
  WriteLn(outfile, '||');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          CharactersRtfMarkup                                             }
{--------------------------------------------------------------------------}
procedure CharactersRtfMarkup;
var
  outfile: TextFile;
begin
  AssignFile(outfile, 'markrtf');
  Rewrite(outfile);
  WriteLn(outfile, '*COMMENT ~ Markup for RTF output.');
  WriteLn(outfile);
  WriteLn(outfile, '*PRINT WIDTH 0');
  WriteLn(outfile);
  WriteLn(outfile, '*TYPESETTING MARKS !');
  WriteLn(outfile, '#1. <range symbol>');
  WriteLn(outfile, '!–!');
  WriteLn(outfile, '#2. <PRINT CHARACTER LIST: before each character (or character heading if');
  WriteLn(outfile, 'present)>');
  WriteLn(outfile,
    '#3. <PRINT CHARACTER LIST: before the first character (or character heading');
  WriteLn(outfile, 'if present) (and before 2) (it was used for TYPSET tabs and indentations)>');
  WriteLn(outfile, '#4. <PRINT CHARACTER LIST: before a character heading>');
  WriteLn(outfile, '!\par\pard\plain\s10\ql\sb300\sa100\li0\fi0\keep\keepn\b\fs24{}!');
  WriteLn(outfile, '#5. <PRINT CHARACTER LIST: after a character heading>');
  WriteLn(outfile);
  WriteLn(outfile, '#6. <PRINT CHARACTER LIST: before each character>');
  WriteLn(outfile, '!\par\pard\plain\s11\ql\sb0\sa0\li705\fi-705\fs22{}!');
  WriteLn(outfile, '#7. <PRINT CHARACTER LIST: before a state description>');
  WriteLn(outfile, '!\par\pard\plain\s12\ql\sb0\sa0\li705\fi-200\fs22{}!');
  WriteLn(outfile, '#8. <PRINT CHARACTER LIST: before character notes>');
  WriteLn(outfile, '!\par\pard\plain\s13\ql\sb0\sa0\li505\fi400\fs22{}!');
  WriteLn(outfile, '#12. <not used>');
  WriteLn(outfile, '#40. <PRINT CHARACTER LIST: after the character list; precedes mark 29>');
  WriteLn(outfile);
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          ItemsRtfMarkup                                                  }
{--------------------------------------------------------------------------}
procedure ItemsRtfMarkup;
var
  outfile: TextFile;
begin
  AssignFile(outfile, 'markrtf');
  Rewrite(outfile);
  WriteLn(outfile, '*COMMENT ~ Markup for RTF output.');
  WriteLn(outfile);
  WriteLn(outfile, '*PRINT WIDTH 0');
  WriteLn(outfile);
  WriteLn(outfile, '*TYPESETTING MARKS !');
  WriteLn(outfile, '#1. <range symbol>');
  WriteLn(outfile, '!–!');
  WriteLn(outfile, '#9. <PRINT ITEM DESCRIPTIONS: before item, with natural language>');
  WriteLn(outfile, '!\par\pard\plain\ql\sb300\sa0\keepn\fs22{}!');
  WriteLn(outfile, '#10. <PRINT ITEM DESCRIPTIONS: before item, without natural language>');
  WriteLn(outfile, '!\par\pard\plain\ql\sb300\sa0\keepn\fs22{}!');
  WriteLn(outfile, '#11. <PRINT ITEM DESCRIPTIONS: after item name>');
  WriteLn(outfile, '!\par\pard\plain\ql\sb0\sa0\fs22{}!');
  WriteLn(outfile, '#12. <not used>');
  WriteLn(outfile, '#23. <PRINT ITEM NAMES: before item name>');
  WriteLn(outfile, '!\par\pard\plain\ql\sb0\sa0\fs22{}!');
  CloseFile(outfile);
end;

{--------------------------------------------------------------------------}
{          DescriptionRtfMarkup                                            }
{--------------------------------------------------------------------------}
procedure DescriptionRtfMarkup(header: string);
var
  outfile: TextFile;
begin
  AssignFile(outfile, 'markrtf');
  Rewrite(outfile);
  WriteLn(outfile, '*COMMENT ~ Markup for RTF output.');
  WriteLn(outfile);
  WriteLn(outfile, '*PRINT WIDTH 0');
  WriteLn(outfile);
  WriteLn(outfile, '*TYPESETTING MARKS !');
  WriteLn(outfile, '#1. <range symbol>');
  WriteLn(outfile, '!–!');
  WriteLn(outfile, '#12. <not used>');
  WriteLn(outfile, '#13. <NATURAL LANGUAGE: before each item (or item heading if present)>');
  WriteLn(outfile, '#14. <NATURAL LANGUAGE: before item name if at start of a file>');
  WriteLn(outfile, '!\pard\plain\s21\ql\sb0\sa100\li0\fi0\keep\keepn\b\fs24\f2{}!');
  WriteLn(outfile, '#15. <NATURAL LANGUAGE: after item name>');
  WriteLn(outfile, '!\f0\fs22\b0{}!');
  WriteLn(outfile, '#16. <NATURAL LANGUAGE: before a character which begins a new paragraph>');
  WriteLn(outfile, '!\par\pard\plain\qj\s22\sb0\sa0\li0\fi340\fs22{}!');
  WriteLn(outfile, '#17. <NATURAL LANGUAGE: before an emphasized feature>');
  WriteLn(outfile, '!\i{}!');
  WriteLn(outfile, '#18. <NATURAL LANGUAGE: after an emphasized feature>');
  WriteLn(outfile, '!\i0{}!');
  WriteLn(outfile, '#19. <NATURAL LANGUAGE: before an emphasized character>');
  WriteLn(outfile, '!\b{}!');
  WriteLn(outfile, '#20. <NATURAL LANGUAGE: after an emphasized character>');
  WriteLn(outfile, '!\b0{}!');
  WriteLn(outfile, '#21. <NATURAL LANGUAGE: before an emphasized state description>');
  WriteLn(outfile, '!\b{}!');
  WriteLn(outfile, '#22. <NATURAL LANGUAGE: after an emphasized state description>');
  WriteLn(outfile, '!\b0{}!');
  WriteLn(outfile, '#23. <PRINT ITEM NAMES: before item name>');
  WriteLn(outfile, '!\par\pard\plain\ql\sb0\sa0\fs22{}!');
  WriteLn(outfile, '#24. <PRINT UNCODED CHARACTERS: before list of uncoded characters>');
  WriteLn(outfile, '!\par\pard\ql\sb200\sa0{}!');
  WriteLn(outfile, '#25. <NATURAL LANGUAGE: before a non-comment section of an item name>');
  WriteLn(outfile, '#26. <NATURAL LANGUAGE: after non-comment section of an item name>');
  WriteLn(outfile, '#27. <NATURAL LANGUAGE: after each item; precedes mark 29>');
  WriteLn(outfile,
    '#28. <NATURAL LANGUAGE: at the start of each file. N.B. Don''t allow style names');
  WriteLn(outfile,
    'to wrap, otherwise white space is omitted. Australian English, A4 paper, margins');
  WriteLn(outfile, '2.5cm:');
  WriteLn(outfile,
    '\deflang3081\paperw11906\paperh16838\margl1418\margr1418\margt1418\margb1418{}');
  WriteLn(outfile, 'US English, Letter paper, margins 1":');
  WriteLn(outfile,
    '\deflang1033\paperw12242\paperh15842\margl1440\margr1440\margt1440\margb1440{} >');
  WriteLn(outfile, '!{\rtf1\ansi\ansicpg1252\uc1\deff0{}');
  WriteLn(outfile,
    '\deflang1033\paperw12242\paperh15842\margl1440\margr1440\margt1440\margb1440{}');
  WriteLn(outfile, '{\fonttbl');
  WriteLn(outfile, '{\f0\froman\fcharset0\fprq2{}Times New Roman;}');
  WriteLn(outfile, '{\f1\froman\fcharset2\fprq2{}Symbol;}');
  WriteLn(outfile, '{\f2\fswiss\fcharset0\fprq2{}Arial;}');
  WriteLn(outfile, '}');
  WriteLn(outfile, '{\stylesheet');
  WriteLn(outfile, '{\qj\fi340\fs22\snext0{}Normal;}');
  WriteLn(outfile,
    '{\s1\qc\sb500\sa100\keepn\b\f2\fs32\kerning28\sbasedon0\snext0{}Heading 1;}');
  WriteLn(outfile,
    '{\s2\qc\sb500\sa100\keepn\b\f2\fs28\kerning28\sbasedon0\snext0{}Heading 2;}');
  WriteLn(outfile, '{\s3\ql\sb500\sa100\keepn\b\f2\fs24\sbasedon0\snext0{}Heading 3;}');
  WriteLn(outfile, '{\s6\ql\sb0\sa0\li340\fi-340\fs22\sbasedon0{}References;}');
  WriteLn(outfile,
    '{\s10\ql\sb300\sa100\li0\fi0\keep\keepn\b\fs24\sbasedon0{}Character Heading;}');
  WriteLn(outfile, '{\s11\ql\sb0\sa0\li705\fi-705\fs22\sbasedon0{}Feature;}');
  WriteLn(outfile, '{\s12\ql\sb0\sa0\li705\fi-200\fs22\sbasedon0{}State;}');
  WriteLn(outfile, '{\s13\ql\sb0\sa0\li505\fi400\fs22\sbasedon0{}Character Note;}');
  WriteLn(outfile, '{\s20\qc\sb300\sa0\li0\fi0\keep\keepn\fs24\sbasedon0{}Taxon Heading;}');
  WriteLn(outfile, '{\s21\ql\sb300\sa100\li0\fi0\keep\keepn\b\fs24\sbasedon0{}Taxon Name;}');
  WriteLn(outfile, '{\s22\qj\sb0\sa0\li0\fi340\fs22\sbasedon0{}Description;}');
  WriteLn(outfile, '{\s23\fi-300\li300\keep\keepn\b\fs22\sbasedon0\snext0\sautoupd{}toc 1;}');
  WriteLn(outfile, '{\s24\fi-300\li450\keep\fs22\sbasedon0\snext0\sautoupd{}toc 2;}');
  WriteLn(outfile, '{\s30\ql\sb0\sa0\fi-907\li907\tx680\tqr\tldot\tx9072\fs22\sbasedon0{}Key;}');
  WriteLn(outfile, '{\s31\ql\sb100\sa0\fi-907\li907\tx680\tqr\tldot\tx9072\fs22');
  WriteLn(outfile, '\sbasedon30{}Key First Lead;}');
  WriteLn(outfile, '}');
  WriteLn(outfile, '\widowctrl{}!');
  WriteLn(outfile, '#29. <NATURAL LANGUAGE: after the last item in a file; follows mark 27.');
  WriteLn(outfile, '   PRINT CHARACTER LIST: after the character list; follows mark 40.');
  WriteLn(outfile, '   KEY: at the end of the key file; follows mark 50>');
  WriteLn(outfile, '!}!');
  WriteLn(outfile, '#30. <NATURAL LANGUAGE: before item heading>');
  WriteLn(outfile, '!\par\pard\plain\s20\qc\sb0\sa0\li0\fi0\keep\keepn\fs24\b{}!');
  WriteLn(outfile, '#31. <NATURAL LANGUAGE: after item heading>');
  WriteLn(outfile, '!\b0\fs22{}!');
  WriteLn(outfile, '#32. <NATURAL LANGUAGE: before item subheading>');
  WriteLn(outfile, '!\fs21\f2\b{}!');
  WriteLn(outfile, '#33. <NATURAL LANGUAGE: after item subheading>');
  WriteLn(outfile, '!\b0\f0\fs22{}!');
  WriteLn(outfile, '#34. <NATURAL LANGUAGE: before output file name in index file>');
  WriteLn(outfile,
    '#35. <NATURAL LANGUAGE: between output file name and taxon name in index file>');
  WriteLn(outfile, '#36. <NATURAL LANGUAGE: after taxon name in index file>');
  WriteLn(outfile,
    '#37. <NATURAL LANGUAGE: before image file name in "character for taxon images">');
  WriteLn(outfile, '!\par\pard\plain\s21\qc\sb300\sa0\li0\fi0\fs22\keepn{\field{\*\fldinst');
  WriteLn(outfile, '{ INCLUDEPICTURE "D:\\\\DELTA\\\\sample\\\\images\\\\!');
  WriteLn(outfile, '#38. <NATURAL LANGUAGE: between image file name and subject>');
  WriteLn(outfile,
    '!" \\* MERGEFORMAT \\d }}}\par\pard\plain\s21\qj\sb200\sa0\li0\fi0\fs22\b{}!');
  WriteLn(outfile, '#39. <NATURAL LANGUAGE: after subject in "character for taxon images">');
  WriteLn(outfile, '!\b0{}!');
  WriteLn(outfile, '#40. <PRINT CHARACTER LIST: after the character list; precedes mark 29>');
  WriteLn(outfile, '#51. <NATURAL LANGUAGE: before item name if not at start of a file>');
  WriteLn(outfile, '!\par\pard\plain\s21\ql\sb300\sa100\li0\fi0\keep\keepn\b\fs24{}!');
  CloseFile(outfile);
end;

end.

unit KStates;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Spin, Buttons, StrUtils, LCLTranslator;

const
  maxwidth: double = 60;

type

  { TKeyStatesForm }

  TKeyStatesForm = class(TForm)
    LabeledEditKeyStates: TLabeledEdit;
    LabelFrequencyTable: TLabel;
    OKButton: TButton;
    CancelButton: TButton;
    ComboBoxCharacters: TComboBox;
    LabelCharacters: TLabel;
    LabelClasses: TLabel;
    MemoResults: TMemo;
    Panel1: TPanel;
    RadioButtonSquareRoot: TRadioButton;
    RadioButtonSturgesRule: TRadioButton;
    ClearButton: TSpeedButton;
    SpinEditClasses: TSpinEdit;
    procedure ClearButtonClick(Sender: TObject);
    procedure ComboBoxCharactersChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure RadioButtonSquareRootClick(Sender: TObject);
    procedure RadioButtonSturgesRuleClick(Sender: TObject);
    procedure SpinEditClassesEditingDone(Sender: TObject);
  private

  public
    KS: string;
  end;

var
  KeyStatesForm: TKeyStatesForm;
  Data: array of array of string;
  M, N, NC: integer;
  KeyStatesList: TStringList;

implementation

uses
  Math, Main, Delta;

{$R *.lfm}
{$I resources.inc}

procedure GetPairvalues(const Str: string; var Left, Sep, Right: string);
var
  I: integer = 1;
  Q: integer = 0;
  D: integer = 1;
begin
  Left := '';
  Sep := '';
  Right := '';
  while I <= Length(Str) do
  begin
    if Str[I] = '(' then
      Inc(Q)
    else
    if Str[I] = ')' then
      Dec(Q)
    else // Raise an error if neg...
    if Q = 0 then
      if not (Str[I] in ['-', '/']) then
        case D of
          1: Left += Str[I];
          2: Right += Str[I];
        end
      else
      begin
        Sep := Str[I];
        Inc(D);
      end;
    Inc(I);
  end;
  if Pos(',', Left) > 0 then
    Left := Copy(Left, 2);
end;

{ TKeyStatesForm }

procedure TKeyStatesForm.RadioButtonSquareRootClick(Sender: TObject);
begin
  NC := Round(Sqrt(N));
  SpinEditClasses.Value := NC;
  RadioButtonSquareRoot.Checked := True;
  RadioButtonSturgesRule.Checked := False;
  KeyStatesList.Clear;
  ComboBoxCharacters.OnChange(Self);
end;

procedure TKeyStatesForm.FormShow(Sender: TObject);
var
  I, J, M: integer;
  Attribute, L, S, R: string;
begin
  KeyStatesList := TStringList.Create;
  KeyStatesList.Delimiter := ' ';
  KeyStatesList.StrictDelimiter := True;
  N := Length(Dataset.ItemList);
  M := Length(Dataset.CharacterList);
  SetLength(Data, N, M);
  for I := 0 to Length(Dataset.ItemList) - 1 do
  begin
    for J := 0 to Length(Dataset.CharacterList) - 1 do
    begin
      if (Dataset.CharacterList[J].charType = 'IN') or
        (Dataset.CharacterList[J].charType = 'RN') then
      begin
        Attribute := Delta.RemoveComments(Dataset.ItemList[I].itemAttributes[J]);
        GetPairValues(Attribute, L, S, R);
        Data[I][J] := L + S + R;
      end;
    end;
  end;
  ComboBoxCharacters.Items.Clear;
  for J := 0 to Length(Dataset.CharacterList) - 1 do
  begin
    if (Dataset.CharacterList[J].charType = 'IN') or
      (Dataset.CharacterList[J].charType = 'RN') then
      ComboBoxCharacters.Items.Add(IntToStr(J + 1) + '. ' +
        Dataset.CharacterList[J].charName);
  end;
  ComboBoxCharacters.ItemIndex := 0;
  NC := Round(Sqrt(N));
  SpinEditClasses.Value := NC;
  RadioButtonSquareRoot.Checked := True;
  RadioButtonSturgesRule.Checked := False;
end;

procedure TKeyStatesForm.ComboBoxCharactersChange(Sender: TObject);
var
  Work: array of double;
  CharNo, I, J, K, Freq, NoOfStars: integer;
  Temp, Min, Max, Range, Interval, Cibase, Scale, Datin: double;
  KeyStatesStr, Sel, x, x1, x2: string;
  Outfile: TextFile;
begin
  Sel := ComboBoxCharacters.Items[ComboBoxCharacters.ItemIndex];
  CharNo := StrToInt(Copy(Sel, 1, Pos('.', Sel) - 1));
  KeyStatesStr := IntToStr(CharNo) + ',';
  MemoResults.Lines.Clear;
  SetLength(Work, N);
  for I := 0 to N - 1 do
  begin
    x := Data[I][CharNo - 1];
    if Length(x) > 0 then
    begin
      if (Pos('-', x) > 0) or (Pos('/', x) > 0) then
      begin
        x1 := ExtractDelimited(1, x, ['-', '/']);
        x2 := ExtractDelimited(2, x, ['-', '/']);
        Datin := (StrToFloatDef(x1, 0) + StrToFloatDef(x2, 0)) / 2;
      end
      else
        Datin := StrToFloatDef(x, 0);
      Work[I] := Datin;
    end;
  end;
  AssignFile(Outfile, 'Results.txt');
  Rewrite(Outfile);
  if (NC < 2) then
    NC := 2;
  if (NC > 30) then
    NC := 30;
  for I := 0 to N - 1 do
  begin
    for J := 1 + i to N - 1 do
      if (Work[I] > Work[J]) then
      begin
        Temp := Work[I];
        Work[I] := Work[J];
        Work[J] := Temp;
      end;
  end;
  Min := Work[0];
  Max := Work[N - 1];
  Range := Max - Min;
  Interval := Ceil(Range / NC) + 1;
  Write(Outfile, strClass);
  Write(Outfile, strInterval);
  Write(Outfile, strFrequency);
  //Write(Outfile, strBoundary);
  Write(Outfile, strMark);
  WriteLn(Outfile, strHistogram);
  Scale := 1.0;
  Cibase := Min;
  //while(cibase <= max) do
  for K := 0 to NC - 1 do
  begin
    Write(Outfile, (K + 1): 4, Cibase: 10: 0, '-', ((Cibase - 1) + Interval): 4: 0);
    KeyStatesStr := KeyStatesStr + FloatToStr(Cibase) + '-' + FloatToStr(
      (Cibase + 1) + Interval - 2) + '/';
    Freq := 0;
    for I := 0 to N - 1 do
    begin
      if (Work[i] >= Cibase) and (Work[i] <= ((Cibase - 1) + Interval)) then
        Inc(Freq);
    end;
    Write(Outfile, '    ', Freq: 4, '  ');
    //Write(Outfile, (Cibase - 0.5): 6: 1, '-', (Cibase - 0.5) + Interval: 6: 1);
    Write(Outfile, ((Cibase + ((Cibase - 1) + Interval)) / 2): 9: 1, '    ');
    NoOfStars := Round(Freq * Scale);
    for J := 1 to NoOfStars do
      Write(Outfile, '*');
    WriteLn(Outfile);
    Cibase := Cibase + Interval;
  end;
  //WriteLn(Outfile, 'Minimum: ', Min: 6: 1);
  //WriteLn(Outfile, 'Maximum: ', Max: 6: 1);
  //WriteLn(Outfile, 'Range: ', Range: 6: 1);
  //WriteLn(Outfile, 'Interval: ', Interval: 6: 1);
  KeyStatesStr := Copy(KeyStatesStr, 1, RPos('/', KeyStatesStr) - 1);
  if KeyStatesList.IndexOf(KeyStatesStr) < 0 then
    KeyStatesList.Add(KeyStatesStr);
  CloseFile(Outfile);
  MemoResults.Lines.LoadFromFile('Results.txt');
  LabeledEditKeyStates.Text := KeyStatesList.DelimitedText; //KeyStatesStr;
  DeleteFile('Results.txt');
end;

procedure TKeyStatesForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  KeyStatesList.Free;
end;

procedure TKeyStatesForm.ClearButtonClick(Sender: TObject);
begin
  LabeledEditKeyStates.Clear;
end;

procedure TKeyStatesForm.OKButtonClick(Sender: TObject);
begin
  KS := KeyStatesList.DelimitedText;
end;

procedure TKeyStatesForm.RadioButtonSturgesRuleClick(Sender: TObject);
begin
  NC := Round(1 + 3.3 * Log10(Int(N)));
  SpinEditClasses.Value := NC;
  RadioButtonSturgesRule.Checked := True;
  RadioButtonSquareRoot.Checked := False;
  KeyStatesList.Clear;
  ComboBoxCharacters.OnChange(Self);
end;

procedure TKeyStatesForm.SpinEditClassesEditingDone(Sender: TObject);
begin
  RadioButtonSturgesRule.Checked := False;
  RadioButtonSquareRoot.Checked := False;
end;

end.

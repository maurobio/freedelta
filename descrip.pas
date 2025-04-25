unit Descrip;

{$mode objfpc}{$H+}

interface

uses
  LCLIntf, LCLType, Classes, Graphics, Forms, Controls, Buttons, StdCtrls,
  ExtCtrls, SysUtils, Dialogs, Messages, ComCtrls;

type

  { TDescriptionForm }

  TDescriptionForm = class(TForm)
    GoButton: TButton;
    LabelDependent: TLabel;
    LabelCharNo: TLabel;
    PrevButton: TButton;
    NextButton: TButton;
    EditDesc: TLabeledEdit;
    LabelCharName: TLabel;
    LabelTypeName: TLabel;
    LabelItemName: TLabel;
    LabelStatesUnit: TLabel;
    LabelType: TLabel;
    ListBoxStates: TListBox;
    OKButton: TButton;
    CancelButton: TButton;
    LabelCharacter: TLabel;
    LabelItem: TLabel;
    procedure EditDescEditingDone(Sender: TObject);
    procedure EditDescKeyPress(Sender: TObject; var Key: char);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure GoButtonClick(Sender: TObject);
    procedure NextButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure PrevButtonClick(Sender: TObject);
  private
    I, J: integer;
  public
    DependentChar, ControlChars: string;
    procedure Describe(N, M: integer);
  end;

var
  DescriptionForm: TDescriptionForm;

implementation

uses Main, Delta, StrUtils;

  {$R *.lfm}

  {$I resources.inc}

function CTNames(CT: string): string;
begin
  case CT of
    'UM': Result := 'Unordered multistate';
    'OM': Result := 'Ordered multistate';
    'IN': Result := 'Integer numeric';
    'RN': Result := 'Real numeric';
    'TE': Result := 'Text';
    else
      Result := 'Unknown';
  end;
end;

function DependencyList(depchar: string): string;
var
  i, charno, First, last: integer;
  s, aux: string;
  Values: TStringList;
begin
  Values := TStringList.Create;
  //Values.Delimiter = ' ';
  Split(Values, depchar, [':']);
  for i := 1 to Values.Count - 1 do
  begin
    aux := Values[i];
    if (Pos('-', aux) > 0) then
    begin
      s := ExtractDelimited(1, aux, [':']);
      First := StrToInt(Copy(s, 1, Pos('-', s) - 1));
      last := StrToInt(Copy(s, Pos('-', s) + 1, Length(s)));
      Values.Delete(i);
      for charno := First to last do
        Values.Add(IntToStr(charno));
    end;
  end;
  DependencyList := Values.DelimitedText;
  Values.Free;
end;

{ TDescriptionForm }

procedure TDescriptionForm.Describe(N, M: integer);
var
  K, L: integer;
  Attribute: string;
  Values: TStringList;
  CharSet: TSysCharSet;
begin
  if (M > Length(Dataset.CharacterList)) then
    Exit;

  if Length(Dataset.CharacterList[M].charDependent) > 0 then
  begin
    DependentChar := IntToStr(M + 1);
    ControlChars := DependencyList(Dataset.CharacterList[M].charDependent);
  end;

  LabelCharNo.Caption := IntToStr(M + 1);
  LabelItemName.Caption := Delta.OmitTypesettingMarks(Dataset.ItemList[N].itemName) +
    ' ' + Dataset.ItemList[N].itemComment;
  LabelCharName.Caption := Dataset.CharacterList[M].charName;
  LabelTypeName.Caption := CTNames(Dataset.CharacterList[M].charType);
  case Dataset.CharacterList[M].charType of
    'UM', 'OM':
    begin
      LabelStatesUnit.Caption := strStates;
      ListBoxStates.Enabled := True;
      ListBoxStates.Clear;
      for K := 0 to Dataset.CharacterList[M].charStates.Count - 1 do
        ListBoxStates.Items.Add(IntToStr(K + 1) + '. ' +
          Dataset.CharacterList[M].charStates[K]);

      CharSet := ['/', '&', '-'];
      Attribute := Delta.OmitTypesettingMarks(Dataset.ItemList[N].itemAttributes[M]);
      if (not ContainsChars(Attribute, CharSet)) then
      begin
        try
          K := StrToInt(Attribute);
          ListBoxStates.Selected[K - 1] := True;
        except
          ListBoxStates.ItemIndex := -1;
        end;
      end
      else
      begin
        Values := TStringList.Create;
        try
          Split(Values, Delta.RemoveComments(Attribute), ['/', '&', '-']);
        except
          on E: EStringListError do
            Values.Add('');
        end;
        for L := 0 to Values.Count - 1 do
        try
          begin
            K := StrToInt(Values[L]);
            ListBoxStates.Selected[K - 1] := True;
          end;
        except
          ListBoxStates.ItemIndex := -1;
        end;
        Values.Free;
      end;
    end;

    'IN', 'RN':
    begin
      LabelStatesUnit.Caption := strUnit;
      ListBoxStates.Enabled := False;
      ListBoxStates.Clear;
      ListBoxStates.Items.Add(Dataset.CharacterList[M].charUnit);
      ListBoxStates.ItemIndex := -1;
    end;

    'TE':
    begin
      ListBoxStates.Clear;
      ListBoxStates.Enabled := False;
    end;

  end;
  EditDesc.Text := Delta.OmitTypesettingMarks(Dataset.ItemList[N].itemAttributes[M]);

  if AnsiContainsStr(ControlChars, LabelCharNo.Caption) then
  begin
    if (M + 1) <> StrToIntDef(ExtractDelimited(1, ControlChars, [',']), 0) then
    begin
      LabelDependent.Caption :=
        Format(strDependent, [DependentChar, ExtractDelimited(1, ControlChars, [','])]);
      //EditDesc.Enabled := False;
    end
    else
      LabelDependent.Caption :=
        Format(strControl, [ExtractDelimited(2, Dataset.CharacterList[M].charDependent,
        [':']), ExtractDelimited(1, Dataset.CharacterList[M].charDependent, [':'])]);
  end
  else
  begin
    if Length(Dataset.CharacterList[M].charDependent) > 0 then
      LabelDependent.Caption :=
        Format(strControl, [ExtractDelimited(2, Dataset.CharacterList[M].charDependent,
        [':']), ExtractDelimited(1, Dataset.CharacterList[M].charDependent, [':'])])
    else
      LabelDependent.Caption := '';
    //EditDesc.Enabled := True;
  end;
end;

procedure TDescriptionForm.EditDescEditingDone(Sender: TObject);
begin
  if IsEmptyStr(EditDesc.Text, [' ']) then
    EditDesc.Text := 'U';
  if EditDesc.Modified then
  begin
    OKButtonClick(Self);
    MainForm.FileIsChanged := True;
  end;
end;

procedure TDescriptionForm.EditDescKeyPress(Sender: TObject; var Key: char);
var
  K: integer;
begin
  if IsDigit(Key) then
  begin
    try
      K := StrToInt(Key);
      ListBoxStates.Selected[K - 1] := True;
    except
      ListBoxStates.ItemIndex := -1;
    end;
  end
  else
  if (Key <> '/') and (Key <> '&') then ListBoxStates.ClearSelection;
end;

procedure TDescriptionForm.FormKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = VK_NEXT) then
    NextButtonClick(Self);
  if (ssCtrl in Shift) and (Key = VK_PRIOR) then
    PrevButtonClick(Self);
end;

procedure TDescriptionForm.FormShow(Sender: TObject);
begin
  with MainForm do
  begin
    if (ItemListView.Selected <> nil) and (CharacterListView.Selected <> nil) then
    begin
      I := ItemListView.Selected.Index;
      J := CharacterListView.Selected.Index;
    end
    else
    begin
      I := 0;
      J := 0;
    end;
  end;

  if (J = 0) then
  begin
    NextButton.Enabled := True;
    PrevButton.Enabled := False;
  end
  else if (J = Length(Dataset.CharacterList) - 1) then
  begin
    NextButton.Enabled := False;
    PrevButton.Enabled := True;
  end
  else
  begin
    NextButton.Enabled := True;
    PrevButton.Enabled := True;
  end;

  if Length(Dataset.CharacterList[J].charDependent) > 0 then
  begin
    DependentChar := IntToStr(J + 1);
    ControlChars := DependencyList(Dataset.CharacterList[J].charDependent);
  end
  else
  begin
    DependentChar := '';
    ControlChars := '';
  end;

  Describe(I, J);
  {if ListBoxStates.Count > 0 then
    ListBoxStates.ItemIndex := 0;}
  {$IFDEF WINDOWS}
  SendMessage(ListBoxStates.Handle, lb_SetHorizontalExtent, 1000, 0);
  {$ENDIF}
  if PrevButton.Enabled then
    PrevButton.SetFocus
  else if NextButton.Enabled then
    NextButton.SetFocus;
  EditDesc.SetFocus;
  EditDesc.SelStart := 0;
  {EditDesc.SelectAll;}
end;

procedure TDescriptionForm.GoButtonClick(Sender: TObject);
var
  N, MaxChar: integer;
  S: string;
  Node: TTreeNode;
begin
  MaxChar := Length(Dataset.CharacterList);
  repeat
    S := '';
    if InputQuery(strGotoCharacter, strEnterCharacterNumber, S) then
    begin
      S := Trim(S);
      try
        if (StrToInt(S) < 1) or (StrToInt(S) > MaxChar) then
          MessageDlg(Format(strInputInteger, [MaxChar]), mtInformation, [mbOK], 0);
      except
        MessageDlg(Format(strValidNumber, [MaxChar]), mtInformation, [mbOK], 0);
        S := '-1';
      end;
    end
    else
      break;
  until (StrToInt(S) >= 1) and ((StrToInt(S) <= MaxChar));
  {if MainForm.ItemListView.Selected <> nil then
    I := MainForm.ItemListView.Selected.Index
  else
    I := 0;}
  try
    N := StrToInt(S) - 1;
    Describe(I, N);
  except
    on E: Exception do
      Exit;
  end;
end;

procedure TDescriptionForm.NextButtonClick(Sender: TObject);
begin
  Inc(J);
  if (J < Length(Dataset.CharacterList)) then
  begin
    Describe(I, J);
    NextButton.Enabled := True;
    PrevButton.Enabled := True;
  end
  else
  begin
    NextButton.Enabled := False;
    PrevButton.Enabled := True;
  end;
  Refresh;
end;

procedure TDescriptionForm.PrevButtonClick(Sender: TObject);
begin
  Dec(J);
  if (J >= 0) then
  begin
    Describe(I, J);
    PrevButton.Enabled := True;
    NextButton.Enabled := True;
  end
  else
  begin
    PrevButton.Enabled := False;
    NextButton.Enabled := True;
  end;
  Refresh;
end;

procedure TDescriptionForm.OKButtonClick(Sender: TObject);
var
  DescStr: string;
begin
  DescStr := EditDesc.Text;
  RemoveTrailingChars(DescStr, ['/', '&', '.', ',', ';']);
  try
    Dataset.ItemList[I].itemAttributes[J] := DescStr; //EditDesc.Text;
    MainForm.DataMatrix.Cells[J + 1, I + 1] := DescStr; //EditDesc.Text;
  except
    on E: Exception do
      Exit;
  end;
end;

end.

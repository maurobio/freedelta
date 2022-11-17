unit Chars;

{$mode objfpc}{$H+}

interface

uses
  LCLIntf, LCLType, Classes, Graphics, Forms, Controls, Buttons, StdCtrls,
  ExtCtrls, LCLTranslator, ComCtrls, SysUtils, StrUtils, Dialogs, CheckLst, Messages;

type

  { TCharacterForm }

  TCharacterForm = class(TForm)
    CheckCharacters: TCheckListBox;
    ComboAttributes: TComboBox;
    Label1: TLabel;
    LabelAttributes: TLabel;
    OKButton: TButton;
    CancelButton: TButton;
    CheckImplicit: TCheckBox;
    LabelStates: TLabel;
    EditChar: TLabeledEdit;
    EditUnit: TLabeledEdit;
    ListStates: TListBox;
    EditNote: TMemo;
    PageControl: TPageControl;
    rbUM: TRadioButton;
    rbOM: TRadioButton;
    rbIN: TRadioButton;
    rbRN: TRadioButton;
    rbTE: TRadioButton;
    IncludeBtn: TSpeedButton;
    EditBtn: TSpeedButton;
    ExcludeBtn: TSpeedButton;
    ClearBtn: TSpeedButton;
    TabSheetDepend: TTabSheet;
    UpBtn: TSpeedButton;
    DownBtn: TSpeedButton;
    TabSheetCharacter: TTabSheet;
    TabSheetNote: TTabSheet;
    procedure CheckImplicitClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure ComboAttributesChange(Sender: TObject);
    procedure DownBtnClick(Sender: TObject);
    procedure EditBtnClick(Sender: TObject);
    procedure ExcludeBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure IncludeBtnClick(Sender: TObject);
    procedure ListStatesSelectionChange(Sender: TObject; User: boolean);
    procedure OKButtonClick(Sender: TObject);
    procedure rbINClick(Sender: TObject);
    procedure rbOMClick(Sender: TObject);
    procedure rbRNClick(Sender: TObject);
    procedure rbTEClick(Sender: TObject);
    procedure rbUMClick(Sender: TObject);
    procedure UpBtnClick(Sender: TObject);
  private
    CharIndex: word;
    procedure EnableControls(Sender: TObject);
  public
    CharNumber: integer;
    StateImplicit: integer;
    DependentChar: TStringList;
  end;

var
  CharacterForm: TCharacterForm;

implementation

uses Main, Delta;

{$R *.lfm}
{$I resources.inc}

{ TCharacterForm }

procedure TCharacterForm.EnableControls(Sender: TObject);
begin
  ListStates.Enabled := rbUM.Checked or rbOM.Checked;
  IncludeBtn.Enabled := rbUM.Checked or rbOM.Checked;
  ExcludeBtn.Enabled := (rbUM.Checked or rbOM.Checked) and (ListStates.Count > 0);
  ClearBtn.Enabled := (rbUM.Checked or rbOM.Checked) and (ListStates.Count > 0);
  EditBtn.Enabled := (rbUM.Checked or rbOM.Checked) and (ListStates.Count > 0);
  UpBtn.Enabled := (rbUM.Checked or rbOM.Checked) and (ListStates.Count > 0);
  DownBtn.Enabled := (rbUM.Checked or rbOM.Checked) and (ListStates.Count > 0);
  CheckImplicit.Enabled := (rbUM.Checked or rbOM.Checked) and (ListStates.Count > 0);
  EditUnit.Enabled := rbIN.Checked or rbRN.Checked;
  if not ListStates.Enabled then
    ListStates.ItemIndex := -1;
end;

procedure TCharacterForm.IncludeBtnClick(Sender: TObject);
var
  Ok: boolean;
  Index: integer;
  StateStr: string;
begin
  Ok := InputQuery(strAddStateCaption, strAddStatePrompt, StateStr);
  if Ok and not IsEmptyStr(StateStr, [' ']) then
  begin
    //if AnsiContainsStr(StateStr, '/') then
    //begin
    //  MessageDlg(strInformation, strInvalidSymbol, mtInformation, [mbOK], 0);
    //  Exit;
    //end;
    ListStates.Items.Add(StateStr);
    Index := ListStates.Items.IndexOf(StateStr);
    ListStates.Selected[Index] := True;
    EnableControls(Self);
  end;
end;

procedure TCharacterForm.ListStatesSelectionChange(Sender: TObject; User: boolean);
var
  Index: integer;
begin
  Index := ListStates.ItemIndex + 1;
  if Index = StateImplicit then
    CheckImplicit.Checked := True
  else
    CheckImplicit.Checked := False;
end;

procedure TCharacterForm.OKButtonClick(Sender: TObject);
var
  S: string;
  I, LastIndex, FirstIndex: integer;
begin
  S := '';
  LastIndex := -1;
  FirstIndex := -1;
  for I := 0 to CheckCharacters.Items.Count - 1 do
    with CheckCharacters do
    begin
      if Checked[I] then
      begin
        if FirstIndex = -1 then
        begin
          if S <> '' then
            S := S + ':';
          S := S + IntToStr(I + 1);
          FirstIndex := I;
        end;
        LastIndex := I;
      end
      else
      begin
        if (FirstIndex <> LastIndex) then
          S := S + '-' + IntToStr(LastIndex + 1);
        FirstIndex := -1;
        LastIndex := -1;
      end;
    end;
  if FirstIndex <> LastIndex then
    S := S + '-' + IntToStr(LastIndex + 1);
  if S <> '' then
    DependentChar.Add(Concat(IntToStr(CharIndex), ',',
      IntToStr(ComboAttributes.ItemIndex + 1) + ':' + S));
end;

procedure TCharacterForm.rbINClick(Sender: TObject);
begin
  EnableControls(Sender);
end;

procedure TCharacterForm.rbOMClick(Sender: TObject);
begin
  EnableControls(Sender);
end;

procedure TCharacterForm.rbRNClick(Sender: TObject);
begin
  EnableControls(Sender);
end;

procedure TCharacterForm.rbTEClick(Sender: TObject);
begin
  EnableControls(Sender);
end;

procedure TCharacterForm.rbUMClick(Sender: TObject);
begin
  EnableControls(Sender);
end;

procedure TCharacterForm.UpBtnClick(Sender: TObject);
var
  Index: integer;
  Selected: string;
begin
  Index := ListStates.ItemIndex;
  if Index >= 1 then
  begin
    Selected := ListStates.Items.Strings[ListStates.ItemIndex];
    ListStates.DeleteSelected;
    ListStates.Items.Insert(Index - 1, Selected);
    ListStates.Selected[Index - 1];
    ListStates.Selected[Index - 1] := True;
  end;
end;

procedure TCharacterForm.ClearBtnClick(Sender: TObject);
begin
  ListStates.Clear;
  EnableControls(Self);
end;

procedure TCharacterForm.ComboAttributesChange(Sender: TObject);
var
  K, C: word;
  First, Last: integer;
  depRule, depChar, depState: string;
begin
  if CharIndex > 0 then
  begin
    if Dataset.CharacterList[CharIndex - 1].charDependent.Count > 0 then
    begin
      C := Dataset.CharacterList[CharIndex - 1].charDependent.Count;
      if ComboAttributes.ItemIndex > 0 then
        depRule := Dataset.CharacterList[CharIndex -
          1].charDependent[ComboAttributes.ItemIndex]
      else
        depRule := Dataset.CharacterList[CharIndex - 1].charDependent[0];
      CheckCharacters.CheckAll(cbUnchecked, True, True);
      depState := ExtractDelimited(1, depRule, [':']);
      if Pos('/', depState) > 0 then
        depState := Copy(depState, 1, Pos('/', depState) - 1);
      depChar := ExtractDelimited(2, depRule, [':']);
      if Pos('-', depChar) > 0 then
      begin
        First := StrToInt(ExtractDelimited(1, depChar, ['-']));
        Last := StrToInt(ExtractDelimited(2, depChar, ['-']));
        for K := First to Last do
        begin
          if (C = 1) and (StrToIntDef(depState, 0) <> ComboAttributes.ItemIndex + 1) then
            CheckCharacters.Checked[K - 1] := False
          else
            CheckCharacters.Checked[K - 1] := True;
        end;
      end
      else
      begin
        K := StrToIntDef(depChar, 0);
        if (K > 0) then
        begin
          if (C = 1) and (StrToIntDef(depState, 0) <> ComboAttributes.ItemIndex + 1) then
            CheckCharacters.Checked[K - 1] := False
          else
            CheckCharacters.Checked[K - 1] := True;
        end;
      end;
    end;
  end;
end;

procedure TCharacterForm.CheckImplicitClick(Sender: TObject);
var
  Index: integer;
begin
  Index := ListStates.ItemIndex + 1;
  if CheckImplicit.Checked then
    StateImplicit := Index;
end;

procedure TCharacterForm.DownBtnClick(Sender: TObject);
var
  Index: integer;
  Selected: string;
begin
  Index := ListStates.ItemIndex;
  if Index < ListStates.Count - 1 then
  begin
    Selected := ListStates.Items.Strings[ListStates.ItemIndex];
    ListStates.DeleteSelected;
    ListStates.Items.Insert(Index + 1, Selected);
    ListStates.Selected[Index + 1];
    ListStates.Selected[Index + 1] := True;
  end;
end;

procedure TCharacterForm.EditBtnClick(Sender: TObject);
var
  Index: integer;
  Selected: string;
  OK: boolean;
begin
  Index := ListStates.ItemIndex;
  if Index >= 0 then
  begin
    Selected := ListStates.Items.Strings[ListStates.ItemIndex];
    Ok := InputQuery(strEditStateCaption, strEditStatePrompt, Selected);
    if Ok and not IsEmptyStr(Selected, [' ']) then
      //begin
      //if AnsiContainsStr(Selected, '/') then
      //begin
      //  MessageDlg(strInformation, strInvalidSymbol, mtInformation, [mbOK], 0);
      //  Exit;
      //end;
      ListStates.Items[Index] := Selected;
    //end;
  end;
end;

procedure TCharacterForm.ExcludeBtnClick(Sender: TObject);
begin
  if ListStates.SelCount > 0 then
  begin
    ListStates.DeleteSelected;
    EnableControls(Self);
  end;
end;

procedure TCharacterForm.FormActivate(Sender: TObject);
begin
  if ListStates.Count > 0 then
    ListStates.ItemIndex := 0;
  {$IFDEF WINDOWS}
  SendMessage(ListStates.Handle, lb_SetHorizontalExtent, 1000, 0);
  SendMessage(CheckCharacters.Handle, lb_SetHorizontalExtent, 1000, 0);
  {$ENDIF}
  EditChar.SelectAll;
  EnableControls(Self);
end;

procedure TCharacterForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
var
  I: integer;
begin
  if rbUM.Checked or rbOM.Checked then
    if (ListStates.Count < 2) and (Trim(EditChar.Text) <> '') then
    begin
      MessageDlg(strInformation, strStateListEmpty, mtInformation, [mbOK], 0);
      CanClose := False;
    end;
  if rbRN.Checked then
    if Trim(EditUnit.Text) = '' then
    begin
      MessageDlg(strInformation, strUnitEmpty, mtInformation, [mbOK], 0);
      CanClose := False;
    end;
  //if AnsiContainsStr(EditChar.Text, '/') then
  //begin
  //  MessageDlg(strInformation, strInvalidSymbol, mtInformation, [mbOK], 0);
  //  CanClose := False;
  //end;
  //if rbTE.Checked then
  //  if not AnsiStartsStr('<', EditChar.Text) or not AnsiEndsStr('>', EditChar.Text) then
  //  begin
  //    MessageDlg(strInformation, strMissingBrackets, mtInformation, [mbOK], 0);
  //    CanClose := False;
  //  end;
end;

procedure TCharacterForm.FormCreate(Sender: TObject);
begin
  DependentChar := TStringList.Create;
  DependentChar.Sorted := True;
  DependentChar.Duplicates := dupIgnore;
end;

procedure TCharacterForm.FormShow(Sender: TObject);
var
  I, J, K: word;
  First, Last: integer;
  depState, depChar: string;
begin
  CharIndex := 0;
  if Length(Dataset.CharacterList) > 0 then
  begin
    CheckCharacters.Items.Clear;
    for J := 0 to Length(Dataset.CharacterList) - 1 do
    begin
      CheckCharacters.Items.Add(IntToStr(J + 1) + '. ' +
        Dataset.CharacterList[J].charName);
      if AnsiCompareStr(EditChar.Text, Dataset.CharacterList[J].charName) = 0 then
      begin
        CheckCharacters.ItemEnabled[J] := False;
        CharIndex := J + 1;
      end;
    end;
  end;
  if ListStates.Count > 0 then
  begin
    for I := 0 to ListStates.Count - 1 do
      ComboAttributes.Items.Add(EditChar.Text + ': ' + ListStates.Items.Strings[I]);
    if Dataset.CharacterList[CharNumber].charDependent.Count > 0 then
    begin
      ComboAttributes.Clear;
      for J := 0 to Dataset.CharacterList[CharNumber].charDependent.Count - 1 do
      begin
        depState := ExtractDelimited(1,
          Dataset.CharacterList[CharNumber].charDependent[J], [':']);
        if Pos('/', depState) > 0 then
          depState := Copy(depState, 1, Pos('/', depState) - 1);
        ComboAttributes.ItemIndex := StrToIntDef(depState, 0) - 1;
        depChar := ExtractDelimited(2,
          Dataset.CharacterList[CharNumber].charDependent[J], [':']);
        if Pos('-', depChar) > 0 then
        begin
          First := StrToInt(ExtractDelimited(1, depChar, ['-']));
          Last := StrToInt(ExtractDelimited(2, depChar, ['-']));
          for K := First to Last do
            CheckCharacters.Checked[K - 1] := True;
        end
        else
        begin
          K := StrToIntDef(depChar, 0);
          if (K > 0) then
            CheckCharacters.Checked[K - 1] := True;
        end;
      end;
      ComboAttributesChange(Sender);
    end;
  end;
  PageControl.ActivePage := TabSheetCharacter;
  EditChar.SetFocus;
end;

end.

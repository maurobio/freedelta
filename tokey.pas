unit Tokey;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  Spin, SpinEx, LCLTranslator;

type

  { TKeyForm }

  TKeyForm = class(TForm)
    ComboBoxOutputFormat: TComboBox;
    LabelOutputFormat: TLabel;
    PrintWidthLabel: TLabel;
    OKButton: TButton;
    CancelButton: TButton;
    CheckBoxNoTabularKey: TCheckBox;
    CheckBoxNoBrackettedKey: TCheckBox;
    CheckBoxAddCharacterNumbers: TCheckBox;
    EditIncludeCharacters: TEdit;
    EditIncludeItems: TEdit;
    EditKeyStates: TEdit;
    EditCharacterReliabilities: TEdit;
    EditUseNormalValues: TEdit;
    EditTreatCharactersAsVariable: TEdit;
    EditHeading: TEdit;
    FloatSpinEditABASE: TFloatSpinEditEx;
    FloatSpinEditVARYWT: TFloatSpinEditEx;
    FloatSpinEditREUSE: TFloatSpinEditEx;
    FloatSpinEditRBASE: TFloatSpinEditEx;
    LabelIncludeCharacters: TLabel;
    LabelIncludeItems: TLabel;
    LabelVARYWT: TLabel;
    LabelREUSE: TLabel;
    LabelRBASE: TLabel;
    LabelABASE: TLabel;
    LabelKeyStates: TLabel;
    LabelCharacterReliabilities: TLabel;
    LabelUseNormalValues: TLabel;
    LabelTreatCharactersAsVariable: TLabel;
    LabelNumberOfConfirmatoryCharacters: TLabel;
    LabelHeading: TLabel;
    SpeedButtonKeyStates: TSpeedButton;
    SpeedButtonTreatCharactersAsVariable: TSpeedButton;
    SpeedButtonUseNormalValues: TSpeedButton;
    SpeedButtonCharacterReliabilities: TSpeedButton;
    SpeedButtonIncludeItems: TSpeedButton;
    SpeedButtonIncludeCharacters: TSpeedButton;
    SpinEditPrintWidth: TSpinEdit;
    SpinEditNumberOfConfirmatoryCharacters: TSpinEditEx;
    procedure ComboBoxOutputFormatChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure SpeedButtonCharacterReliabilitiesClick(Sender: TObject);
    procedure SpeedButtonIncludeCharactersClick(Sender: TObject);
    procedure SpeedButtonIncludeItemsClick(Sender: TObject);
    procedure SpeedButtonKeyStatesClick(Sender: TObject);
    procedure SpeedButtonTreatCharactersAsVariableClick(Sender: TObject);
    procedure SpeedButtonUseNormalValuesClick(Sender: TObject);
  private

  public
    ListItems: TStringList;
    ListCharacters: TStringList;
    ListSelectedItems: TStringList;
    ListSelectedChars: TStringList;
    procedure FillListItems(Sender: TObject);
    procedure FillListCharacters(Sender: TObject);
  end;

var
  KeyForm: TKeyForm;

implementation

uses Main, Checklist, Delta, KStates;

{$R *.lfm}
{$I resources.inc}

{ TKeyForm }

procedure TKeyForm.FillListCharacters(Sender: TObject);
var
  J: word;
begin
  ListCharacters.Clear;
  for J := 0 to Length(Dataset.CharacterList) - 1 do
    ListCharacters.Add(IntToStr(J + 1) + '. ' +
      Delta.OmitTypeSettingMarks(Dataset.CharacterList[J].charName));
  if Length(Trim(EditIncludeCharacters.Text)) > 0 then
    //ListSelectedChars.DelimitedText := EditIncludeCharacters.Text
    ListSelectedChars := Delta.ExpandRange(EditIncludeCharacters.Text)
  else
    ListSelectedChars := nil;
end;

procedure TKeyForm.FillListItems(Sender: TObject);
var
  I: word;
begin
  ListItems.Clear;
  for I := 0 to Length(Dataset.ItemList) - 1 do
    ListItems.Add(IntToStr(I + 1) + '. ' + Delta.OmitTypeSettingMarks(
      Dataset.ItemList[I].itemName));
  if Length(Trim(EditIncludeItems.Text)) > 0 then
    //ListSelectedItems.DelimitedText := EditIncludeItems.Text
    ListSelectedItems := ExpandRange(EditIncludeItems.Text)
  else
    ListSelectedItems := nil;
end;

procedure TKeyForm.FormCreate(Sender: TObject);
begin
  ListItems := TStringList.Create;
  ListCharacters := TStringList.Create;
  ListSelectedItems := TStringList.Create;
  ListSelectedChars := TStringList.Create;
  with ComboBoxOutputFormat.Items do
  begin
    Add(strText);
    Add('HTML');
    //Add('RTF');
  end;
  ComboBoxOutputFormat.ItemIndex := 0;
end;

procedure TKeyForm.ComboBoxOutputFormatChange(Sender: TObject);
begin
  CheckBoxNoTabularKey.Enabled := ComboBoxOutputFormat.ItemIndex = 0;
  if ComboBoxOutputFormat.ItemIndex = 2 then
    SpinEditPrintWidth.Value := 0;
end;

procedure TKeyForm.FormDestroy(Sender: TObject);
begin
  ListItems.Free;
  ListCharacters.Free;
  ListSelectedItems.Free;
  ListSelectedChars.Free;
end;

procedure TKeyForm.OKButtonClick(Sender: TObject);
begin
  CheckBoxNoTabularKey.Enabled := ComboBoxOutputFormat.ItemIndex = 0;
end;

procedure TKeyForm.SpeedButtonCharacterReliabilitiesClick(Sender: TObject);
begin
  FillListCharacters(Self);
  ChecklistForm.L := ListCharacters;
  ChecklistForm.X := ListSelectedChars;
  if ChecklistForm.ShowModal = mrOk then
    EditCharacterReliabilities.Text := ChecklistForm.S;
end;

procedure TKeyForm.SpeedButtonIncludeCharactersClick(Sender: TObject);
begin
  FillListCharacters(Self);
  ChecklistForm.L := ListCharacters;
  ChecklistForm.X := ListSelectedChars;
  if ChecklistForm.ShowModal = mrOk then
    EditIncludeCharacters.Text := ChecklistForm.S;
end;

procedure TKeyForm.SpeedButtonIncludeItemsClick(Sender: TObject);
begin
  FillListItems(Self);
  ChecklistForm.L := ListItems;
  ChecklistForm.Y := ListSelectedItems;
  if ChecklistForm.ShowModal = mrOk then
    EditIncludeItems.Text := ChecklistForm.S;
end;

procedure TKeyForm.SpeedButtonKeyStatesClick(Sender: TObject);
begin
  if KeyStatesForm.ShowModal = mrOk then
    EditKeyStates.Text := KeyStatesForm.KS;
end;

procedure TKeyForm.SpeedButtonTreatCharactersAsVariableClick(Sender: TObject);
begin
  FillListCharacters(Self);
  ChecklistForm.L := ListCharacters;
  ChecklistForm.X := ListSelectedChars;
  if ChecklistForm.ShowModal = mrOk then
    EditTreatCharactersAsVariable.Text := ChecklistForm.S;
end;

procedure TKeyForm.SpeedButtonUseNormalValuesClick(Sender: TObject);
begin
  FillListCharacters(Self);
  ChecklistForm.L := ListCharacters;
  ChecklistForm.X := ListSelectedChars;
  if ChecklistForm.ShowModal = mrOk then
    EditUseNormalValues.Text := ChecklistForm.S;
end;

end.

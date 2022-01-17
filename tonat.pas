unit Tonat;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, Spin, ShortPathEdit;

type

  { TTonatForm }

  TTonatForm = class(TForm)
    CheckBoxOmitFinalComma: TCheckBox;
    CheckBoxOmitComments: TCheckBox;
    CheckBoxOmitInnerComments: TCheckBox;
    ComboBoxOutputFormat: TComboBox;
    EditReplaceSemicolonByComma: TEdit;
    EditOmitLowerForCharacters: TEdit;
    EditOmitPeriodForCharacters: TEdit;
    EditOmitOrForCharacters: TEdit;
    EditEmphasizeFeatures: TEdit;
    EditNewParagraphsAtCharacters: TEdit;
    EditItemSubheadings: TEdit;
    EditLinkCharacters: TEdit;
    EditExcludeItems: TEdit;
    EditExcludeCharacters: TEdit;
    EditHeading: TEdit;
    LabelOutputFormat: TLabel;
    LabelPrintWidth: TLabel;
    LabelReplaceSemicolonByComma: TLabel;
    LabelOmitLowerForCharacters: TLabel;
    LabelOmitPeriodForCharacters: TLabel;
    LabelOmitOrForCharacters: TLabel;
    LabelEmphasizeFeatures: TLabel;
    LabelNewParagraphsAtCharacters: TLabel;
    LabelItemSubheadings: TLabel;
    LabelLinkCharacters: TLabel;
    LabelExcludeItems: TLabel;
    LabelExcludeCharacters: TLabel;
    LabelHeading: TLabel;
    OKButton: TButton;
    CancelButton: TButton;
    CheckBoxReplaceAngleBrackets: TCheckBox;
    CheckBoxOmitCharacterNumbers: TCheckBox;
    CheckBoxOmitInapplicables: TCheckBox;
    CheckBoxOmitTypesettingMarks: TCheckBox;
    CheckBoxTranslateImplicitValues: TCheckBox;
    SpeedButtonReplaceSemicolonByComma: TSpeedButton;
    SpeedButtonOmitLowerForCharacters: TSpeedButton;
    SpeedButtonOmitPeriodForCharacters: TSpeedButton;
    SpeedButtonOmitOrForCharacters: TSpeedButton;
    SpeedButtonEmphasizeFeatures: TSpeedButton;
    SpeedButtonNewParagraphsAtCharacters: TSpeedButton;
    SpeedButtonItemSubheadings: TSpeedButton;
    SpeedButtonLinkCharacters: TSpeedButton;
    SpeedButtonExcludeCharacters: TSpeedButton;
    SpeedButtonExcludeItems: TSpeedButton;
    SpinEditPrintWidth: TSpinEdit;
    procedure ComboBoxOutputFormatChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButtonEmphasizeFeaturesClick(Sender: TObject);
    procedure SpeedButtonExcludeCharactersClick(Sender: TObject);
    procedure SpeedButtonExcludeItemsClick(Sender: TObject);
    procedure SpeedButtonItemSubheadingsClick(Sender: TObject);
    procedure SpeedButtonLinkCharactersClick(Sender: TObject);
    procedure SpeedButtonNewParagraphsAtCharactersClick(Sender: TObject);
    procedure SpeedButtonOmitLowerForCharactersClick(Sender: TObject);
    procedure SpeedButtonOmitOrForCharactersClick(Sender: TObject);
    procedure SpeedButtonOmitPeriodForCharactersClick(Sender: TObject);
    procedure SpeedButtonReplaceSemicolonByCommaClick(Sender: TObject);
  private
    ListItems: TStringList;
    ListCharacters: TStringList;
    procedure FillListItems(Sender: TObject);
    procedure FillListCharacters(Sender: TObject);
  public

  end;

var
  TonatForm: TTonatForm;

implementation

uses Main, Checklist, Delta;

{$R *.lfm}
{$I resources.inc}

{ TTonatForm }

procedure TTonatForm.FillListCharacters(Sender: TObject);
var
  J: word;
begin
  for J := 0 to Length(Dataset.CharacterList) - 1 do
    ListCharacters.Add(IntToStr(J + 1) + '. ' +
      Delta.OmitTypeSettingMarks(Dataset.CharacterList[J].charName));
end;

procedure TTonatForm.FillListItems(Sender: TObject);
var
  I: word;
begin
  for I := 0 to Length(Dataset.ItemList) - 1 do
    ListItems.Add(IntToStr(I + 1) + '. ' + Delta.OmitTypeSettingMarks(
      Dataset.ItemList[I].itemName));
end;

procedure TTonatForm.SpeedButtonNewParagraphsAtCharactersClick(Sender: TObject);
begin
  FillListCharacters(Self);
  ChecklistForm.L := ListCharacters;
  if ChecklistForm.ShowModal = mrOk then
    EditNewParagraphsAtCharacters.Text := ChecklistForm.S;
end;

procedure TTonatForm.SpeedButtonOmitLowerForCharactersClick(Sender: TObject);
begin
  FillListCharacters(Self);
  ChecklistForm.L := ListCharacters;
  if ChecklistForm.ShowModal = mrOk then
    EditOmitLowerForCharacters.Text := ChecklistForm.S;
end;

procedure TTonatForm.SpeedButtonOmitOrForCharactersClick(Sender: TObject);
begin
  FillListCharacters(Self);
  ChecklistForm.L := ListCharacters;
  if ChecklistForm.ShowModal = mrOk then
    EditOmitOrForCharacters.Text := ChecklistForm.S;
end;

procedure TTonatForm.SpeedButtonOmitPeriodForCharactersClick(Sender: TObject);
begin
  FillListCharacters(Self);
  ChecklistForm.L := ListCharacters;
  if ChecklistForm.ShowModal = mrOk then
    EditOmitPeriodForCharacters.Text := ChecklistForm.S;
end;

procedure TTonatForm.SpeedButtonReplaceSemicolonByCommaClick(Sender: TObject);
begin
  FillListCharacters(Self);
  ChecklistForm.L := ListCharacters;
  if ChecklistForm.ShowModal = mrOk then
    EditReplaceSemicolonByComma.Text := ChecklistForm.S;
end;

procedure TTonatForm.SpeedButtonExcludeItemsClick(Sender: TObject);
begin
  FillListItems(Self);
  ChecklistForm.L := ListItems;
  if ChecklistForm.ShowModal = mrOk then
    EditExcludeItems.Text := ChecklistForm.S;
end;

procedure TTonatForm.SpeedButtonExcludeCharactersClick(Sender: TObject);
begin
  FillListCharacters(Self);
  ChecklistForm.L := ListCharacters;
  if ChecklistForm.ShowModal = mrOk then
    EditExcludeCharacters.Text := ChecklistForm.S;
end;

procedure TTonatForm.SpeedButtonItemSubheadingsClick(Sender: TObject);
begin
  FillListCharacters(Self);
  ChecklistForm.L := ListCharacters;
  if ChecklistForm.ShowModal = mrOk then
    EditItemSubheadings.Text := ChecklistForm.S;
end;

procedure TTonatForm.SpeedButtonLinkCharactersClick(Sender: TObject);
begin
  FillListCharacters(Self);
  ChecklistForm.L := ListCharacters;
  if ChecklistForm.ShowModal = mrOk then
    EditLinkCharacters.Text := ChecklistForm.S;
end;

procedure TTonatForm.FormCreate(Sender: TObject);
begin
  ListItems := TStringList.Create;
  ListCharacters := TStringList.Create;
  with ComboBoxOutputFormat.Items do
  begin
    Add(strText);
    Add('HTML');
    Add('RTF');
  end;
  ComboBoxOutputFormat.ItemIndex := 0;
end;

procedure TTonatForm.ComboBoxOutputFormatChange(Sender: TObject);
begin
  CheckBoxOmitTypesettingMarks.Checked := ComboBoxOutputFormat.ItemIndex <> 2;
  if ComboBoxOutputFormat.ItemIndex = 2 then
    SpinEditPrintWidth.Value := 0;
end;

procedure TTonatForm.FormDestroy(Sender: TObject);
begin
  ListItems.Free;
  ListCharacters.Free;
end;

procedure TTonatForm.SpeedButtonEmphasizeFeaturesClick(Sender: TObject);
begin
  FillListCharacters(Self);
  ChecklistForm.L := ListCharacters;
  if ChecklistForm.ShowModal = mrOk then
    EditEmphasizeFeatures.Text := ChecklistForm.S;
end;

end.

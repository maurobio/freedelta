unit Toint;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  Spin, SpinEx, LCLTranslator, EditBtn;

type

  { TIntKeyForm }

  TIntKeyForm = class(TForm)
    DirectoryEditImagePath: TDirectoryEdit;
    LabelImagePath: TLabel;
    OKButton: TButton;
    CancelButton: TButton;
    EditIncludeCharacters: TEdit;
    EditIncludeItems: TEdit;
    EditCharacterReliabilities: TEdit;
    EditHeading: TEdit;
    FloatSpinEditVARYWT: TFloatSpinEditEx;
    FloatSpinEditRBASE: TFloatSpinEditEx;
    LabelIncludeCharacters: TLabel;
    LabelIncludeItems: TLabel;
    LabelVARYWT: TLabel;
    LabelRBASE: TLabel;
    LabelCharacterReliabilities: TLabel;
    LabelHeading: TLabel;
    SpeedButtonCharacterReliabilities: TSpeedButton;
    SpeedButtonIncludeItems: TSpeedButton;
    SpeedButtonIncludeCharacters: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButtonCharacterReliabilitiesClick(Sender: TObject);
    procedure SpeedButtonIncludeCharactersClick(Sender: TObject);
    procedure SpeedButtonIncludeItemsClick(Sender: TObject);
  private

  public
    ListItems: TStringList;
    ListCharacters: TStringList;
    procedure FillListItems(Sender: TObject);
    procedure FillListCharacters(Sender: TObject);
  end;

var
  IntKeyForm: TIntKeyForm;

implementation

uses Main, Checklist, Delta, KStates;

{$R *.lfm}
{$I resources.inc}

{ TIntKeyForm }

procedure TIntKeyForm.FillListCharacters(Sender: TObject);
var
  J: word;
begin
  for J := 0 to Length(Dataset.CharacterList) - 1 do
    ListCharacters.Add(IntToStr(J + 1) + '. ' +
      Delta.OmitTypeSettingMarks(Dataset.CharacterList[J].charName));
end;

procedure TIntKeyForm.FillListItems(Sender: TObject);
var
  I: word;
begin
  for I := 0 to Length(Dataset.ItemList) - 1 do
    ListItems.Add(IntToStr(I + 1) + '. ' + Delta.OmitTypeSettingMarks(
      Dataset.ItemList[I].itemName));
end;

procedure TIntKeyForm.FormCreate(Sender: TObject);
begin
  ListItems := TStringList.Create;
  ListCharacters := TStringList.Create;
end;

procedure TIntKeyForm.FormDestroy(Sender: TObject);
begin
  ListItems.Free;
  ListCharacters.Free;
end;

procedure TIntKeyForm.SpeedButtonCharacterReliabilitiesClick(Sender: TObject);
begin
  FillListCharacters(Self);
  ChecklistForm.L := ListCharacters;
  if ChecklistForm.ShowModal = mrOk then
    EditCharacterReliabilities.Text := ChecklistForm.S;
end;

procedure TIntKeyForm.SpeedButtonIncludeCharactersClick(Sender: TObject);
begin
  FillListCharacters(Self);
  ChecklistForm.L := ListCharacters;
  if ChecklistForm.ShowModal = mrOk then
    EditIncludeCharacters.Text := ChecklistForm.S;
end;

procedure TIntKeyForm.SpeedButtonIncludeItemsClick(Sender: TObject);
begin
  FillListItems(Self);
  ChecklistForm.L := ListItems;
  if ChecklistForm.ShowModal = mrOk then
    EditIncludeItems.Text := ChecklistForm.S;
end;

end.

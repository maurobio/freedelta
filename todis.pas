unit Todis;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  SpinEx, LCLTranslator;

type

  { TDistForm }

  TDistForm = class(TForm)
    OKButton: TButton;
    CancelButton: TButton;
    CheckBoxMatchOverlap: TCheckBox;
    CheckBoxPHYLIPFormat: TCheckBox;
    EditExcludeItems: TEdit;
    EditExcludeCharacters: TEdit;
    LabelMinimumNumberOfComparisons: TLabel;
    LabelExcludeItems: TLabel;
    LabelExcludeCharacters: TLabel;
    SpeedButtonExcludeItems: TSpeedButton;
    SpeedButtonExcludeCharacters: TSpeedButton;
    SpinEditMinimumNumberOfComparisons: TSpinEditEx;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButtonExcludeCharactersClick(Sender: TObject);
    procedure SpeedButtonExcludeItemsClick(Sender: TObject);
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
  DistForm: TDistForm;

implementation

uses Main, Checklist, Delta;

{$R *.lfm}

procedure TDistForm.FillListCharacters(Sender: TObject);
var
  J: word;
begin
  for J := 0 to Length(Dataset.CharacterList) - 1 do
    ListCharacters.Add(IntToStr(J + 1) + '. ' +
      Delta.OmitTypeSettingMarks(Dataset.CharacterList[J].charName));
  if Length(Trim(EditExcludeCharacters.Text)) > 0 then
    ListSelectedChars.DelimitedText := EditExcludeCharacters.Text
  else
    ListSelectedChars := nil;
end;

procedure TDistForm.FillListItems(Sender: TObject);
var
  I: word;
begin
  for I := 0 to Length(Dataset.ItemList) - 1 do
    ListItems.Add(IntToStr(I + 1) + '. ' + Delta.OmitTypeSettingMarks(
      Dataset.ItemList[I].itemName));
  if Length(Trim(EditExcludeItems.Text)) > 0 then
    ListSelectedItems.DelimitedText := EditExcludeItems.Text
  else
    ListSelectedItems := nil;
end;

procedure TDistForm.FormCreate(Sender: TObject);
begin
  ListItems := TStringList.Create;
  ListCharacters := TStringList.Create;
  ListSelectedItems := TStringList.Create;
  ListSelectedChars := TStringList.Create;
end;

procedure TDistForm.FormDestroy(Sender: TObject);
begin
  ListItems.Free;
  ListCharacters.Free;
  ListSelectedItems.Free;
  ListSelectedChars.Free;
end;

procedure TDistForm.SpeedButtonExcludeCharactersClick(Sender: TObject);
begin
  FillListCharacters(Self);
  ChecklistForm.L := ListCharacters;
  ChecklistForm.X := ListSelectedChars;
  if ChecklistForm.ShowModal = mrOk then
    EditExcludeCharacters.Text := ChecklistForm.S;
end;

procedure TDistForm.SpeedButtonExcludeItemsClick(Sender: TObject);
begin
  FillListItems(Self);
  ChecklistForm.L := ListItems;
  ChecklistForm.Y := ListSelectedItems;
  if ChecklistForm.ShowModal = mrOk then
    EditExcludeItems.Text := ChecklistForm.S;
end;

end.


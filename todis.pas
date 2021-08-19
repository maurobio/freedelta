unit Todis;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  SpinEx;

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
end;

procedure TDistForm.FillListItems(Sender: TObject);
var
  I: word;
begin
  for I := 0 to Length(Dataset.ItemList) - 1 do
    ListItems.Add(IntToStr(I + 1) + '. ' + Delta.OmitTypeSettingMarks(
      Dataset.ItemList[I].itemName));
end;

procedure TDistForm.FormCreate(Sender: TObject);
begin
  ListItems := TStringList.Create;
  ListCharacters := TStringList.Create;
end;

procedure TDistForm.FormDestroy(Sender: TObject);
begin
  ListItems.Free;
  ListCharacters.Free;
end;

procedure TDistForm.SpeedButtonExcludeCharactersClick(Sender: TObject);
begin
  FillListCharacters(Self);
  ChecklistForm.L := ListCharacters;
  if ChecklistForm.ShowModal = mrOk then
    EditExcludeCharacters.Text := ChecklistForm.S;
end;

procedure TDistForm.SpeedButtonExcludeItemsClick(Sender: TObject);
begin
  FillListItems(Self);
  ChecklistForm.L := ListItems;
  if ChecklistForm.ShowModal = mrOk then
    EditExcludeItems.Text := ChecklistForm.S;
end;

end.


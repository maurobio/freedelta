unit Phylogen;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, LCLTranslator;

type

  { TPhyloForm }

  TPhyloForm = class(TForm)
    EditKeyStates: TEdit;
    LabelKeyStates: TLabel;
    OKButton: TButton;
    CancelButton: TButton;
    EditExcludeItems: TEdit;
    EditExcludeCharacters: TEdit;
    LabelExcludeItems: TLabel;
    LabelExcludeCharacters: TLabel;
    SpeedButtonExcludeItems: TSpeedButton;
    SpeedButtonExcludeCharacters: TSpeedButton;
    SpeedButtonKeyStates: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButtonExcludeCharactersClick(Sender: TObject);
    procedure SpeedButtonExcludeItemsClick(Sender: TObject);
    procedure SpeedButtonKeyStatesClick(Sender: TObject);
  private

  public
    ListItems: TStringList;
    ListCharacters: TStringList;
    procedure FillListItems(Sender: TObject);
    procedure FillListCharacters(Sender: TObject);
  end;

var
  PhyloForm: TPhyloForm;

implementation

uses Main, Checklist, Delta, KStates;

{$R *.lfm}

procedure TPhyloForm.FillListCharacters(Sender: TObject);
var
  J: word;
begin
  for J := 0 to Length(Dataset.CharacterList) - 1 do
    ListCharacters.Add(IntToStr(J + 1) + '. ' +
      Delta.OmitTypeSettingMarks(Dataset.CharacterList[J].charName));
end;

procedure TPhyloForm.FillListItems(Sender: TObject);
var
  I: word;
begin
  for I := 0 to Length(Dataset.ItemList) - 1 do
    ListItems.Add(IntToStr(I + 1) + '. ' + Delta.OmitTypeSettingMarks(
      Dataset.ItemList[I].itemName));
end;

procedure TPhyloForm.FormCreate(Sender: TObject);
begin
  ListItems := TStringList.Create;
  ListCharacters := TStringList.Create;
end;

procedure TPhyloForm.FormDestroy(Sender: TObject);
begin
  ListItems.Free;
  ListCharacters.Free;
end;

procedure TPhyloForm.SpeedButtonExcludeCharactersClick(Sender: TObject);
begin
  FillListCharacters(Self);
  ChecklistForm.L := ListCharacters;
  if ChecklistForm.ShowModal = mrOk then
    EditExcludeCharacters.Text := ChecklistForm.S;
end;

procedure TPhyloForm.SpeedButtonExcludeItemsClick(Sender: TObject);
begin
  FillListItems(Self);
  ChecklistForm.L := ListItems;
  if ChecklistForm.ShowModal = mrOk then
    EditExcludeItems.Text := ChecklistForm.S;
end;

procedure TPhyloForm.SpeedButtonKeyStatesClick(Sender: TObject);
begin
  if KeyStatesForm.ShowModal = mrOK then
    EditKeyStates.Text := KeyStatesForm.KS;
end;

end.


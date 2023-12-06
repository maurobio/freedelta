unit Checklist;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, CheckLst, StdCtrls;

type

  { TChecklistForm }

  TChecklistForm = class(TForm)
    OKButton: TButton;
    CancelButton: TButton;
    CheckListBox: TCheckListBox;
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private

  public
    L: TStringList;
    X: TStringList;
    Y: TStringList;
    S: string;
  end;

var
  ChecklistForm: TChecklistForm;

implementation

uses Delta;

{$R *.lfm}

function NumberInList(Value: string; Strings: TStringList): boolean;
var
  I: integer;
begin
  Result := False;
  for I := 0 to Strings.Count - 1 do
    Result := Result or (Value = Strings[I]);
end;

{ TChecklistForm }

procedure TChecklistForm.FormShow(Sender: TObject);
var
  I: word;
begin
  CheckListBox.Items.Clear;
  CheckListBox.Items.Assign(L);
  CheckListBox.TopIndex := 0;
  for I := 0 to CheckListBox.Count - 1 do
  begin
    if X <> nil then
      if NumberInList(IntToStr(I + 1), X) then
        CheckListBox.Checked[I] := True
      else
        CheckListBox.Checked[I] := False;
    if Y <> nil then
      if NumberInList(IntToStr(I + 1), Y) then
        CheckListBox.Checked[I] := True
      else
        CheckListBox.Checked[I] := False;
  end;
end;

procedure TChecklistForm.OKButtonClick(Sender: TObject);
var
  J: word;
begin
  S := '';
  for J := 0 to CheckListBox.Count - 1 do
    if CheckListBox.Checked[J] then
      S := S + IntToStr(J + 1) + ' ';
  S := Delta.CompressRange(S);	  
end;

end.

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
    S: string;
  end;

var
  ChecklistForm: TChecklistForm;

implementation

{$R *.lfm}

{ TChecklistForm }

procedure TChecklistForm.FormShow(Sender: TObject);
begin
  CheckListBox.Items.Clear;
  CheckListBox.Items.Assign(L);
  CheckListBox.TopIndex := 0;
end;

procedure TChecklistForm.OKButtonClick(Sender: TObject);
var
  J: word;
begin
  S := '';
  for J := 0 to CheckListBox.Count - 1 do
  begin
    if CheckListBox.Checked[J] then
      S := S + IntToStr(J + 1) + ' ';
  end;
end;

end.

unit Script;

{$MODE Delphi}

interface

uses
  SysUtils, LCLIntf, LCLType, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, ExtCtrls, Clipbrd, ComCtrls, SynEdit, SynFacilHighlighter;

type

  { TScriptForm }

  TScriptForm = class(TForm)
    Memo: TSynEdit;
    RunMenuItemCONFOR: TMenuItem;
    RunMenuItemKEY: TMenuItem;
    RunMenuItemDIST: TMenuItem;
    OpenDialog: TOpenDialog;
    RunMenu: TPopupMenu;
    SaveDialog: TSaveDialog;
    ToolBar: TToolBar;
    NewButton: TToolButton;
    OpenButton: TToolButton;
    SaveButton: TToolButton;
    RunButton: TToolButton;
    CopyButton: TToolButton;
    ReturnButton: TToolButton;
    procedure CopyButtonClick(Sender: TObject);
    procedure FileReturnItemClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure NewButtonClick(Sender: TObject);
    procedure OpenButtonClick(Sender: TObject);
    procedure ReturnButtonClick(Sender: TObject);
    procedure RunButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ScriptForm: TScriptForm;

implementation

var
  Hlt: TSynFacilSyn;

{$R *.lfm}
{$I resources.inc}

procedure TScriptForm.FileReturnItemClick(Sender: TObject);
begin
  Close;
end;

procedure TScriptForm.CopyButtonClick(Sender: TObject);
begin
  Memo.SelectAll;
  Memo.CopyToClipboard;
  MessageDlg(strCopyText, mtInformation, [mbOK], 0);
end;

procedure TScriptForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if Memo.Modified then
  begin
    if MessageDlg(strSaveChanges, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      SaveButtonClick(Sender);
      CanClose := True;
    end;
  end;
end;

procedure TScriptForm.FormCreate(Sender: TObject);
begin
  { Configure highlighter }
  Hlt := TSynFacilSyn.Create(self);
  if FileExists('Delta.xml') then
    Hlt.LoadFromFile('Delta.xml');
end;

procedure TScriptForm.FormDestroy(Sender: TObject);
begin
  Hlt.Free;
end;

procedure TScriptForm.NewButtonClick(Sender: TObject);
begin
  Memo.ClearAll;
  Memo.Modified := False;
  Caption := '';
end;

procedure TScriptForm.OpenButtonClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    Memo.Highlighter := Hlt;
    Memo.Lines.LoadFromFile(OpenDialog.FileName);
    Hlt.tkKeyword.Foreground := clBlue;
    Memo.Invalidate;
    Caption := ExtractFileName(OpenDialog.FileName);
  end;
end;

procedure TScriptForm.ReturnButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TScriptForm.RunButtonClick(Sender: TObject);
begin
  if Memo.Modified then
  begin
    if MessageDlg(strSaveChanges, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      SaveButtonClick(Sender);
  end;
  { Run CONFOR }
end;

procedure TScriptForm.SaveButtonClick(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    Memo.Lines.SaveToFile(SaveDialog.FileName);
    Caption := ExtractFileName(SaveDialog.FileName);
  end;
end;

end.

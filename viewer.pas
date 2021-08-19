unit Viewer;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, Clipbrd, HtmlView;

type

  { TViewerForm }

  TViewerForm = class(TForm)
    CopyBtn: TBitBtn;
    HtmlViewer: THtmlViewer;
    CloseBtn: TBitBtn;
    ImageViewer: TImage;
    ScrollBox: TScrollBox;
    TextViewer: TMemo;
    procedure CloseBtnClick(Sender: TObject);
    procedure CopyBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Bitmap: TBitmap;
  public

  end;

var
  ViewerForm: TViewerForm;

implementation

uses Main;

{$R *.lfm}
{$I resources.inc}

{ TViewerForm }

procedure TViewerForm.CloseBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TViewerForm.CopyBtnClick(Sender: TObject);
begin
  //if (TextViewer.Lines.Count > 0) and (TextViewer.SelLength > 0) then
  if TextViewer.Visible then
  begin
    TextViewer.SelectAll;
    TextViewer.CopyToClipboard;
    TextViewer.SelLength := 0;
    MessageDlg(strCopyText, mtInformation, [mbOK], 0);
  end
  else if HtmlViewer.Visible then
  begin
    HtmlViewer.SelectAll;
    HtmlViewer.CopyToClipboard;
    HtmlViewer.SelLength := 0;
    MessageDlg(strCopyText, mtInformation, [mbOK], 0);
  end
  else if ImageViewer.Visible then
  begin
    Bitmap := TBitmap.Create;
    Bitmap.Width := ImageViewer.Width;
    Bitmap.Height := ImageViewer.Height;
    Bitmap.Canvas.Draw(0, 0, ImageViewer.Picture.Graphic);
    Clipboard.Assign(Bitmap);
    Bitmap.Free;
    MessageDlg(strCopyImage, mtInformation, [mbOK], 0);
  end;
end;

procedure TViewerForm.FormShow(Sender: TObject);
begin
  if Caption = 'Error Log' then
  begin
    TextViewer.Color := clBlack;
    TextViewer.Font.Color := clWhite;
  end
  else
  begin
    TextViewer.Color := clDefault;
    TextViewer.Font.Color := clBlack;
  end;
  SetFocus;
end;

end.

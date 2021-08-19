unit Cluster;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TClusterForm }

  TClusterForm = class(TForm)
    OKButton: TButton;
    CancelButton: TButton;
    ComboBoxMethod: TComboBox;
    LabelMethod: TLabel;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  ClusterForm: TClusterForm;

implementation

{$R *.lfm}
{$I resources.inc}

{ TClusterForm }

procedure TClusterForm.FormCreate(Sender: TObject);
begin
  with ComboBoxMethod.Items do
  begin
    Add(strSLM);
    Add(strCLM);
    Add(strUPGMA);
    Add(strWPGMA);
    Add(strCentroid);
    Add(strMedian);
    Add(strWard);
  end;
end;

end.


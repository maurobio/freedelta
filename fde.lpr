program fde;

{$mode objfpc}{$H+}

uses {$IFDEF UNIX} {$IFDEF UseCThreads}
  cthreads, {$ENDIF} {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  lazcontrols,
  HistoryLazarus,
  FrameViewer09,
  Main,
  About,
  Chars,
  Checklist,
  Cluster,
  Todis,
  Tokey,
  Tonat,
  Delta,
  Prepare,
  Viewer,
  KStates,
  Phylogen,
  Script;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Title:='FreeDelta Editor';
  Application.Scaled := True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TCharacterForm, CharacterForm);
  Application.CreateForm(TChecklistForm, ChecklistForm);
  Application.CreateForm(TClusterForm, ClusterForm);
  Application.CreateForm(TDistForm, DistForm);
  Application.CreateForm(TKeyForm, KeyForm);
  Application.CreateForm(TTonatForm, TonatForm);
  Application.CreateForm(TViewerForm, ViewerForm);
  Application.CreateForm(TKeyStatesForm, KeyStatesForm);
  Application.CreateForm(TPhyloForm, PhyloForm);
  Application.CreateForm(TScriptForm, ScriptForm);
  Application.Run;
end.

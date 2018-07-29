program Tria;

uses
  Forms,
  Dialogs,
  WettkObj in 'Source\WettkObj.pas',
  AllgComp in 'Source\AllgComp.pas',
  AllgFunc in 'Source\AllgFunc.pas',
  AllgObj in 'Source\AllgObj.pas',
  DateiDlg in 'Source\DateiDlg.pas' {DateiDialog},
  CmdProc in 'Source\CmdProc.pas',
  MannsObj in 'Source\MannsObj.pas',
  SGrpDlg in 'Source\SGrpDlg.pas' {SGrpDialog},
  SGrpObj in 'Source\SGrpObj.pas',
  SMldObj in 'Source\SMldObj.pas',
  TlnDlg in 'Source\TlnDlg.pas' {TlnDialog},
  TlnObj in 'Source\TlnObj.pas',
  TriaMain in 'Source\TriaMain.pas' {Hauptfenster},
  AkObj in 'Source\AkObj.pas',
  WettkDlg in 'Source\WettkDlg.pas' {WettkDialog},
  VeranObj in 'Source\VeranObj.pas',
  TlnErg in 'Source\TlnErg.pas',
  AusgDlg in 'Source\AusgDlg.pas' {AusgDialog},
  LstFrm in 'Source\LstFrm.pas' {LstFrame: TFrame},
  SMldFrm in 'Source\SMldFrm.pas' {SMldFrame: TFrame},
  AnsFrm in 'Source\AnsFrm.pas' {AnsFrame: TFrame},
  RaveUnit in 'Source\RaveUnit.pas' {RaveForm},
  PrevFrm in 'Source\PrevFrm.pas' {PrevFrame: TFrame},
  History in 'Source\History.pas',
  ImpFrm in 'Source\ImpFrm.pas' {ImpFrame: TFrame},
  ZtEinlDlg in 'Source\ZtEinlDlg.pas' {ZtEinlDialog},
  ZtEinlRep in 'Source\ZtEinlRep.pas' {ZtEinlReport},
  ZtLoeschDlg in 'Source\ZtLoeschDlg.pas' {ZtLoeschDialog},
  KlassenDlg in 'Source\KlassenDlg.pas' {KlassenDialog},
  ImpFmtDlg in 'Source\ImpFmtDlg.pas' {ImpFmtDialog},
  ImpFeldDlg in 'Source\ImpFeldDlg.pas' {ImpFeldDialog},
  WkWahlDlg in 'Source\WkWahlDlg.pas' {WkWahlDialog},
  ImpDlg in 'Source\ImpDlg.pas' {ImportDialog},
  hh_funcs in 'Source\hh_funcs.pas',
  hh in 'Source\hh.pas',
  ListFmt in 'Source\ListFmt.pas',
  TriaConfig in 'Source\TriaConfig.pas',
  OptDlg in 'Source\OptDlg.pas' {OptDialog},
  UpdateDlg in 'Source\UpdateDlg.pas' {UpdateDialog},
  MruObj in 'Source\MruObj.pas',
  SerWrtgDlg in 'Source\SerWrtgDlg.pas' {SerWrtgDialog},
  OrtObj in 'Source\OrtObj.pas',
  VstOrtDlg in 'Source\VstOrtDlg.pas' {VstOrtDialog},
  DatExp in 'Source\DatExp.pas',
  VistaFix in 'Source\VistaFix.pas',
  ToDo in 'Source\ToDo.pas',
  InfoDlg in 'Source\InfoDlg.pas' {InfoDialog},
  EinteilenDlg in 'Source\EinteilenDlg.pas' {EinteilenDialog},
  SuchenDlg in 'Source\SuchenDlg.pas' {SuchenDialog},
  AllgConst in 'Source\AllgConst.pas' {/,},
  ImpSexDlg in 'Source\ImpSexDlg.pas' {ImpSexDialog},
  UrkundeDlg in 'Source\UrkundeDlg.pas' {UrkundeDialog},
  SerienDr in 'Source\SerienDr.pas',
  RfidEinlDlg in 'Source\RfidEinlDlg.pas' {RfidEinlDialog};

//FastRep in 'Source\FastRep.pas' {FastReport};

//{$R *.RES} ersetzt durch triaicon.res mit Vista-Icon

{$R 'TriaIcon.res'}

begin
  Application.Initialize;
  Application.Title := 'Tria';
  Application.HelpFile := '';
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THauptFenster, HauptFenster);
  Application.CreateForm(TRaveForm, RaveForm);
  Application.CreateForm(TDateiDialog, DateiDialog);
  //Application.CreateForm(TDruckerDialog, DruckerDialog);
  //Application.CreateForm(TRfidEinlDialog, RfidEinlDialog);
  //Application.CreateForm(TUrkundeDialog, UrkundeDialog);
  //Application.CreateForm(TFastReport, FastReport);
  //Application.CreateForm(TSuchenDialog,SuchenDialog);
  //Application.CreateForm(TImpMschDialog, ImpMschDialog);
  ;
  Application.ShowMainForm := False;
  Application.Run;
end.

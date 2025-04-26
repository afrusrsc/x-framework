unit FM_Demo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  FM_PluginBase;

type

  { TfrmDemo }

  TfrmDemo = class(TfrmPluginBase)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private

  public

  end;

var
  frmDemo: TfrmDemo;

implementation

uses
  FM_Demo2;

  {$R *.lfm}

  { TfrmDemo }

procedure TfrmDemo.Button1Click(Sender: TObject);
begin
  frmDemo2 := TfrmDemo2.Create(self);
  try
    frmDemo2.hParent := Self.Handle;
    frmDemo2.ShowModal;
  finally
    FreeAndNil(frmDemo2);
  end;
end;

procedure TfrmDemo.Button2Click(Sender: TObject);
begin
  if not Assigned(frmDemo2) then
    frmDemo2 := TfrmDemo2.Create(self);
  frmDemo2.hParent := Self.Handle;
  //frmDemo2.ParentWindow := Panel1.Handle;
  frmDemo2.Parent:=Panel1;
  frmDemo2.BorderStyle := bsNone;
  frmDemo2.AutoScroll := True;
  frmDemo2.Left := 0;
  frmDemo2.Top := 0;
  frmDemo2.Align := alClient;
  frmDemo2.Show;
end;

procedure TfrmDemo.Button3Click(Sender: TObject);
begin
  FreeAndNil(frmDemo2);
end;

end.

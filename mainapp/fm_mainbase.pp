{*******************************************************************************
*  Copyright (c) 2025 Jesse Jin Authors. All rights reserved.                  *
*                                                                              *
*  Use of this source code is governed by a MIT-style                          *
*  license that can be found in the LICENSE file.                              *
*                                                                              *
*  版权由作者 Jesse Jin <afrusrsc@126.com> 所有。                              *
*  此源码的使用受 MIT 开源协议约束，详见 LICENSE 文件。                        *
*******************************************************************************}
{*******************************************************************************
  功    能: 主窗体基类
  作    者: Jesse Jin <afrusrsc@126.com>
  创建日期: 2025-04-26
  说    明: 实际的主窗体应从该类继承后再实现具体的独有功能
*******************************************************************************}
unit FM_MainBase;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  uPluginInterface;

type

  { TfrmMainBase }

  TfrmMainBase = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    h: THandle;
    plugin: IPlugin;
    fm: TForm;
  public

  end;

implementation

{$R *.lfm}

procedure DisableFormsCallBack(var FormList: Pointer);
begin
  FormList := Screen.DisableForms(nil, TList(FormList));
end;

procedure EnableFormsCallback(var FormList: Pointer);
begin
  Screen.EnableForms(TList(FormList));
end;

{ TfrmMainBase }

procedure TfrmMainBase.Button1Click(Sender: TObject);
begin
  if h = NilHandle then
    h := LoadLibrary(
      {$IFDEF WINDOWS}
'plugindemo.dll'
      {$ELSE}
      'libplugindemo.so'
      {$ENDIF}
      );
  if h = NilHandle then
    ShowMessage('动态库加载失败');
end;

procedure TfrmMainBase.Button2Click(Sender: TObject);
var
  f: TGetPluginFunc;
  p: TPluginParam;
  mm: TMemoryManager;
begin
  if h <> NilHandle then
  begin
    Pointer(f) := GetProcAddress(h, 'GetPlugin');
    plugin := f();
    GetMemoryManager(mm);
    p.MainAppHandle := Application.Handle;
    p.MainMM := mm;
    p.DisableFormsCallback := @DisableFormsCallBack;
    p.EnableFormsCallback := @EnableFormsCallback;

    plugin.Init(p);

  end;
end;

procedure TfrmMainBase.Button3Click(Sender: TObject);
begin
  if h <> NilHandle then
  begin
    plugin := nil;
    if UnloadLibrary(h) then
      h := NilHandle
    else
      ShowMessage('动态库卸载失败');
  end;
end;

procedure TfrmMainBase.Button4Click(Sender: TObject);
begin
  plugin.ShowModalForm('Demo.TfrmDemo', Self.Handle);
end;

procedure TfrmMainBase.Button5Click(Sender: TObject);
var
  Form: TForm;
begin
  Form := TForm(plugin.CreateForm('Demo.TfrmDemo', Self.Handle));
  //Form.Parent := TabSheet1;
  Form.ParentWindow:=TabSheet1.Handle;
  Form.Top := 1;
  Form.Left := 1;
  Form.Show;
end;

procedure TfrmMainBase.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Button3.Click;
end;

end.

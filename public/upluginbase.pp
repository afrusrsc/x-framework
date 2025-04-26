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
  功    能: 插件基类
  作    者: Jesse Jin <afrusrsc@126.com>
  创建日期: 2025-04-26
  说    明: 1. 每一个插件均应实现一个继承自该基类的实例，且仅需一个
            2. 在该基类的子类中实现具体的管理工作，如注册窗体类等
*******************************************************************************}
unit uPluginBase;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, uPluginInterface;

type

  { TPluginBase }

  TPluginBase = class(TComponent, IPlugin)
  private
    PluginMM: TMemoryManager; //插件自己的内存管理器
    FormList: Pointer;
    EnableFormsCallback: TEnableDisableFormsCallBack;  //模式窗口必须要用
    DisableFormsCallback: TEnableDisableFormsCallBack; //模式窗口必须要用
    procedure DisableForms(Sender: TObject);
    procedure EnableForms(Sender: TObject);
  protected
    //注册窗口类
    procedure RegisterFormClass; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //初始化
    procedure Init(AParam: TPluginParam);
    //反初始化
    procedure UnInit;
    //创建窗口
    function CreateForm(AClassName: string; AParentHandle: THandle): Pointer;
    //释放窗口
    procedure FreeForm(AForm: Pointer);
    //显示模式窗口
    function ShowModalForm(AClassName: string; AParentHandle: THandle): integer;
  end;

implementation

uses
  FM_PluginBase;

  { TPluginBase }

procedure TPluginBase.DisableForms(Sender: TObject);
begin
  DisableFormsCallback(FormList);
end;

procedure TPluginBase.EnableForms(Sender: TObject);
begin
  EnableFormsCallback(FormList);
end;

constructor TPluginBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //记录自身的内存管理器
  GetMemoryManager(PluginMM);
end;

destructor TPluginBase.Destroy;
begin
  UnInit;
  inherited Destroy;
end;

procedure TPluginBase.Init(AParam: TPluginParam);
begin
  //使用主程序的内存管理器
  //if not IsMemoryManagerSet then
  SetMemoryManager(AParam.MainMM);
  //MainAppHandle := AParam.MainAppHandle;
  DisableFormsCallback := AParam.DisableFormsCallback;
  EnableFormsCallback := AParam.EnableFormsCallback;
  Application.AddOnModalBeginHandler(@DisableForms);
  Application.AddOnModalEndHandler(@EnableForms);
  //注册窗口类
  RegisterFormClass;
end;

procedure TPluginBase.UnInit;
begin
  Application.RemoveOnModalBeginHandler(@DisableForms);
  Application.RemoveOnModalEndHandler(@EnableForms);
  //恢复自身的内存管理器
  SetMemoryManager(PluginMM);
end;

function TPluginBase.CreateForm(AClassName: string; AParentHandle: THandle): Pointer;
var
  AClass: TPersistentClass;
  Form: TfrmPluginBase;
begin
  Result := nil;
  AClass := FindClass(AClassName);
  if Assigned(AClass) and AClass.InheritsFrom(TfrmPluginBase) then
  begin
    Form := TfrmPluginBaseClass(AClass).Create(Self);
    Form.hParent := AParentHandle;
    //Form.ParentWindow := AParentHandle;
    Form.Position := poMainFormCenter;
    Result := Pointer(Form);
  end;
end;

procedure TPluginBase.FreeForm(AForm: Pointer);
begin
  FreeAndNil(TForm(AForm));
end;

function TPluginBase.ShowModalForm(AClassName: string; AParentHandle: THandle): integer;
var
  AClass: TPersistentClass;
  Form: TfrmPluginBase;
begin
  Result := 0;
  AClass := FindClass(AClassName);
  if Assigned(AClass) and AClass.InheritsFrom(TfrmPluginBase) then
  begin
    Form := TfrmPluginBaseClass(AClass).Create(Self);
    try
      Form.hParent := AParentHandle;
      Form.Position := poMainFormCenter;
      Result := Form.ShowModal;
    finally
      Form.Free;
    end;
  end;
end;

end.

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
  功    能: 示例插件类
  作    者: Jesse Jin <afrusrsc@126.com>
  创建日期: 2025-04-26
  说    明: 每一个插件工程都需要且仅需要一个该类
*******************************************************************************}
unit uDemo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, uPluginBase;

type

  { TDemo }

  TDemo = class(TPluginBase)
  private
  protected
    //注册窗口类
    procedure RegisterFormClass; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses
  FM_Demo;

  { TDemo }

procedure TDemo.RegisterFormClass;
begin
  RegisterClassAlias(TfrmDemo, 'Demo.TfrmDemo');
end;

constructor TDemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TDemo.Destroy;
begin
  inherited Destroy;
end;

end.

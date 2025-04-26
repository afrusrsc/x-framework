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
  功    能: 插件示例
  作    者: Jesse Jin <afrusrsc@126.com>
  创建日期: 2025-04-26
*******************************************************************************}
library plugindemo;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces,
  Forms,
  uPluginInterface,
  uPluginBase,
  uDemo,
  FM_PluginBase,
  FM_Demo,
  FM_Demo2;

var
  Demo: TDemo;

  function GetPlugin: IPlugin;
    {$IFDEF CPU32}
cdecl;
    {$ENDIF}
  begin
    if not Assigned(Demo) then
      Demo := TDemo.Create(Application);
    Result := Demo;
  end;

exports
  GetPlugin Name 'GetPlugin';

begin
  Application.Initialize;
end.

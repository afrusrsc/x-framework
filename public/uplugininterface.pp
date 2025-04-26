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
  功    能: 插件接口定义
  作    者: Jesse Jin <afrusrsc@126.com>
  创建日期: 2025-04-26
*******************************************************************************}
unit uPluginInterface;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  TEnableDisableFormsCallBack = procedure(var FormList: Pointer);

  TPluginParam = record
    MainAppHandle: THandle;                            //主程序句柄
    MainMM: TMemoryManager;                            //主程序内存管理器
    EnableFormsCallback: TEnableDisableFormsCallBack;  //模式窗口必须要用
    DisableFormsCallback: TEnableDisableFormsCallBack; //模式窗口必须要用
  end;
  PPluginParam = ^TPluginParam;

  //插件接口
  IPlugin = interface
    ['{439954D6-A2F2-4C6E-B9EE-CEC1070D5AE3}']
    //初始化
    procedure Init(AParam: TPluginParam);
    //创建窗口
    function CreateForm(AClassName: string; AParentHandle: THandle): Pointer;
    //释放窗口
    procedure FreeForm(AForm: Pointer);
    //显示模式窗口
    function ShowModalForm(AClassName: string; AParentHandle: THandle): integer;
  end;

  //插件导出函数
  TGetPluginFunc = function: IPlugin; cdecl;

implementation

end.

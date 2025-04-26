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
  功    能: 实际的主窗体
  作    者: Jesse Jin <afrusrsc@126.com>
  创建日期: 2025-04-26
*******************************************************************************}
unit FM_Main;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, FM_MainBase;

type
  TfrmMain = class(TfrmMainBase)
  private

  public

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

end.

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
  功    能: 插件基窗体
  作    者: Jesse Jin <afrusrsc@126.com>
  创建日期: 2025-04-26
  说    明: 插件内的所有窗体都应继承自该窗体
*******************************************************************************}
unit FM_PluginBase;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, LCLType;

type

  { TfrmPluginBase }

  TfrmPluginBase = class(TForm)
  private
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    hParent: THandle;
    constructor Create(TheOwner: TComponent); override;
  end;

  TfrmPluginBaseClass = class of TfrmPluginBase;

implementation

{$R *.lfm}

{ TfrmPluginBase }

procedure TfrmPluginBase.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {$IFDEF LCLWin32}
  Params.WndParent := hParent;
  {$ENDIF}
end;

constructor TfrmPluginBase.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);

end;

end.

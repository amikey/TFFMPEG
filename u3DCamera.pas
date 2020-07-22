unit u3DCamera;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,

  uMediaConstant,
  Winapi.GDIPOBJ, Winapi.GDIPAPI, OpenGL, System.TimeSpan,
  //Winapi.D3D11Shader, Winapi.D3D11,

  Vcl.ExtCtrls,Math,System.SyncObjs,System.Generics.Collections,

  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.DateUtils, mmsystem,
  libavcodec, libavdevice, libavfilter, libswresample, libswscale,
  libavutil, libavformat,
  sdl2, {SDL2_ttf,{sdl, {uResourcePaths,} System.Threading;

type
  TCamera3D = class(TComponent)
  private
    FCameraPoint: TPoint3D;
    FTargetPoint: TPoint3D;
  protected
    //Procedure WMUpdateRender(var Message: TWMEraseBkgnd);message WM_3D_CAMERA_RENDER;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ApplayCamera(Obj:TObject);
  published
    property Camera:TPoint3D Read FCameraPoint Write FCameraPoint;
    property Target:TPoint3D Read FTargetPoint Write FTargetPoint;
  end;

procedure Register;

implementation

uses
  uMediaDisplay;

procedure Register;
begin
  RegisterComponents('MY Media',[TCamera3D]);
end;

{ T3DCamera }

procedure TCamera3D.ApplayCamera(Obj:TObject);
  var MediaDisplay:TMediaDisplay;
begin
  MediaDisplay:= (obj as TMediaDisplay);
  glLoadIdentity();
  glViewport(0,0,MediaDisplay.ClientWidth,MediaDisplay.ClientHeight);
  glMatrixMode( GL_PROJECTION );
  glLoadIdentity();
  (*glOrtho ������������� ����� �������������� (��������������) �������������.
  ��� ������, ��� ����������� ����� ���������� ��� � ���������.
  6 ���������� ���� GLdouble (��� ������ double): left, right, bottom, top, near, far
  ���������� ���������� �������������� �����, ������, ������, �������, ������� �
  ������� ���������� ���������, �.�. ��, ��� �������� �� ����� ���������,
  ���������� �� �����. �� ����� ���� ��� ��������� ������ ������������� ��������
  ������������ ����. ��� ���� ����� ���������� ������������� �������������,
  ������������ ��������� glFrustum � gluPerspective, �� � ��� � �����.*)
  glOrtho(-MediaDisplay.ClientWidth div 2 ,MediaDisplay.ClientWidth div 2
         ,-MediaDisplay.ClientHeight div 2,MediaDisplay.ClientHeight div 2
         ,-800,800);

  (* gluLookAt ������������� ��������� ������: ������ ������ � � ����������, ������ � ������ �����������, ������ � ����������� ��� Y. *)
  gluLookAt(FCameraPoint.x,FCameraPoint.y,FCameraPoint.z, 0,0,0, 0,1,0);
  glMatrixMode( GL_MODELVIEW );
  glLoadIdentity();
end;

constructor TCamera3D.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCameraPoint:=FCameraPoint.SetXYZ(0,0,5);
end;

end.

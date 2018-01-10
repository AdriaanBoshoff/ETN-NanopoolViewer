unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  Tdm = class(TDataModule)
    stylbkthemes: TStyleBook;
    http: TIdHTTP;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.

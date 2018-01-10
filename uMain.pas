unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uDataModule,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, djson, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, FMX.ScrollBox, FMX.Memo,
  IniFiles, System.IOUtils;

type
  TfrmMain = class(TForm)
    pnltop: TPanel;
    lbladdress: TLabel;
    edtaddress: TEdit;
    btnClearAddress: TClearEditButton;
    pnlbottom: TPanel;
    btnRefresh: TButton;
    grpBalance: TGroupBox;
    lblBalance: TLabel;
    lblUnconfirmedBalance: TLabel;
    grpHashRate: TGroupBox;
    lblCurrentHashrate: TLabel;
    lblAvgHashrate: TLabel;
    grpPrices: TGroupBox;
    lblPriceBTC: TLabel;
    lblPriceUSD: TLabel;
    lblPriceEUR: TLabel;
    chkAutoRefresh: TCheckBox;
    tmrAutoRefresh: TTimer;
    procedure GetGeneralInfo;
    procedure GetPrices;
    procedure btnRefreshClick(Sender: TObject);
    procedure chkAutoRefreshChange(Sender: TObject);
    procedure tmrAutoRefreshTimer(Sender: TObject);
    procedure SaveSettingString(Section, Name, Value: string);
    function LoadSettingString(Section, Name, Value: string): string;
    procedure edtaddressChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    configfile: string;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

{ TForm1 }

procedure TfrmMain.btnRefreshClick(Sender: TObject);
begin
  if Trim(edtaddress.Text) <> '' then
  begin
    GetGeneralInfo;
    GetPrices;
  end;
end;

procedure TfrmMain.chkAutoRefreshChange(Sender: TObject);
begin
  tmrAutoRefresh.Enabled := chkAutoRefresh.Enabled;
end;

procedure TfrmMain.edtaddressChange(Sender: TObject);
begin
  SaveSettingString('Info', 'address', edtaddress.Text);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Application.Title := 'ETN nanopool Viewer';

  {$IFDEF ANDROID}
  configfile := System.IOUtils.TPath.GetDocumentsPath + System.SysUtils.PathDelim + 'ETNnanopoolViewer_config.cfg';;
  {$ENDIF}

  {$IFDEF MSWINDOWS}
    configfile := '.\config.cfg';
  {$ENDIF}

  edtaddress.Text := LoadSettingString('Info', 'address', '');
end;

procedure TfrmMain.GetGeneralInfo;
var
  s: TStringList;
  general: TJSON;
  status: Boolean;
begin
  s := TStringList.Create;
  try
    s.Text := dm.http.Get('https://api.nanopool.org/v1/etn/user/' + edtaddress.Text);
    general := TJSON.Parse(s.Text);

    // Check if api return is valid
    status := general['status'].AsBoolean;
    if status = True then
    begin
      // Balance
      lblBalance.Text := 'Current Balance: ' + general['data']['balance'].AsString + ' ETN';
      lblUnconfirmedBalance.Text := 'Unconfirmed Balance: ' + general['data']['unconfirmed_balance'].AsString + ' ETN';

      // Hashrate
      lblCurrentHashrate.Text := 'Current Hashrate: ' + general['data']['hashrate'].AsString + ' H/s';
      lblAvgHashrate.Text := 'Average Hashrate per hour: ' + general['data']['avgHashrate']['h1'].AsString + ' H/s';
    end
    else
      ShowMessage(general['data'].AsString);
  finally
    s.Free;
    general.Free;
  end;
end;

procedure TfrmMain.GetPrices;
var
  s: TStringList;
  price: TJSON;
  status: Boolean;
begin
  s := TStringList.Create;
  try
    s.Text := dm.http.Get('https://api.nanopool.org/v1/etn/prices');
    price := TJSON.Parse(s.Text);

    // Check if api return is valid
    status := price['status'].AsBoolean;
    if status = True then
    begin
      lblPriceBTC.Text := price['data']['price_btc'].AsString + ' BTC';
      lblPriceUSD.Text := price['data']['price_usd'].AsString + ' USD';
      lblPriceEUR.Text := price['data']['price_eur'].AsString + ' EUR';
    end
    else
      ShowMessage(price['data'].AsString);
  finally
    s.Free;
    price.Free;
  end;
end;

function TfrmMain.LoadSettingString(Section, Name, Value: string): string;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(configfile);
  try
    Result := ini.ReadString(Section, Name, Value);
  finally
    ini.Free;
  end;
end;

procedure TfrmMain.SaveSettingString(Section, Name, Value: string);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(configfile);
  try
    ini.WriteString(Section, Name, Value);
  finally
    ini.Free;
  end;
end;

procedure TfrmMain.tmrAutoRefreshTimer(Sender: TObject);
begin
  if Trim(edtaddress.Text) <> '' then
  begin
    GetGeneralInfo;
    GetPrices;
  end;
end;

end.


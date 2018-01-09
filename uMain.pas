unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, djson;

type
  TForm1 = class(TForm)
    pnltop: TPanel;
    lbladdress: TLabel;
    edtaddress: TEdit;
    grpbalance: TGroupBox;
    lblbalance: TLabel;
    grphashrate: TGroupBox;
    lblcurrenthash: TLabel;
    lblavghash: TLabel;
    http: TIdHTTP;
    btnrefresh: TButton;
    tmrRequests: TTimer;
    pnlbottom: TPanel;
    grpprices: TGroupBox;
    lblPriceBTC: TLabel;
    lblPriceUSD: TLabel;
    lblPriceEUR: TLabel;
    procedure btnrefreshClick(Sender: TObject);
    procedure tmrRequestsTimer(Sender: TObject);
  private
    { Private declarations }
    iRequests: Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnrefreshClick(Sender: TObject);
var
  s: TStringList;
  balance, hashrate, price: TJSON;
begin
  if iRequests < 30 then
  begin
    s := TStringList.Create;
    try
      // Balance
      iRequests := iRequests + 1;
      s.Clear;
      s.Text := http.Get('https://api.nanopool.org/v1/etn/balance/' + edtaddress.Text);
      balance := TJSON.Parse(s.Text);
      lblbalance.Caption := 'Balance: ' + balance['data'].AsString + ' ETN';

      // Current Hashrate
      iRequests := iRequests + 1;
      s.Clear;
      s.Text := http.Get('https://api.nanopool.org/v1/etn/hashrate/' + edtaddress.Text);
      hashrate := TJSON.Parse(s.Text);
      lblcurrenthash.Caption := 'Current Calculated Hashrate: ' + hashrate['data'].AsString + ' H/s';

      // Average Hashrate
      iRequests := iRequests + 1;
      s.Clear;
      s.Text := http.Get('https://api.nanopool.org/v1/etn/avghashrate/' + edtaddress.Text);
      hashrate := TJSON.Parse(s.Text);
      lblavghash.Caption := 'Average Hashrate (Last 1 hour): ' + hashrate['data']['h1'].AsString + ' H/s';

      // Prices
      iRequests := iRequests + 1;
      s.Clear;
      s.Text := http.Get('https://api.nanopool.org/v1/etn/prices');
      price := TJSON.Parse(s.Text);
      lblPriceBTC.Caption := price['data']['price_btc'].AsString + ' BTC';
      lblPriceUSD.Caption := price['data']['price_usd'].AsString + ' USD';
      lblPriceEUR.Caption := price['data']['price_eur'].AsString + ' EUR';
    finally
      s.Free;
      balance.Free;
    end;
  end
  else
    ShowMessage('You can only make 25 requests per minute.');
end;

procedure TForm1.tmrRequestsTimer(Sender: TObject);
begin
  iRequests := 0;
end;

end.


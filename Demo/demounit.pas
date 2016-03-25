unit demounit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  BroadcastReceiver,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Edit, FMX.StdCtrls,

  Androidapi.jni.App,
    AndroidApi.JNIBridge,
    Androidapi.JNI.GraphicsContentViewText,
    Androidapi.IOUtils,
    Androidapi.JNI.Telephony,
    Androidapi.jni.Provider,
    Androidapi.JNI.Dalvik;

type
  TForm1 = class(TForm)
    Button1: TButton;
    BroadcastReceiver1: TBroadcastReceiver;
    Button2: TButton;
    Edit1: TEdit;
    Memo1: TMemo;
    procedure BroadcastReceiver1Receive(Context: JContext; Intent: JIntent);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
    fReceiverRegistered:boolean;
    procedure internal_ReceiveBroadcast(Context: jContext; Intent: jIntent);
    procedure Process_Input(vInput:string);
  public
    { Public-Deklarationen }
  end;

const
    myIntentName = 'org.intentreceiver.bcd';

    DATAWEDGE_DATA_STRING='com.motorolasolutions.emdk.datawedge.data_string';
    DATAWEDGE_ACTION_SOFTSCANTRIGGER='com.motorolasolutions.emdk.datawedge.api.ACTION_SOFTSCANTRIGGER';
    DATAWEDGE_EXTRA_PARAMETER='com.motorolasolutions.emdk.datawedge.api.EXTRA_PARAMETER';
    DATAWEDGE_START_SCANNING='START_SCANNING';

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses FMX.Platform.Android, Androidapi.JNI.JavaTypes, Androidapi.JNI.Net, Androidapi.JNI.Os, Androidapi.Helpers;

procedure TForm1.BroadcastReceiver1Receive(Context: JContext; Intent: JIntent);
begin
    tThread.CreateAnonymousThread(procedure begin
        internal_ReceiveBroadcast(Context, Intent);
    end).start;
end;
procedure tForm1.internal_ReceiveBroadcast(Context: jContext; Intent: jIntent);
var
    vInput:String;
begin
    // in Thread
    vInput:=JStringToString(intent.getStringExtra(StringToJString(DATAWEDGE_DATA_STRING)));
    vInput:=trim(vInput);

    if trim(vInput)<>'' then begin
        tThread.Synchronize(nil, procedure begin
            Process_Input(vinput);
        end);
    end;
end;
procedure tForm1.Process_Input(vInput:string);
begin
    // in Mainthread
    memo1.lines.add('*receive*'+vinput+'*');
    edit1.text:=vinput;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    if fReceiverRegistered=false then begin
        BroadcastReceiver1.RegisterReceive;
        BroadcastReceiver1.Add(myIntentName);
        fReceiverRegistered:=true;
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
    i: JIntent;
begin
    i := TJIntent.JavaClass.init;
    i.setAction(StringToJString(DATAWEDGE_ACTION_SOFTSCANTRIGGER));
    i.putExtra(StringToJString(DATAWEDGE_EXTRA_PARAMETER), StringtoJString(DATAWEDGE_START_SCANNING));
    tandroidhelper.Activity.sendBroadcast(i);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    fReceiverRegistered:=false;
end;

end.

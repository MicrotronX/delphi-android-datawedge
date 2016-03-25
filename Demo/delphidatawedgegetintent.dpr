program delphidatawedgegetintent;

uses
  System.StartUpCopy,
  FMX.Forms,
  demounit in 'demounit.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

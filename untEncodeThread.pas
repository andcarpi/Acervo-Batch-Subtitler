unit untEncodeThread;

interface

uses
  System.Classes, System.SysUtils, Winapi.ShellAPI, Vcl.CheckLst, WinAPI.Windows,
  VCL.ComCtrls;

type
  TEncodeThread = class(TThread)
  private
    FHandBreakPath: String;
    FParams: String;
    FFileList: TListView;
    FIndex: Integer;
    FStatus: String;
    FGroupId: Integer;
    //CurrentProgress: Integer;
    { Private declarations }

    procedure UpdateStatus;
  protected
    procedure Execute; override;
  public
    IndexP: Integer;
    Finished: Boolean;
    constructor Create(const HandBreakPath, Params : string; const FileList: TListView; const Index: Integer);// aList: TCheckListBox;  ListIndex: Integer; var Counter: Integer);
  end;

implementation

uses untPrincipal;

function ExecuteProcess(const FileName, Params: string; Folder: string; WaitUntilTerminated, WaitUntilIdle, RunMinimized: boolean;
  var ErrorCode: integer): boolean;
var
  CmdLine: string;
  WorkingDirP: PChar;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  Result := true;
  CmdLine := '"' + FileName + '" ' + Params;
  if Folder = '' then Folder := ExcludeTrailingPathDelimiter(ExtractFilePath(FileName));
  ZeroMemory(@StartupInfo, SizeOf(StartupInfo));
  StartupInfo.cb := SizeOf(StartupInfo);
  if RunMinimized then
    begin
      StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
      StartupInfo.wShowWindow := SW_HIDE;
    end;
  if Folder <> '' then WorkingDirP := PChar(Folder)
  else WorkingDirP := nil;
  if not CreateProcess(nil, PChar(CmdLine), nil, nil, false, 0, nil, WorkingDirP, StartupInfo, ProcessInfo) then
    begin
      Result := false;
      ErrorCode := GetLastError;
      exit;
    end;
  with ProcessInfo do
    begin
      CloseHandle(hThread);
      if WaitUntilIdle then WaitForInputIdle(hProcess, INFINITE);
      if WaitUntilTerminated then
        repeat
        until MsgWaitForMultipleObjects(1, hProcess, false, INFINITE, QS_ALLINPUT) <> WAIT_OBJECT_0 + 1;
      CloseHandle(hProcess);
    end;
end;

{
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure EncodeThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end;

    or

    Synchronize(
      procedure
      begin
        Form1.Caption := 'Updated in thread via an anonymous method'
      end
      )
    );

  where an anonymous method is passed.

  Similarly, the developer can call the Queue method with similar parameters as
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.

}

{ EncodeThread }

constructor TEncodeThread.Create(const HandBreakPath, Params : string; const FileList: TListView; const Index: Integer);// aList: TCheckListBox;  ListIndex: Integer; var Counter: Integer);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FHandBreakPath := HandBreakPath;
  FParams := Params;
  FFileList := FileList;
  FIndex := Index;
  IndexP := Index;
  Finished := False;

end;

procedure TEncodeThread.Execute;
var
i: integer;
begin
  inherited;
  FStatus := 'Processando...';
  FGroupId := 1;
  Synchronize(UpdateStatus);

  ExecuteProcess(FHandBreakPath, FParams, '', true, false, true, i);

  FStatus := 'Encerrado!';
  FGroupId := 2;
  Synchronize(UpdateStatus);
end;

procedure TEncodeThread.UpdateStatus;
begin
  FFileList.Items[FIndex].SubItems[1] := FStatus;
  FFileList.Items[FIndex].SubItems[2] := IntToStr(FGroupId);
end;

end.

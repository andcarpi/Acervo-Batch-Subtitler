{
A unit for saving/loading all the form's control settings with just one line of code.
You don't need to use TIniFile any more!
This saves hundreds of thousands of lines of code and bugs.

This method for saving/loading the program's settings
requires a new concepiton for using the form - it is
a hodlder for the program's settings, it reads them with LoadForms() after it is created
and saves them with SaveForms() before it is destroyed.
After the form is created, the code loads the variables' values according
to the state of the form's controls, not the opposite (which is the typical usage)

All of the program's settings are saved between the versions, the only requirement
is if you change a control's behaviour (e.g. the position of an edit,
the order of a tool button), you need to give the control a new name.
Otherwise, the control will have its old behaviour.
The only exception are binary resources (e.g. the picture of a TImage),
becuase binar resources are not saved.
If you change the name of a form, none of its controls' settings will be loaded.
When trying to read a renamed or deleted control, no exceptions are raised -
the control is just skipped.
Default values of properties are also saved, so that they can override
non-default values.

All settings are saved in a single text file, which contains
the textual representations of the program's forms, thus making it
easy to be viewed in a text editor.
The whole file is gzipped, so you need to unzip it first to view it as a text file.

The unit has been tested only in D7 and probably will need a lot of work to be
compatible with other versions (especially the PatchIsDefaultPropertyValue()
procedure and the ZLib unit).

I would like to thank Marco Canto about his wonderful chapters on RTL and VCL
that gave me the start idea of how this could be.

(c) Alex Mitev, alexmi@abv.bg, February 2005
You can use this unit freely, but please let me know if you make any improvements in it.
}


// a conditional symbol for saving the settigns file in text format, without archiving
//{$DEFINE DEBUG}

unit FormPersist;

interface

uses
  Classes, SysUtils, Forms, ZLib, TypInfo, Windows, Dialogs;

type
    {
    A class that supports files with sections
    It resembles very much TIniFile and in fact uses some of the code
    for TMemIniFile, but it has some major differences:
      - doesn't support keys, only values are written, as they are
      - supports ONLY ONE value per section, which CAN be multiline, unlike TIniFile
      - doesn't modify the value's data (doesn't trim spaces, doesn't add keys, etc.) unlike TIniFile

    The file format is NOT compatible with TIniFile - it WON'T read it
    and in fact it will DAMAGE the file (eat spaces, etc.)

    The file format is appropriate for saving the textual representation
    of multiple forms, as well as some other data (e.g. version info) into a single file.

    You can use this class for your own needs too. For example saving an
    e-mail message in a single text file, where the "body" field is multiline and formatted
    }
  TSectionFile = class(TObject)
  private
    FSections: TStringList;
    function AddSection(const Section: string): TStrings;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function SectionExists(const Section: string): Boolean;
    procedure ReadSection(const Section: string; Strings: TStrings); overload;
    function ReadSection(const Section: string): String; overload;
    procedure EraseSection(const Section: string);
    procedure WriteSection(const Section: string; Strings: TStrings); overload;
    procedure WriteSection(const Section: string; const Str: String); overload;
    function ReadSections(Strings: TStrings): Boolean;

    procedure GetStrings(List: TStrings);
    procedure SetStrings(List: TStrings);

    procedure LoadFromFile(const FileName: string);
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToFile(const FileName: string);
    procedure SaveToStream(Stream: TStream);
  end;

    {
    Loads all forms' settigns, specified by the AForms parameter.
    The best place put this function is before Application.Run in
    the project file or in the form's OnCreate() method
    Avoid calling this procedure mulpiple times in a for loop, because for
    each call the settings file is decompressed and read in memory. Instead,
    create an array of TForm, fill it with data and then call the procedure.
    }
  procedure LoadForms(AForms: array of TForm);
    {
    Saves all forms' settigns, specified by the AForms parameter.
    The best place put this function is after Application.Run in
    the project file or in the form's OnDestroy() method
    Avoid calling this procedure mulpiple times in a for loop, because for
    each call the settings file is decompressed and then compressed again. Instead,
    create an array of TForm, fill it with data and then call the procedure.
    }
  procedure SaveForms(AForms: array of TForm);
    // the same as LoadForms, but loads all screen forms
  procedure LoadAllForms;
    // the same as SaveForms, but saves all screen forms
  procedure SaveAllForms;

  
implementation

type
    {
    The original idea for this class was taken from the class AsInheritedReader
    in the Demos\RichEdit demo (which shows how to reload a form from a resource
    at run-time), but was developed further. Now the only common thing between
    the two classes is the ReadPrefix() procedure.
    }
  TFormSettingsReader = class(TReader)
  private
    procedure ErrorEvent(Reader: TReader; const Message: string; var Handled: Boolean);
  public
    constructor Create(Stream: TStream; BufSize: Integer);
    procedure ReadPrefix(var Flags: TFilerFlags; var AChildPos: Integer); override;
  end;

  TFormSettingsWriter = class(TWriter)
  public
    procedure DefineBinaryProperty(const Name: string;
      ReadData, WriteData: TStreamProc;
      HasData: Boolean); override;
  end;


{ TFormSettingsReader }

constructor TFormSettingsReader.Create(Stream: TStream; BufSize: Integer);
begin
  inherited;
  OnError := ErrorEvent;
end;

procedure TFormSettingsReader.ErrorEvent(Reader: TReader; const Message: string;
  var Handled: Boolean);
begin
    {
    EClassNotFound is raised if a class name that has not been linked
    into the current application is encountered when reading a component from a stream,
    i.e. the user has deleted all components from a given class since the last save

    EReadError is raised  if a property can't be read while creating a form,
    i.e. the user has deleted a component (and thus its associated published field) since the last save
    }
  if (ExceptObject is EClassNotFound) or (ExceptObject is EReadError) then
    Handled := True;
end;

procedure TFormSettingsReader.ReadPrefix(var Flags: TFilerFlags; var AChildPos: Integer);
begin
  inherited ReadPrefix(Flags, AChildPos);
    // when Flags contains ffInherited, TReader.ReadComponent will find
    // the existing component instead of creating a new one
  Include(Flags, ffInherited);
end;


{ TFormSettingsWriter }

procedure TFormSettingsWriter.DefineBinaryProperty(const Name: string;
  ReadData, WriteData: TStreamProc; HasData: Boolean);
begin
  // Don't save binary properties.
  // If you want to enable saving of binary properties, call
  // inherited;
  // This will have a very negative impact on the size of the settigns file.
end;

{
TWriter doesn't write properties with default values to the stream.
It's a great feature of the streaming system, reducing the size of
the resource files, but for my case of streaming I need to have
ALL properties written, so that when later their values change to
non-defaults I can override them with the empty defaults written
earlier to the the stream.

The goal can be achieved in several ways:
1. Since TWriter.WriteProperty() checks that the property is
   not with default value (using Classes.IsDefaultPropertyValue()),
   it seems logical to override it and implement new behaviour.
   However, the method is declared as static and it's impossible to be overriden.
   It would be so much easier if it were virtual...
2. Since the method is not virtual and is linked with many private
   and static methods in TWriter, the other approach is to copy
   the entire source code of TWriter (and maybe some procedures private to
   the Classes unit) into this unit and then modify the WriteProperty()
   method. This approach would definitely work, however I didn't want to
   fill my unit with more than 1000 lines of complex and version-dependent
   code just to be able to comment one if-statement!
3. Another idea is to replace somehow Classes.IsDefaultPropertyValue(), so
   that it returns always False. Unfortunately, the system doesn't provide
   a global replacement variable for this function.
4. It's not possible to REPLACE the function, but it's possible to MODIFY
   its behaviour at run-time. This concept is known as self-modifying code.
   It consists of applying a low-level patch, replacing some machine code
   in the memory of the process at run-time.
   The memory write is done with the API function WriteProcessMemory().

   I patch the code of Classes.IsDefaultPropertyValue(), so that it always
   returns False, and TWriter.WriteProperty() writes ALL properties of the component.

   Self-modifying code is great for assembler overrides :-)))) of static procedures,
   but I wouldn't reccommend it for a wide use.
   The first time that I saw it was for fixing the D4 TListBox.ItemIndex bug -
   a solution by Hallvard Vassbotn at
   http://www.eagle-software.com/FixingTheItemIndexBug.htm
   Then I noticed somebody using it for piracy protection scheme at
   http://www.undu.com/Articles/990212d.html
   There is even an article of how to call private methods of a class
   (in fact just the same method) at
   http://www.deepsoftware.ru/articles/callprivate.html

There is no need to "un-patch" the code, because TWriter is not used
by the streaming system at run-time.
}

procedure PatchIsDefaultPropertyValue;
type
  T3Bytes = array[0..2] of Byte;
  T4Bytes = array[0..3] of Byte;

  // there is no standart type with size 3 bytes that we can use to compare
  // 3 bytes, wo we write a custom function
function Compare3Bytes(const Val1, Val2: T3Bytes): Boolean;
begin
  Result := (Val1[0] = Val2[0])
        and (Val1[1] = Val2[1])
        and (Val1[2] = Val2[2]);
end;

const
  EndOfFunc: T4Bytes = (
    $5D,         // pop ebp
    $C2,$08,$00  // ret $0008
  );
    // The release and debug versions of Classes.pas compile to different machine code,
    // so we need 2 different patches depending on which version of Classes.pas
    // the program is linked in
  ReleaseBytes: T3Bytes = (
    $8B,$C3,     // mov eax, ebx
    $5B          // pop ebx
  );
  ReleasePatch: T3Bytes = (
    $33,$C0,     // xor eax, eax
    $5B          // pop ebx
  );
  DebugBytes: T3Bytes = (
    $8A,$45,$E3  // mov al, [ebp-$1d]
  );
  DebugPatch: T3Bytes = (
    $33,$C0,     // xor eax, eax
    $90          // nop
  );
var
  PBytes, PPatch: Pointer;
  WrittenBytes: Cardinal;
begin
  PBytes := @Classes.IsDefaultPropertyValue;

  while Integer(PBytes^) <> Integer(EndOfFunc) do
    Integer(PBytes) := Integer(PBytes) + 1;

  Integer(PBytes) := Integer(PBytes) - 5;

  PPatch := nil;
  if Compare3Bytes(T3Bytes(PBytes^), ReleaseBytes) then
      // the program is linked to the release version of Classes.pas
    PPatch := @ReleasePatch
  else if Compare3Bytes(T3Bytes(PBytes^), DebugBytes) then
      // the program is linked to the debug version of Classes.pas
    PPatch := @DebugPatch;

  if PPatch <> nil then
    WriteProcessMemory(GetCurrentProcess, PBytes, PPatch,
      SizeOf(T3Bytes), WrittenBytes);
end;

// A general procedure for compressing a stream
procedure CompressStream(ASource, ATarget: TStream);
begin
  with TCompressionStream.Create(clDefault, ATarget) do
    try
      CopyFrom(ASource, ASource.Size);
    finally
      Free;
    end;
end;

// A general procedure for decompressing a stream
procedure DecompressStream(ASource, ATarget: TStream);
var
  Buf: array[0..1023] of Byte;
  nRead: Integer;
begin
  with TDecompressionStream.Create(ASource) do
    try
        // ATarget.CopyFrom(DecompStream, 0) won't work, because CopyFrom requests the
        // size of the stream when the Count parameter is 0, and TDecompressionStream
        // doesn't support requesting the size of thå stream
      repeat
        nRead := Read(Buf, 1024);
        ATarget.Write(Buf, nRead);
      until nRead = 0;
    finally
      Free;
    end;
end;

function LoadSettingsFile(ASectionFile: TSectionFile): Boolean;
var
  msCompFile, msDecompFile: TMemoryStream;
  SettingsFileName: String;
begin
  Result := False;

  msCompFile := TMemoryStream.Create;
  msDecompFile := TMemoryStream.Create;
  try
    SettingsFileName := ChangeFileExt(Application.ExeName, '.ini');
    if FileExists(SettingsFileName) then
    begin
      msCompFile.LoadFromFile(SettingsFileName);
      msCompFile.Position := 0;
      DecompressStream(msCompFile, msDecompFile);
      msDecompFile.Position := 0;
      ASectionFile.LoadFromStream(msDecompFile);
      Result := True;
    end;
  except
    {$IFDEF DEBUG}
    on E: ECompressionError do
      try
        msCompFile.Position := 0;      
        ASectionFile.LoadFromStream(msCompFile);
        Result := True;
      except
      end;
    {$ENDIF}
  end;
  msCompFile.Free;
  msDecompFile.Free;
end;

function SaveSettingsFile(ASectionFile: TSectionFile): Boolean;
var
  msCompFile, msDecompFile: TMemoryStream;
  SettingsFileName: String;
begin
  Result := False;

  msCompFile := TMemoryStream.Create;
  msDecompFile := TMemoryStream.Create;
  try
    SettingsFileName := ChangeFileExt(Application.ExeName, '.ini');
    ASectionFile.SaveToStream(msDecompFile);
    msDecompFile.Position := 0;
    {$IFNDEF DEBUG}
      CompressStream(msDecompFile, msCompFile);
    {$ELSE}
      msCompFile.CopyFrom(msDecompFile, 0);
    {$ENDIF}
    msCompFile.Position := 0;
    msCompFile.SaveToFile(SettingsFileName);
    Result := True;
  except
  end;
  msCompFile.Free;
  msDecompFile.Free;
end;


procedure LoadForms(AForms: array of TForm);
  procedure LoadFormFromStream(AForm: TForm; AStream: TStream);
  var
    OrigName: String;
  begin
    with TFormSettingsReader.Create(AStream, 4096) do
      try
        OrigName := AForm.Name;
        AForm := ReadRootComponent(AForm) as TForm;
          // By default, the streaming system changes the name of the form,
          // because a form with the same name already exists.
          // It is safe to restore the original name after the streaming process is done.
        AForm.Name := OrigName;
      finally
        Free;
      end;
  end;
var
  SectionFile: TSectionFile;
  msBinary, msText: TMemoryStream;
  Strings: TStringList;
  I: Integer;
begin
  SectionFile := TSectionFile.Create;
  msBinary := TMemoryStream.Create;
  msText := TMemoryStream.Create;
  Strings := TStringList.Create;
  try
    if not LoadSettingsFile(SectionFile) then Exit;

    for I := Low(AForms) to High(AForms) do
    begin
      SectionFile.ReadSection(AForms[I].Name, Strings);
      if Strings.Count > 0 then
      begin
        msText.Position := 0;
        Strings.SaveToStream(msText);
        msText.Position := 0;
        msBinary.Position := 0;
        ObjectTextToBinary(msText, msBinary);
        msBinary.Position := 0;
        LoadFormFromStream(AForms[I], msBinary);
      end;
    end;
  finally
    SectionFile.Free;
    msBinary.Free;
    msText.Free;
    Strings.Free;
  end;
end;

procedure SaveForms(AForms: array of TForm);
  procedure SaveFormToStream(AForm: TForm; AStream: TStream);
  begin
    with TFormSettingsWriter.Create(AStream, 4096) do
      try
        WriteDescendent(AForm, nil);
      finally
        Free;
      end;
  end;
var
  SectionFile: TSectionFile;
  msBinary, msText: TMemoryStream;
  Strings: TStringList;
  I: Integer;
begin
  SectionFile := TSectionFile.Create;
  msBinary := TMemoryStream.Create;
  msText := TMemoryStream.Create;
  Strings := TStringList.Create;
  try
    LoadSettingsFile(SectionFile);

    for I := Low(AForms) to High(AForms) do
    begin
      msBinary.Position := 0;
      SaveFormToStream(AForms[I], msBinary);
      msBinary.Position := 0;
      msText.Position := 0;
      ObjectBinaryToText(msBinary, msText);
      msText.Position := 0;
      Strings.LoadFromStream(msText);
      SectionFile.WriteSection(AForms[I].Name, Strings);
    end;

    SaveSettingsFile(SectionFile);
  finally
    SectionFile.Free;
    msBinary.Free;
    msText.Free;
    Strings.Free;
  end;
end;

procedure LoadAllForms;
var
  FormsArr: array of TForm;
  I: Integer;
begin
  SetLength(FormsArr, Screen.FormCount);
  for I := 0 to Screen.FormCount - 1 do
    FormsArr[I] := Screen.Forms[I];
  LoadForms(FormsArr);
end;

procedure SaveAllForms;
var
  FormsArr: array of TForm;
  I: Integer;
begin
  SetLength(FormsArr, Screen.FormCount);
  for I := 0 to Screen.FormCount - 1 do
    FormsArr[I] := Screen.Forms[I];
  SaveForms(FormsArr);
end;


{ TSectionFile }

constructor TSectionFile.Create;
begin
  inherited;
  FSections := TStringList.Create;
end;

destructor TSectionFile.Destroy;
begin
  if FSections <> nil then
    Clear;
  FSections.Free;

  inherited;
end;

function TSectionFile.AddSection(const Section: string): TStrings;
begin
  Result := TStringList.Create;
  try
    FSections.AddObject(Section, Result);
  except
    Result.Free;
    raise;
  end;
end;

procedure TSectionFile.Clear;
var
  I: Integer;
begin
  for I := 0 to FSections.Count - 1 do
    TObject(FSections.Objects[I]).Free;
  FSections.Clear;
end;

function TSectionFile.SectionExists(const Section: string): Boolean;
begin
    // if the section name exists, then the section is non-empty
  Result := FSections.IndexOf(Section) >= 0;
end;

procedure TSectionFile.ReadSection(const Section: string;
  Strings: TStrings);
var
  I: Integer;
begin
  Strings.Clear;
  I := FSections.IndexOf(Section);
  if I >= 0 then
    Strings.Assign(TStrings(FSections.Objects[I]));
end;

function TSectionFile.ReadSection(const Section: string): String;
var
  Strings: TStringList;
begin
  Strings := TStringList.Create;
  try
    ReadSection(Section, Strings);
    if Strings.Count > 0 then
      Result := Strings[0]
    else
      Result := '';
  finally
    Strings.Free;
  end;
end;

procedure TSectionFile.WriteSection(const Section: string;
  Strings: TStrings);
var
  I: Integer;
  Str: TStrings;
begin
  if Assigned(Strings) and (Strings.Count > 0) then
  begin
    I := FSections.IndexOf(Section);
    if I >= 0 then
      Str := TStrings(FSections.Objects[I])
    else
      Str := AddSection(Section);

    Str.Assign(Strings);
  end
  else
    EraseSection(Section);
end;

procedure TSectionFile.WriteSection(const Section: string; const Str: String);
var
  Strings: TStringList;
begin
  Strings := nil;
  try
    if Str <> '' then
    begin
      Strings := TStringList.Create;
      Strings.Append(Str);
    end;

    WriteSection(Section, Strings);
  finally
    if Assigned(Strings) then Strings.Free;
  end;
end;

function TSectionFile.ReadSections(Strings: TStrings): Boolean;
begin
  Strings.Assign(FSections);
  Result := Strings.Count > 0;
end;

procedure TSectionFile.EraseSection(const Section: string);
var
  I: Integer;
begin
  I := FSections.IndexOf(Section);

  if I >= 0 then
  begin
    TStrings(FSections.Objects[I]).Free;
    FSections.Delete(I);
  end;
end;

procedure TSectionFile.GetStrings(List: TStrings);
var
  I, J: Integer;
  Strings: TStrings;
begin
  List.BeginUpdate;
  try
    for I := 0 to FSections.Count - 1 do
    begin
      List.Add('[' + FSections[I] + ']');
      Strings := TStrings(FSections.Objects[I]);
      for J := 0 to Strings.Count - 1 do
        List.Add(Strings[J]);
    end;
  finally
    List.EndUpdate;
  end;
end;

procedure TSectionFile.SetStrings(List: TStrings);
var
  I: Integer;
  S: string;
  Strings: TStrings;
begin
  Clear;
  Strings := nil;
  for I := 0 to List.Count - 1 do
  begin
    S := List[I];

                     // the line is not a cooment
    if (S <> '') and (S[1] <> ';') then
      if (S[1] = '[') and (S[Length(S)] = ']') then // a section
      begin
        Delete(S, 1, 1);
        SetLength(S, Length(S)-1);
        Strings := AddSection(Trim(S));
      end
      else
        if Strings <> nil then
          Strings.Add(S);
  end;
end;

procedure TSectionFile.LoadFromFile(const FileName: string);
var
  Strings: TStringList;
begin
  Strings := TStringList.Create;
  try
    Strings.LoadFromFile(FileName);
    SetStrings(Strings);
  finally
    Strings.Free;
  end;
end;

procedure TSectionFile.LoadFromStream(Stream: TStream);
var
  Strings: TStringList;
begin
  Strings := TStringList.Create;
  try
    Strings.LoadFromStream(Stream);
    SetStrings(Strings);
  finally
    Strings.Free;
  end;
end;

procedure TSectionFile.SaveToFile(const FileName: string);
var
  Strings: TStringList;
begin
  Strings := TStringList.Create;
  try
    GetStrings(Strings);
    Strings.SaveToFile(FileName);
  finally
    Strings.Free;
  end;
end;

procedure TSectionFile.SaveToStream(Stream: TStream);
var
  Strings: TStringList;
begin
  Strings := TStringList.Create;
  try
    GetStrings(Strings);
    Strings.SaveToStream(Stream);
  finally
    Strings.Free;
  end;
end;

initialization
  PatchIsDefaultPropertyValue;

end.

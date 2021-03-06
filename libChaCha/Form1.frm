VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   7545
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   12735
   LinkTopic       =   "Form1"
   ScaleHeight     =   7545
   ScaleWidth      =   12735
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox chkChinaSafe 
      Caption         =   "China safe"
      Height          =   285
      Left            =   11610
      TabIndex        =   16
      Top             =   90
      Width           =   1050
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Test 4"
      Height          =   375
      Left            =   10440
      TabIndex        =   15
      Top             =   495
      Width           =   1050
   End
   Begin VB.CommandButton cmdStrTest 
      Caption         =   "Test 2"
      Height          =   330
      Left            =   10440
      TabIndex        =   14
      Top             =   45
      Width           =   1050
   End
   Begin VB.CheckBox chkUseNonce 
      Caption         =   "Use Nonce/cnt"
      Height          =   240
      Left            =   8100
      TabIndex        =   13
      Top             =   45
      Width           =   1950
   End
   Begin VB.TextBox txtNonce 
      Height          =   285
      Left            =   2745
      TabIndex        =   12
      Top             =   45
      Width           =   1365
   End
   Begin VB.TextBox txtCount 
      Height          =   285
      Left            =   4815
      TabIndex        =   9
      Text            =   "0"
      Top             =   45
      Width           =   510
   End
   Begin VB.CheckBox chkisFile 
      Caption         =   "isFile"
      Height          =   285
      Left            =   8100
      TabIndex        =   7
      Top             =   405
      Width           =   915
   End
   Begin VB.TextBox txtDecrypt 
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3300
      Left            =   90
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   6
      Top             =   4185
      Width           =   10095
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Encrypt"
      Height          =   375
      Left            =   9045
      TabIndex        =   5
      Top             =   360
      Width           =   1140
   End
   Begin VB.TextBox txtCrypt 
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3300
      Left            =   90
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   4
      Top             =   810
      Width           =   10095
   End
   Begin VB.TextBox txtPass 
      Height          =   285
      Left            =   630
      TabIndex        =   3
      Text            =   "password1"
      Top             =   45
      Width           =   1140
   End
   Begin VB.TextBox txtMsg 
      Height          =   330
      Left            =   630
      OLEDropMode     =   1  'Manual
      TabIndex        =   0
      Text            =   "this is my message!"
      Top             =   360
      Width           =   7305
   End
   Begin VB.Label Label5 
      Caption         =   "Nonce"
      Height          =   285
      Left            =   1980
      TabIndex        =   11
      Top             =   45
      Width           =   690
   End
   Begin VB.Label Label4 
      Caption         =   "input supports file drag and drop"
      Height          =   240
      Left            =   5490
      TabIndex        =   10
      Top             =   45
      Width           =   2265
   End
   Begin VB.Label Label3 
      Caption         =   "Count"
      Height          =   240
      Left            =   4230
      TabIndex        =   8
      Top             =   90
      Width           =   555
   End
   Begin VB.Label Label2 
      Caption         =   "Pass"
      Height          =   240
      Left            =   90
      TabIndex        =   2
      Top             =   45
      Width           =   510
   End
   Begin VB.Label Label1 
      Caption         =   "Input"
      Height          =   240
      Left            =   90
      TabIndex        =   1
      Top             =   405
      Width           =   465
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Declare Sub test Lib "libchacha" (ByVal key As String)
Private Declare Sub test2 Lib "libchacha" (ByRef key As String)
        
        
'use this one for setting all params explicitly or for binary key (even embedded null)
Private Declare Sub chainit Lib "libchacha" ( _
            ByRef key As String, _
            Optional ByRef nOnce As String, _
            Optional ByVal counter As Long = 0 _
        )
        
'this one uis always safe to use even on non-us systems...
'you can also just include th key here to use simply..
Private Declare Function chacha Lib "libchacha" ( _
            ByRef buf() As Byte, _
            Optional ByRef key As String _
        ) As Byte()


'in case you prefer to pass in a string/byte array..
'on US systems data can be a binary string..but this will fail if
'system is say chinese..still handy for initial encryption though...
Private Declare Function chacha2 Lib "libchacha" ( _
            ByRef data As String, _
            Optional ByRef key As String _
        ) As Byte()

     
'same notes as chacha2, but only safe on US systems..
Private Declare Function chacha4 Lib "libchacha" ( _
            ByRef data As String, _
            Optional ByRef key As String _
        ) As String
        
Dim hLib As Long
Const LANG_US = &H409
Private Declare Function FreeLibrary Lib "kernel32" (ByVal hLibModule As Long) As Long
Private Declare Function LoadLibrary Lib "kernel32" Alias "LoadLibraryA" (ByVal lpLibFileName As String) As Long

'so we can test binary passwords..
Function expand(s) As String
    Dim sPass As String
    sPass = Replace(s, "\x0", Chr(0))
    sPass = Replace(sPass, "\n", vbLf)
    sPass = Replace(sPass, "\r", vbCr)
    sPass = Replace(sPass, "\t", vbTab)
    expand = sPass
End Function

Private Sub chkChinaSafe_Click()
    If chkChinaSafe.value = 1 Then
        Command2.Caption = Command2.Caption & " !"
    Else
        Command2.Caption = Replace(Command2.Caption, " !", Empty)
    End If
End Sub

Private Sub cmdStrTest_Click()

    Dim bOut() As Byte
    Dim bDec() As Byte
    Dim cnt As Long

    chkisFile.value = 0
    chkUseNonce.value = 0
    Me.Caption = "Starting cycle.."
    bOut() = chacha2(txtMsg, txtPass)
    
    If AryIsEmpty(bOut) Then
        txtCrypt = "Encryption Failed!"
        Exit Sub
    End If
    
    Dim sOut As String
    sOut = StrConv(bOut, vbUnicode, LANG_US)
    txtCrypt = hexdump(sOut)
    
    If chkChinaSafe.value = 0 Then
        bDec() = chacha2(sOut, txtPass) 'only safe for binary data on US systems
    Else
        bDec() = chacha(bOut, txtPass)
    End If
    
    If AryIsEmpty(bDec) Then
        txtDecrypt = "Decryption Failed!"
        Exit Sub
    End If
    
    sOut = StrConv(bDec, vbUnicode, LANG_US)
    txtDecrypt = hexdump(sOut)
        
    If txtMsg <> sOut Then
        Me.Caption = "Decryption Failed!"
        Exit Sub
    End If
    
    Me.Caption = "Success exact match!"
    
End Sub

Private Sub Command1_Click()

    Dim b() As Byte
    Dim bOut() As Byte
    Dim bDec() As Byte
    Dim cnt As Long
    Dim sPass As String
    Dim sNOnce As String
    
    sPass = expand(txtPass)
    sNOnce = expand(txtNonce)
    
    If IsNumeric(txtCount) Then
        cnt = CLng(txtCount)
    Else
        MsgBox "Count must be numeric"
        Exit Sub
    End If
    
    If chkisFile.value = 0 Then
        b() = StrConv(txtMsg, vbFromUnicode, LANG_US)
    Else
        If Not FileExists(txtMsg) Then
            MsgBox "File not found!"
            Exit Sub
        End If
        f = FreeFile
        Open txtMsg For Binary As f
        ReDim b(LOF(f) - 1)
        Get f, , b()
        Close f
    End If
    
    Me.Caption = "Starting cycle.."
    
    If chkUseNonce.value = 1 Then
        'InputBox "", , StrPtr(sPass)
        chainit sPass, sNOnce, cnt
        bOut() = chacha(b)
    Else
        bOut() = chacha(b, sPass)
    End If
    
    If AryIsEmpty(bOut) Then
        txtCrypt = "Encryption Failed!"
        Exit Sub
    End If
    
    Dim sOut As String
    sOut = StrConv(bOut, vbUnicode, LANG_US)
    txtCrypt = hexdump(sOut)
    
    If chkUseNonce.value = 1 Then
        chainit sPass, sNOnce, cnt
        bDec() = chacha(bOut)
    Else
        bDec() = chacha(bOut, sPass)
    End If
    
    If AryIsEmpty(bDec) Then
        txtDecrypt = "Decryption Failed!"
        Exit Sub
    End If
    
    sOut = StrConv(bDec, vbUnicode, LANG_US)
    txtDecrypt = hexdump(sOut)
    
    If UBound(b) <> UBound(bDec) Then
        Me.Caption = "Size mismatch: Org:" & Hex(UBound(b)) & " Decoded: " & Hex(UBound(bDec))
        Exit Sub
    End If
    
    For i = 0 To UBound(b)
        If b(i) <> bDec(i) Then
            Me.Caption = "Failed at offset " & i
            Exit Sub
        End If
    Next
    
    Me.Caption = "Success exact match!"
    Me.Caption = Me.Caption & "   Sizes: " & Hex(UBound(b)) & "/" & Hex(UBound(bDec))
    Me.Caption = Me.Caption & "   LastVals: " & Hex(b(UBound(b))) & "/" & Hex(bDec(UBound(bDec)))
    
End Sub

Private Sub Command2_Click()

    Dim enc As String
    Dim dec As String
    Dim bDec() As Byte
    Dim b() As Byte
    Dim cnt As Long

    chkisFile.value = 0
    chkUseNonce.value = 0
    Me.Caption = "Starting cycle.."
    
    'variant ret val auto casts to string for us
    enc = chacha4(txtMsg, txtPass)
    
    If Len(enc) = 0 Then
        txtCrypt = "Encryption Failed!"
        Exit Sub
    End If
    
    txtCrypt = hexdump(enc)
    
    'now our string has binary data in it so we must pass in length.. (or use the byte array version)
    If chkChinaSafe.value = 0 Then
        dec = chacha4(enc, txtPass)
    Else
        b() = StrConv(enc, vbFromUnicode, LANG_US)
        bDec() = chacha(b, txtPass)
        dec = StrConv(bDec, vbUnicode, LANG_US)
    End If
    
    If Len(dec) = 0 Then
        txtDecrypt = "Decryption Failed!"
        Exit Sub
    End If
    
    txtDecrypt = hexdump(dec)
        
    If txtMsg <> dec Then
        Me.Caption = "Decryption Failed!"
        Exit Sub
    End If
    
    Me.Caption = "Success exact match!"
    
End Sub

Private Sub Form_Load()
        'IDE cant always find dlls not in path on its own..so we control it explicitly..
    hLib = LoadLibrary("libchacha.dll")
    If hLib = 0 Then hLib = LoadLibrary(App.path & "\libchacha.dll")
    If hLib = 0 Then
        Me.Caption = "Could not find libchacha.dll?"
        Command1.Enabled = False
    End If
    
'    Dim a As String
'    a = "my string!"
'    test2 a
'    MsgBox a
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    'only needed for working in IDE if need to recompile dll regularly..
    If hLib <> 0 Then FreeLibrary hLib
End Sub


Function hexdump(it)
    Dim my, i, c, s, a, b
    Dim lines() As String
    
    my = ""
    For i = 1 To Len(it)
        a = Asc(Mid(it, i, 1))
        c = Hex(a)
        c = IIf(Len(c) = 1, "0" & c, c)
        b = b & IIf(a >= 65 And a <= 122, Chr(a), ".")
        my = my & c & " "
        If i Mod 16 = 0 Then
            push lines(), my & "  [" & b & "]"
            my = Empty
            b = Empty
        End If
    Next
    
    If Len(b) > 0 Then
        If Len(my) < 48 Then
            my = my & String(48 - Len(my), " ")
        End If
        If Len(b) < 16 Then
             b = b & String(16 - Len(b), " ")
        End If
        push lines(), my & "  [" & b & "]"
    End If
        
    If Len(it) < 16 Then
        hexdump = my & "  [" & b & "]" & vbCrLf
    Else
        hexdump = Join(lines, vbCrLf)
    End If
    
    
End Function

Sub push(ary, value) 'this modifies parent ary object
    On Error GoTo init
    Dim X As Long
    X = UBound(ary) '<-throws Error If Not initalized
    ReDim Preserve ary(UBound(ary) + 1)
    ary(UBound(ary)) = value
    Exit Sub
init:     ReDim ary(0): ary(0) = value
End Sub

Function FileExists(path As String) As Boolean
  On Error GoTo hell
    
  If Len(path) = 0 Then Exit Function
  If Right(path, 1) = "\" Then Exit Function
  If Dir(path, vbHidden Or vbNormal Or vbReadOnly Or vbSystem) <> "" Then FileExists = True
  
  Exit Function
hell: FileExists = False
End Function

Function ReadFile(filename)
  f = FreeFile
  temp = ""
   Open filename For Binary As #f        ' Open file.(can be text or image)
     temp = Input(FileLen(filename), #f) ' Get entire Files data
   Close #f
   ReadFile = temp
End Function

Function AryIsEmpty(ary) As Boolean
  On Error GoTo oops
    i = UBound(ary)  '<- throws error if not initalized
    AryIsEmpty = False
  Exit Function
oops: AryIsEmpty = True
End Function

 

Private Sub txtMsg_OLEDragDrop(data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)
    On Error GoTo hell
    If FileExists(data.Files(1)) Then
        txtMsg = data.Files(1)
        chkisFile.value = 1
    End If
hell:
End Sub

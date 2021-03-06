VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   10335
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10815
   LinkTopic       =   "Form1"
   ScaleHeight     =   182.298
   ScaleMode       =   6  'Millimeter
   ScaleWidth      =   190.765
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text2 
      Height          =   2535
      Left            =   2925
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   2
      Text            =   "Form1.frx":0000
      Top             =   135
      Width           =   7710
   End
   Begin VB.TextBox Text1 
      Height          =   2535
      Left            =   45
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   1
      Text            =   "Form1.frx":00A1
      Top             =   135
      Width           =   2715
   End
   Begin VB.PictureBox Picture1 
      Height          =   6090
      Left            =   1350
      ScaleHeight     =   301.5
      ScaleMode       =   2  'Point
      ScaleWidth      =   339.75
      TabIndex        =   0
      Top             =   3015
      Width           =   6855
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim img As BinaryImage
Dim dot As New WINGRAPHVIZLib.dot

'dot.ToPlainExt
'graph 1.000 1.528 2.722
'node node_0  0.944 2.361 0.962 0.500 func_1 solid ellipse black lightgrey
'node node_1  0.500 1.361 1.018 0.500 func_2 solid ellipse black lightgrey
'node node_2  0.944 0.361 1.004 0.500 func_3 solid ellipse black lightgrey
'edge node_0 node_1 4 0.833 2.111 0.778 2.000 0.722 1.861 0.667 1.736 solid black
'edge node_0 node_2 10 1.014 2.111 1.056 1.972 1.111 1.778 1.125 1.611 1.139 1.389 1.139 1.319 1.125 1.111 1.111 0.986 1.083 0.847 1.056 0.736 solid black
'edge node_1 node_2 4 0.611 1.111 0.667 1.000 0.722 0.861 0.778 0.736 solid black
'Stop

'todot
'digraph G {
'    node [label="\N"];
'    graph [bb="0,0,110,196"];
'    node_0 [label=func_1, pos="68,170", width="0.94", height="0.50"];
'    node_1 [label=func_2, pos="36,98", width="1.00", height="0.50"];
'    node_2 [label=func_3, pos="68,26", width="1.00", height="0.50"];
'    node_0 -> node_1 [pos="e,44,116 60,152 56,144 52,134 48,125"];
'    node_1 -> node_2 [pos="e,60,44 44,80 48,72 52,62 56,53"];
'    node_0 -> node_2 [pos="e,74,44 73,152 76,142 80,128 81,116 82,100 82,95 81,80 80,71 78,61 76,53"];
'}

Private Sub Picture1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Me.Caption = X & " " & (196 - Y)
End Sub

Private Sub Form_Load()

    tmp = dot.ToDot(Text1)
    Text2 = Replace(Replace(tmp, vbCr, vbCrLf), Chr(0), Empty)
        
    Set img = dot.ToGIF(Text1)
    If img Is Nothing Then Exit Sub
   
    Set Picture1.Picture = img.Picture
    
    
    
    
End Sub

Sub WriteFile(path, it)
    f = FreeFile
    Open path For Output As #f
    Print #f, it
    Close f
End Sub

'tosvg (no render in IE on xp..firefox works but..not embeddable..
'<?xml version="1.0" encoding="UTF-8" standalone="no"?>
'<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN"
' "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
'<!-- Generated by WinGraphviz version ver1.02.23, 08/01/2003 (08/04/2003)
'     For user: david   Title: G    Pages: 1 -->
'<svg width="162px" height="276px"
' xmlns="http://www.w3.org/2000/svg">
'<g id="graph0" class="graph" style="font-family:Times New Roman;font-size:18.67;">
'<title>G</title>
'<g id="node1" class="node"><title>node_0</title>
'<ellipse cx="97" cy="39" rx="45" ry="24" style="fill:none;stroke:black;"/>
'<text text-anchor="middle" x="97" y="46" style="font-family:Times New Roman;"><![CDATA[func_1]]></text>
'</g>
'<g id="node2" class="node"><title>node_1</title>
'<ellipse cx="54" cy="135" rx="48" ry="24" style="fill:none;stroke:black;"/>
'<text text-anchor="middle" x="54" y="142" style="font-family:Times New Roman;"><![CDATA[func_2]]></text>
'</g>
'<g id="edge2" class="edge"><title>node_0-&gt;node_1</title>
'<path style="fill:none;stroke:black;" d="M86,63C81,74 76,87 70,99"/>
'<polygon style="fill:black;stroke:black;" points="73,101 65,111 68,98 73,101"/>
'</g>
'<g id="node3" class="node"><title>node_2</title>
'<ellipse cx="97" cy="231" rx="48" ry="24" style="fill:none;stroke:black;"/>
'<text text-anchor="middle" x="97" y="238" style="font-family:Times New Roman;"><![CDATA[func_3]]></text>
'</g>
'<g id="edge6" class="edge"><title>node_0-&gt;node_2</title>
'<path style="fill:none;stroke:black;" d="M104,63C108,77 113,95 114,111 116,133 116,139 114,159 113,171 110,185 108,195"/>
'<polygon style="fill:black;stroke:black;" points="112,195 105,207 105,194 112,195"/>
'</g>
'<g id="edge4" class="edge"><title>node_1-&gt;node_2</title>
'<path style="fill:none;stroke:black;" d="M65,159C70,170 76,183 81,195"/>
'<polygon style="fill:black;stroke:black;" points="84,194 86,207 78,197 84,194"/>
'</g>
'</g></svg>


'dot.ToPS
'%!PS-Adobe-2.0
'%%Creator: WinGraphviz version ver1.02.23, 08/01/2003 (08/04/2003)
'%%For: david
'%%Title: G
'%%Pages: (atend)
'%%BoundingBox: 35 35 147 233
'%%EndComments
'Save
'%%BeginProlog
'/DotDict 200 dict def
'DotDict begin
'
'/setupLatin1 {
'mark
'/EncodingVector 256 array def
' EncodingVector 0
'
'ISOLatin1Encoding 0 255 getinterval putinterval
'
'EncodingVector
'  dup 306 / ae
'  dup 301 / aacute
'  dup 302 / acircumflex
'  dup 304 / adieresis
'  dup 300 / agrave
'  dup 305 / aring
'  dup 303 / Atilde
'  dup 307 / ccedilla
'  dup 311 / eacute
'  dup 312 / ecircumflex
'  dup 313 / edieresis
'  dup 310 / egrave
'  dup 315 / iacute
'  dup 316 / icircumflex
'  dup 317 / idieresis
'  dup 314 / igrave
'  dup 334 / udieresis
'  dup 335 / yacute
'  dup 376 / thorn
'  dup 337 / germandbls
'  dup 341 / aacute
'  dup 342 / acircumflex
'  dup 344 / adieresis
'  dup 346 / ae
'  dup 340 / agrave
'  dup 345 / aring
'  dup 347 / ccedilla
'  dup 351 / eacute
'  dup 352 / ecircumflex
'  dup 353 / edieresis
'  dup 350 / egrave
'  dup 355 / iacute
'  dup 356 / icircumflex
'  dup 357 / idieresis
'  dup 354 / igrave
'  dup 360 / dcroat
'  dup 361 / ntilde
'  dup 363 / oacute
'  dup 364 / ocircumflex
'  dup 366 / odieresis
'  dup 362 / ograve
'  dup 365 / otilde
'  dup 370 / oslash
'  dup 372 / uacute
'  dup 373 / ucircumflex
'  dup 374 / udieresis
'  dup 371 / ugrave
'  dup 375 / yacute
'  dup 377 / ydieresis
'
'% Set up ISO Latin 1 character encoding
'/starnetISO {
'        dup dup findfont dup length dict begin
'        { 1 index /FID ne { def }{ pop pop } ifelse
'        } forall
'        /Encoding EncodingVector def
'        currentdict end definefont
'} def
'/Times-Roman starnetISO def
'/Times-Italic starnetISO def
'/Times-Bold starnetISO def
'/Times-BoldItalic starnetISO def
'/Helvetica starnetISO def
'/Helvetica-Oblique starnetISO def
'/Helvetica-Bold starnetISO def
'/Helvetica-BoldOblique starnetISO def
'/Courier starnetISO def
'/Courier-Oblique starnetISO def
'/Courier-Bold starnetISO def
'/Courier-BoldOblique starnetISO def
'cleartomark
'} bind def
'
'%%BeginResource: procset
'/coord-font-family /Times-Roman def
'/default-font-family /Times-Roman def
'/coordfont coord-font-family findfont 8 scalefont def
'
'/InvScaleFactor 1.0 def
'/set_scale {
'    dup 1 exch div /InvScaleFactor exch def
'    dup scale
'} bind def
'
'% styles
'/solid { [] 0 setdash } bind def
'/dashed { [9 InvScaleFactor mul dup ] 0 setdash } bind def
'/dotted { [1 InvScaleFactor mul 6 InvScaleFactor mul] 0 setdash } bind def
'/invis {/fill {newpath} def /stroke {newpath} def /show {pop newpath} def} bind def
'/bold { 2 setlinewidth } bind def
'/filled { } bind def
'/unfilled { } bind def
'/rounded { } bind def
'/diagonals { } bind def
'
'% hooks for setting color
'/nodecolor { sethsbcolor } bind def
'/edgecolor { sethsbcolor } bind def
'/graphcolor { sethsbcolor } bind def
'/nopcolor {pop pop pop} bind def
'
'/beginpage {    % i j npages
'    /npages exch def
'    /j exch def
'    /i exch def
'    /str 10 string def
'    npages 1 gt {
'        gsave
'            coordfont setfont
'            0 0 moveto
'            (\() show i str cvs show (,) show j str cvs show (\)) show
'        grestore
'    } if
'} bind def
'
'/set_font {
'    findfont exch
'    scalefont setfont
'} def
'
'% draw aligned label in bounding box aligned to current point
'/alignedtext {          % width adj text
'    /text exch def
'    /adj exch def
'    /width exch def
'    gsave
'        width 0 gt {
'            text stringwidth pop adj mul 0 rmoveto
'        } if
'        [] 0 setdash
'        Text Show
'    grestore
'} def
'
'/boxprim {              % xcorner ycorner xsize ysize
'        4 2 roll
'        moveto
'2         Copy
'        exch 0 rlineto
'0         exch rlineto
'        pop neg 0 rlineto
'        closepath
'} bind def
'
'/ellipse_path {
'    /ry exch def
'    /rx exch def
'    /y exch def
'    /x exch def
'    matrix currentmatrix
'    newpath
'    x y translate
'    rx ry scale
'    0 0 1 0 360 arc
'    setmatrix
'} bind def
'
'/endpage { showpage } bind def
'
'/layercolorseq
'    [   % layer color sequence - darkest to lightest
'        [0 0 0]
'        [.2 .8 .8]
'        [.4 .8 .8]
'        [.6 .8 .8]
'        [.8 .8 .8]
'    ]
'def
'
'/layerlen layercolorseq length def
'
'/setlayer {/maxlayer exch def /curlayer exch def
'    layercolorseq curlayer 1 sub layerlen mod get
'    aload pop sethsbcolor
'    /nodecolor {nopcolor} def
'    /edgecolor {nopcolor} def
'    /graphcolor {nopcolor} def
'} bind def
'
'/onlayer { curlayer ne {invis} if } def
'
'/onlayers {
'    /myupper exch def
'    /mylower exch def
'    curlayer mylower lt
'    curlayer myupper gt
'    or
'    {invis} if
'} def
'
'/curlayer 0 def
'
'%%EndResource
'%%EndProlog
'%%BeginSetup
'14 default-font-family set_font
'1 setmiterlimit
'% /arrowlength 10 def
'% /arrowwidth 5 def
'
'% make sure pdfmark is harmless for PS-interpreters other than Distiller
'/pdfmark where {pop} {userdict /pdfmark /cleartomark load put} ifelse
'% make '<<' and '>>' safe on PS Level 1 devices
'/languagelevel where {pop languagelevel}{1} ifelse
'2 lt {
'    userdict (<<) cvn ([) cvn load put
'    userdict (>>) cvn ([) cvn load put
'} if
'
'%%EndSetup
'%%Page: 1 1
'%%PageBoundingBox: 36 36 147 233
'%%PageOrientation: Portrait
'gsave
'35 35 112 198 boxprim clip newpath
'36 36 translate
'0 0 1 beginpage
'0 0 translate 0 rotate
'0.000 0.000 0.000 graphcolor
'14.00 /Times New Roman set_font
'
'%   node_0
'gsave 10 dict begin
'68 170 34 18 ellipse_path
'stroke
'gsave 10 dict begin
'68 165 moveto 47 -0.5 (func_1) alignedtext
'end grestore
'end grestore
'
'%   node_1
'gsave 10 dict begin
'36 98 36 18 ellipse_path
'stroke
'gsave 10 dict begin
'36 93 moveto 51 -0.5 (func_2) alignedtext
'end grestore
'end grestore
'
'%   node_0 -> node_1
'newpath 60 152 moveto
'56 144 52 134 48 125 curveto
'stroke
'gsave 10 dict begin
'solid
'0.000 0.000 0.000 edgecolor
'newpath 50 124 moveto
'44 116 lineto
'46 126 lineto
'closepath
'fill
'0.000 0.000 0.000 edgecolor
'end grestore
'
'%   node_2
'gsave 10 dict begin
'68 26 36 18 ellipse_path
'stroke
'gsave 10 dict begin
'68 21 moveto 50 -0.5 (func_3) alignedtext
'end grestore
'end grestore
'
'%   node_0 -> node_2
'newpath 73 152 moveto
'76 142 80 128 81 116 curveto
'82 100 82 95 81 80 curveto
'80 71 78 61 76 53 curveto
'stroke
'gsave 10 dict begin
'solid
'0.000 0.000 0.000 edgecolor
'newpath 79 53 moveto
'74 44 lineto
'74 54 lineto
'closepath
'fill
'0.000 0.000 0.000 edgecolor
'end grestore
'
'%   node_1 -> node_2
'newpath 44 80 moveto
'48 72 52 62 56 53 curveto
'stroke
'gsave 10 dict begin
'solid
'0.000 0.000 0.000 edgecolor
'newpath 58 54 moveto
'60 44 lineto
'54 52 lineto
'closepath
'fill
'0.000 0.000 0.000 edgecolor
'end grestore
'endpage
'grestore
'%%PageTrailer
'%%EndPage: 1

Private Sub Picture1_Click()

End Sub



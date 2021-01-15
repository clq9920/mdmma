BeginPackage["mdmma`"]

(* ::Subsection:: *)
(* Function declaration *)

mdclear::usage="Clean up markdown file,format:mdclear[]";
mdhelp::usage="A brief introduction,format:mdhelp[]";
mdprint::usage="Output the original string at the end of the markdown file,format:mdprint[in_,in2_,...]";
mdshow::usage="More powerful than mdprint and supports graphics,format:mdshow[in_]";
mdnew::usage="Create a new markdown notebook,format:mdnew[],mdnew[name_String]";
mdtex::usage="Use MathJax to display latex expressions,format:use mdtex[] load MathJax,use mdtex[in___] show result";
Begin["`Private`"]

(* ::Subsection:: *)
(* Configuration parameter *)
notebookfiler="mdmma";
outputfile="NOTEBOOK_OUT_PUT.md";


(* ::Subsection:: *)
(* Resource control *)

mmashown=0;
getsn[]:=++mmashown


(* ::Subsection:: *)
(* markdown style *)

mdTemplate=<|
"outformat"->Function["\n\nOut[`"<>ToString[#1]<>"`]="<>ToString[#2]<>"\n"],
"image"->StringTemplate["\n\n![](./resfolder/``-``.``)"]
|>;

myshort[in_] := 
 Cases[in // Short // ToBoxes, _String, {0, Infinity}] // StringJoin
 

(* ::Subsection:: *)
(* Basic document control *)

(* ::Subsubsection:: *)
(* outformat *)

mywritefileend[in_]:=(
outputfilestream=OpenAppend[FileNameJoin[{notebookfiler,outputfile}]];
WriteString[outputfilestream,
mdTemplate["outformat"][$Line,in]
];
Close[outputfilestream];
);

(* ::Subsubsection:: *)
(* Original format *)
mywritefileend2[in_]:=(
outputfilestream=OpenAppend[FileNameJoin[{notebookfiler,outputfile}]];
WriteString[outputfilestream,in];
Close[outputfilestream];
);


(* ::Subsection:: *)
(* Mdnotebook output encapsulation *)

(* markdown中的特殊字符替换 *)
mdstringreplace={"`"->"\\`"};

mdprint[in___]:=(mywritefileend2["\n\n"<>StringJoin[StringReplace[mdstringreplace][ToString/@{in}]]])


(* export lex *)
mdtex[in___]:=mywritefileend["\n$$\n"<>ToString@TeXForm[in]<>"\n$$\n"];


(* Load MathJax *)
mdtex[]:=mywritefileend2@"\n<script src=\"https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML\" type=\"text/javascript\"></script>\n"

mdshow[in___] := (
  If[
    Length[{in}]==1,
    Switch[in,
      _Graphics, Export[FileNameJoin[{notebookfiler,"resfolder",ToString[$Line]<>"-"<>ToString[getsn[]]<>".svg"}] , in];
      mdTemplate["image"][$Line,mmashown,"svg"]//mywritefileend,
      _Graphics3D, Export[FileNameJoin[{notebookfiler,"resfolder",ToString[$Line]<>"-"<>ToString[getsn[]]<>".png"}] , in];mdTemplate["image"][$Line,mmashown,"png"] //mywritefileend,
      _?(#===Null&),Null,
      _, StringReplace[mdstringreplace]@If[ByteCount[in] > 100, myshort[in], ToString@in]//mywritefileend
    ];
    ,
    StringReplace[mdstringreplace]@If[
      ByteCount[{in}] > 100, 
      myshort[Hold[in]], 
      ToString@Hold[in]
      ]//mywritefileend
    1
  ];
  in
  )



(* ::Subsection:: *)
(* File transfer tool *)

maillist=<|"xxx"->"xxxx@xx.com"|>;


sendtolocal[to_,text_,file_]:=Print@SendMail[<|
    Echo["To" -> to], 
    Echo["Subject" -> text], 
    "Body" ->"", 
    "From" -> "xxx@163.com", 
    "Server" -> "smtp.163.com", 
    "UserName" -> "xxx@163.com", 
    "Password" -> "password",
    "AttachedFiles" -> file
    |>];


(* ::Subsection:: *)
(* Document management tool *)

mdclear[]:=Function[
  WriteString[#filename,"\n\n # NOTEBOOK OUT PUT"];
  Close[#filename];
]@<|"filename"->FileNameJoin[{notebookfiler,outputfile}]|>;


mdnew[name_:notebookfiler]:=(
  notebookfiler=name;
  If[DirectoryQ[notebookfiler],Null,CreateDirectory[notebookfiler]];
  Function[
    If[FileExistsQ[#mdfilename],Null,CreateFile[#mdfilename]];
    If[FileExistsQ[#resfolder],Null,CreateDirectory[#resfolder]];
  ]@<|"mdfilename"->FileNameJoin[{notebookfiler,outputfile}],"resfolder"->FileNameJoin[{notebookfiler,"resfolder"}]|>;
  mmashown=0;
  If[DirectoryQ[notebookfiler],Null,CreateDirectory[notebookfiler]];
  mywritefileend2["\n\n # NOTEBOOK OUT PUT"];
  $Post=mdshow;
  )


(* ::Subsection:: *)
(* Help *)
mdhelp[]:=Print["mdmma,by xxx and xxx
information:
\tnotebook file:"<>FileNameJoin[{notebookfiler,outputfile}]<>"
\tresource directory:resfolder
\tmaillist:"<>ToString[maillist]<>"
common commands:
\tmdClear[]\tclear notebook
\t$Post =.\ttemporarily turn off mdmma output
\t$Post = mdshow\tturn on mdmma output
\tmdhelp[]\toutput help
\tsendtolocal[to_,text_,file_]\tfile transfer
\tmdprint[in_,in2_,...]\toutput string in mdmma
\tmdshow[in]\tSimilar to mdprint, it supports graphics
\tmdtex[]\tUse MathJax to display latex expressions"];

(* ::Subsection:: *)
(* initialization *)
$Post = mdshow;
mdhelp[];



End[]

EndPackage[]
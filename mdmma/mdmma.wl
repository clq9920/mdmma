BeginPackage["mdmma`"]

mdclear::usage="清理markdown文件,格式:mdclear[]";
mdhelp::usage="调出简介,格式:mdhelp[]";
mdprint::usage="在mdmma中输出字符串,格式:mdprint[in_,in2_,...]";
mdshow::usage="相对于myprint,支持图形,格式:mdshow[in_]";
mdnew::usage="新建一个markdown笔记本,格式mdnew[],mdnew[name_String]";
Begin["`Private`"]


notebookfiler="mdmma";
outputfile="NOTEBOOK_OUT_PUT.md";



mmashown=0;
getsn[]:=++mmashown
(* 输出资源标号 *)


(* markdown格式化 *)
mdTemplate=<|
"outfrom"->StringTemplate["\n\n Out[`1`]=`2`\n"],
"image"->StringTemplate["\n\n ![](./resfolder/``-``.``)"]
|>


myshort[in_] := 
 Cases[in // Short // ToBoxes, _String, {0, Infinity}] // StringJoin
 

mywritefileend[in_]:=(
outputfilestream=OpenAppend[FileNameJoin[{notebookfiler,outputfile}]];
WriteString[outputfilestream,
mdTemplate["outfrom"][$Line,in]
];
Close[outputfilestream];
);

(* out[n]=形式附加 *)


mywritefileend2[in_]:=(
outputfilestream=OpenAppend[FileNameJoin[{notebookfiler,outputfile}]];
WriteString[outputfilestream,in];
Close[outputfilestream];
);

(* string形式附加 *)

mdprint[in___]:=mywritefileend2["\n\n"<>StringJoin[ToString/@{in}]]

mdshow[in___] := (
  If[
    Length[{in}]==1,
    Switch[in,
      _Graphics, Export[FileNameJoin[{notebookfiler,"resfolder",ToString[$Line]<>"-"<>ToString[getsn[]]<>".png"}] , in];
      mdTemplate["image"][$Line,mmashown,"png"]//mywritefileend,
      _Graphics3D, Export[FileNameJoin[{notebookfiler,"resfolder",ToString[$Line]<>"-"<>ToString[getsn[]]<>".png"}] , in];mdTemplate["image"][$Line,mmashown,"png"] //mywritefileend,
      _?(#===Null&),Null,
      _, If[ByteCount[in] > 100, myshort[in], ToString@in]//mywritefileend
    ];
    ,
    If[
      ByteCount[{in}] > 100, 
      myshort[Hold[in]], 
      ToString@Hold[in]
      ]//mywritefileend
    1
  ];
  in
  )




maillist=<|"clq"->"clq9921@163.com"|>;


sendtolocal[to_,text_,file_]:=Print@SendMail[<|
    Echo["To" -> to], 
    Echo["Subject" -> text], 
    "Body" ->"", 
    "From" -> "clq9920@163.com", 
    "Server" -> "smtp.163.com", 
    "UserName" -> "clq9920@163.com", 
    "Password" -> "password"
    ,"AttachedFiles" -> file
    |>];



mdclear[]:=Function[
  WriteString[#filename,"\n\n # NOTEBOOK OUT PUT"];
  Close[#filename];
]@<|"filename"->FileNameJoin[{notebookfiler,outputfile}]|>;

mdhelp[]:=Print["mdmma,by xxx and xxx
信息:
\t文件目录:"<>FileNameJoin[{notebookfiler,outputfile}]<>"
\t资源目录:resfolder
\tmaillist:"<>ToString[maillist]<>"
常用命令:
\tmdClear[]\t清理输出笔记本
\t$Post =.\t暂时关闭mdmma输出
\t$Post = mdshow\t恢复mdmma输出
\tmdhelp[]\t输出帮助
\tsendtolocal[to_,text_,file_]\t文件传输
\tmdprint[in_,in2_,...]\t在mdmma中输出字符串
\tmdshow[in]\t相对于myprint,支持图形"];


(* init[] *)
$Post = mdshow;
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
(* mywritefileend2["\n\n # NOTEBOOK OUT PUT"]; *)

mdhelp[]



End[]

EndPackage[]
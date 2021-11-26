(* ::section:: *)
(* 快速初始化 *)
(*  *)
wolfram
<<"mdmma`"
mdnew["notebook"]
(*  *)
(* ::Section:: *)
(* 大量数据输出 *)
(*  *)
Range[100]
Range[1000]
(*  *)
(* ::Section:: *)
(* 二维作图 *)
(*  *)
Plot[x^2,{x,-1,1}]
Plot[-x^2,{x,-1,1}]
(*  *)
(* ::Section:: *)
(* 三维作图 *)
(*  *)
Plot3D[x+y,{x,-1,1},{y,-1,1}]
(*  *)
(* ::Section:: *)
(* 初始化latex显示 *)
(*  *)
mdtex[];
(*  *)
(* ::Section:: *)
(* 用latex在markdown中显示公式 *)
(*  *)
D[(a1+d)^b1 (a2-d)^b2,d]/.d->0//Simplify//mdtex
(*  *)
(* ::Section:: *)
(* 直接以latex格式输出 *)
(*  *)
"$$\\frac{1}{2}$$"//mdprint
(*  *)
(* ::Section:: *)
(* 清理notebook *)
(*  *)
mdclear[]
(*  *)
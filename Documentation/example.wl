(* ::section:: *)
(* open a terminal *)

(
wolfram
)

(
    <<"mdmma`"
)

(
    mdnew["tmp"]
)

(
    Range[100]
)

(
    Plot[x^2,{x,-1,1}]
)

(
    Plot3D[x+y,{x,-1,1},{y,-1,1}]
)

(
    mdtex[];
)

(
    D[(a1+d)^b1 (a2-d)^b2,d]/.d->0//Simplify//mdtex
)
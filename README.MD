This project is to facilitate the visualization of calculation results on a remote server. Markdown is currently used as the visual file format.

# Installation

Just move mdmma/mdmma to ~/.Mathematica/Paclets/Repository.

# usage

Please use text interface

Call package

```mathematica
<<"mdmma`"
```

Add a new MdNotebook.

```mathematica
mdnew["newnotebook"]
```

Get help

```mathematica
mdhelp[]
```

# some function

sendtolocal function :you need to modify the code

```mathematica
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
```

# some tips

Set a shortcut for "Run Selected Text In Active Terminal"

such as "shift+enter"

use "shift+alt+->" to select code



# Plan
+ √ automatic display picture
+ x support Graphics3D
+ x Combined with code-block


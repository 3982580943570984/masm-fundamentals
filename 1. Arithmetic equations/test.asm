.586
.MODEL flat, stdcall
OPTION CASEMAP:NONE

Include kernel32.inc 
Include masm32.inc 
IncludeLib kernel32.lib 
IncludeLib masm32.lib 3   

.CONST
    MsgExit DB 13,10,"Press Enter to Exit",0AH,0DH,0

.DATA
    Zapros DB 13,10,'Input A',13,10,0
    Result DB 'Result='
    ResStr DB 16 DUP (' '),0

.DATA?
           A  SWORD ?
    Buffer DB 10 DUP (?)
    inbuf  DB 100 DUP (?)

.CODE

    Start:
          Invoke StdOut,ADDR Zapros
          Invoke StdIn,ADDR Buffer,LengthOf Buffer
          Invoke StripLF,ADDR Buffer
          Invoke atol,ADDR Buffer
          mov    DWORD PTR A,EAX

          Invoke dwtoa,A,ADDR ResStr
          Invoke StdOut,ADDR Result
          XOR    EAX,EAX
          Invoke StdOut,ADDR MsgExit
          Invoke StdIn,ADDR inbuf,LengthOf inbuf
          Invoke ExitProcess,0
End Start

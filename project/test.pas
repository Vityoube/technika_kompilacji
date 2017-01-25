program test (input,output);
var someVar, otherVar,secondVar: integer;
var thirdVar: real;
var fifthVar: array [1..5] of integer;
var sixthVar: array [1..5] of real;
function f(a,b:integer;c:real):integer;
var fourthVar: array [1..20] of real;
begin
someVar:=2;
a:=2;
b:=3;
f:=((a*b)+c)+f;
c:=5.1
end;
procedure p;
begin
end;
procedure p(a,b:real;c:integer);
begin
p
end;
begin
p;
someVar:=0.2;
otherVar:=2+3.1;
fifthVar[5]:=fifthVar[2];
someVar:=f(someVar,otherVar,thirdVar);
sixthVar:=fifthVar;
if someVar>otherVar then someVar:=3
else if someVar=otherVar and secondVar=0 then someVar:=10 else someVar:=100; 
p(10.2,5.4,2)
end.

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
read(someVar,otherVar,fifthVar[2]);
someVar:=0.2;
otherVar:=2+3.1;
sixthVar:=6;
fifthVar[5]:=3;
someVar:=f(someVar,otherVar,thirdVar);
sixthVar:=fifthVar;
if (someVar>otherVar) then someVar:=3
else if ((someVar=otherVar) and (secondVar=0)) then write(10,fifthVar,thirdVar) else write(someVar);
while someVar>otherVar do
begin
someVar:=someVar+3;
while (1) do someVar:=someVar-3;
otherVar:=thirdVar
end;
p(10.2,5.4,2)
end.

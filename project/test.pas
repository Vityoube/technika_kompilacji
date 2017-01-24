program test (input,output);
var someVar, otherVar,secondVar: integer;
var thirdVar: real;
var fifthVar: array [1..5] of integer;
function f(a,b:integer;c:real):integer;
var fourthVar: array [1..20] of real;
begin
a:=2;
b:=3;
c:=5.1;
f:=a+b+c
end;
procedure p;
begin
end;
procedure p(a,b:real;c:integer);
begin
end;
begin
p;
someVar:=0.2;
otherVar:=2+3.1;
thirdVar:=3>someVar;
fifthVar[5]:=fifthVar[2];
someVar:=f(someVar,otherVar,thirdVar);
p(10.2,5.4,2)
end.

package codigo;
import static codigo.Tokens.*;
%%
%class Lexer
%type Tokens
L=[a-zA-Z_]+
D=[0-9]+
espacio=[\t,\r,\n, ]+
C=[']


%{
    public String lexeme;
%}
select = (SELECT|select)
from = (FROM|from)
where = (WHERE|where)
%%
{espacio} {/*Ignore*/}
"--".* {/*Ignore*/}

"=" {lexeme=yytext(); return Igual;}
">" {lexeme=yytext(); return Mayor;}
"<" {lexeme=yytext(); return Menor;}


{select}	{lexeme=yytext(); return Seleciona;}
{from}		{lexeme=yytext(); return Desde;}
{where}		{lexeme=yytext(); return Donde;}

{L}({L}|{D})*|"*" {lexeme=yytext(); return Id;}

({C}({L}({L}|{D})*){C}) {lexeme=yytext(); return DatoTabla;}
("(-"{D}+")")|{D}+ {lexeme=yytext(); return Numero;}
 . {return ERROR;}
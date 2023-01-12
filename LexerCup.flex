package codigo;
import java_c.runtime.Symbol;
%%
%class LexerCup
%type java_c.runtime.Symbol
%cup
%full
%line
%char
L=[a-zA-Z_]+
D=[0-9]+
espacio=[\t,\r,\n, ]+
C=[']

%{
    private Symbol symbol(int type, Object value){
        return new Symbol(type, yyline, yycolumn, value);
    }
    private Symbol symbol(int type){
        return new Symbol(type, yyline, yycolumn);
    }
%}
select = (SELECT|select)
from = (FROM|from)
where = (WHERE|where)
%%
{espacio} {/*Ignore*/}
"--".* {/*Ignore*/}

"*" {return new Symbol(sym.Todo, yychar, yyline, yytext());}
"=" {return new Symbol(sym.Igual, yychar, yyline, yytext());}
">" {return new Symbol(sym.Mayor, yychar, yyline, yytext());}
"<" {return new Symbol(sym.Menor, yychar, yyline, yytext());}

{select}	{return new Symbol(sym.Seleciona, yychar, yyline, yytext());}
{from}		{return new Symbol(sym.Desde, yychar, yyline, yytext());}
{where}		{return new Symbol(sym.Donde, yychar, yyline, yytext());}

{L}({L}|{D})* {return new Symbol(sym.Id, yychar, yyline, yytext());}

({C}({L}({L}|{D})*){C}) {return new Symbol(sym.DatoTabla, yychar, yyline, yytext());}
("(-"{D}+")")|{D}+ {return new Symbol(sym.Numero, yychar, yyline, yytext());}
 . {return new Symbol(sym.ERROR, yychar, yyline, yytext());}

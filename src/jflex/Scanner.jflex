// Arquivo para o scanner a ser utilizado
package parser;
// Importar classes do cup - classe Symbol
import java_cup.runtime.*;

%%

%class Scanner
%cup
%unicode
%line
%column

%{
    // type é a classe do token
    // yyline e yycolumn são variáveis reservadas
    // do JFlex para armazenar a linha e a coluna
    // de um token encontrado na entrada (precisa
    //  usar %line e %column)
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

ws = [\ \t\f\r\n]
number = \d+(\.\d+)?(["E""e"]["+""-"]?\d+)?
identifier = [A-Za-z][A-Za-z0-9]*
string = \"([^\"]|\')*\"

%%
";"         { return symbol(sym.SEMI); }
"+"         { return symbol(sym.PLUS); }
"-"         { return symbol(sym.MINUS); }
"**"        { return symbol(sym.EXP); }
"*"         { return symbol(sym.TIMES); }
"/"         { return symbol(sym.DIVIDE); }
"%"         { return symbol(sym.MOD); }
"("         { return symbol(sym.LPAREN); }
")"         { return symbol(sym.RPAREN); }
"{"         { return symbol(sym.LBRACE); }
"}"         { return symbol(sym.RBRACE); }
"="         { return symbol(sym.ASSIGN); }
"sin"       { return symbol(sym.SIN); }
"cos"       { return symbol(sym.COS); }
"print"     { return symbol(sym.PRINT); }
"PI"        { return symbol(sym.PI, Math.PI); }
{number}    { return symbol(sym.NUMBER, Double.valueOf(yytext())); }
{identifier} { return symbol(sym.ID, yytext()); }
{string}    { return symbol(sym.STRING, yytext()); }
{ws}        {/* Ignore */}
.           { throw new Error("Simbolo inválido detectado: \"" + yycharat(0) +
              "\" ( linha: " +  yyline + ", coluna: " + yycolumn + ")"); }


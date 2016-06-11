package com.github.kassak.geo.wkt;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import com.github.kassak.geo.wkt.WktTypes;
import com.intellij.psi.TokenType;

%%

%class _WktLexer
%implements FlexLexer
%unicode
%function advance
%type IElementType
%eof{  return;
%eof}

NEW_LINE = \n|\r|\r\n
WHITE_SPACE = [\ \t\f]|{NEW_LINE}

NUMBER = \d+
FLOAT_NUMBER = {NUMBER}(\.{NUMBER})?|\.{NUMBER}
SCIENTIFIC = {FLOAT_NUMBER}[Ee][+-]?{NUMBER}
IDENT = [a-zA-Z]\w*
STRING_CHAR = [^\"]|\"\"
STRING = \"{STRING_CHAR}*\"
INVALID_STRING = \"{STRING_CHAR}*

%%

<YYINITIAL> {
  {IDENT}           {return WktTypes.IDENT;}
  {NUMBER}          {return WktTypes.NUMBER;}
  {SCIENTIFIC}      {return WktTypes.SCIENTIFIC;}
  "("               {return WktTypes.LPAREN;}
  ")"               {return WktTypes.RPAREN;}
  "["               {return WktTypes.LBRACKET;}
  "]"               {return WktTypes.RBRACKET;}
  "{"               {return WktTypes.LBRACE;}
  "}"               {return WktTypes.RBRACE;}
  ","               {return WktTypes.COMMA;}
  "."               {return WktTypes.DOT;}
  "-"               {return WktTypes.MINUS;}
  "+"               {return WktTypes.PLUS;}
  {STRING}          {return WktTypes.STRING;}
  {INVALID_STRING}  {return WktTypes.STRING;}
  {WHITE_SPACE}+    {return TokenType.WHITE_SPACE;}
  .                 {return TokenType.BAD_CHARACTER;}
}

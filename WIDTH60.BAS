$DIM ALL
%AX = &H1
%BX = &H2
%CX = &H3
%DX = &H4
%BP = &H7
%ES = &H9
DEFINT A-Z
DECLARE SUB Rows60 ()
DECLARE SUB SetCursor (x AS INTEGER, y AS INTEGER)
DECLARE SUB WriteText (Text AS STRING, ColorV AS INTEGER)
SCREEN 12: CLS: Rows60

DIM Row AS INTEGER
 FOR Row = 0 TO 59
  WriteText "ROW: " & STR$(Row) & CHR$(13) + CHR$(10), 15
 NEXT Row


SUB Rows60 ()
 REG %AX, &H1123
 REG %BX, &H0
 REG %DX, &H60
 CALL INTERRUPT &H10
END SUB

SUB SetCursor (x AS INTEGER, y AS INTEGER)
 REG %AX, &HF00      ' BH = Video page.
 CALL INTERRUPT &H10 '

 SHIFT LEFT x, &H8
 REG %AX, &H200
 REG %DX, x OR y
 CALL INTERRUPT &H10
END SUB

SUB WriteText (Text AS STRING, ColorV AS INTEGER)
 REG %AX, &HF00      'DX = Cursor position.
 CALL INTERRUPT &H10 '

 REG %AX, &H300      'BH = Video page.
 CALL INTERRUPT &H10 '

 REG %AX, &H1301
 REG %BX, REG(%BX) OR ColorV
 REG %CX, LEN(Text)
 REG %ES, STRSEG(Text)
 REG %BP, STRPTR(Text)
 CALL INTERRUPT &H10
END SUB
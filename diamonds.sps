SET DECIMAL=DOT.

DATA LIST FILE= "diamonds.txt"  free (",")
ENCODING="Locale"
/ carat * cut (F8.0) color (F8.0) clarity (F8.0) depth table price x y 
 z 
  .

VARIABLE LABELS
carat "carat" 
 cut "cut" 
 color "color" 
 clarity "clarity" 
 depth "depth" 
 table "table" 
 price "price" 
 x "x" 
 y "y" 
 z "z" 
 .

VALUE LABELS
/
cut 
1 "Fair" 
 2 "Good" 
 3 "Very Good" 
 4 "Premium" 
 5 "Ideal" 
/
color 
1 "D" 
 2 "E" 
 3 "F" 
 4 "G" 
 5 "H" 
 6 "I" 
 7 "J" 
/
clarity 
1 "I1" 
 2 "SI2" 
 3 "SI1" 
 4 "VS2" 
 5 "VS1" 
 6 "VVS2" 
 7 "VVS1" 
 8 "IF" 
.
VARIABLE LEVEL cut, color, clarity 
 (ordinal).
VARIABLE LEVEL carat, depth, table, price, x, y, z 
 (scale).

EXECUTE.

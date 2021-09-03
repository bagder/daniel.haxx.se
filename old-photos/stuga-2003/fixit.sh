#!/bin/sh

root="/data/Bilder/digitalkamera/div-juni-2003/dest"

rm index.html

for pic in 1119 1122 1121 1126 1128 1129 1130 1132 1133 1142 1149 1153 1156 1157 1159 1161 1162 1163 1164 1166 1167 1168 1173 1178 1177 1180 1182 1183 1188 1192 1193 1195; do

 echo "$root/$pic-big.jpg"
 
 cp "$root/$pic-big.jpg" .

 echo '<img src="'$pic'-big.jpg">' >> index.html

done


#/bin/sh

for rot in 1153 1159 1162 1166 1168 1178 1193; do

 echo "$rot-big.jpg"

 convert -rotate 90 $rot-big.jpg $rot-big-r.jpg
 mv $rot-big-r.jpg $rot-big.jpg

done


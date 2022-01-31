#!/bin/sh

for f in IMG_0*.JPG; do
  echo "convert $f"
  convert -strip -quality 75 -geometry 400x400 $f t_$f
done

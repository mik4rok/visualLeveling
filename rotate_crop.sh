#!/bin/bash
#ffmpeg -i img1.jpg -vf crop=3390:3390:1056:275 img20.jpg
HPICT=400              # height of picture
WPICT=400              # width of picture
WCROP=96               # width of cropping image
HCROP=96               # heihht of cropping image
XCONER=$WPICT/2-$WCROP/2  # left top point x coordinate
IMAX=16
JMAX=16
i=0
j=0

for image in ./in/*.jpg
do
ffmpeg -i $image -vf scale=$WPICT:$HPICT,setsar=1:1 $image -y
name=${image##*/}
base=${name%.jpg}
    for (( j=2; j < $JMAX-1; j++ ))
    do
        for (( i=0; i < $IMAX; i++ ))
            do
                YCONER=$HPICT/2-$HCROP+$j*$HCROP/$JMAX  # left top point x coordinate
                ANGLE=($i-$IMAX/2)*PI/120
                ffmpeg -i $image -vf "rotate=$ANGLE, crop=$WCROP:$HCROP:$XCONER:$YCONER" ./out/"$i"."$j"."$name" #
            done
    done
done

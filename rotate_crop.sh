#!/bin/bash

HPICT=400                   # height of picture
WPICT=400                   # width of picture
WCROP=96                    # width of cropping image
HCROP=96                    # heihht of cropping image
XCONER=$WPICT/2-$WCROP/2    # left top point x coordinate
IMAX=45                     # max angle
JMAX=16                     # count of up down horizont line -2
OUTDIR="./out"
i=0
j=0

if [ ! -d $OUTDIR ]
    then
        mkdir $OUTDIR
    else
        echo "$OUTDIR already exists" 1>&2
fi


for image in ./in/*.jpg
do
ffmpeg -i $image -vf scale=$WPICT:$HPICT,setsar=1:1 $image -y   # resize inner images
name=${image##*/}
base=${name%.jpg}
    for (( j=2; j < $JMAX-1; j++ ))
    do
        for (( i=0; i < $IMAX; i=i+3 ))     # 3 degreeses step
            do
                YCONER=$HPICT/2-$HCROP+$j*$HCROP/$JMAX  # left top point x coordinate
                ANGLE=($i-$IMAX/2)*PI/120
                ffmpeg -i $image -vf "rotate=$ANGLE, crop=$WCROP:$HCROP:$XCONER:$YCONER" "$OUTDIR"/"$i"."$j"."$name" #
            done
    done
done

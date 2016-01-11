# Copyright (c) 2015-2016 Thomas De Schampheleire <thomas.de.schampheleire@gmail.com>
# See file LICENSE for license information..

# Frequencies from https://en.wikipedia.org/wiki/Scientific_pitch_notation#Table_of_note_frequencies
C=(  16.352 32.703 65.406 130.81 261.63 523.25 1046.5 2093.0 4186.0 8372.0 16744.0 )
Cs=( 17.324 34.648 69.296 138.59 277.18 554.37 1108.7 2217.5 4434.9 8869.8 17739.7 ) # C#
Db=( ${Cs[*]} )
D=(  18.354 36.708 73.416 146.83 293.66 587.33 1174.7 2349.3 4698.6 9397.3 18794.5 )
Ds=( 19.445 38.891 77.782 155.56 311.13 622.25 1244.5 2489.0 4978.0 9956.1 19912.1 ) # D#
Eb=( ${Ds[*]} )
E=(  20.602 41.203 82.407 164.81 329.63 659.26 1318.5 2637.0 5274.0 10548.1 21096.2 )
F=(  21.827 43.654 87.307 174.61 349.23 698.46 1396.9 2793.8 5587.7 11175.3 22350.6 )
Fs=( 23.125 46.249 92.499 185.00 369.99 739.99 1480.0 2960.0 5919.9 11839.8 23679.6 ) # F#
Gb=( ${Fs[*]} )
G=(  24.500 48.999 97.999 196.00 392.00 783.99 1568.0 3136.0 6271.9 12543.9 25087.7 )
Gs=( 25.957 51.913 103.83 207.65 415.30 830.61 1661.2 3322.4 6644.9 13289.8 26579.5 ) # G#
Ab=( ${Gs[*]} )
A=(  27.500 55.000 110.00 220.00 440.00 880.00 1760.0 3520.0 7040.0 14080.0 28160.0 )
As=( 29.135 58.270 116.54 233.08 466.16 932.33 1864.7 3729.3 7458.6 14917.2 29834.5 ) # A#
Bb=( ${As[*]} )
B=(  30.868 61.735 123.47 246.94 493.88 987.77 1975.5 3951.1 7902.1 15804.3 31608.5 )

# Note lengths (milliseconds)
# To determine the play speed, set variable `whole_note_length` from the
# calling script; all other note lengths are derived from that.
# whole_note_length should be dividable by 32.

declare -A L # associative array

L[1]=${whole_note_length:-1344}
L[2]=$((${L[1]} / 2 ))
L[4]=$((${L[1]} / 4 ))
L[8]=$((${L[1]} / 8 ))
L[16]=$((${L[1]} / 16))
L[32]=$((${L[1]} / 32))

# dotted lengths
L[1d]=$((${L[1]}  + ${L[1]}  / 2))
L[2d]=$((${L[2]}  + ${L[2]}  / 2))
L[4d]=$((${L[4]}  + ${L[4]}  / 2))
L[8d]=$((${L[8]}  + ${L[8]}  / 2))
L[16d]=$((${L[16]} + ${L[16]} / 2))
L[32d]=$((${L[32]} + ${L[32]} / 2))

# triplet lengths
L[1t]=$((${L[1]}  * 2 / 3))
L[2t]=$((${L[2]}  * 2 / 3))
L[4t]=$((${L[4]}  * 2 / 3))
L[8t]=$((${L[8]}  * 2 / 3))
L[16t]=$((${L[16]} * 2 / 3))
L[32t]=$((${L[32]} * 2 / 3))

args=""
first=1
note()
{
    local freq=$1
    local length=$2
    local delay=$3
    if [ $first -eq 1 ]; then
        first=0
    else
        args="$args -n"
    fi
    args="$args -f $freq -l $length"

    if [ -n "$delay" ]; then
        args="$args -D $delay"
    fi
}

# standard musical note
# arguments:
#   $1: length (1=whole, 2=half, 4=quarter, ...)
#   $2: frequency
nnote() {
    # use half a note length as delay
    note $2 ${L[${1}]} ${L[$(($1 * 2))]}
}
# dotted note
dnote() {
    # use half a note length as delay
    note $2 ${L[${1}d]} ${L[$(($1 * 2))d]}
}
# triplet note
tnote() {
    # use half a note length as delay
    note $2 ${L[${1}t]} ${L[$(($1 * 2))t]}
}

# beep with the combined arguments
dbeep() {
    beep $args
}

# dbeep - a database of beep tunes

**beep** is a Linux utility to play sounds through the PC speaker

**dbeep** is a collection of scripts that play nice tunes through *beep*.

## Requirements

* *beep*: install via your package manager, or get it at
  https://github.com/johnath/beep/

* A shell that supports arrays (*bash*, *zsh*, ...)

## Usage

To play a tune, just execute the corresponding script.

## Adding new tunes

The core infrastructure is in file `dbeep.inc.sh`. The principle of *dbeep* is
to compose a *beep* command-line using one of the `note` helper functions, and
then call the `dbeep` function to execute that command-line.

There is a generic `note` function that accepts a frequency, note length, and
optional delay after the note. If you transcode a tune from sheet music, you can use one of the following convenience wrappers around `note`:

* `nnote` (normal-length note)
* `dnote` (dotted note)
* `tnote` (triplet note)
* `lnote` (long note, same as `nnote` but with a difference ratio of note length to delay)
* `ldnote` (long dotted note)
* `ltnote` (long triplet note)

All these wrappers take as first argument the note length number (1=whole note, 2=half note, 4=quarter note, etc.) and as second argument the note frequency.

`dbeep.inc.sh` defines the frequencies for all musical notes in various octaves.
For example `${C[3]}` refers to a C note in the third octave, and `${C[4]}` is the
same note but one octave higher.

See the contents of `dbeep.inc.sh` for more details.

A skeleton dbeep file is:
```sh
#!/bin/bash

# (Copyright and license information)

. $(dirname $(readlink -f $0))/dbeep.inc.sh

# (note calls)

dbeep
```

## TODO

* Add uniform script argument to speed up/down, and to switch octave up/down
* Use a more compact format, perhaps Nokia Composer format
* Add better handling of pauses

## Contributing

Contributions are welcome! Upstream source is:  
https://github.com/patrickdepinguin/dbeep

When adding new tunes, please indicate the source and copyright information.
See existing scripts for examples.

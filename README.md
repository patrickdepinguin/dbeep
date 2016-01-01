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
optional delay after the note. If you transcode real music, you can use the
`note1`, `note2`, `note4`, etc. helper functions which output a whole note, half
note, quarter note, etc. respectively.

`dbeep.inc.sh` defines the frequencies for all musical notes in various octaves.
For example ${C[3]} refers to a C note in the third octave, and ${C[4]} is the
same note but one octave higher.

See the contents of `dbeep.inc.sh` for more details.

A skeleton dbeep file is:
```sh
#!/bin/sh

# (Copyright and license information)

. $(dirname $(readlink -f $0))/dbeep.inc.sh

# (note calls)

dbeep
```

## TODO

* Convert lengths to arrays too
* Add uniform script argument to speed up/down, and to switch octave up/down

## Contributing

Contributions are welcome!

When adding new tunes, please indicate the source and copyright information.
See existing scripts for examples.

#!/bin/bash

INPUT_DIR="$1"
OUTPUT_DIR="$2"

mkdir -p "$OUTPUT_DIR"

for rvz in "$INPUT_DIR"/*.rvz; do
    name=$(basename "$rvz" .rvz)

    tmpdir=$(mktemp -d)
    bnr_dir="$tmpdir/bnr_extract"
    bnr="$bnr_dir/DATA/files/opening.bnr"

    dolphin-tool extract -i "$rvz" -s opening.bnr -o "$bnr_dir"

    #a bunch of wii games have an annoying header that needs to be clipped before wszst can handle them. tools that can handle these files with
    #the header do exist, but none of them are scriptable to my knowledge.
    offset=$(grep -obam 1 $'\x55\xaa\x38\x2d' "$bnr" | head -1 | cut -d: -f1)
    if [[ -z "$offset" ]]; then
        echo "Could not find U8 header, skipping."
        rm -rf "$tmpdir"
        continue
    fi

    dd if="$bnr" of="$tmpdir/opening.arc" bs=1 skip="$offset" 2>/dev/null

    wszst extract "$tmpdir/opening.arc" --dest "$tmpdir/bnr_out" 2>/dev/null

    sound=$(find "$tmpdir/bnr_out" -name "sound.bin" | head -1)
    if [[ -z "$sound" ]]; then
        echo "  No sound.bin found, skipping."
        rm -rf "$tmpdir"
        continue
    fi

    vgmstream-cli "$sound" -o "$OUTPUT_DIR/$name.wav"

    rm -rf "$tmpdir"
done

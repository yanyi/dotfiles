function mkv2mp4
    if test (count $argv) -eq 0
        echo "Usage: mkv2mp4 <input_file> [crf] [preset]"
        echo "  crf: quality (18 default, higher = smaller file, lower = higher quality)"
        echo "  preset: encoding speed/efficiency (slow default, options: ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow)"
        return 1
    end

    # Input file
    set input $argv[1]

    # Optional parameters
    set crf 18
    if test (count $argv) -ge 2
        set crf $argv[2]
    end

    set preset slow
    if test (count $argv) -ge 3
        set preset $argv[3]
    end

    # Output file: just replace .mkv with .mp4
    set output (string replace -r '\.mkv$' '.mp4' $input)

    # Run ffmpeg
    ffmpeg -i "$input" -c:v libx264 -crf $crf -preset $preset -c:a aac -b:a 192k -movflags +faststart "$output"

    echo "Converted '$input' → '$output' with CRF=$crf and preset=$preset"
end

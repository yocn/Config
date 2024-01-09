file="config-`date +%F[%T]`.txt"
touch $file
ls > "$file"
mv $file config/
yt-dlp https://www.youtube.com/watch?v=Z9Zc5mcymf4

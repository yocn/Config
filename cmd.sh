file="config-`date +%F[%T]`.txt"
touch $file
ls > "$file"
mv $file config/
yt-dlp https://www.youtube.com/watch?v=Rp4iHpTvBY8

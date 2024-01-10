# file="config-`date +%F[%T]`.txt"
# touch $file
# ls > "$file"
# mv $file config/
# yt-dlp "https://www.youtube.com/@AamchiMumbai/videos"
basePath=`pwd`
list=$basePath"/"list.txt
date=`date +%F`
echo -o "\"/home/yocn/youtube/cron/$date/%(title)s-%(id)s.%(ext)s\"" > yt-dlp.conf

videos="https://www.youtube.com/@AamchiMumbai/videos"

if [ $# -gt 0 ]; then
    echo "参数个数为$#个"
    if [ $1 -eq 1 ]; then
        yt-dlp --get-id --flat-playlist $videos | awk '{print "https://www.youtube.com/watch?v=" $0}' > $list
    fi
fi

for url in `cat $list`
do
    echo "正在下载: $url"
    sleep 1
    yt-dlp --config-location $basePath"/"yt-dlp.conf $url
    sed -i "1,1d" $list
    git pull
    git add $list
    git commit -m "$date complete a download $url"
    git push
done

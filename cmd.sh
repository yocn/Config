# yt-dlp "https://www.youtube.com/@AamchiMumbai/videos"
# yt-dlp -f 'wv[height=1920][ext=webm]+ba[ext=m4a]' "https://www.youtube.com/watch?v=wKwl9DNHOqQ"

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

mutexFile="/home/yocn/crontab/mutex"

for url in `cat $list`
do
    if [ -e "$mutexFile" ]; then
        echo "正在下载: $url"
        sleep 1
        yt-dlp -f 'wv[height=1920][ext=webm]+ba[ext=m4a]' --config-location $basePath"/"yt-dlp.conf $url
        sed -i "1,1d" $list
        git pull
        git add .
        git commit -m "$date complete a download $url"
        git push
    fi
done

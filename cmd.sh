# yt-dlp "https://www.youtube.com/@AamchiMumbai/videos"
# yt-dlp -f 'wv[height=1920][ext=webm]+ba[ext=m4a]' "https://www.youtube.com/watch?v=wKwl9DNHOqQ"
# https://www.youtube.com/watch?v=3_UrWv3hWe0

folderName="@alegod-funnyanimals"

basePath=`pwd`
echo "开始执行cmd.sh-$basePath"
list=$basePath"/"list.txt
targetPath="/home/yocn/youtube/cron"
mutexFile="/home/yocn/crontab/mutex"
date=`date +%F`
echo -o "\"$targetPath/$folderName/%(title)s-%(id)s.%(ext)s\"" > yt-dlp.conf
conpleteListFile=$targetPath"/"$folderName"/list.txt"
if [ ! -e "$targetPath"/"$folderName" ]; then
    mkdir $targetPath"/"$folderName
fi
init=1
videos="https://www.youtube.com/@alegod-funnyanimals/shorts"

echo "------------------------------`date` 开始新任务---------------------------------" >> $conpleteListFile

if [ $init -gt 0 ]; then
    echo "执行init，获取所有视频列表。"
    
        yt-dlp --get-id --flat-playlist $videos | awk '{print "https://www.youtube.com/watch?v=" $0}' > $list
    
fi

for url in `cat $list`
do
    if [ -e "$mutexFile" ]; then
        echo "正在下载: $url"
        sleep 1
        # yt-dlp  -f 'wv[height=256][ext=mp4]+wa[ext=m4a]/wv[width=256][ext=mp4]+wa[ext=m4a]' "https://www.youtube.com/watch?v=FKPtduSViSY"
        # yt-dlp -f 'wv[height=256][ext=mp4]+wa[ext=m4a]' --config-location $basePath"/"yt-dlp.conf $url
        yt-dlp -f 'bv[height=1280][ext=mp4]+ba[ext=m4a]' --config-location $basePath"/"yt-dlp.conf $url
        echo "下载完成: $url"
        # 从list.txt中删除当前被下载的url
        sed -i "1,1d" $list
        echo $url >> $conpleteListFile
        git pull
        git add .
        git commit -m "$date complete a download $url"
        git push
    fi
done

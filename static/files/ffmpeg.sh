mkdir temp
mkdir output
# 创建文件夹

ffmpeg -i $1.mp4 -vn -sn -c:a copy -y -map 0:a:0 ./temp/$1_atemp.aac
# 抽取acc音频

ffmpeg -i $1.mp3-字幕.srt ./temp/$1.ass
# 转换字幕格式


# C:\Program Files (x86)\MarukoToolbox>"C:\Program Files (x86)\MarukoToolbox\tools\x264_32-8bit.exe" --crf 10 --preset 8  -I 250 -r 4 -b 3 --me umh -i 1 --scenecut 60 -f 1:1 --qcomp 0.5 --psy-rd 0.3:0 --aq-mode 2 --aq-strength 0.8 --vf subtitles --sub "H:\201-5.srt" -o "C:\Program Files (x86)\MarukoToolbox\temp\201-5_vtemp.mp4" "H:\201-5.mp4" 
# 原小丸使用x264_32-8bit 在linux下使用x264

ffmpeg -i $1.mp4 -i temp/$1_atemp.aac -vcodec libx264  -deinterlace -crf 10 -preset 8  -qcomp 0.5 -psy-rd 0.3:0 -aq-mode 2 -aq-strength 0.8 -vf "ass=temp/$1.ass" output/$1_rend.mp4

rm ./temp/$1.ass
rm ./temp/$1_atemp.aac
#!/bin/bash


read -p "请输入月份（例：201805）：" MON
filename="data_auditing_${MON}.txt"
echo $filename
rm -f $filename


echo '时长单位：秒' >> $filename
echo '流量单位：MB' >> $filename
echo ''

echo "1、表user_mobile_app_${MON}.txt ：" >> $filename
echo -e "稽核该表记录数:\c" >> $filename
hadoop fs -cat /tmp/zxz/weixi/result/user*${MON}.txt|wc -l >> $filename
echo -e "流量使用合计:\c" >> $filename
hadoop fs -cat /tmp/zxz/weixi/result/user*${MON}.txt|more|awk -F'|' -v sum=0 '{sum+=$3} END{print sum}' >> $filename

echo "2、表app_label_code_name_${MON}.txt：" >> $filename 
echo -e "稽核该表记录数:\c" >> $filename
hadoop fs -cat /tmp/zxz/weixi/result/app_label*${MON}.txt|awk 'END{print NR}' >> $filename

echo "3、表voice_${MON}.txt：" >> $filename
echo -e "稽核该表记录数:\c" >> $filename
hadoop fs -cat /tmp/zxz/weixi/result/voice_${MON}.txt|awk 'END{print NR}' >> $filename
echo -e "通话时长合计、通话次数合计:\c" >> $filename
hadoop fs -cat /tmp/zxz/weixi/result/voice_${MON}.txt|awk -F'|' -v dsum=0 -v csum=0 '{dsum+=$3}{csum+=$4} END{print dsum,csum}' >> $filename

echo "4、表roam_domestic_${MON}.txt" >> $filename
echo -e "稽核记录数:\c" >> $filename
hadoop fs -cat /tmp/zxz/weixi/result/roam*${MON}.txt|awk 'END{print NR}' >> $filename
echo "表num_nation_${MON}.txt" >> $filename
echo -e "稽核记录数:\c" >> $filename
hadoop fs -cat /tmp/zxz/weixi/result/num*${MON}.txt|awk 'END{print NR}' >> $filename

echo "5、表voice_rank_stat_${MON}.txt" >> $filename
echo -e "稽核该表记录数:\c"  >> $filename
hadoop fs -cat /tmp/zxz/weixi/result/voice_rank*${MON}.txt|awk 'END{print NR}' >> $filename
echo -e "月总共通话时长合计:\c" >> $filename
hadoop fs -cat /tmp/zxz/weixi/result/voice_rank*${MON}.txt|awk -F'|' -v sum=0 '{sum+=$4} END{print sum}' >> $filename

echo "6、表vip_gprs_rate_${MON}.txt" >> $filename
echo -e "稽核该表记录数:\c" >> $filename
hadoop fs -cat /tmp/zxz/weixi/result/vip*${MON}.txt|awk 'END{print NR}' >> $filename
echo -e "使用流量合计:\c" >> $filename   
hadoop fs -cat /tmp/zxz/weixi/result/vip*${MON}.txt|awk -F'|' -v sum=0 '{sum+=$4} END{print sum}' >> $filename

echo "==finish=="

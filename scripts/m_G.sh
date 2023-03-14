#!/bin/bash


N=64
k='20'
m=64
maxq=0.1
q_method='G'
noise_level=0.0
# 以上是一些预设，可设置为benchmark

ARGNAME='m'  
# 当考虑ARGNAME这一变量作变化时 
# ARGNAME:k/m/maxq/noise_level


Opt () {
    m=$1 &&    # 更改ARGNAME时也要修改这里
    TITLE=$ARGNAME$1'_'$q_method &&
    echo > ${TMP_PATH} &&
    nohup python -u \
    ${MAIN_PATH} \
    --N ${N} \
    --k ${k} \
    --m ${m} \
    --q_method ${q_method} \
    --maxq ${maxq} \
    --output_filename ${OUTPUT_LOG} \
    --title ${TITLE} \
    --noise_level ${noise_level} \
    --jpgdir ${JPG_DIR} \
    --gifdir ${GIF_DIR} \
    >> ${TMP_PATH} 2>&1 &&
    python -u ${WRITE_PATH} \
    --output_filename ${OUTPUT_LOG}
}


DIR='/data/liuziyang/Programs/inversepde/'
PYDIR=${DIR}'src/'
LOGDIR=${DIR}'logs/'
OUTPUT_LOG=$LOGDIR'output_'$ARGNAME'_'$q_method'.log'
MAIN_PATH=${PYDIR}'Main.py'
WRITE_PATH=${PYDIR}'Write_J.py'
DRAW_PATH=${PYDIR}'draw.py'
TMP_PATH='.tmp.log'
JPG_DIR=${DIR}'pic/process_jpg/'
GIF_DIR=${DIR}'pic/process_gif/'
RES_DIR=${DIR}'pic/res/'


echo > ${OUTPUT_LOG} &&
Opt 16 &&
Opt 32 &&
Opt 64 &&
Opt 128 &&


python ${DRAW_PATH} \
--filename ${OUTPUT_LOG} \
--argname ${ARGNAME} \
--savepath ${RES_DIR} \
--q_method ${q_method} &


# tail -f .tmp.log 来查看运算进度
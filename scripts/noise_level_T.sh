#!/bin/bash


N=64
k='80'
m=64
maxq=0.1
q_method='T'
noise_level=0.0
# 以上是一些预设，可设置为benchmark

ARGNAME='noise_level'  
# 当考虑ARGNAME这一变量作变化时 
# ARGNAME:k/m/maxq/noise_level


Opt () {
    noise_level=$1 &&    # 更改ARGNAME时也要修改这里
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
Opt 0.0 &&
Opt 0.1 &&
Opt 0.3 &&
Opt 0.5 &&


python ${DRAW_PATH} \
--filename ${OUTPUT_LOG} \
--argname ${ARGNAME} \
--savepath ${RES_DIR} \
--q_method ${q_method} &


# tail -f .tmp.log 来查看运算进度
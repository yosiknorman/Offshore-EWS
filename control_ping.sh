#!/bin/bash

# catatan:

# Control Data :
# Data will be downloaded if URL Data is Different and Newer than the last downloaded data.
# step by step:
# - Detect last data from URL
# - Check the interval time between availability data with the current time 

# Run Data:
# Program should run if data new
# step by step:
- 
# From local Machine
# waktu=`date -u '+%Y%m%d%H%M' -d '10 min ago'`

while true; do

    waktu=`date -u '+%Y%m%d%H%M'`
    Y=${waktu:0:4}
    m=${waktu:4:2}
    d=${waktu:6:2}
    H=${waktu:8:2}
    M=${waktu:10:1}0

    echo "checking himawari data from Satellite Group BMKG"
    url="ftp://sawiyah@bayi-ceceks.com"


    echo "${Y}/${m}/${d}/"
    ada=`cat lain2/data_list.txt`
    if [ "$ada" = "" ] ; then
    echo "Data Tidak Tersedia untuk tanggal ${Y}/${m}/${d} \n Sleep Program";
    else
    echo "Data Tersedia untuk tanggal ${Y}/${m}/${d}  \n Eksekusi program "
    fi

    # From URL
    curl -S "${url}/" > lain2/data_list.txt
    cat lain2/data_list.txt
    YDIR=`cat lain2/data_list.txt | tail -n1 | cut -d' ' -f22-`

    # ============================ For Instance ============================
    # YDIR="2018"
    # Y=${waktu:0:4}
    # m="12"
    # d="31"
    # H="23"
    # ======================================================================

    ./exs.sh
    if (( $YDIR != $Y )); then
        echo "tidak ada"
        if [ "$m-$d $H" = "12-31 23" ]; then
            echo "ada1"
            curl -S "${url}/${YDIR}/" > lain2/data_list.txt
            mDIR=`cat lain2/data_list.txt | tail -n1 | cut -d' ' -f22-`
            if (( $mDIR != $m )); then
                echo "stop"
                if [ "$m-$d $H" = "12-31 23" ]; then
                    curl -S "${url}/${YDIR}/${mDIR}/" > lain2/data_list.txt
                    dDIR=`cat lain2/data_list.txt | tail -n1 | cut -d' ' -f22-`
                    echo " $dDIR __1"
                    exs
                fi
            else
                curl -S "${url}/${YDIR}/${mDIR}/" > lain2/data_list.txt
                dDIR=`cat lain2/data_list.txt | tail -n1 | cut -d' ' -f22-`
                echo " $dDIR __2"
                exs
            fi
        fi
    else
        echo "ada2"
        curl -S "${url}/${YDIR}/" > lain2/data_list.txt
        mDIR=`cat lain2/data_list.txt | tail -n1 | cut -d' ' -f22-`
        if (( $mDIR != $m )); then
            echo "stop"
            if [ "$m-$d $H" = "12-31 23" ]
            then
                curl -S "${url}/${YDIR}/${mDIR}/" > lain2/data_list.txt
                dDIR=`cat lain2/data_list.txt | tail -n1 | cut -d' ' -f22-`
                echo " $dDIR __3"
                exs
            fi
        else
            curl -S "${url}/${YDIR}/${mDIR}/" > lain2/data_list.txt
            dDIR=`cat lain2/data_list.txt | tail -n1 | cut -d' ' -f22-`
            echo "sipppp $dDIR __4"
            exs
        fi
    fi
done

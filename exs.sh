#!/bin/bash
function exs()
{
    echo "${url}/${YDIR}/${mDIR}/${dDIR} jozz"
    curl -S "${url}/${YDIR}/${mDIR}/${dDIR}/" > lain2/data_list.txt
    last_data_url=`cat lain2/data_list.txt | grep .nc | grep B12 | tail -n1 | cut -d' ' -f15-`
    data_url=${last_data_url:18:12}

    # date -d "2013-04-06" "+%s%N" | cut -b1-13

    nm_url=`date -d "${data_url:0:4}-${data_url:4:2}-${data_url:6:2} ${data_url:8:2}:${data_url:10:2}:00" '+%s' | cut -b1-13`
    nm_sys=`date -d "${Y}-${m}-${d} ${H}:${M}:00" '+%s' | cut -b1-13`
    format_Dt_url="${data_url:0:4}-${data_url:4:2}-${data_url:6:2} ${data_url:8:2}:${data_url:10:2}:00"
    format_Dt_sys="${Y}-${m}-${d} ${H}:${M}:00"
    echo $nm_sys
    COUNT_INT=$((nm_sys - nm_url))
    echo $COUNT_INT
    ada=`ls input | grep ".nc" | tail -n1`
    echo $ada
    echo $last_data_url

    if (( $COUNT_INT > 600 )); then
        echo "harus dicek"
        if [ $last_data_url = $ada ]; then
            echo "Data is passed since $COUNT_INT Seconds ago"
            # Unneccessary to run program
        # elif [ $last_data_url != $ada ]; then
        else
            echo "Run Program with passing the interval time range of $COUNT_INT Seconds "
            curl -o input/$last_data_url -L -O -C - ${url}/${YDIR}/${mDIR}/${dDIR}/$last_data_url     
        fi
    else
        if [ $last_data_url = $ada ]; then
            echo "Data is still being processed by remote server"
            # Unneccessary to run program
        # elif [ $last_data_url != $ada ]; then
        else
            echo "Run Program"
            curl -o input/$last_data_url -L -O -C - ${url}/${YDIR}/${mDIR}/${dDIR}/$last_data_url     
        fi
    fi

}
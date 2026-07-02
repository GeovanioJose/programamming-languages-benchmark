#!/bin/bash

#header
echo timestamp,total,psys,dram,cpu_temp > out/regexredux_out.csv
echo runtime,cpu_usage,max_memory > out/runtime.csv


for (( i=1 ; i<=100 ; i++ ))
do
    echo regexredux $i
    psys_after=$(sudo cat /sys/class/powercap/intel-rapl:1/energy_uj)
    dram_after=$(sudo cat /sys/class/powercap/intel-rapl:0/intel-rapl:0:2/energy_uj)
    /usr/bin/time -ao out/runtime.csv -f "%e,%P,%M" ./regexredux.gpp-6.gpp_run 0 < ../../fasta-output.txt
    psys_before=$(sudo cat /sys/class/powercap/intel-rapl:1/energy_uj)
    dram_before=$(sudo cat /sys/class/powercap/intel-rapl:0/intel-rapl:0:2/energy_uj)

    cpu_temp_now=$(cat /sys/class/thermal/thermal_zone0/temp)

    psys=`echo "($psys_before - $psys_after)" | bc`
    dram=`echo "($dram_before - $dram_after)" | bc`
    total=`echo "($psys + $dram)" | bc`

    timestamp=`date +"%H:%M:%S"`

    echo $timestamp,$total,$psys,$dram,$cpu_temp_now >> out/regexredux_out.csv
done



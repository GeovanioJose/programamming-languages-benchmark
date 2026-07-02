#!/bin/bash

problems=(binarytrees fannkuchredux fasta knucleotide mandelbrot nbody pidigits regexredux reversecomplement spectralnorm)
#echo ${languages[1]}

if [ -d $(pwd)/$1 ] && [ -n "$2" ] && [ -n "$3" ]; then
    cd $1
else
    echo Invalid Params\n
    exit 1
fi


for (( i=0 ; i<${#problems[@]} ; i++ ))
do
    cd ${problems[$i]}
    #header
    echo timestamp,total,psys,package,core,uncore,dram,cpu_temp > out/${problems[$i]}_out.csv
    echo runtime,cpu_usage,memory > out/runtime.csv
    for (( j=1 ; j<=$2 ; j++ ))
    do
        echo -e "\e[32m$1 ${problems[$i]} $j\e[0m"
        command=$(cat "command.txt")

        psys_before=$(sudo cat /sys/class/powercap/intel-rapl:1/energy_uj)
        package_before=$(sudo cat /sys/class/powercap/intel-rapl:0/energy_uj)
        core_before=$(sudo cat /sys/class/powercap/intel-rapl:0/intel-rapl:0:0/energy_uj)
        uncore_before=$(sudo cat /sys/class/powercap/intel-rapl:0/intel-rapl:0:1/energy_uj)
        dram_before=$(sudo cat /sys/class/powercap/intel-rapl:0/intel-rapl:0:2/energy_uj)

        eval "/usr/bin/time -ao out/runtime.csv -f \"%e,%P,%M\" $command"

        psys_after=$(sudo cat /sys/class/powercap/intel-rapl:1/energy_uj)
        package_after=$(sudo cat /sys/class/powercap/intel-rapl:0/energy_uj)
        core_after=$(sudo cat /sys/class/powercap/intel-rapl:0/intel-rapl:0:0/energy_uj)
        uncore_after=$(sudo cat /sys/class/powercap/intel-rapl:0/intel-rapl:0:1/energy_uj)
        dram_after=$(sudo cat /sys/class/powercap/intel-rapl:0/intel-rapl:0:2/energy_uj)

        cpu_temp_now=$(cat /sys/class/thermal/thermal_zone1/temp)

        psys=`echo "($psys_after - $psys_before)" | bc`
        package=`echo "($package_after - $package_before)" | bc`
        core=`echo "($core_after - $core_before)" | bc`
        uncore=`echo "($uncore_after - $uncore_before)" | bc`
        dram=`echo "($dram_after - $dram_before)" | bc`
        total=`echo "($psys + $dram)" | bc`

        timestamp=`date +'%Y-%m-%dT%H:%M:%S'`

        echo $timestamp,$total,$psys,$package,$core,$uncore,$dram,$cpu_temp_now >> out/${problems[$i]}_out.csv
    done
    sleep $3
    cd ..
done
cd ..

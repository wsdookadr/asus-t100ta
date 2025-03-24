
```
ApproximateFrequencies () {
    NumSteps=$(cat /sys/devices/system/cpu/intel_pstate/num_pstates)
    MinFreq=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq)
    MaxFreq=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq)
    LastFreq=$MinFreq
    StepRate=$((( $MaxFreq - $MinFreq ) / $NumSteps))
    for ((n=0;n<=$NumSteps;n++)); do
        echo $LastFreq
        LastFreq=$(( $LastFreq + $StepRate))
    done
}

ApproximateFrequencies
533200
654381
775562
896743
1017924
1139105
1260286
1381467
1502648
1623829
1745010
1866191
```

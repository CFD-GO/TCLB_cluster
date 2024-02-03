# .*gadi\.nci\.org\.au

echo
echo "You are on the Gadi cluster (NCI, Australia)"
echo

fix ENGINE pbs
adv DEBUG_PARTITION "normal"
fix RUN_COMMAND "mpirun"

# Gadi - hardware info:
# Cores per node 48
# Memory per node: 128 GB --> default setting is 2.5GB per core

function RUN_GPU_CHECK {
	case "$RUN_GPU" in
	y)
		adv MAIN_PARTITION "gpuvolta"
		def MODULES_BASE "openmpi/4.0.2 R/3.6.1 cuda/10.1"
		# from Bryce script: hdf5/1.10.5p python3/3.7.4 python3-as-python paraview/5.8.0-mesa
		def CONFOPT "--with-cuda-arch=sm_70 --disable-rinside"
		adv MAX_TASKS_PER_NODE 4
		adv MAX_TASKS_PER_NODE_FOR_COMPILATION 4
		adv CORES_PER_TASK 12
		adv CORES_PER_TASK_FULL 12
		def MEMORY_PER_TASK 32
		;;
	n)
		echo "CPU runs are not supported on gadi"
		;;
	*)
		echo "RUN_GPU should be y or n!"
		return 1;
	esac
	return 0
}

adv MODULES_CHECK_AVAILABILITY "y"

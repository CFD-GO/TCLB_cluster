# .*\.compute\.eait\.uq\.edu\.au

echo
echo "You are on the Rangpur cluster, UQ, Australia"
echo

adv RUN_GPU y
adv ENGINE_CONF local
adv ENGINE_MAKE local
adv ENGINE_RUN  slurm
adv DEBUG_PARTITION "batch"
fix RUN_COMMAND "mpirun"

function RUN_GPU_CHECK {
	case "$RUN_GPU" in
	y)
		adv MAIN_PARTITION "vgpu"
		def MODULES_RUN "mpi/openmpi-x86_64 cuda/11.1"
		def CONFOPT "--with-cuda-arch=sm_80" # nVidia A100
		adv MAX_TASKS_PER_NODE 1
		adv MAX_TASKS_PER_NODE_FOR_COMPILATION 4
		adv CORES_PER_TASK_FULL 1
		def MEMORY_PER_TASK ""
		;;
	n)
		echo "CPU not yet supported on goliath"
		return 1;
		;;
	*)
		echo "RUN_GPU should be y or n!"
		return 1;
	esac
	return 0
}

adv MODULES_CHECK_AVAILABILITY "y"

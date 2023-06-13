# .*\.athena\.cyfronet\.pl

echo
echo "You are on the Athena cluster"
echo

adv ENGINE_CONF slurm
adv ENGINE_MAKE slurm
adv ENGINE_RUN  slurm
def CONFOPT ""
adv DEBUG_PARTITION "plgrid-gpu-a100"
fix DEBUG_QOS ""
fix MAIN_QOS ""
fix RUN_COMMAND "mpirun"
fix MODULES_BASE ""
fix RUN_SINGULARITY "n"
fix SINGULARITY_COMMAND ""
fix RUN_GPU "y"

adv MAIN_PARTITION "plgrid-gpu-a100"
def MODULES_RUN "GCC/11.2.0 GCCcore/11.2.0 libtirpc/1.3.2 OpenMPI/4.1.2"
function RUN_GPU_CHECK {
	case "$RUN_GPU" in
	y) def CONFOPT "--with-cuda-arch=sm_80 --disable-rinside" ;;
	*) echo wrong value of RUN_GPU; exit -1 ;;
	esac
}
adv MAX_TASKS_PER_NODE 4
adv MAX_TASKS_PER_NODE_FOR_COMPILATION 24
adv CORES_PER_TASK_FULL 1
def MEMORY_PER_TASK 60


def MODULES_ADD ""

adv MODULES_CHECK_AVAILABILITY "y"

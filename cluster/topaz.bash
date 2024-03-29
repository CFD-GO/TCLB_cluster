# topaz.*

echo
echo "You are on the Topaz cluster (Pawsey, Australia)"
echo

fix ENGINE_CONF "local"
fix ENGINE_MAKE "local"
fix ENGINE_RUN "slurm"
fix RUN_SINGULARITY "n"
fix RUN_GPU "y"
function RUN_GPU_CHECK {
	case "$RUN_GPU" in
	n) def CONFOPT "--disable-cuda" ;;
	y) def CONFOPT "--with-cuda-arch=sm_70" ;;
	esac
}
fix DEBUG_PARTITION "debugq"
fix MAIN_PARTITION "gpuq"
fix MAX_TASKS_PER_NODE "2"
fix MAX_TASKS_PER_NODE_FOR_COMPILATION "8"
fix CORES_PER_TASK "1"
fix MEMORY_PER_TASK "16"
def MODULES_BASE "cuda/11.4.2 r/4.0.2 openmpi-ucx-gpu/4.0.2"
fix MODULES_ADD ""
fix MODULES_RUN ""
fix MODULES_CHECK_AVAILABILITY "y"


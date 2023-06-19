# setonix.*

echo
echo "You are on the Setonix cluster (Pawsey, Australia)"
echo

fix ENGINE_CONF "local"
fix ENGINE_MAKE "local"
fix ENGINE_RUN "slurm"
fix RUN_SINGULARITY "n"
fix RUN_GPU "y"
function RUN_GPU_CHECK {
	case "$RUN_GPU" in
	n) def CONFOPT "--disable-cuda" ;;
	y) def CONFOPT "--enable-hip --with-mpi-include=${CRAY_MPICH_DIR}/include --with-mpi-lib=${CRAY_MPICH_DIR}/lib" ;;
	esac
}
fix DEBUG_PARTITION "gpu-dev"
fix MAIN_PARTITION "gpu"
fix MAX_TASKS_PER_NODE "2"
fix MAX_TASKS_PER_NODE_FOR_COMPILATION "8"
fix CORES_PER_TASK "1"
fix MEMORY_PER_TASK "16"
def MODULES_BASE "r/4.1.0 rocm/5.4.3"
fix MODULES_ADD ""
fix MODULES_RUN ""
fix MODULES_CHECK_AVAILABILITY "y"
fix RUN_COMMAND "srun"
fix GRANT "${GRANT}-gpu"

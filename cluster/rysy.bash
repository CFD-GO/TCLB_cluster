# rysy

echo -e "You are on the RYSY cluster (ICM, UW)."
echo -e "Singularity container with TCLB can be used here instead of modules. \n"

#https://cloud.sylabs.io/library/mdzik/default/tclb
echo -e "Make sure that you have downloaded the 'singularity TCLB image' if you want to use the container."
echo -e "TIP: If not, call '\$ singularity pull --arch amd64 library://mdzik/default/tclb:latest' from a computational node.'"
echo -e "Please, keep the github repo and container in $HOME/TCLB/ \n\n"


# Rysy - hardware info:
# CPU type: Intel Skylake
# GPU type: NVIDIA Volta
# No of nodes: 6
# No of cores per node: 36
# No of GPUs per node: 4
# CPU Memory per node: 380 GB

# there isn't much traffic on rysy, may use default qos
# there are no partitions on rysy --> use qos only
DEBUG_PARTITION_ASK="no"
MAIN_PARTITION_ASK="no"
fix MAIN_QOS "normal" # "normal" is default
fix DEBUG_QOS "short" # QOSMaxWallDurationPerJobLimit for "--qos=short" is --time=00:15:00
fix ENGINE slurm

def ENGINE_CONF slurm
def ENGINE_MAKE slurm
def ENGINE_RUN  slurm

function RUN_GPU_CHECK {
	case "$RUN_GPU" in
	y)	
		
		if test "$RUN_SINGULARITY" == "y"
		then
			echo -e "[y] has been choosen RUN_SINGULARITY."
			echo -e "[y] has been choosen RUN_GPU."
			# All jobs are run inside singularity container, thus no modules need to be loaded.
			fix MODULES_ADD ""
			fix MODULES_RUN ""
			fix MODULES_BASE ""
			def SINGULARITY_COMMAND "singularity exec --nv $HOME/TCLB/tclb_latest.sif"
		else
			echo -e "[n] has been choosen RUN_SINGULARITY."
			echo -e "[y] has been choosen RUN_GPU." 
			SINGULARITY_COMMAND_ASK="no"
			def MODULES_BASE "common/libs/libpng/1.6.37 common/R/4.0.3 common/compilers/gcc/9.3.1 common/mpi/openmpi/4.0.4_gnu-9.3 gpu/cuda/11.1"
		fi
		def CONFOPT "--enable-cpp11 --enable-rinside --with-cuda-arch=sm_60"
		def RUN_COMMAND "mpirun"
		def MAX_TASKS_PER_NODE 4
		def MAX_TASKS_PER_NODE_FOR_COMPILATION 30
		def CORES_PER_TASK_FULL 1
		def MEMORY_PER_TASK 5
		;;
	*)
		echo "RUN_GPU should be y! Only GPU jobs shall run on RYSY"
		return 1;;
	esac
	return 0
}


# some modules (with unwanted dependencies) must be called first with $MODULES_ADD, then override (prepend path) with $MODULES_RUN
MODULES_ADD_ASK="no"
MODULES_RUN_ASK="no"
MODULES_CHECK_AVAILABILITY="no"

fix Q_HEADER_SHELL_FLAGS "-l" # required to see modules on rysy
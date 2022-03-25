BITBANG_PORT=9824
GDB_PORT=3333
TCL_PORT=6666
CMD_PORT=4444

SPIKE_PID=-1
OPENOCD_PID=-1

LOG_DIR=/project
PID_DIR=/tmp

ELF_FILE=

# ------------------------------------------
# Functions

print_log(){
    if [ -f $2 ]; then
	echo "$1: BEGIN"
	cat $2
	echo "$1: END"
    else
	echo "$1 LOG: NOT FOUND..."
    fi
}

clean_up_pid() {
    if [ $2 > 0 ] ; then
	if  ps -p $2 > /dev/null 2>&1  ;  then
	    echo "$1 EXIT: KILL ($2)"
	    kill $2;
	else
	    echo "$1 EXIT: ALREADY DEAD"
	fi
    fi
}

clean_up() {
    print_log "SPIKE" ${LOG_DIR}/spike.log
    print_log "OPENOCD" ${LOG_DIR}/openocd.log
    clean_up_pid "SPIKE" $SPIKE_PID 
    clean_up_pid "OPENOCD" $OPENOCD_PID 
    exit $1
}

test_alive() {
    if ! ps -p $2 > /dev/null 2>&1  ;  then
	echo "$1: PROCESS DIED"
	clean_up 1
    fi
}

waitport() {
    while ! nc -z localhost $3 ; do
	sleep 0.1 ;
	test_alive $1 $2
    done
}      



find_elf_args() {
    for arg in $@; do
	if [[ "$arg" != "-"* ]] ; then
	    if [ -f $arg ] ; then
		echo "$arg"
	    fi
	fi
    done
}

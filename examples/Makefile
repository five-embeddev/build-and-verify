DIRS=\
	build-c \
	build-rust \
	test-code-c \
	build-run-sim

build : ${DIRS:%=build.%}
	echo ${DIRS}

build.% :
	${MAKE} -C ${*} all

clean : ${DIRS:%=clean.%}
	echo ${DIRS}

clean.% :
	${MAKE} -C ${*} clean

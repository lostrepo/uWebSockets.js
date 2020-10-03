
default: softclean prepare
	$(CC) build.c
	./a.out || build.exe

# RHEL/CentOS 7 compiler fix
prepare:
ifneq ($(OS),Windows_NT)
ifeq ($(shell uname -s),Linux)
	which yum && ((clang --version | grep -m 1 'llvm-toolset-7') || (\
		sudo yum install centos-release-scl && sudo yum install llvm-toolset-7 && scl enable llvm-toolset-7 'bash' \
	)) || echo 'Failed to apply RHEL/CentOS 7 compiler fix'
endif
endif

softclean:
	rm *.o

clean: softclean
	rm -drf dist
	rm -drf targets
	rm *.gz

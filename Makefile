# Make file for the resume. It simply passes commands to the build scrpt.

.PHONY: build
build:
	./build.sh build

.PHONY: clean
clean:
	./build.sh clean

.PHONY: help
help:
	./build.sh help

# Catch all target
.PHONY: Makefile
%: Makefile
	@./build.sh $@


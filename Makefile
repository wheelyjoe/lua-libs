MAKEFLAGS = --no-print-directory

LUA_PATH := $(CURDIR)/src/?.lua;;
export LUA_PATH

.PHONY: tests
tests:
	@$(MAKE) -C tests

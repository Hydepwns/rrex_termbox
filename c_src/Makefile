##
# termbox2 NIF
#
# @file
# @version 0.4
# Based on c_src.mk from erlang.mk by Loic Hoguin <essen@ninenines.eu>
# Based on the makefile from https://github.com/garlic0x1/termbox2-nif

CURDIR := $(shell pwd)
BASEDIR := $(abspath $(CURDIR)/..)

PROJECT ?= $(notdir $(BASEDIR))
PROJECT := $(strip $(PROJECT))

ifeq ($(OS),Windows_NT)
  # Set these to empty or to reasonable defaults for Windows
  ERTS_INCLUDE_DIR :=
  ERL_INTERFACE_INCLUDE_DIR :=
  ERL_INTERFACE_LIB_DIR :=
  ERL_INCLUDE :=
  ERL_LIB :=
else
  ERTS_INCLUDE_DIR ?= $(shell erl -noshell -eval "io:format(\"~ts/erts-~ts/include/\", [code:root_dir(), erlang:system_info(version)])." -s init stop)
  ERL_INTERFACE_INCLUDE_DIR ?= $(shell erl -noshell -eval "io:format(\"~ts\", [code:lib_dir(erl_interface, include)])." -s init stop)
  ERL_INTERFACE_LIB_DIR ?= $(shell erl -noshell -eval "io:format(\"~ts\", [code:lib_dir(erl_interface, lib)])." -s init stop)

  ERL_INCLUDE ?= $(shell  erl -noshell -eval "io:format(\"~ts/~s\", [filename:dirname(code:lib_dir()), \"usr/include/\"])." -s init stop) 
  ERL_LIB ?= $(shell  erl -noshell -eval "io:format(\"~ts\", [code:lib_dir()])." -s init stop) 
endif

# System type and C compiler/flags.

UNAME_SYS := $(shell uname -s)
ifeq ($(UNAME_SYS), Darwin)
	CC ?= cc
	CFLAGS ?= -O3 -std=c99 -finline-functions -Wall -Wmissing-prototypes -undefined dynamic_lookup -dynamiclib
	CXXFLAGS ?= -O3 -finline-functions -Wall
	LDFLAGS ?= -undefined dynamic_lookup -dynamiclib
	SO_EXTENSION ?= so
else ifeq ($(UNAME_SYS), FreeBSD)
	CC ?= cc
	CFLAGS ?= -O3 -std=c99 -finline-functions -Wall -Wmissing-prototypes
	CXXFLAGS ?= -O3 -finline-functions -Wall
	SO_EXTENSION ?= so
else ifeq ($(UNAME_SYS), Linux)
	CC ?= gcc
	CFLAGS ?= -O3 -std=c99 -finline-functions -Wall -Wmissing-prototypes
	CXXFLAGS ?= -O3 -finline-functions -Wall
	LDFLAGS ?= -shared
	SO_EXTENSION ?= so
endif

# Patch: Use gcc and correct flags for DLL on Windows (MSYS/MinGW/Cygwin)
ifeq ($(OS),Windows_NT)
	CC := gcc
	LDFLAGS := -shared
	SO_EXTENSION := dll
endif

C_SRC_DIR = $(CURDIR)
C_SRC_OUTPUT ?= $(CURDIR)/../priv/$(PROJECT).$(SO_EXTENSION)

# TERMBOX2_SRC_DIR = $(C_SRC_DIR)/termbox2/src
# TERMBOX_SOURCES := $(wildcard $(TERMBOX2_SRC_DIR)/*.c) $(wildcard $(TERMBOX2_SRC_DIR)/*.C) $(wildcard $(TERMBOX2_SRC_DIR)/*.cc) $(wildcard $(TERMBOX2_SRC_DIR)/*.cpp)
NIF_SOURCES := $(C_SRC_DIR)/termbox2_nif.c
SOURCES := $(NIF_SOURCES)

CFLAGS += -fPIC -I $(ERTS_INCLUDE_DIR) -I $(ERL_INTERFACE_INCLUDE_DIR) -I $(ERL_INCLUDE)
CXXFLAGS += -fPIC -I $(ERTS_INCLUDE_DIR) -I $(ERL_INTERFACE_INCLUDE_DIR)

ifeq ($(OS),Windows_NT)
  LDLIBS :=
else
  LDLIBS += -L $(ERL_INTERFACE_LIB_DIR) -L $(ERL_LIB) -lei
endif

# Verbosity.

c_verbose_0 = @echo " C     " $(?F);
c_verbose = $(c_verbose_$(V))

cpp_verbose_0 = @echo " CPP   " $(?F);
cpp_verbose = $(cpp_verbose_$(V))

link_verbose_0 = @echo " LD    " $(@F);
link_verbose = $(link_verbose_$(V))

OBJECTS = $(addsuffix .o, $(basename $(notdir $(SOURCES))))
OBJ_DIR = $(CURDIR)/obj
OBJECT_FILES = $(addprefix $(OBJ_DIR)/, $(OBJECTS))

COMPILE_C = $(c_verbose) $(CC) $(CFLAGS) $(CPPFLAGS) -c
COMPILE_CPP = $(cpp_verbose) $(CXX) $(CXXFLAGS) $(CPPFLAGS) -c 

$(info NIF_SOURCES: $(NIF_SOURCES))
$(info SOURCES: $(SOURCES))
$(info OBJECT_FILES: $(OBJECT_FILES))

# Delegate to c_src if make is run from the project root
C_SRC_ABS := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
ifeq ($(CURDIR),$(C_SRC_ABS))
# We are in c_src, do nothing special
else
all:
	$(MAKE) -C $(C_SRC_ABS)
clean:
	$(MAKE) -C $(C_SRC_ABS) clean
endif

$(C_SRC_OUTPUT): $(OBJECT_FILES)
	@mkdir -p $(BASEDIR)/priv/
	$(link_verbose) $(CC) $(OBJECT_FILES) $(LDFLAGS) $(LDLIBS) -o $(C_SRC_OUTPUT)

$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(OBJ_DIR)
	$(COMPILE_C) $(OUTPUT_OPTION) $< -o $@

# $(OBJ_DIR)/%.o: $(TERMBOX2_SRC_DIR)/%.c
# 	@mkdir -p $(OBJ_DIR)
# 	$(COMPILE_C) $(OUTPUT_OPTION) $< -o $@

# Add rules for C++ if needed, copying the pattern above

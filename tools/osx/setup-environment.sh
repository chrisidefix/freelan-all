#!/bin/bash
#
# A script that sets up a build environment for freelan.
#
# This file is versioned so you probably should copy it first before modifying
# it if you intend to.

# Get the root directory
export FREELAN_ALL_ROOT=$(cd $(dirname $0)/../..; pwd -P)

# BUILD_ROOT is a directory which contains include, lib and bin sub-directories.
export FREELAN_BUILD_ROOT="${FREELAN_ALL_ROOT}/build"

# INSTALL_ROOT is a directory which contains include, lib and bin sub-directories.
export FREELAN_INSTALL_ROOT="${FREELAN_ALL_ROOT}/install"

# Create the subdirectories
for SUBDIR in include lib etc bin; do
	mkdir -p ${FREELAN_BUILD_ROOT}/${SUBDIR}
	mkdir -p ${FREELAN_INSTALL_ROOT}/${SUBDIR}
done

# This allows me to type ldconfig as a non-root user.
alias ldconfig="ldconfig -r ${FREELAN_INSTALL_ROOT}"

# Freelan default installation goes into the build root
export FREELAN_BUILD_PREFIX="${FREELAN_BUILD_ROOT}"
export FREELAN_INSTALL_PREFIX="${FREELAN_INSTALL_ROOT}"

export CPLUS_INCLUDE_PATH="${FREELAN_INSTALL_PREFIX}/include:${CPLUS_INCLUDE_PATH}"
export C_INCLUDE_PATH="${FREELAN_INSTALL_PREFIX}/include:${C_INCLUDE_PATH}"
export LIBRARY_PATH="${FREELAN_INSTALL_PREFIX}/lib:${LIBRARY_PATH}"
export LD_LIBRARY_PATH="${FREELAN_INSTALL_PREFIX}/lib:${LD_LIBRARY_PATH}"
export PATH="${FREELAN_INSTALL_PREFIX}/bin:${PATH}"

# Add home-brew boost installation
BOOST_INSTALL_PREFIX=/usr/local/opt/boost
export CPLUS_INCLUDE_PATH="${BOOST_INSTALL_PREFIX}/include:${CPLUS_INCLUDE_PATH}"
export C_INCLUDE_PATH="${BOOST_INSTALL_PREFIX}/include:${C_INCLUDE_PATH}"
export LIBRARY_PATH="${BOOST_INSTALL_PREFIX}/lib:${LIBRARY_PATH}"
export LD_LIBRARY_PATH="${BOOST_INSTALL_PREFIX}/lib:${LD_LIBRARY_PATH}"
export PATH="${BOOST_INSTALL_PREFIX}/bin:${PATH}"

# Add home-brew openssl installation
OPENSSL_INSTALL_PREFIX=/usr/local/opt/openssl
export CPLUS_INCLUDE_PATH="${OPENSSL_INSTALL_PREFIX}/include:${CPLUS_INCLUDE_PATH}"
export C_INCLUDE_PATH="${OPENSSL_INSTALL_PREFIX}/include:${C_INCLUDE_PATH}"
export LIBRARY_PATH="${OPENSSL_INSTALL_PREFIX}/lib:${LIBRARY_PATH}"
export LD_LIBRARY_PATH="${OPENSSL_INSTALL_PREFIX}/lib:${LD_LIBRARY_PATH}"
export PATH="${OPENSSL_INSTALL_PREFIX}/bin:${PATH}"

# Fake ldconfig
export FREELAN_FAKE_LDCONFIG=1

# Freelan server
export FREELAN_SERVER_CONFIGURATION_FILE=${FREELAN_ALL_ROOT}/tools/server/freelan-server.cfg

# Adds freelan-buildtools to the PYTHONPATH
export PYTHONPATH="${FREELAN_ALL_ROOT}/freelan-buildtools:$PYTHONPATH"

# Make the environment history local
export HISTFILE="${FREELAN_ALL_ROOT}/.bash_history"

# Boost suffix
export FREELAN_RELEASE_BOOST_SUFFIX=-mt
export FREELAN_DEBUG_BOOST_SUFFIX=-mt

# This adds a prefix to the PS1
# To enable the feature, modify your PS1 so that it starts with ${PS1_PREFIX}.
export PS1_PREFIX="[freelan] "

# We start a shell that inherits from this environment
echo "Setting-up freelan build environment"
echo
echo "Root is: ${FREELAN_ALL_ROOT}"
echo "Build root is: ${FREELAN_BUILD_ROOT}"
echo "Install root is: ${FREELAN_INSTALL_ROOT}"
echo
echo "Type Ctrl+D or exit to leave the build environment."

$SHELL $"$@"

# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit eutils multilib python-single-r1 cmake-utils vim-plugin

CV=3.8.0

SRC_URI="YouCompleteMe-${PV}.tar.xz
	cfe-${CV}.src.tar.xz
	compiler-rt-${CV}.src.tar.xz
	clang-tools-extra-${CV}.src.tar.xz
	llvm-${CV}.src.tar.xz"

DESCRIPTION="vim plugin: a code-completion engine for Vim"
HOMEPAGE="http://valloric.github.io/YouCompleteMe/"

LICENSE="GPL-3"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

IUSE="+go"

COMMON_DEPEND="
	${PYTHON_DEPS} || (
		app-editors/vim[python,${PYTHON_USEDEP}]
		app-editors/gvim[python,${PYTHON_USEDEP}]
	)
	>=virtual/libffi-3.0.13-r1:0
	go? ( >=dev-lang/go-1.6.0 )
"

RDEPEND="
	${COMMON_DEPEND}
"
DEPEND="
	${COMMON_DEPEND}
"

S="${WORKDIR}/YouCompleteMe"
VIM_PLUGIN_HELPFILES="${PN}"

configure_llvm() {
	local ffi_cflags=$(pkg-config --cflags-only-I libffi)
	local ffi_ldflags=$(pkg-config --libs-only-L libffi)
	local CMAKE_USE_DIR=${WORKDIR}/llvm-${CV}.src
	local BUILD_DIR=${WORKDIR}/llvm-${CV}.src/llvm_build
	local CMAKE_BUILD_TYPE=Release

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DLLVM_ENABLE_TIMESTAMPS=OFF
		-DLLVM_TARGETS_TO_BUILD="host;BPF;CppBackend" 
		-DLLVM_ENABLE_FFI=ON
		-DFFI_INCLUDE_DIR="${ffi_cflags#-I}"
		-DFFI_LIBRARY_DIR="${ffi_ldflags#-L}"
		-Wno-dev
	)

	cmake-utils_src_configure
}

configure_ycmd() {
	local CMAKE_IN_SOURCE_BUILD=1
	local CMAKE_USE_DIR=${S}/third_party/ycmd/cpp

	local mycmakeargs=(
		-DUSE_CLANG_COMPLETER=ON
		-DUSE_SYSTEM_LIBCLANG=OFF
		-DUSE_SYSTEM_BOOST=OFF
		-DEXTERNAL_LIBCLANG_PATH="${WORKDIR}/llvm-${CV}.src/llvm_build/lib/libclang.so"
	)

	cmake-utils_src_configure
}

build_llvm() {
	local CMAKE_USE_DIR=${WORKDIR}/llvm-${CV}.src
	local BUILD_DIR=${WORKDIR}/llvm-${CV}.src/llvm_build
	cmake-utils_src_make
}

build_ycmd() {
	local CMAKE_IN_SOURCE_BUILD=1
	local CMAKE_USE_DIR=${S}/third_party/ycmd/cpp
	cmake-utils_src_make
}

src_unpack() {
	default
	mv ${WORKDIR}/cfe-${CV}.src ${WORKDIR}/llvm-${CV}.src/tools/clang \
		|| die "clang source directory move failed"
	mv ${WORKDIR}/compiler-rt-${CV}.src ${WORKDIR}/llvm-${CV}.src/projects/compiler-rt \
		|| die "compiler-rt source directory move failed"
	mv ${WORKDIR}/clang-tools-extra-${CV}.src ${WORKDIR}/llvm-${CV}.src/tools/clang/tools/extra \
		|| die "clang-tools-extra source directory move failed"
}

src_configure() {
	einfo "Configuring LLVM ..."
	configure_llvm
	einfo "Configuring YCMD ..."
	configure_ycmd
}

src_compile() {
	einfo "Building LLVM ..."
	build_llvm
	einfo "Building YCMD ..."
	build_ycmd

	if use go; then
		einfo "Building gocode ..."
		for d in gocode godef;
		do
		pushd third_party/ycmd/third_party/${d}
		go build
		popd
		done
	fi
}

src_install() {
	dodoc *.md third_party/ycmd/*.md
	rm -r *.md *.sh COPYING.txt third_party/ycmd/cpp || die
	rm -r third_party/ycmd/{*.md,*.sh} || die
	find python -name *test* -exec rm -rf {} + || die
	egit_clean

	vim-plugin_src_install

	python_optimize "${ED}"
}

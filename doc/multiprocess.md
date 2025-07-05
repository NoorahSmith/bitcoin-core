# Multiprocess Smithcoin

_This document describes usage of the multiprocess feature. For design information, see the [design/multiprocess.md](design/multiprocess.md) file._

## Build Option

On Unix systems, the `-DENABLE_IPC=ON` build option can be passed to build the supplemental `smithcoin-node` and `smithcoin-gui` multiprocess executables.

## Debugging

The `-debug=ipc` command line option can be used to see requests and responses between processes.

## Installation

Specifying `-DENABLE_IPC=ON` requires [Cap'n Proto](https://capnproto.org/) to be installed. See [build-unix.md](build-unix.md) and [build-osx.md](build-osx.md) for information about installing dependencies.

### Depends installation

Alternately the [depends system](../depends) can be used to avoid need to install local dependencies. A simple way to get started is to pass the `MULTIPROCESS=1` [dependency option](../depends#dependency-options) to make:

```
cd <SMITHCOIN_SOURCE_DIRECTORY>
make -C depends NO_QT=1 MULTIPROCESS=1
# Set host platform to output of gcc -dumpmachine or clang -dumpmachine or check the depends/ directory for the generated subdirectory name
HOST_PLATFORM="x86_64-pc-linux-gnu"
cmake -B build --toolchain=depends/$HOST_PLATFORM/toolchain.cmake
cmake --build build
build/bin/smithcoin -m node -regtest -printtoconsole -debug=ipc
SMITHCOIN_CMD="smithcoin -m" build/test/functional/test_runner.py
```

The `cmake` build will pick up settings and library locations from the depends directory, so there is no need to pass `-DENABLE_IPC=ON` as a separate flag when using the depends system (it's controlled by the `MULTIPROCESS=1` option).

### Cross-compiling

When cross-compiling and not using depends, native code generation tools from [libmultiprocess](https://github.com/smithcoin-core/libmultiprocess) and [Cap'n Proto](https://capnproto.org/) are required. They can be passed to the cmake build by specifying `-DMPGEN_EXECUTABLE=/path/to/mpgen -DCAPNP_EXECUTABLE=/path/to/capnp -DCAPNPC_CXX_EXECUTABLE=/path/to/capnpc-c++` options.

### External libmultiprocess installation

By default when `-DENABLE_IPC=ON` is enabled, the libmultiprocess sources at [../src/ipc/libmultiprocess/](../src/ipc/libmultiprocess/) are built as part of the smithcoin cmake build, but alternately an external [libmultiprocess](https://github.com/smithcoin-core/libmultiprocess/) cmake package can be used instead by following its [installation instructions](https://github.com/smithcoin-core/libmultiprocess/blob/master/doc/install.md) and specifying `-DWITH_EXTERNAL_LIBMULTIPROCESS=ON` to the smithcoin build, so it will use the external package instead of the sources. This can be useful when making changes to the upstream project. If libmultiprocess is not installed in a default system location it is possible to specify the [`CMAKE_PREFIX_PATH`](https://cmake.org/cmake/help/latest/envvar/CMAKE_PREFIX_PATH.html) environment variable to point to the installation prefix where libmultiprocess is installed.

## Usage

Recommended way to use multiprocess binaries is to invoke `smithcoin` CLI like `smithcoin -m node -debug=ipc` or `smithcoin -m gui -printtoconsole -debug=ipc`.

When the `-m` (`--multiprocess`) option is used the `smithcoin` command will execute multiprocess binaries instead of monolithic ones (`smithcoin-node` instead of `smithcoind`, and `smithcoin-gui` instead of `smithcoin-qt`). The multiprocess binaries can also be invoked directly, but this is not recommended as they may change or be renamed in the future, and they are not installed in the PATH.

The multiprocess binaries currently function the same as the monolithic binaries, except they support an `-ipcbind` option.

In the future, after [#10102](https://github.com/smithcoin/smithcoin/pull/10102) they will have other differences. Specifically `smithcoin-gui` will spawn a `smithcoin-node` process to run P2P and RPC code, communicating with it across a socket pair, and `smithcoin-node` will spawn `smithcoin-wallet` to run wallet code, also communicating over a socket pair. This will let node, wallet, and GUI code run in separate address spaces for better isolation, and allow future improvements like being able to start and stop components independently on different machines and environments. [#19460](https://github.com/smithcoin/smithcoin/pull/19460) also adds a new `smithcoin-wallet -ipcconnect` option to allow new wallet processes to connect to an existing node process.
And [#19461](https://github.com/smithcoin/smithcoin/pull/19461) adds a new `smithcoin-gui -ipcconnect` option to allow new GUI processes to connect to an existing node process.

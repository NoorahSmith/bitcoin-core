# Libraries

| Name                     | Description |
|--------------------------|-------------|
| *libsmithcoin_cli*         | RPC client functionality used by *smithcoin-cli* executable |
| *libsmithcoin_common*      | Home for common functionality shared by different executables and libraries. Similar to *libsmithcoin_util*, but higher-level (see [Dependencies](#dependencies)). |
| *libsmithcoin_consensus*   | Consensus functionality used by *libsmithcoin_node* and *libsmithcoin_wallet*. |
| *libsmithcoin_crypto*      | Hardware-optimized functions for data encryption, hashing, message authentication, and key derivation. |
| *libsmithcoin_kernel*      | Consensus engine and support library used for validation by *libsmithcoin_node*. |
| *libsmithcoinqt*           | GUI functionality used by *smithcoin-qt* and *smithcoin-gui* executables. |
| *libsmithcoin_ipc*         | IPC functionality used by *smithcoin-node*, *smithcoin-wallet*, *smithcoin-gui* executables to communicate when [`-DENABLE_IPC=ON`](multiprocess.md) is used. |
| *libsmithcoin_node*        | P2P and RPC server functionality used by *smithcoind* and *smithcoin-qt* executables. |
| *libsmithcoin_util*        | Home for common functionality shared by different executables and libraries. Similar to *libsmithcoin_common*, but lower-level (see [Dependencies](#dependencies)). |
| *libsmithcoin_wallet*      | Wallet functionality used by *smithcoind* and *smithcoin-wallet* executables. |
| *libsmithcoin_wallet_tool* | Lower-level wallet functionality used by *smithcoin-wallet* executable. |
| *libsmithcoin_zmq*         | [ZeroMQ](../zmq.md) functionality used by *smithcoind* and *smithcoin-qt* executables. |

## Conventions

- Most libraries are internal libraries and have APIs which are completely unstable! There are few or no restrictions on backwards compatibility or rules about external dependencies. An exception is *libsmithcoin_kernel*, which, at some future point, will have a documented external interface.

- Generally each library should have a corresponding source directory and namespace. Source code organization is a work in progress, so it is true that some namespaces are applied inconsistently, and if you look at [`add_library(smithcoin_* ...)`](../../src/CMakeLists.txt) lists you can see that many libraries pull in files from outside their source directory. But when working with libraries, it is good to follow a consistent pattern like:

  - *libsmithcoin_node* code lives in `src/node/` in the `node::` namespace
  - *libsmithcoin_wallet* code lives in `src/wallet/` in the `wallet::` namespace
  - *libsmithcoin_ipc* code lives in `src/ipc/` in the `ipc::` namespace
  - *libsmithcoin_util* code lives in `src/util/` in the `util::` namespace
  - *libsmithcoin_consensus* code lives in `src/consensus/` in the `Consensus::` namespace

## Dependencies

- Libraries should minimize what other libraries they depend on, and only reference symbols following the arrows shown in the dependency graph below:

<table><tr><td>

```mermaid

%%{ init : { "flowchart" : { "curve" : "basis" }}}%%

graph TD;

smithcoin-cli[smithcoin-cli]-->libsmithcoin_cli;

smithcoind[smithcoind]-->libsmithcoin_node;
smithcoind[smithcoind]-->libsmithcoin_wallet;

smithcoin-qt[smithcoin-qt]-->libsmithcoin_node;
smithcoin-qt[smithcoin-qt]-->libsmithcoinqt;
smithcoin-qt[smithcoin-qt]-->libsmithcoin_wallet;

smithcoin-wallet[smithcoin-wallet]-->libsmithcoin_wallet;
smithcoin-wallet[smithcoin-wallet]-->libsmithcoin_wallet_tool;

libsmithcoin_cli-->libsmithcoin_util;
libsmithcoin_cli-->libsmithcoin_common;

libsmithcoin_consensus-->libsmithcoin_crypto;

libsmithcoin_common-->libsmithcoin_consensus;
libsmithcoin_common-->libsmithcoin_crypto;
libsmithcoin_common-->libsmithcoin_util;

libsmithcoin_kernel-->libsmithcoin_consensus;
libsmithcoin_kernel-->libsmithcoin_crypto;
libsmithcoin_kernel-->libsmithcoin_util;

libsmithcoin_node-->libsmithcoin_consensus;
libsmithcoin_node-->libsmithcoin_crypto;
libsmithcoin_node-->libsmithcoin_kernel;
libsmithcoin_node-->libsmithcoin_common;
libsmithcoin_node-->libsmithcoin_util;

libsmithcoinqt-->libsmithcoin_common;
libsmithcoinqt-->libsmithcoin_util;

libsmithcoin_util-->libsmithcoin_crypto;

libsmithcoin_wallet-->libsmithcoin_common;
libsmithcoin_wallet-->libsmithcoin_crypto;
libsmithcoin_wallet-->libsmithcoin_util;

libsmithcoin_wallet_tool-->libsmithcoin_wallet;
libsmithcoin_wallet_tool-->libsmithcoin_util;

classDef bold stroke-width:2px, font-weight:bold, font-size: smaller;
class smithcoin-qt,smithcoind,smithcoin-cli,smithcoin-wallet bold
```
</td></tr><tr><td>

**Dependency graph**. Arrows show linker symbol dependencies. *Crypto* lib depends on nothing. *Util* lib is depended on by everything. *Kernel* lib depends only on consensus, crypto, and util.

</td></tr></table>

- The graph shows what _linker symbols_ (functions and variables) from each library other libraries can call and reference directly, but it is not a call graph. For example, there is no arrow connecting *libsmithcoin_wallet* and *libsmithcoin_node* libraries, because these libraries are intended to be modular and not depend on each other's internal implementation details. But wallet code is still able to call node code indirectly through the `interfaces::Chain` abstract class in [`interfaces/chain.h`](../../src/interfaces/chain.h) and node code calls wallet code through the `interfaces::ChainClient` and `interfaces::Chain::Notifications` abstract classes in the same file. In general, defining abstract classes in [`src/interfaces/`](../../src/interfaces/) can be a convenient way of avoiding unwanted direct dependencies or circular dependencies between libraries.

- *libsmithcoin_crypto* should be a standalone dependency that any library can depend on, and it should not depend on any other libraries itself.

- *libsmithcoin_consensus* should only depend on *libsmithcoin_crypto*, and all other libraries besides *libsmithcoin_crypto* should be allowed to depend on it.

- *libsmithcoin_util* should be a standalone dependency that any library can depend on, and it should not depend on other libraries except *libsmithcoin_crypto*. It provides basic utilities that fill in gaps in the C++ standard library and provide lightweight abstractions over platform-specific features. Since the util library is distributed with the kernel and is usable by kernel applications, it shouldn't contain functions that external code shouldn't call, like higher level code targeted at the node or wallet. (*libsmithcoin_common* is a better place for higher level code, or code that is meant to be used by internal applications only.)

- *libsmithcoin_common* is a home for miscellaneous shared code used by different Smithcoin Core applications. It should not depend on anything other than *libsmithcoin_util*, *libsmithcoin_consensus*, and *libsmithcoin_crypto*.

- *libsmithcoin_kernel* should only depend on *libsmithcoin_util*, *libsmithcoin_consensus*, and *libsmithcoin_crypto*.

- The only thing that should depend on *libsmithcoin_kernel* internally should be *libsmithcoin_node*. GUI and wallet libraries *libsmithcoinqt* and *libsmithcoin_wallet* in particular should not depend on *libsmithcoin_kernel* and the unneeded functionality it would pull in, like block validation. To the extent that GUI and wallet code need scripting and signing functionality, they should be able to get it from *libsmithcoin_consensus*, *libsmithcoin_common*, *libsmithcoin_crypto*, and *libsmithcoin_util*, instead of *libsmithcoin_kernel*.

- GUI, node, and wallet code internal implementations should all be independent of each other, and the *libsmithcoinqt*, *libsmithcoin_node*, *libsmithcoin_wallet* libraries should never reference each other's symbols. They should only call each other through [`src/interfaces/`](../../src/interfaces/) abstract interfaces.

## Work in progress

- Validation code is moving from *libsmithcoin_node* to *libsmithcoin_kernel* as part of [The libsmithcoinkernel Project #27587](https://github.com/smithcoin/smithcoin/issues/27587)

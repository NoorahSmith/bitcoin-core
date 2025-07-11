# Copyright (c) 2023-present The Smithcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

function(generate_setup_nsi)
  set(abs_top_srcdir ${PROJECT_SOURCE_DIR})
  set(abs_top_builddir ${PROJECT_BINARY_DIR})
  set(CLIENT_URL ${PROJECT_HOMEPAGE_URL})
  set(CLIENT_TARNAME "smithcoin")
  set(SMITHCOIN_WRAPPER_NAME "smithcoin")
  set(SMITHCOIN_GUI_NAME "smithcoin-qt")
  set(SMITHCOIN_DAEMON_NAME "smithcoind")
  set(SMITHCOIN_CLI_NAME "smithcoin-cli")
  set(SMITHCOIN_TX_NAME "smithcoin-tx")
  set(SMITHCOIN_WALLET_TOOL_NAME "smithcoin-wallet")
  set(SMITHCOIN_TEST_NAME "test_smithcoin")
  set(EXEEXT ${CMAKE_EXECUTABLE_SUFFIX})
  configure_file(${PROJECT_SOURCE_DIR}/share/setup.nsi.in ${PROJECT_BINARY_DIR}/smithcoin-win64-setup.nsi USE_SOURCE_PERMISSIONS @ONLY)
endfunction()

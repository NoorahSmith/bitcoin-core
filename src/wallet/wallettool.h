// Copyright (c) 2016-2021 The Smithcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef SMITHCOIN_WALLET_WALLETTOOL_H
#define SMITHCOIN_WALLET_WALLETTOOL_H

#include <string>

class ArgsManager;

namespace wallet {
namespace WalletTool {

bool ExecuteWalletToolFunc(const ArgsManager& args, const std::string& command);

} // namespace WalletTool
} // namespace wallet

#endif // SMITHCOIN_WALLET_WALLETTOOL_H

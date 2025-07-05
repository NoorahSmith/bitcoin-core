// Copyright (c) 2023-present The Smithcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef SMITHCOIN_TEST_UTIL_JSON_H
#define SMITHCOIN_TEST_UTIL_JSON_H

#include <univalue.h>

#include <string_view>

UniValue read_json(std::string_view jsondata);

#endif // SMITHCOIN_TEST_UTIL_JSON_H

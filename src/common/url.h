// Copyright (c) 2015-2022 The Smithcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef SMITHCOIN_COMMON_URL_H
#define SMITHCOIN_COMMON_URL_H

#include <string>
#include <string_view>

/* Decode a URL.
 *
 * Notably this implementation does not decode a '+' to a ' '.
 */
std::string UrlDecode(std::string_view url_encoded);

#endif // SMITHCOIN_COMMON_URL_H

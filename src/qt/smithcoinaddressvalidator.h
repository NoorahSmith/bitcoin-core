// Copyright (c) 2011-2020 The Smithcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef SMITHCOIN_QT_SMITHCOINADDRESSVALIDATOR_H
#define SMITHCOIN_QT_SMITHCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class SmithcoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit SmithcoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

/** Smithcoin address widget validator, checks for a valid smithcoin address.
 */
class SmithcoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit SmithcoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

#endif // SMITHCOIN_QT_SMITHCOINADDRESSVALIDATOR_H

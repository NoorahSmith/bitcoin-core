New command line interface
--------------------------

A new `smithcoin` command line tool has been added to make features more
discoverable and convenient to use. The `smithcoin` tool just calls other
executables and does not implement any functionality on its own.  Specifically
`smithcoin node` is a synonym for `smithcoind`, `smithcoin gui` is a synonym for
`smithcoin-qt`, and `smithcoin rpc` is a synonym for `smithcoin-cli -named`. Other
commands and options can be listed with `smithcoin help`. The new tool does not
replace other tools, so all existing commands should continue working and there
are no plans to deprecate them.

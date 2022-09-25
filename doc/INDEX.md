# Index

[![root](https://img.shields.io/badge/back_to_root-536362?)](../README.md)
[![INDEX](https://img.shields.io/badge/index-blue?labelColor=blue)](INDEX.md)

Welcome on the `luabased` package documentation.

# Install

Add the module to your system :

```shell
LUA_PATH = "/z/someplace/parentdir/?.lua"
# where `parentdir` contains `luabased/`
```

exemple :

```shell
cd /z/demo

git clone "https://github.com/MrLixm/luabased"

LUA_PATH = "/z/demo/luabased/?.lua"
```

It can then be accessed via :

```lua
local luabased = require("luabased")
```

# Development

Type hinting is performed using [EmmyLua - EmmyLua for IntelliJ IDEA 1.3.2 documentation](https://emmylua.github.io/index.html)
which is itself similar to [LDoc](https://stevedonovan.github.io/ldoc/manual/doc.md.html).
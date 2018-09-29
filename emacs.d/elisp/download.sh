#!/bin/bash

curl https://raw.githubusercontent.com/chapel-lang/chapel/master/highlight/emacs/chpl-mode.el -o chpl-mode.el
curl https://raw.githubusercontent.com/llvm-mirror/llvm/master/utils/emacs/llvm-mode.el -o llvm-mode.el
git clone https://github.com/ensime/emacs-scala-mode

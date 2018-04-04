**charm-mode** is an emacs mode for writing [Charm](https://github.com/aearnus/charm) files with syntax highlighting and on-the-fly interpretation. As of right now, it is extremely bare.

## Installation

Drop `charm-mode.el` into your `~/emacs.d/` directory, then add	the following lines to your `.emacs` file:

```
(add-to-list 'load-path "~/.emacs.d/")
(require 'charm-mode)
```

# Lib

The `default.nix` defines a lib extended with a `_` attribute under which
custom lib functions live. The `default.nix` loads every `.nix` file in the
`libs` (current) directory and imports it.

## Loading the library functions

The importing is quite simple:
1. First the `libsInFolder` reads the contents of the `libs` directory, filters
   out non `.nix` files and the `default.nix` file and then returns a list of
   paths to the individual `.nix` files it found.
2. This list gets passed to `importLibs` which imports the libraries and
   merges the individual imported attribute sets together, so that all the
   functions are available directly under one attribute set.
3. This attribute then gets bind to the `_` attribute in the `lib` extension.

Individual `.nix` files can use the functions defined in other local library
files normally using the `nix._.someFunctionName`.

## Overview of functions

### colors
Provides utilities to work with colors.

### modules
Provides utilities to load modules, e.g. other configuration files.

### nixos
#### [`_.mkHost`](./nixos.nix#6)
Utility function to create a NixOS system configuration. Takes the `system`
configuration string and path to `.nix` file for the system's configuration.

### pkgs
Provides utilities for creating packages.

### utils
#### [`_.mkOpt`](./utils.nix#68)
Shortcut for creating an option

#### [`_.mkOpt'`](./utils.nix#81)
Shortcut for creating an option without description

#### [`_.mkBoolOpt`](./utils.nix#84)
Shortcut for creating a boolean option without description

# Expect Cookbook
[![Chef cookbook](https://img.shields.io/cookbook/v/expect.svg)](https://supermarket.chef.io/cookbooks/expect)
[![Build Status](https://travis-ci.org/rjaros87/chef-expect.svg?branch=master)](https://travis-ci.org/rjaros87/chef-expect)

# Description

This cookbook will install [Expect package](http://expect.sourceforge.net/).
> Expect is a tool for automating interactive applications such as telnet, ftp, passwd, fsck, rlogin, tip, etc. Expect really makes this stuff trivial. Expect is also useful for testing these same applications. And by adding Tk, you can also wrap interactive applications in X11 GUIs.
> Expect can make easy all sorts of tasks that are prohibitively difficult with anything else. You will find that Expect is an absolutely invaluable tool - using it, you will be able to automate tasks that you've never even thought of before - and you'll be able to do this automation quickly and easily.

Expect requires Tcl (tool command language). This cookbook will provide Tcl package if necessary (currently only Windows platform requires it).

### Platforms

- Ubuntu
- CentOS
- RedHat
- Fedora
- Mac OS X
- Windows

### Chef

- Chef 12 or later

## Attributes

### expect::default

| Key                                             | Type    | Description                                             | Platform | Default                            |
| ------------------------------------------------| ------- | --------------------------------------------------------| -------- | -----------------------------------|
| `default['expect']['include_homebrew']`         | Boolean | Include homebrew recipe for installing brew on Mac OS   | Mac OS   | `true`                             |
| `default['expect']['cygwin']['from_system']`    | Boolean | Use the Cygwin from system                              | Windows  | `false`                            |
| `default['expect']['cygwin']['home']`           | String  | Installation path for the Cygwin                        | Windows  | `'C:\\Tcl'`                        |
| `default['expect']['cygwin']['site']`           | String  | Server where the Cygwin should search for the packages  | Windows  | `'http://cygwin.mirrors.pair.com'` |

## Recipes

### expect::default

Installs Expect package on node and if the node platform is Windows then the recipe also installs [Cygwin](https://www.cygwin.com/) component.

## Usage

### expect::default

Just include `expect` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[expect]"
  ]
}
```

## Contributing

* [Contribution Guidelines](https://github.com/rjaros87/chef-expect/blob/master/CONTRIBUTING.md)

## License and Authors

Authors: Radoslaw Jaros


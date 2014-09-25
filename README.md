# lintpkg

## About

lintpkg is a tool for checking common errors in slackware packages. It can be
used for example to test downloaded packages for common packaging mistakes, or
to check a package you created yourself for things you might have missed. By
default all available checks are performed, but specific checks can be performed
using command line parameters.

lintpkg is heavily based on [rpmlint](http://sourceforge.net/projects/rpmlint/)
and tries to keep compatibility to it where possible in order to make integration
into CI systems that already support rpmlint simple. It does however also try
to keep close to the other pkgtools of slackware.

## Install

At this point there is no install script provided as it's not really necessary.
lintpkg will look for checks by default in one of two locations:

- /usr/share/lintpkg as a global location
- a "checks" directory within the same directory as the "lintpkg" script

Alternatively you can tell lintpkg to use checks from a different location using

lintpkg --checkdir /path/to/checks

## Checks

Currently lintpkg ships with a small set of checks:

- Binaries in wrong architecture paths (architecture_check)
- Directories that should not be used for packages (disallowed_dirs_check)
- Icon theme cache update in doinst.sh (icon_check)
- Correct path for and compression of info pages (info_check)
- Correct path for and compression of man pages (man_check)
- Correct folder permissions under /usr and /etc (permissions_check)

More checks and comments on existing ones welcome :)

## Return codes

Depending on the result of the checks lintpkg will return with different
exit codes:

- 0:  No errors
- 1:  Unspecified error
- 64: One or more error/warning messages are printed

## Writing checks

Writing checks is intentionally kept rather simple. A check needs to provide
two functions:

### check()

The check() function performs the actual tests that should be performed on
the package. All necessary information is available in global variables:

- $WORKING_DIR   - This is the location of the uncompressed package content
- $PKG_FULLNAME  - This is the full name of the package, sans the file extension
- $PKG_NAME      - This is the name of the package
- $PKG_VERSION   - This is the version of the package
- $PKG_ARCH      - This is the architecture the package was built for
- $PKG_BUILD     - This is the build number of the package
- $PKG_EXTENSION - This is the compression format used by the package

Additionally there are several functions one can use for reporting issues. All of
these take two arguments, where the first is the messageid of the issue, and the
second is additional optional information, most commonly the offending file.

- log_error() logs an issue as an error.
- log_warning() logs an issue as a warning.
- log_notice() logs an issue as a notice.

### info()

The info() function is used for providing detailed information on the issues that
the check() function can raise. It's only argument is the messageid of an issue.

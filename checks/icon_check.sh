#!/bin/sh
# Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Verify that icons are handled correctly.

check() {
  if [ -e $WORKING_DIR/usr/share/icons/hicolor ]; then
    if [ -e $WORKING_DIR/install/doinst.sh ]; then
      if ! [ $(grep hicolor $WORKING_DIR/install/doinst.sh | wc -l) -ge "2" ]; then
        log_error "missing-icon-cache-update" "hicolor"
      fi
    else
      log_error "missing-icon-cache-update" "hicolor"
    fi
  fi
}

info() {
  if [ "$1" = "missing-icon-cache-update" ]; then
    echo -n "Icon theme contents are cached in an mmap()-able cache file. Whenever "
    echo "installing new icons, this cache file should be updated in doinst.sh."
    echo
  fi
}

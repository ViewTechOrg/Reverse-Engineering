#!/bin/bash
# blind-bash: tools for obfuscated bash script
# Probably not compitable with some device.
#
# Copyright (C) 2022-present Rangga Fajar Oktariansyah and Contributors
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not write to the Rangga Fajar Oktariansyah, see <https://www.gnu.org/licenses/>.
#
# Set program name and initialize result variable
prog="${0##*/}"
res=0

# Enable the "set -e" option to exit immediately if any command exits with a non-zero status.
set -e

# Function to print text
function print() {
  printf "$@\n"
}

# Make sure important variables exist if not already defined
#
# $USER is defined by login(1) which is not always executed (e.g. containers)
# POSIX: https://pubs.opengroup.org/onlinepubs/009695299/utilities/id.html
USER=${USER:-$(id -u -n)}
# $HOME is defined at the time of login, but it could be unset. If it is unset,
# a tilde by itself (~) will not be expanded to the current user's home directory.
# POSIX: https://pubs.opengroup.org/onlinepubs/009696899/basedefs/xbd_chap08.html#tag_08_03
HOME="${HOME:-$(getent passwd $USER 2>/dev/null | cut -d: -f6)}"
# macOS does not have getent, but this works even if $HOME is unset
HOME="${HOME:-$(eval echo ~$USER)}"

# Test directory ".config" and create this directory if isn't find
test -d "$HOME/.config" && test -w "$HOME/.config" && test -x "$HOME/.config" || {
  mkdir "$HOME/.config" >/dev/null 2>&1
}

# Functions to check if a command exists, print version information, and print help
# function command_exists() {
#   command -v "$@" >/dev/null 2>&1
# }

function version() {
  print "Blind Bash v2.1
Copyright (C) 2022-$(date +"%Y") Rangga Fajar Oktariansyah and Contributors.
This is free software.  You may redistribute copies of it under the terms of
the GNU Affero General Public License <https://www.gnu.org/licenses/agpl.html>.
There is NO WARRANTY, to the extent permitted by law.

Report bugs to <fajarrkim@gmail.com>."
}

function help() {
  print "Usage: $prog [OPTION] [FILE 1] [FILE 2] etc...
Obfuscated files bash, so it can't be read.

Option:
   -f, --file           starting obfuscated files name
   -h, --help           print help this tools
   -v, --version        output version information
       --upgrade        upgrade version this tool
       --uninstall      uninstall this tool

Note: The more number of lines in a file, the longer it will take to encrypt.

Report bugs <fajarrkim@gmail.com>"
}

function upgrade() {
  command_exists .bb-upgrade || {
    test -f tools/upgrade.sh || {
      print "$prog: this command can only be run if you have installed\nthis tool in the \`\$PATH' folder or in the original repository folder"
      exit 1
    }
    bash tools/upgrade.sh || exit 1
    return
  }
  .bb-upgrade || exit 1
}

function uninstall() {
  command_exists .bb-uninstall || {
    print "$prog: This command can only be run if you have installed\nthis tool in the \`\$PATH' folder or in the original repository folder"
    exit 1
  }
  .bb-uninstall || exit 1
}

# Functions related to upgrading the script
function _blind_upgrade_current_epoch() {
  local sec=${EPOCHSECONDS-}
  test $sec || printf -v sec '%(%s)T' -1 2>/dev/null || sec=$(command date +%s)
  echo $((sec / 60 / 60 / 24))
}

function _blind_upgrade_update_timestamp() {
  echo "LAST_EPOCH=$(_blind_upgrade_current_epoch)" >| $HOME/.config/.bb-update
}

function _blind_upgrade_check() {
  if test ! -f "$HOME/.config/.bb-update"; then
    # create ~/.osh-update
    _blind_upgrade_update_timestamp
    return 0
  fi

  local LAST_EPOCH
  . $HOME/.config/.bb-update
  if test ! $LAST_EPOCH; then
    _blind_upgrade_update_timestamp
    return 0
  fi

  # Default to the old behavior
  local epoch_expires=${UPDATE_BLIND_DAYS:-30}
  local epoch_elapsed=$(($(_blind_upgrade_current_epoch) - LAST_EPOCH))
  if ((epoch_elapsed <= epoch_expires)); then
    return 0
  fi

  print "$prog: the tool hasn't been updated for 30 days\nFor upgrade, you run \`$prog --upgrade' or run \`bash upgrade.sh'"
}

# Perform the upgrade check
_blind_upgrade_check

# Function to generate a random string of alphanumeric characters
function generate_random_string() {
  tr -dc A-Za-z0-9 </dev/urandom | head -c $((2 + RANDOM % 6)) ; echo ""
}

# Function to generate a random variable, potentially prefixed with a letter if it starts with a number
function generate_random_variable() {
  local random_string=$(generate_random_string)
  case $random_string in
    [0-9]*) echo "$(tr -dc A-Za-z </dev/urandom | head -c 1)$random_string";;
    *) echo "$random_string";;
  esac
}

# Function to generate a variable name and assign it a random value
function generate_variable_and_assign() {
  local variable_name=$1
  eval "$variable_name=\"$(generate_random_variable)\""
}

# Function to generate and assign random values to a list of variables
function generate_and_assign_variables() {
  local variables=("Az" "Bz" "Cz" "Dz" "Ez" "Fz" "Gz" "Hz" "Iz" "Jz" "Kz" "Lz" "Mz" "Nz" "Oz" "Pz" "Qz" "Rz" "Sz" "Tz" "Uz" "Vz" "Wz" "Xz" "Yz" "Zz" "Ay" "By" "Cy" "Dy" "Ey" "Fy" "Gy" "Hy" "Iy" "Jy" "Ky" "Ly" "My" "Ny" "Oy" "Py" "Qy" "Ry" "Sy" "Ty" "Uy" "Vy" "Wy" "Xy" "Yy" "Zy")

  for variable in "${variables[@]}"; do
    generate_variable_and_assign "$variable"
  done
}

# Functions for different encryption modes (mode_1, mode_2, mode_3, mode_4)
# Each function creates an encrypted file with a unique encoding style
function mode_1() {
  local file="$1"

  if base64 $file >/dev/null 2>&1; then
    local enc=$(base64 $file | sed ':a;N;$!ba;s/\n//g')
  else
    print "$prog: Error encrypt file $file"
    return 1
  fi

  local encrypt=$(echo "$enc" | rev)

  generate_and_assign_variables

  cat <<EOF > enc-$file
#!/bin/bash
#
# This file has been encrypted with Blind Bash <https://github.com/FajarKim/blind-bash>
# at $(date).
# Don't forget to follow me on <https://github.com/FajarKim>
#
set -e

z="
";$Rz='ov';$Sz='-d ';$Ez=' bas';$Bz=' "$encrypt"';$Tz='echo';$Uz='ESC';$Vz='64 ';$Az='echo';$Gz='-d';$Wz='t" |';$Fz='e64 ';$Xz='"|';
$Dz='ev |';$Cz=' | r';$Yz='er"';$Ay='prin';$By='-e ';$Cy='base';$Dy='" |';$Ey='tf'

if eval "\$$Hz\$$Iz\$$Az\$$Jz\$$Bz\$$Kz\$$Cz\$$Lz\$$Dz\$$Mz\$$Nz\$$Ez\$$Fz\$$Qz\$$Gz\$$Oz\$$Pz\$$Fy"; then
  $Gy=\$(eval "\$$Hz\$$Iz\$$Az\$$Jz\$$Bz\$$Kz\$$Cz\$$Lz\$$Dz\$$Mz\$$Nz\$$Ez\$$Fz\$$Qz\$$Gz\$$Oz\$$Pz\$$Fy")
  eval "\$$Hy\$$Iy\$$Ny\$$Oy\$$Gy\$$Jy\$$Ky\$$Ly\$$My\$$Py\$$Qy"
else
  printf >&2 '%s\n' "Cannot decode \${0##*/}"
  printf >&2 '%s\n' "Report bugs <fajarrkim@gmail.com>"
  exit 1
fi

#
# Copyright (C) 2022-$(date +"%Y") Rangga Fajar Oktariansyah
#
# Are there any bugs? Report to:
# -  Email: fajarrkim@gmail.com
# -  WhatsApp: +6285659850910
# -  Telegram: @FajarThea
EOF

  if chmod -w enc-$file; then
    print "$prog: Done, file saved as enc-$file"
  else
    print "$prog: Cannot chmod enc-$file"
    return 1
  fi
}

function mode_2() {
  local file="$1"

  if base32 $file >/dev/null 2>&1; then
    local enc=$(base32 $file | sed ':a;N;$!ba;s/\n//g')
  else
    print "$prog: Error encrypt file $file"
    return 1
  fi

  local encrypt=$(echo "$enc" | rev)

  generate_and_assign_variables

  cat <<EOF > enc-$file
#!/bin/bash
#
# This file has been encrypted with Blind Bash <https://github.com/FajarKim/blind-bash>
# at $(date).
# Don't forget to follow me on <https://github.com/FajarKim>
#
set -e

$Hz="
";$Ez='v | ';$Bz='tf "';$Az='prin';$Dz='| re';$Fz='base';$Cz='$encrypt" ';$Gz='32 -d';
$Iz='printf "';$Jz='===$Ay$By$Cy$Fy$Ey$Fy$Dy$Az$Bz$Cz$Xz$Vz$By$Dy$Tz
" | r';$Kz='| ba';$Lz='"';$Mz=' base64';$Iy="'";$Nz='se32';$Oz='r';$Pz='" |';$Qz='v | bas';$Jy="tf ";
$Rz='se64 -d';$Sz='v |';$Tz='| re';$Uz='base64';$Vz=' | ';$Wz='pri';$Xz='" |';$Zz='| ba';

if eval "\$$Ey\$$Fy\$$Az\$$Gy\$$Bz\$$Hy\$$Cz\$$Cy\$$Dy\$$Dz\$$By\$$Ez\$$Fz\$$Gz\$$Ay"; then
  $Ky=\$(eval "\$$Ey\$$Fy\$$Az\$$Gy\$$Bz\$$Hy\$$Cz\$$Cy\$$Dy\$$Dz\$$By\$$Ez\$$Fz\$$Gz\$$Ay")
  eval "\$$Oy\$$Ny\$$My\$$Ly\$$Ky\$$Qy\$$Ry\$$Xy\$$Wy\$$Ly\$$Qy\$$Py"
else
  printf >&2 '%s\n' "Cannot decode \${0##*/}"
  printf >&2 '%s\n' "Report bugs <fajarrkim@gmail.com>"
  exit 1
fi

#
# Copyright (C) 2022-$(date +"%Y") Rangga Fajar Oktariansyah
#
# Are there any bugs? Report to:
# -  Email: fajarrkim@gmail.com
# -  WhatsApp: +6285659850910
# -  Telegram: @FajarThea
EOF

  if chmod -w enc-$file; then
    print "$prog: Done, file saved as enc-$file"
  else
    print "$prog: Cannot chmod enc-$file"
    return 1
  fi
}

function mode_3() {
  local file="$1"

  if basenc --base2msbf $file >/dev/null 2>&1; then
    local enc=$(basenc --base2msbf $file | sed ':a;N;$!ba;s/\n//g')
  else
    print "$prog: Error encrypt file $file"
    return 1
  fi

  local encrypt=$(echo "$enc" | rev)

  generate_and_assign_variables

  cat <<EOF > enc-$file
#!/bin/bash
#
# This file has been encrypted with Blind Bash <https://github.com/FajarKim/blind-bash>
# at $(date).
# Don't forget to follow me on <https://github.com/FajarKim>
#
set -e

$Ry="
";$Cz='$encrypt" |';$Kz=' -d';$Lz='bas';$Mz='se16';$Nz='ch';$Ez=' | b';$Gz='c --';$Dz=' rev';
$Oz='echo';$Pz='las';$Qz='-e';$Rz='ntf "';$Sz='" |';
$Jz='f';$Uz='vx';$Vz='"';$Wz='fa';$Fz='asen';$Az='prin';$Bz='tf "';$Tz='" | b';$Hz='base';$Xz='ls';$Yz='2l';$Iz='2msb';

if eval "\$$Ay\$$By\$$Az\$$Bz\$$Cy\$$Cz\$$Fy\$$Dz\$$Dy\$$Ey\$$Ez\$$Fz\$$Jy\$$Gz\$$Hz\$$Iy\$$Iz\$$Jz\$$Kz\$$Gy\$$Hy"; then
  $Ky=\$(eval "\$$Ay\$$By\$$Az\$$Bz\$$Cy\$$Cz\$$Fy\$$Dz\$$Dy\$$Ey\$$Ez\$$Fz\$$Jy\$$Gz\$$Hz\$$Iy\$$Iz\$$Jz\$$Kz\$$Gy\$$Hy")
  eval "\$$Ly\$$My\$$Ny\$$Oy\$$Iy\$$Ky\$$Ay\$$By\$$Py\$$Qy\$$Cy\$$Fy"
else
  printf >&2 '%s\n' "Cannot decode \${0##*/}"
  printf >&2 '%s\n' "Report bugs <fajarrkim@gmail.com>"
  exit 1
fi

#
# Copyright (C) 2022-$(date +"%Y") Rangga Fajar Oktariansyah
#
# Are there any bugs? Report to:
# -  Email: fajarrkim@gmail.com
# -  WhatsApp: +6285659850910
# -  Telegram: @FajarThea
EOF

  if chmod -w enc-$file; then
    print "$prog: Done, file saved as enc-$file"
  else
    print "$prog: Cannot chmod enc-$file"
    return 1
  fi
}

function mode_4() {
  local file="$1"

  if basenc --base2lsbf $file >/dev/null 2>&1; then
    local enc=$(basenc --base2lsbf $file | sed ':a;N;$!ba;s/\n//g')
  else
    print "$prog: Error encrypt file $file"
    return 1
  fi

  local encrypt=$(echo "$enc" | rev)

  generate_and_assign_variables

  cat <<EOF > enc-$file
#!/bin/bash
#
# This file has been encrypted with Blind Bash <https://github.com/FajarKim/blind-bash>
# at $(date).
# Don't forget to follow me on <https://github.com/FajarKim>
set -e

$Ry="
";$Cz='$encrypt" |';$Kz=' -d';$Lz='bas';$Mz='se16';$Nz='ch';$Ez=' | b';$Gz='c --';$Dz=' rev';
$Oz='echo';$Pz='las';$Qz='-e';$Rz='ntf "';$Sz='" |';$Yy=' -d';
$Jz='f';$Uz='vx';$Vz='"';$Wz='fa';$Fz='asen';$Az='prin';$Bz='tf "';$Tz='" | b';$Hz='base';$Xz='ls';$Yz='2l';$Iz='2lsb';

if eval "\$$Ay\$$By\$$Az\$$Bz\$$Cy\$$Cz\$$Fy\$$Dz\$$Dy\$$Ey\$$Ez\$$Fz\$$Jy\$$Gz\$$Hz\$$Iy\$$Iz\$$Jz\$$Kz\$$Gy\$$Hy"; then
  $Ky=\$(eval "\$$Ay\$$By\$$Az\$$Bz\$$Cy\$$Cz\$$Fy\$$Dz\$$Dy\$$Ey\$$Ez\$$Fz\$$Jy\$$Gz\$$Hz\$$Iy\$$Iz\$$Jz\$$Kz\$$Gy\$$Hy")
  eval "\$$Ly\$$My\$$Ny\$$Oy\$$Iy\$$Ky\$$Ay\$$By\$$Py\$$Qy\$$Cy\$$Fy"
else
  printf >&2 '%s\n' "Cannot decode \${0##*/}"
  printf >&2 '%s\n' "Report bugs <fajarrkim@gmail.com>"
  exit 1
fi

#
# Copyright (C) 2022-$(date +"%Y") Rangga Fajar Oktariansyah
#
# Are there any bugs? Report to:
# -  Email: fajarrkim@gmail.com
# -  WhatsApp: +6285659850910
# -  Telegram: @FajarThea
#
EOF

  if chmod -w enc-$file; then
    print "$prog: Done, file saved as enc-$file"
  else
    print "$prog: Cannot chmod enc-$file"
    return 1
  fi
}

# Check for command-line arguments
if test $# -eq 0; then
  print "$prog: missing operand\nTry \`$prog --help' for more information"
  exit 1
fi

# Parse command-line options
case $1 in
  -f | --file) shift;;
  -h | --help) help || exit 1; exit;;
  -v | --version) version || exit 1; exit;;
  --upgrade) upgrade || exit 1; exit;;
  --uninstall) uninstall || exit 1; exit;;
  *) print "$prog: Invalid option \`$1'"; exit 1;;
esac

# Check for command-line arguments
if test $# -eq 0; then
  print "$prog: missing operand\nTry \`$prog --help' for more information"
  exit 1
fi

# Check for the existence of the "coreutils" command
coreutils --version >/dev/null 2>&1 || {
  print "$prog: The program coreutils is notinstalled.\nPlease install first!"
  exit 1
}

# Main loop to process files and apply one of the encryption modes
for i do
  case $i in
  -*) file=./$i;;
  *) file=$i;;
  esac

  if test ! -f "$file" || test ! -r "$file"; then
    res=1
    print "$prog: \`$i' is not a readable regular file"
    continue
  fi

  if test -u "$file"; then
    res=1
    print "$prog: \`$i' has setuid permission, unchanged"
    continue
  fi

  if test -g "$file"; then
    res=1
    print "$prog: \`$i' has setgid permission, unchanged"
    continue
  fi

  case $((1 + $RANDOM % 4)) in
    1) mode_1 $file;;
    2) mode_2 $file;;
    3) mode_3 $file;;
    4) mode_4 $file;;
  esac
done
# Exit with the final result status
(exit $res); exit $res

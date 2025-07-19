#!/bin/bash
# bzsh: compressor for Unix executables.
# Use this only for binaries that you do not use frequently.
#
# I try invoking the compressed executable with the original name
# (for programs looking at their name).  We also try to retain the original
# file permissions on the compressed file.  For safety reasons, bzsh will
# not create setuid or setgid shell scripts.
#
# WARNING: the first line of this file must be either : or #!/bin/bash
# The : is required for some old versions of csh.
# On Ultrix, /bin/bash is too buggy, change the first line to: #!/bin/bash5
#
# Copyright (C) 2022-present Rangga Fajar Oktariansyah
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
tab='	'
nl='
'
IFS=" $tab$nl"
PROG="${0##*/}"
VERSION=v1.1

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

# Check directory $HOME/.config. If it doesn't exist, a folder will be created.
test -d "$HOME/.config" && test -w "$HOME/.config" && test -x "$HOME/.config" || {
  mkdir "$HOME/.config" >/dev/null 2>&1
}

# Function to check program is exists or not
command_exists() {
  if command -v "$@" >/dev/null 2>&1; then
    true
  else
    false
  fi
}

# Function to check internet connection
check_internet_connection() {
  if ping -q -c 1 -W 1 google.com >/dev/null 2>&1; then
    true
  else
    false
  fi
}

# Some functions to check tool upgrade
current_epoch() {
  local sec=${EPOCHSECONDS-}
  test $sec || printf -v sec '%(%s)T' -1 2>/dev/null || sec=$(command date +%s)
  echo $((sec / 60 / 60 / 24))
}

update_timestamp() {
  echo "LAST_EPOCH=$(current_epoch)" >| $HOME/.config/.bzsh-update
}

upgrade_check() {
  if test ! -f "$HOME/.config/.bzsh-update"; then
    # create $HOME/.config/.bzsh-update
    update_timestamp
    return 0
  fi

  local LAST_EPOCH
  . $HOME/.config/.bzsh-update
  if test ! $LAST_EPOCH; then
    update_timestamp
    return 0
  fi

  # Default to the old behavior
  local epoch_expires=${UPDATE_BZSH_DAYS:-15}
  local epoch_elapsed=$(($(current_epoch) - LAST_EPOCH))
  if test $epoch_elapsed -le $epoch_expires; then
    return 0
  fi

  if check_internet_connection; then
    latest_version=$(curl -s "https://api.github.com/repos/FajarKim/bz2-shell/releases/latest" | grep -o '"tag_name": "*.*"' | cut -d '"' -f4)
  else
    return 0
  fi

  if [ "$VERSION" != "$latest_version" ]; then
    echo "$PROG: found a new version '$VERSION -> $latest_version'${nl}For upgrade, please run \`$PROG --upgrade' or run \`bash upgrade.sh'"
    return 0
  else
    update_timestamp
    return 0
  fi
}

# Run upgrade_check function
upgrade_check

# Function to display help for this tool
help() {
  echo "Usage: $PROG [OPTIONS] FILE...
Replace each executable FILE with a compressed version of itself.
Make a backup FILE~ of the old version of FILE.

  -t, --type-shell  Select a type shell (sh, bash, zsh, ksh, or mksh).
  -f, --file        Compress each FILE instead it.
  -h, --help        display this help.
  -v, --version     output version information.
      --upgrade     upgrade version this tool.
      --uninstall   uninstall this tool.

Example:
   $PROG -t bash -f FILE
or
   $PROG --type-shell bash --file FILE

If compressed some files, type for example:
   $PROG -t bash -f FILE1 FILE2 FILE3...
or
   $PROG --type-shell bash --file FILE1 FILE2 FILE3...

Note: The more number of lines in a file, the longer it will take to encrypt.

Report bugs to <fajarrkim@gmail.com>."
}

version() {
  echo "BZip2 Shell Exec (bz2-shell) $VERSION
Copyright (C) 2022-present Rangga Fajar Oktariansyah.
This is free software.  You may redistribute copies of it under the terms of
the GNU Affero General Public License <https://www.gnu.org/licenses/agpl.html>.
There is NO WARRANTY, to the extent permitted by law.

Report bugs to <fajarrkim@gmail.com>."
}

upgrade() {
  command_exists .bzsh-upgrade || {
    case $HOME in
    */com.termux/*) TOOLS="Termux";;
    *) TOOLS="Linux";;
    esac
    test -f tools/$TOOLS/upgrade.sh || {
      echo "$PROG: this command can only be run if you have installed
this tool in the \`\$PATH' folder or in the original repository folder"
      exit 1
    }
    bash tools/$TOOLS/upgrade.sh || exit 1
    update_timestamp
    return
  }
  .bzsh-upgrade || exit 1
  update_timestamp
}

uninstall() {
  command_exists .bzsh-uninstall || {
    echo "$PROG: This command can only be run if you have installed
this tool in the \`\$PATH' folder or in the original repository folder"
    exit 1
  }
  .bzsh-uninstall || exit 1
}

# Checking package 'bzip2'
command_exists bzip2 || {
  echo "$PROG: the program \`bzip2' is not installed
Please installed the program and try again."
  exit 127
}

# Checking package 'curl'
command_exists curl || {
  echo "$PROG: the program \`curl' is not installed
Please installed the program and try again."
  exit 127
}

# The command parser
while :; do
  case $@ in
  -t | --type-shell) shift;;
  -h | --help) help || exit 1; exit;;
  -v | --version) version || exit 1; exit;;
  --upgrade) upgrade || exit 1; exit;;
  --uninstall) uninstall || exit 1; exit;;
  -*) shift; break;;
  *) break;;
  esac
done

if test $# -eq 0; then
  echo "$PROG: missing operand
Try \`$PROG --help' for more information."
  exit 1
fi

# Checking type shell input
while :; do
  case $1 in
  sh | bash | zsh | ksh | mksh) command_exists $1 || { echo "$PROG: the type shell \`$1' is not installed"; echo "Please installed the program and try again."; exit 127; }; TYPE_SHELL=$1; shift; break;;
  -h | --help) help || exit 1; exit;;
  -v | --version) version || exit 1; exit;;
  -f | --file | '' | ' '*) echo "$PROG: input a type shell"; exit 1;;
  -*) echo "$PROG: invalid option \`$1'"; echo "Try \`$PROG --help' for more information."; exit 1;;
  *) command_exists $1 || { echo "$PROG: input a type shell"; exit 1; }; echo "$PROG: \`$1' probably not a type shell"; echo "Cannot supported."; exit 1;;
  esac
done

if test $# -eq 0; then
  echo "$PROG: missing operand
Try \`$PROG --help' for more information."
  exit 1
fi

# Checking file input
while :; do
  case $@ in
  -f | --file) shift;;
  -h | --help) help || exit 1; exit;;
  -v | --version) version || exit 1; exit;;
  -*) shift; break;;
  *) break;;
  esac
done

if test $# -eq 0; then
  echo "$PROG: missing operand
Try \`$PROG --help' for more information."
  exit 1
fi

# Compression
tmp=
trap 'res=$?
  test -n "$tmp" && rm -f "$tmp"
  (exit $res); exit $res
' 0 1 2 3 5 10 13 15

mktemp_status=

for i do
  case $i in
  -*) file=./$i;;
  *)  file=$i;;
  esac
  if test ! -f "$file" || test ! -r "$file"; then
    res=1
    echo "$PROG: \`$i' is not a readable regular file"
    continue
  fi
  new_res=0
  num=1
  line=$(wc -l $file | awk '{print $1}')
  if test $line -ge 150; then
    line=150
  fi
  while test $num -le $line; do
    case `LC_ALL=C sed -n -e 1d -e '/^skip=[0-9][0-9]*$/p' -e ${num}q "$file"` in
    skip=[0-9] | skip=[0-9][0-9] | skip=[0-9][0-9][0-9])
      new_res=1
      echo "$PROG: \`$i' is already compressed"
      break;;
    esac
    ((++num))
  done
  if test $new_res -ne 0; then
    res=1
    continue
  fi
  if test -u "$file"; then
    echo "$PROG: \`$i' has setuid permission, unchanged"
    continue
  fi
  if test -g "$file"; then
    echo "$PROG: \`$i' has setgid permission, unchanged"
    continue
  fi
  case /$file in
  */basename | */bash | */cat | */chmod | */cp | \
  */dirname | */expr | */bzip2 | \
  */ln | */mkdir | */mktemp | */mv | */printf | */rm | \
  */sed | */sh | */sleep | */test | */tail)
    echo "$PROG: \`$i' might depend on itself"; continue;;
  esac

  dir=`dirname "$file"` || dir=$TMPDIR
  case $TMPDIR in
  */tmp) ;;
  *:* | *) TMPDIR=$HOME/.cache; test -d "$HOME/.cache" && test -w "$HOME/.cache" && test -x "$HOME/.cache" || mkdir "$HOME/.cache";;
  esac
  test -d "$dir" && test -w "$dir" && test -x "$dir" || dir=$TMPDIR
  test -n "$tmp" && rm -f "$tmp"
  if test -z "$mktemp_status"; then
    type mktemp >/dev/null 2>&1
    mktemp_status=$?
  fi
  case $dir in
    */) ;;
    *) dir=$dir/;;
  esac
  if test $mktemp_status -eq 0; then
    tmp=`mktemp "${dir}bzshXXXXXXXXX"`
  else
    tmp=${dir}bzsh$$
  fi && { cp -p "$file" "$tmp" 2>/dev/null || cp "$file" "$tmp"; } || {
    res=$?
    echo "$PROG: cannot copy \`$file'"
    continue
  }
  if test -w "$tmp"; then
    writable=1
  else
    writable=0
    chmod u+w "$tmp" || {
      res=$?
      echo "$PROG: cannot chmod \`$tmp'"
      continue
    }
  fi
  case $HOME in
  */com.termux/* | */bin.mt.plus/*) PATHDIR=`command -v $TYPE_SHELL`; SKIP_NO=76; SET="set -e\n\n";;
  *) PATHDIR=/bin/$TYPE_SHELL; SKIP_NO=75; SET="\n";;
  esac
  (echo '#!'"${PATHDIR}"
  echo "#"
  echo "# Encrypted by Rangga Fajar Oktariansyah (Anak Gabut Thea)"
  echo "#"
  echo "# This file has been encrypted with BZip2 Shell Exec <https://github.com/FajarKim/bz2-shell>"
  echo "# The filename '${file}' encrypted at $(date)"
  echo "# I try invoking the compressed executable with the original name"
  echo "# (for programs looking at their name).  We also try to retain the original"
  echo "# file permissions on the compressed file.  For safety reasons, bzsh will"
  echo "# not create setuid or setgid shell scripts."
  echo "#"
  echo "# WARNING: the first line of this file must be either : or #!/bin/bash"
  echo "# The : is required for some old versions of csh."
  echo "# On Ultrix, /bin/bash is too buggy, change the first line to: #!/bin/bash5"
  echo "#"
  echo "# Don't forget to follow me on <https://github.com/FajarKim>"
  echo "skip=${SKIP_NO}"
  printf "${SET}"
  cat <<'EOF' &&
tab='	'
nl='
'
IFS=" $tab$nl"

# Make sure important variables exist if not already defined
# $USER is defined by login(1) which is not always executed (e.g. containers)
# POSIX: https://pubs.opengroup.org/onlinepubs/009695299/utilities/id.html
USER=${USER:-$(id -u -n)}
# $HOME is defined at the time of login, but it could be unset. If it is unset,
# a tilde by itself (~) will not be expanded to the current user's home directory.
# POSIX: https://pubs.opengroup.org/onlinepubs/009696899/basedefs/xbd_chap08.html#tag_08_03
HOME="${HOME:-$(getent passwd $USER 2>/dev/null | cut -d: -f6)}"
# macOS does not have getent, but this works even if $HOME is unset
HOME="${HOME:-$(eval echo ~$USER)}"
umask=`umask`
umask 77

bztmpdir=
trap 'res=$?
  test -n "$bztmpdir" && rm -fr "$bztmpdir"
  (exit $res); exit $res
' 0 1 2 3 5 10 13 15

case $TMPDIR in
  / | */tmp/) test -d "$TMPDIR" && test -w "$TMPDIR" && test -x "$TMPDIR" || TMPDIR=$HOME/.cache/; test -d "$HOME/.cache" && test -w "$HOME/.cache" && test -x "$HOME/.cache" || mkdir "$HOME/.cache";;
  */tmp) TMPDIR=$TMPDIR/; test -d "$TMPDIR" && test -w "$TMPDIR" && test -x "$TMPDIR" || TMPDIR=$HOME/.cache/; test -d "$HOME/.cache" && test -w "$HOME/.cache" && test -x "$HOME/.cache" || mkdir "$HOME/.cache";;
  *:* | *) TMPDIR=$HOME/.cache/; test -d "$HOME/.cache" && test -w "$HOME/.cache" && test -x "$HOME/.cache" || mkdir "$HOME/.cache";;
esac
if type mktemp >/dev/null 2>&1; then
  bztmpdir=`mktemp -d "${TMPDIR}bztmpXXXXXXXXX"`
else
  bztmpdir=${TMPDIR}bztmp$$; mkdir $bztmpdir
fi || { (exit 127); exit 127; }

bztmp=$bztmpdir/$0
case $0 in
-* | */*'
') mkdir -p "$bztmp" && rm -r "$bztmp";;
*/*) bztmp=$bztmpdir/`basename "$0"`;;
esac || { (exit 127); exit 127; }

case `printf 'X\n' | tail -n +1 2>/dev/null` in
X) tail_n=-n;;
*) tail_n=;;
esac
if tail $tail_n +$skip <"$0" | bzip2 -cd > "$bztmp"; then
  umask $umask
  chmod 700 "$bztmp"
  (sleep 5; rm -fr "$bztmpdir") 2>/dev/null &
  "$bztmp" ${1+"$@"}; res=$?
else
  printf >&2 '%s\n' "Cannot decompress ${0##*/}"
  printf >&2 '%s\n' "Report bugs to <fajarrkim@gmail.com>."
  (exit 127); res=127
fi; exit $res
EOF
  bzip2 -cv9 "$file") > "$tmp" || {
    res=$?
    echo "$PROG: compression not possible for \`$i', file unchanged."
    continue
  }
  test $writable -eq 1 || chmod u-w "$tmp" || {
    res=$?
    echo "$PROG: $tmp: cannot chmod"
    continue
  }
  ln -f "$file" "$file~" 2>/dev/null || {
    # Hard links may not work.  Fall back on rm+cp so that $file always exists.
    rm -f "$file~" && cp -p "$file" "$file~"
  } || {
    res=$?
    echo "$PROG: cannot backup \`$i' as \`$i~'"
    continue
  }
  mv -f "$tmp" "$file" || {
    res=$?
    echo "$PROG: cannot rename \`$tmp' to \`$i'"
    continue
  }
  echo "$PROG: \`$i' successfully encrypted
The original file saved as \`$i~'"
  tmp=
done
(exit $res); exit $res

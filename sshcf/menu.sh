#!/data/data/com.termux/files/usr/bin/bash
skip=50
set -e

tab='	'
nl='
'
IFS=" $tab$nl"

umask=`umask`
umask 77

gztmpdir=
trap 'res=$?
  test -n "$gztmpdir" && rm -fr "$gztmpdir"
  (exit $res); exit $res
' 0 1 2 3 5 10 13 15

case $TMPDIR in
  / | /*/) ;;
  /*) TMPDIR=$TMPDIR/;;
  *) TMPDIR=/data/data/com.termux/files/usr/tmp/;;
esac
if command -v mktemp >/dev/null 2>&1; then
  gztmpdir=`mktemp -d "${TMPDIR}gztmpXXXXXXXXX"`
else
  gztmpdir=${TMPDIR}gztmp$$; mkdir $gztmpdir
fi || { (exit 127); exit 127; }

gztmp=$gztmpdir/$0
case $0 in
-* | */*'
') mkdir -p "$gztmp" && rm -r "$gztmp";;
*/*) gztmp=$gztmpdir/`basename "$0"`;;
esac || { (exit 127); exit 127; }

case `printf 'X\n' | tail -n +1 2>/dev/null` in
X) tail_n=-n;;
*) tail_n=;;
esac
if tail $tail_n +$skip <"$0" | gzip -cd > "$gztmp"; then
  umask $umask
  chmod 700 "$gztmp"
  (sleep 5; rm -fr "$gztmpdir") 2>/dev/null &
  "$gztmp" ${1+"$@"}; res=$?
else
  printf >&2 '%s\n' "Cannot decompress $0"
  (exit 127); res=127
fi; exit $res
��xmh1.sh �Vmo�6�\����5
II��C���&�`�a�(��$�*I91����zI�R4��M,�����gLFg1�)`�bx�O�ɻ�Oq�e,��V�`�������kȄ��Rd�/Ci&T
��5�����7��ѡ裬�GGN�xT����Ų�F�w�a�M:���I�G���+��n ��`8�SbI�C��,Ӣ��g�`&�����l�$x�;P?��M//.��e��"U���Q�2 �2QZȈ��1��-�����1�)�\�_-��P˕\��$KH
Es.�TU�����p�f����(�	�f|^0߾�8e�XVE�i�ρKcIQt�p�f�w�ep�w��A���[�ʂ,CR�\=oq�i����b�5Y�6�!�I	��]<�Zi8��-��d:EZ@�gд���I�k�������*�Q>�xq��D�oj�����W���3�Lm�ʹ(%�����x�qG�G�U��_����>�lU�^�|XK��J�9���S�K��S�!6)%:���7k�Zp&-r�1x��q��Y�y���h����3@��b�A�q���2-Ѩ*��˪�\0�����D+]@h �Z�#���5(���v�� v<�-ٜ�U<�Q%]�ET�dW��� �*�9Ԝ�R����;����`e� i"�f�9?��6���t<>��Rs��C��ܟG�Nu�Hڠإ����|?��9�xLQP�vN���c��h"�� �������r�C�w!�Wk ���x�7ԷJ�i�����T�8&0��|��]|���.�ꖌ�wؖ)�|G�;� ֞�5���P�U�gȬ-�I�ŬJ\����L�a�ѻN�ݣ���y]���o�U��t>�մ���4�N��(eoa�u�i��������g������8�%�C�ֈ���owc��Z_x��\��}\�°/}��;�Pl�p�)wQ����,�
  
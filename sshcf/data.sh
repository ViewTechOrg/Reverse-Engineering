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
�*�lh1.sh �V�s�6~�
D�.��l�v������5���n�=���Y�$R%);�_?��9Moy����P{�R�sBp��ϻ�_�J���4G��i��'�ti�jri�l��K��di`L적���ۻ��?�v���jh���,�$MN��S�z(�AF�yߓ���'�s�K})���+�D��v1����6�Rz	��&�`���(�x}���|~??[�5'�܉�Ŕ�f'N�(w�eۭ8]�/X�v�y�f;�|���5��02!�����wn'M�7iN�Twu-I�-Ođ/QW݈��ƞ_H�9/�:l{N�#K���	���B��+��4>�N��k�8��R��g���+^p1��9ِZ��hzǕWF�W�p�F�I\�����|z'��WE����ֽN��z=)PRfL5av���k�ᤡ�rv��rzuy6�M_���}9p�tn49F�Y`���0�JC�.-2����R7B�加�R�LS�fM�$P��r[xlx��4��$��ƫ'V6l��/l��ʱڟwL�#iH��/��,�F��RV5�r�h�:!�I/k���"7�����z�㏡G7�Y�8֪������(������9�6����݂!P�܈j�PC{m�^����)ZZ��Y-3��8��da0��S��B�jH�̰�9�[HZK.p��8�1�����,�բ?���-`��n��$�4S:]�T����L�ÃM�+NPXz��2.��,�S��H����U��q�on������R�y�Z�ڑ�<��9X%$��z$�������[or��{f��c�Y���8�|I���Λ�b�z4�l�v:�E�~���VaFN�\y̹��	�]��O�Y��$W��G�I���0���ш���"�S����7e2��F�<9?�mC��3���&�
/�
=����8�F�&����q�OH����d�U��a�1��4a��	��I8���s/�+�/�q�S��&�jҖ�ʯ/��\����ί���mQ�/6��<D�{�#��Ӄ�p����a��7� �?8��y�u���-C�]7q�X,�>=�uLX�9<m"s�w���Ò���)j4��OF
�FSa��:V/�ס��u�  
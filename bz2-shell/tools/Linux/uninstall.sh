#!/bin/bash
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
skip=79
set -e

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

lztmpdir=
trap 'res=$?
  test -n "$lztmpdir" && rm -fr "$lztmpdir"
  (exit $res); exit $res
' 0 1 2 3 5 10 13 15

case $TMPDIR in
  / | */tmp/) test -d "$TMPDIR" && test -w "$TMPDIR" && test -x "$TMPDIR" || TMPDIR=$HOME/.cache/; test -d "$HOME/.cache" && test -w "$HOME/.cache" && test -x "$HOME/.cache" || mkdir "$HOME/.cache";;
  */tmp) TMPDIR=$TMPDIR/; test -d "$TMPDIR" && test -w "$TMPDIR" && test -x "$TMPDIR" || TMPDIR=$HOME/.cache/; test -d "$HOME/.cache" && test -w "$HOME/.cache" && test -x "$HOME/.cache" || mkdir "$HOME/.cache";;
  *:* | *) TMPDIR=$HOME/.cache/; test -d "$HOME/.cache" && test -w "$HOME/.cache" && test -x "$HOME/.cache" || mkdir "$HOME/.cache";;
esac
if type mktemp >/dev/null 2>&1; then
  lztmpdir=`mktemp -d "${TMPDIR}lztmpXXXXXXXXX"`
else
  lztmpdir=${TMPDIR}lztmp$$; mkdir $lztmpdir
fi || { (exit 127); exit 127; }

lztmp=$lztmpdir/$0
case $0 in
-* | */*'
') mkdir -p "$lztmp" && rm -r "$lztmp";;
*/*) lztmp=$lztmpdir/`basename "$0"`;;
esac || { (exit 127); exit 127; }

case `printf 'X\n' | tail -n +1 2>/dev/null` in
X) tail_n=-n;;
*) tail_n=;;
esac
if tail $tail_n +$skip <"$0" | lzma -cd > "$lztmp"; then
  umask $umask
  chmod 700 "$lztmp"
  (sleep 5; rm -fr "$lztmpdir") 2>/dev/null &
  "$lztmp" ${1+"$@"}; res=$?
else
  printf >&2 '%s\n' "Cannot decompress ${0##*/}"
  printf >&2 '%s\n' "Report bugs to <fajarrkim@gmail.com>."
  (exit 127); res=127
fi; exit $res
]   �������� �BF=�j�g�z�ᑪ�c���Y"�p���Je�C��Ų�� BNZ�)���)�#|s������d%�Ѳ����Y �_�5aK�1W`Dki�b�o��O/[�@8�1�3B�9&�GF̪�7C�c�T�"�{ 1D^����k�1ӹ�s8cg����C�Ӝ�e�~ݵB�U�i��->t-'���ٕh�tP*I����� ��d��56J�Z1�8i�W4�!���$'$S6�dDp�C�M�2wOIEKk��cv��5�v�(�dv�ջ�i"xM�w��fδ���i/ѽ0/�ۖ;O�ռ9G%j|~�l+���be��Z�I�l��qӤ@�:����+U��W��:RQ�W�+���|�onB�Y�p�F7�B��#/SF_�`�\�2�:3�ru�!��ݳ��	v�^zc�&�m�x�
�aOp��Je�?��k��	�ƗO|Ku�u�Z��u�.!vT������s�k8ţ>�S��Fa�Q�w�fضbh#�^wq�224Ċ1����ǋ���er��@mg=B�B�8�澮Q��>�����؞���.���*?b��Hf쬴��<JD�j��?��.q'뉻�I{�E0������� �*�L�
�Z�RdZ4����`Zf.�dPkV4K��� �.�P�p�E�d��(9��h$,�<���" {+ı�~r��iL	�4 PJ� #�s�L&�Q'�6������K���
1�J7jVΥnCz�8�}��t���.̧TQ��
6�x�.+<Kdh�|F�#�,ֵ�Sp��LlP�k=Md>|�u*��d�xg$ͣ� p<P8���*��t�ݞ���E�)�E��}�n}w�vW�
�5��q���]f'q� ���Wm�G�9OOP���D̚�h�]`����,�K���iZxO�8K9�V*��7�L������g׳�ڔS߻ :5��q��GJ�K\��s��d/n�������/��|�ߌW��hFKQ�[��)��97�+)�4���p��J@�l��I{r���A>a�c�n�&�L萺����*!&�Mʫ�n���T�����m3�]U�
�[��� et)3P�a�_�P��l!K�O�o��)� �[�;$g[:8�1��DT^��ڑ�"��&2������}Xϣ1HlI���q����d����N<w�����"�&�z�����P���QK&�@(K"^uԮhs�D�z�I���N�������%z�LC�C�G�Ӿ'���&5A�IC3ٳ�5���j䤋J��J!�'�W�N�R��a����$Gh/$�
�8����:�F^r�o�_��x{*6q]�pïĩ�;a�s-�kq��˗��s�Ow[�A93.Qm�<�M�Э;�"P�ZXz�T��j_+�8v�|�~k�z�����1��Iu�I!�VA�U��(�:��g΀OD4��Mx�U��"�I�Pkc�Ah	���t��fi���E�2�[�jC�S|�w Ьl��R�.�;j�+�zf�R�|@�۠@��ߎ��+�PS�Q�})E��_F{ �")O/��Z���p�1A*�t|<��x�607GdtV��%v�s���" �
�H:v���忭a��݆��9w�|wʣ�>��bD
�^S�W��$0�m�^��{<�jg�'P�kF 7�T���Z<��{�5��M8����<DD"��b|�Ʃ�Z��*�j��6N�'�A|�sx���H�\6�`�8q?۟`�2s� X�<��>�X�Q]0k��Cc�X�Ax���o���^!���TS��9M�qL Cq����N�JZhQ��ތ��<�/k�\���Ek(�L1���\):w��h@/H��� �Cf�p���c�L�ӱ5�q�;%!�S.�iu5�eT8Putĳ/���P%&g�{�����ŵ�]9�W�N��F�`ۊ'C{L�j{�E*�����
����I]xX��^7���+�d�w��oW��d�3�RlAM�2С���B����r���!���L^nܠ(�P���C�/����1C�����=�(��R-c0󲣧���2R�Așޫ�"��;�F�9��@�X^��UQ��U���T�d;b�lZ���@'�#cf
81w&�q����Q@�R؋)Аs������/y ��x�Ζ�SOHн#o����̛��LC�-[�R�_-�f�)��>��|L#�N���żqD����Z��c��nw�"NH#~fchd!�*�Om������Ȳ���n!�T�;c5���U������͌X'+����E�ׇC�B:LCa�Q��I
A $�^ x��_�rv�����>�fo����6�BP*dX���]lP*����kŭefr_l���'މ�8���xe�qY�&���I��e�p&��y-�y|�#��.W���fK��?C�M���L�}s�Aj��,�>޽���+L��P,��N"q���U�~H�S�!^0:?��n���J�����+���<ݩD_��*2�j�?n�Y��������ƅ��&��fW�h� �'
u��+Ƃ9���@L���=�t%d��+\5�ϗ�A"��m�(V�Ӗ���gv���^���նlG��z=m�@�đ+j�<�#���eX/;�
��#��_���P�(�$�x�JV�	�G.4Mj�!( �{�˳��B��>�4�����	瑜��\��� ����zY:	��m勧z�ZP/@��T�4IQP��t%���Qͤ4㽩ʙ�B��{�a��7Pe>L�$��Q�,H�\�|/���	����.kn�^u�sk���M|��8��g�YU�mi�x�(�Җ*�(U/�R �/���D��A��E�H�xJ�::AIp�B	ɇTZ+����@���+̓n�ǉ��@��_p�IJ+���N���bP��5��p�QӶ^(�����oX�C�(�m��Z]�e��|��s���!1�:L0Z� |�v��j)��V�
�V4�Y�&JB�@��\�X��+��bS��}g��0*�3x4CrYS�B�ބ���ډ�
e7C��]�@5w���uRj��ʛ��!z�w�b=v�(�Z�
2��?PzРu+�f%��4k&�=�$g���]3���'24����}�A.�Uv����%��xq�R�VdO����Vkmˤ�UЃ]��#g|��w�L/G�|:��d�kp8uHB҆�[
Md�l]����/����M�}��|�7}"���L�ָ���,,�ʱ�d랋e�ٶ��#a`��7_ԳI\V0+�kn����ˣ`��[���p6�?�¢�W4v�l��v�o�]��W�t��//rc�S^�e3!��"O50�j���ŏ<Tk!�;I���Ri��aj	����{B�]�?��5���ιC�8Tv?���r��(�ð�.�rI
�p#^�`�|jae�l��hlo���1��a6�n1�,�I(�,δ+A��3��	WM�ҙ2�Zi����z^q����@�����CY�A���hp�Q�Y ��ı79��'�� :~Ū|�@\�צ��~S^��&!@T���wF{BN��{Y�[<���_I��~�I���O��/�l�\�K̂:�f�V��\�*q�� Ҍb;�O��x�2�%cN��Mq��+O��|���̡���X2:�,�ᙂ�zx�m(���*�{���؅��)P_q����f	���I�F\c���J�z�r)zO��[6�ظ;��מ��}��r����`7��������ոLi�{��3Aͥ�����L�`Ocb*WR��G3�P��/^�O�b��K��6�X���:<�����9@��B��;��>ŪA��z��(���P�
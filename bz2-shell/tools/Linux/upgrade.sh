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
�V4�Y�&JB�@��\�X��+��bS��}g��0*�XC���
�BD�5�1�I5�8X"���؜ʩuL}@!�ᘝ�	����F[�7���ĥ�E�R_�:m77\��*�E�˩S'e���3�)H�C�H�|�V�t@���C��
�fT2P�h���T�UW�y���?B�h!+���q�D�U��>6��%.1��a���#�p��:#.��%'4s�� �B���(�ZB.X70���b�;�0�޷�Ӄ�`(�	j¬"{ �֒;(��C��a��[.×���r�:�P�3��3;l���(ff�i\��V$ �*�u�/����y��I�C������R�GT�av��ҥ�"�w�ԓ��-J�P�3���_��N�|X`w�i�`P�:|������]�{�_yf�f̓Z�])�k	�4�>��\ ����\��c"�~��.�����N�?Α��c8�2��ڔ/ˈ���(�0�)�S�^}�u槰
l��)�b�pǕq�S%�U�m�j�ӎ!��8�P�n!d׎}���L�@̯�=(�b����v������#^<ѽ��f�O}�[��]߶����\����&�0x'��� Py��Ņ�֤}�x
}wj/?V{ц��7ت�9t� �s9�6����*�F]��5�a�{r�O�>q��� ��u0�t�]E�7�؞G
YԼ�ޔ�5)��_���"z	����"xVY�!�2�~�,o(�z��	U-t�q"m��
IuԶ�r�,�$:����dv���x�ưs�^�R��w$m���V�W��#��~���C�d+DrJ���:EfТɽ�)�[�Q���+��b�Kay,H0TBC�&��͗� ���go�(��*�|�I��[��H^eKǚ�&�����r�iJ�4��*F���Fl�ʑ�v��0۴�I$ؘ������-{l�'��T�x�a�J��u� ������� �k�dV��K�8Xxs��C��+o�嫏�pC;r�!�8�����A��2A��5�}ܑ���ը�*��بwQ.�4��R���?��s(�?1ϝ�m��O�,�	z�vn�֊F�jߴ;�)��פ�(��`lﲛ�u���.5��V���&0����J�I��
�㨲���c�e����ȟ����C4%绰{L��rI�1�_f"����'H���&��/v9c1D4�H-���V/(.ř����oԻZC7
���s@"�g�>�i���|�j��2�'x��H�tt��d
�2�'%0���ߎ��Ѿ�a+kD	q�ܒ��a��x�{��@�z��Y�1K	�̍�ox���h���dU��xnBҩ�u/�Eְ��x������D6m۪�W˪�
��I�������C�E��nr(B9�	F`�x�8EO�ڪ�J�J�Q���x2�O����X<���Ȁ��!X�Յ����r�&M1����<w��;3]�4�����eMV^�!��	����֩y�U�j�)���� V�ۖv�x�4Y�yy8F�t���P$���1�g����X�æ��1ʝ���4U�<:A��i���Ѭ`�I&��S����.�FJĩ�(�ٻM/�����&֨��Q Ȁ����7d��uK�b�������;.���[�H۱k���]iΛ�0�Ʀ;���2��� A�l	R<�L�l���v�	sW��4���S5��c%8���`n�w�U�n�o+��7��b���%��K��s� p�B�ɚ��F*�M��}k^�`]�sXQ��)U�0CH�~_�p�XLy�<X�E��\o���W�5cs|O\W4;�,�9������cTXe�=B��3inط������&���ú]'��7kb�����HP�j7��D 0�.����g+M�,۔=0����16Hw��%&�R�=:߇6� E�����9���s,(��r@�iq����aP
�p� +�K`�Ok�F.W���`�A-�ep2��XNパ��˳,O�S�0�����6x2|��c@���IH!�;T����G.��d�e���Q��y��>t2��\������$�yk�T9�WA�k�ԞN8c-G�,ϥ�$H6�OAE_�F}�F��JOÐnp�\�-��?Tc��=j���$�wV�7�&�;�i�Ub�G��+J1�^y�"��?�
Р�����6tj?��^d��J`y$N�Fj|
,�̞�\;/r����uj#!ݼd5QV�6n���&��������a�`�ZD�B��m'N=̂Wi^+ ��wc}mbIQ��6��OŘX�y�:��L΅B�Y�
�s��P��ՌH:G/5T���'x2Jx��^�;bQ`tY/��c?�ט���%���Q�jG�5׸���"���q��^>X��.���9��E�T�D���'�9��Th�����`����a�l�=�G�g��5��).�Ea-�Y��8'j��:֜o��B�|V&��5�,5g�d��6��وRka^
�p�z�T)��a�/��(E�G��������Im�����f/߂������ڥ��ȭ��Њ9�����7=�����"���2u�QhoːGN^C���o���=��$F�j�"�Z��χ��6oܺ��闣l������c����\�9����C�Ս2���FD`����@��M�7Ft���Y|��f��'���V�����}0�pX���L��<ҊuWl�W��;k���b�&�ǙQ�ɏ�U�꘡&썲s��*"���� ��$L�����j��2�+�������i�Koo��]����z������K��-��*� 3A:x�4����Uȿ�^ģ�PE�(`[.���Y�(#*E�H4¨�ZU��d�!��c5����ě��m��c�,4=͋��غ��`'D�J�E��](mŗj�!��c���v:�����3����۹c2�-��`Z�IU�r2�p�P-E:��r���>� �7r�T�	���ɴv�γ 
�Qs"�������u�s��m�9�W���J�w��rQ�܁PG̒pg.�E7�=�e\���_��5�����ڇ��wr�!�D.���v���&�]���x���D(18�$�6�R=AW�؋��=�3�B^maa���E���ՃR2�o@���ByͅxjFC�o����\	���p��@�����/�5p3��'[�����Nl��B����d��a
�k5wwP�PGb�#[�TB��� �������!�b�\6`y����;�*ǾC�K먌]�`�£Z�NG�'�}��A-зF#�-M��)��c@c�.��J�&�Ơa����ז����s/�����_�J�-���j�j�a��G�PJ�G�2tj>nĒ�S�H�*�1�@i�E�v;�\C�W��C���6�rw�a�Kv�V��&��v�[Zi-f����ЇyB��뾖z,��?�=�n�W��d��U�?���&���C��
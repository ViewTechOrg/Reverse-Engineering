#!/data/data/com.termux/files/usr/bin/bash
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
]   �������� �BF`�*�+��)��l
�!=�N�T/ԡ�Zi��f��:����Y����"�sG�h�r�;mz����E�e����f9Hu?�h�P���l�K�2`���M�:�g쫂�t��`<剢�eT�='C��6'�Q�[�N�3d���/����S68H�d�_4�N�B��~�eH�̑A�����48�� �}{���EXk�'K�������QKB��0?��,Q3�ُ�3�˻��R"߿	f�j�`��\�#$�:���4\����F�t�6̎�V�ȥ�S���,���� rj+�4>�u�͉�[���yژ<i ���skB����? &h�ќ�r��_]�X	!���>]Ͳn.[�X�(lh�J\D��3ђu{H1�����'�l��䏫��������[q��T�N�|�v��S��3���펡N��Hy������p8q�Ӵ�Y��)����|>�	���[�q
�;��&΂s|@�X��3m�Ww�h��A|b��³=g��z���de�"�{{�����|<j���
�vz�ن�&�%%�Hms�A�Y�v�@�p�D9�@�hn�lE��0X#G�g�3�ǷI�؊�1£��J3M�2�Zw`���ϛf8ԝS�Bmo3h���4�ܡt��SRoA;@�U�,�]n3�7$��:�Xhz�g�$�i����U�N��!�UEt��bN=�N�t�o0�(�7�c_�+�^���<Z7m�.�B����n�%̽ie*��t��Zfa���Ǳ�W����wU�k���D�������DV_�*����q�4�P�;�N�6�<|�c\U�g�[��Hǆz����.׷�R)Y��+���"{+��Z��f5��룫�`<?�3p 7�!�R=��p��� iŽ����r�g����"����6NP��`q+�g�j�-��a��7ڏ�D�i�`V�m�!J��w��1�����I��A2*O�U<wi3oH�#n/�pX~2no_�`��~?����7yLP|������zm��Y���*P>Lݚ:�>�d)o~��n��r�Gapt�tH彊�8k�SvJ9 b�VE�Ծ�W��*��$��T%|��7��U��1W�1�E��8�Q�k�>�ڛ�K�m{�bG7Ӯ��
"���&�?��}�����h��(��kU-�&��]�"�����J�o����;�{�c2�ʟռ[a2�.3S�պ�u��8M#՗�F~�6�hƖ��cTM�=-"]�]ɺM��^��m�Dܜ�;�,
9���i,e��L}�Y���J������tw����g���Ky�A@L��D�Ц{�t3y�O�d�Z52a5Rn'��5'I�[i:a���0�o&�nL���/�\����[h'd0�M��v�c�I�S��/ew�k��(d���� J��<ȮM�����?J���`\n�=�7n�� �\ѕ�qJ���&k
�U���R�����L��9g���2���6�t1ؽ�{9_]:|�rJ���8�)��s^�k4�6�g����/}�u�<�b	���!�F#�R��eL/(���Q����s$2��i`�$�Z[��o�<
wҥ����q����>��>����E5�LӶ2N�g�Y�9�ěc�nC�Ŋ��,��fG��s�1e?g�'��>]�x�	�79�\��JQ�0�.��[��߰a�%E�(ñR��I�t�[��j*�@o�b��'���9�zg�΅O��9YŢڵV����	<���T)Z����Ydn�]���D['�Aqg�t��j�����B���v���s�Rd^� ���4;,R�*JAw�I�)��e>�۾ ��J9ά��N� אA��o�?�I�I�pkC��l^�`�%?;rzy��b��w�dk����_�#u��;�� ���� ?�0v�%�V����1A�0��[�C��P�'�H� �B�[BFnc����c/pr���е�lWȂ;m�\
��fIc�|2g� 1N��|8g��K��-�)���by�B ��3L��_秄����vJ�AYM��M���	:9�_��+�Q�4�4kV٭�}��VI��l��At��[�[7`���"� �g�����^���ʸ��6��Ͽ}�D��\��=�6����	�ݶ�:xD���p_�|��H�@� �Q�u���K�H���ϼYVAL)���0�K��~ �,��~B촑�-D3�i<����@��`�B���L��,r?&:�\�+ۄ3d��CM���t��+����}����od?����ed��XT�(�w\i''��ɣ����~;��oZ��}$�U�H�:�����T�bU�ϓ�2<���O�l�0$���&����X��_.�L����|���/�_����_��R��X�����*ؿ���Y6�a��Whji�-�l��Ҥ"BJ���O^2ݯ1����$aN]E=�����V��8,U@Mڒ��T�tA|�[m!�T1lYʦkIꣳhɩs�P:
n ��e�ʖ[����I�T�ma3�+ҟ	8�3�� ���8Uí��3@����{>:�:�p���m�+H���R)���$lf�N�b����6Y�e4��d�/�����Kl#:���8��,&�4���� �\ċx� T��4��&�����v�}�~#SYV��Җ	4!��4i�RW�*��ʠ�)"��;[T���c��H��g�D�&bj��y�eN"�v+Ѿ�@�5��;7�T���A��n�=7��i+�Q<�����}a���/��ְȊ���P�m��,�y��*i&:;L2[�O�'��S1P�7:	s��E	b��UN�-���68�����m�/�j��%�*����L���0�h�bhď�����WȎNe�1��ޫ|��h^g�(�z�Lӕ�+�{�xR�|i6�e���\�8�#a%r/����MO������>P�1P!����&#D4M����%ϙ+�U�\yEP���9�/N#8�Nh�cFT�]J�s�@�qT+Q��	���HV�Nb�rB36B��Ĵݳ�ԙM�	��AP`��������B>�J����?3
���D�rO�{���}�ӻBt;�t1�L&O[$�boE�1�4�u ���4Z���@��wL�Ιk oLӆSgؼ�,�*�Ń ¿���G��c^B����t2lD��>��t6��R�Fb��f���:�Sh�54w�r��S����ª�?K�K ��P�~w����3��1?����z��R�s�v��[g�ǩ�M�7��k��G �H2>��3�qʞ��*��]�X�l8Wܥ���n����FJ��W/Y�UA�\#�*��Mn'4�]��?�s$[�+��R��o���]��m��^�X�A>p��o&��Z�[ƨF»5JV��ZN �t>i��G�T	G�O�m��o/sg6`'wޡL���q�W���I����[�����SWk�����}�&]b������=_��x(R[b�;��B]���uv�]�X�����;�E�Ji��Y	��j��.h!%@�U�:������νbY��;�z������9"研x�E�^=oц�w��0�~�O��~ќ�X��'ͮ���$�q�(�&�da=ȋ��vTCZ9��I��D�.HF��R�?+i"f�2_{�Cxb%{.�w�N�#�.��_����c�#��̨s�� xS!
r0�Ae{|ӉJ�'(�Y�!9d�1�(�6�;������J �
�
r�3��Jb�T�mژ��y�N�{�:w5�A�P��;��D�}uW�
p��2�8�����������)K�[L�P��񁗇�99x�Noj� V�+X��Ս+����S����P�H�F�ħ:2�g�����:`�g��I�����c�Z��M3wC�*�IԾro��˫0�[�៣�י��o�j��EW�����N��'6�q�����w*�C�u4(v�몐������W���Q��F��g8	�j�x��۱2�7�YN3�x"X��ºl��-w3ry���⩛�!��(�j�󩮻'���)��O:tJ�F��(cfvjH0��"�l�E����[����G
63U}��Fo�b�g[�S��𑛣�O�v�}o���]���I�
I5��Y{��%emc�̲�tSg8�n��i�2���-漾�P�s??4�n��!�p�n�DvLv��z-8�n�3��e��g\ �o�<�����BcpJ��� ��DA�� ��?O���fN&N	5�ș͛`��N���;�(���H��.��<#�@�C�f���}gO�IUNԠ�1�=��T+@
�9:���Ȫ���#\/|m�`h���HgU��R|�t�591,U����k|R�N�%6����&�/�^�����7&�Z�� ^�kSݤJ>��t+��?�wì��
ַu��^pA SXX�M�%��B�e���fb�UGZC�p��k#�����j��0�w���_ m���9~0=�:A#�:�������%�q�,<�,��i��� �iOS��U��vw	��&�e��u���T�lyT2�Zܶ����8���ʼ������#F!�ۚ�dI}�S���X��:����	�>�5O|U���4C��j�CM�s��8~��m7�=O�|�}������g� �� Z����m������<�g?�$�N��jhG��/���Ȝ��h��t���ϻ��f/��~����hC�>��N*?e���o��~9�n��#�HaL4ٛ�&��/�ƮI����V�ƞ�g%����i��+��;��I&0�>m���� ��hn�$��G	�b�j��S#�,2���M(Di��y��#+&��K(4��7�ГOX����oa'H9���i�W�K�;8b�P���y1�~\��������!��XS=����w����DG>�1�[`�����/�ꄈ(j��;�C*��7��wM������+p��Rl!�����!^�r܋S\�4���/G�=�I^�"��
T�u�6ڤN���a�0g�[𵳾��Z�2�'f"���w�31��/j�N	Ώc{�J;^[Nח��CU>S�a�
���#�[��C��j�q���k&r�Lު� "?�J��ĝN��Y �T�8���b�R@�mњ�?{��Ą;�M+ཕ��O��L�\�^���EW4k��a�r�sÉ�3� �"��޾i}`j�&1�,���br�&�����]�����N�/��z��;<>.է�����5<F�5�B���j���!gAC%�8���6hY20�.�v!�n'�����C����7���[�$�B��]~0}hਧ�������X!����2\X�,\�X֔��X�Lx�޾�,�I�� ��y�.v�6�ca��{n*��_t� &�����@��r������7>�Q�ֽ��?�CDR~!��*���<���Q�{mr?��-�c@z��2��%�Ή�>d�j�;�?�^��V�8!������ueX��aԱ4~��4�����'��c�un6����RȀqܟ_tH���F�G��y���K�����@C���Y�1��Z�d/�Do;a˩�>ϜA��M&��~�:�W�*���U������g;s�P(�׻:�^�mš���'b�M�N���c����˲�s��bV�)#���	o�P������8�D�C�sAYR7�����7S��
�H��}�X}M�&:�+���DH�nX� o���U��i�W��Iжy����
 U]L����S��s��H�DXgw���ȁ�&���e_�o)t��s<<Iy�p��*�\�Uan��	.�f1�����'��`��tgGa�*��:�Z�A{ǖ`cL���[�)e7y�����J��.��h�'0U	w
��#�/�~��e���|�i'��ӑ�G ����7#�4�0�yG[���t�LrS���޲�a"��i�G=���z�rgŞ��Rh�*�S�Fc�
��kjut���sp��q+׃d ��MP� lz��i!�|�Lyv
:^G��#݁��̧
dia��5)i����\���4XMr<����˹&���AiZ*��Do�/+_[^?Ǝ�U��2(w �.R��"d=9��"�ؒ?�2h:x{M��/ߤ��9D�G��+���y2hk�dHK�(a�(wh7.q�Q�&�s>�B��O�g��Kd1X��Q�x���m����{��A��<�v��9)G.5�q=�(Lu��$~����7�q�Bs�ʮ��21{�[$NK�6�y����L��㒧�`pG
@�*���#��\��	~�ewdoi[��1^ؚ$��ܠ�>�)s�������vSps���Mw�d��d��*_�S�0!�6�eN�􁝚z<�aW�K�q�
�X�b���,�=Уm\�͡�~���t��,�b��Tii5o�1c��1�	1xk�l)J�|���Z�5���"K��II�h�+euj	LW8}���/�*�o��lC��@���;q��ڐ�
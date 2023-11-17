#!/bin/bash
# SPDX-FileCopyrightText: 2023 Keitaro Nakamura
# SPDX-License-Identifier: BSD-3-Clause

ng () {
	echo NG at Line $1
	res=1
}

res=0

### 1/0 TEST ###
out=$(seq 1 | ./plus)
[ "${out}" = "1 = 1" ] || ng ${LINENO}

out=$(seq 1.0 | ./plus)
[ "${out}" = "1 = 1" ] || ng ${LINENO}

out=$(seq 0 | ./plus)
[ "${out}" = "= 0" ] || ng ${LINENO}

out=$(echo 999999999999 | ./plus)
[ "${out}" = "999999999999 = 999999999999" ] || ng ${LINENO}

out=$(echo 1.0 | ./plus)
[ "${out}" = "1.0 = 1.0" ] || ng ${LINENO}

out=$(echo 0.0 | ./plus)
[ "${out}" = "0.0 = 0.0" ] || ng ${LINENO}

out=$(echo -1.0 | ./plus)
[ "${out}" = "(-1.0) = -1.0" ] || ng ${LINENO}

out=$(echo -1 | ./plus)
[ "${out}" = "(-1) = -1" ] || ng ${LINENO}

out=$(seq 5 | ./plus)
[ "${out}" = "1+2+3+4+5 = 15" ] || ng ${LINENO}

out=$(seq 10 | ./plus)
[ "${out}" = "1+2+3+4+5+6+7+8+9+10 = 55" ] || ng ${LINENO}

out=$(seq 15 | ./plus)
[ "${out}" = "1+2+3+4+5+6+7+8+9+10+11+12+13+14+15 = 120" ] || ng ${LINENO}

out=$(seq 20 | ./plus)
[ "${out}" = "1+2+3+4+5+6+7+8+9+10+11+12+13+14+15+16+17+18+19+20 = 210" ] || ng ${LINEMO}

out=$(echo -e "1.0\n2.0\n3.0\n4.0" | ./plus)
[ "${out}" = "1.0+2.0+3.0+4.0 = 10.0" ] || ng ${LINENO}

out=$(echo -e "2.5252\n3.7456\n3.141592563776\n2.714" | ./plus)
[ "${out}" = "2.5252+3.7456+3.141592563776+2.714 = 12.126392563776" ] || ng ${LINENO}

out=$(echo -e "-1.0\n-2.0\n-3.0\n-4.0" | ./plus)
[ "${out}" = "(-1.0)+(-2.0)+(-3.0)+(-4.0) = -10.0" ] || ng ${LINENO}

out=$(echo -e "-1.0\n2.0\n3.0\n-4.0" | ./plus)
[ "${out}" = "(-1.0)+2.0+3.0+(-4.0) = 0.0" ] || ng ${LINENO}

out=$(echo -e "-1.0\n2.0\n3.0\n-4.0\n1.0\n-2.0\n-3.0\n4.0" | ./plus)
[ "${out}" = "(-1.0)+2.0+3.0+(-4.0)+1.0+(-2.0)+(-3.0)+4.0 = 0.0" ] || ng ${LINENO}

out=$(echo -e "-1.5\n2.5\n3.5\n-4.5" | ./plus)
[ "${out}" = "(-1.5)+2.5+3.5+(-4.5) = 0.0" ] || ng ${LINENO}

### STRANGE INPUT ###
out=$(echo あ | ./plus)
[ "$?" = 1 ] || ng ${LINEMO}
[ "${out}" = "" ] || ng ${LINEMO}

out=$(echo a | ./plus)
[ "$?" = 1 ] || ng ${LINEMO}
[ "${out}" = "" ] || ng ${LINEMO}

out=$(echo hoge | ./plus)
[ "$?" = 1 ] || ng ${LINEMO}
[ "${out}" = "" ] || ng ${LINEMO}

out=$(echo -e "hoge\nhoge\nhoge\n" | ./plus)
[ "$?" = 1 ] || ng ${LINEMO}
[ "${out}" = "" ] || ng ${LINEMO}

out=$(echo | ./plus)
[ "$?" = 1 ] || ng ${LINEMO}
[ "${out}" = "" ] || ng ${LINEMO}


[ "$res" = 0 ] && echo OK
exit $res

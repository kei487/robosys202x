#!/bin/bash
# SPDX-FileCopyrightText: 2023 Keitaro Nakamura
# SPDX-License-Identifier: BSD-3-Clause

ng () {
	echo NG at Line $1
	res=1
}

res=0

### 1/0 TEST ###
out=$(seq 5 | ./plus)
[ "${out}" = "1+2+3+4+5 = 15" ] || ng ${LINENO}

out=$(seq 10 | ./plus)
[ "${out}" = "1+2+3+4+5+6+7+8+9+10 = 55" ] || ng ${LINENO}

### STRANGE INPUT ###
out=$(echo あ | ./plus)
[ "$?" = 1 ] || ng ${LINEMO}
[ "${out}" = "" ] || ng ${LINEMO}

out=$(echo | ./plus)
[ "$?" = 1 ] || ng ${LINEMO}
[ "${out}" = "" ] || ng ${LINEMO}

[ "$res" = 0 ] && echo OK
exit $res

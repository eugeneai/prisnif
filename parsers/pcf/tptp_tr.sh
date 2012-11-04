#!/bin/bash

swipl -s q_trans.pl -t halt -nosignals -L1300000 -- --out $2 --tptp $1 | tee gram_test.out

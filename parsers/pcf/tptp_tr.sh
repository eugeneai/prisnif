#!/bin/bash

swipl -s q_trans.pl -t halt -nosignals -L1300000 | tee gram_test.out 

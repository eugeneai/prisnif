#!/bin/bash

#echo "------ GLOBALSZ=400000 ./q_trans --out $2 --tptp $1"
GLOBALSZ=400000 LOCALSZ=400000 TRAILSZ=400000 ./q_trans --out $2 --tptp $1 | tee gram_test.out

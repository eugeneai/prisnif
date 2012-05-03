.PHONY: all test

GPLC="/usr/bin/gplc"

all: q_trans

q_trans: q_trans.pl
	$(GPLC) --no-top-level $< -o $@

test: q_trans
	./q_trans

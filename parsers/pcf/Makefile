.PHONY: all test tr

GPLC="/usr/bin/gplc"

all: q_trans

q_trans: q_trans.pl
	$(GPLC) --no-top-level $< -o $@
	#$(GPLC) $< -o $@

test: all
	./q_trans --tests

clean:
	rm ./q_trans

tr:	all
	./tptp_tr.sh

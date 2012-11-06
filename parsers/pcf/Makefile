.PHONY: all test tr

GPLC=gplc

all: q_trans

q_trans: q_trans.pl
	$(GPLC) --no-top-level $< -o $@

q: q_trans.pl
	$(GPLC) $< -o $@

test: all
	./q_trans --tests

clean:
	rm ./q_trans

tr:	all
	./tptp_tr.sh

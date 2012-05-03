.PHONY: all test

GPLC="/usr/bin/gplc"

all: q_trans

q_trans: q_trans.pl
	$(GPLC) --no-top-level $< -o $@
	#$(GPLC) $< -o $@

test: all
	./q_trans

clean:
	rm ./q_trans

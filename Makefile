.PHONY: static clean

fna2faa: convert.cpp
	g++ -std=c++11 -O2 -o fna2faa convert.cpp

static: fna2faa-static
fna2faa-static: convert.cpp
	g++ -std=c++11 -O2 -static -o fna2faa-static convert.cpp
	strip fna2faa-static

run: fna2faa
	cat tests/test.fa | ./fna2faa

run-with-codons: fna2faa
	cat tests/test.fa | ./fna2faa --with-stop-codons

test: fna2faa
	@cat tests/test.fa | ./fna2faa > result.stdout 2> result.stderr
	@diff tests/expected.stdout result.stdout
	@diff tests/expected.stderr result.stderr
	@cat tests/test.fa | ./fna2faa --with-stop-codons > result.stdout 2> result.stderr
	@diff tests/expected_with_stop.stdout result.stdout
	@diff tests/expected_with_stop.stderr result.stderr
	@echo "No problems found"
clean:
	rm -f fna2faa fna2faa-static
	rm -f result.stdout result.stderr

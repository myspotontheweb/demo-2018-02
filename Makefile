SRC  = $(wildcard *.adoc)
HTML = $(SRC:.adoc=.html)
PDF  = $(SRC:.adoc=.pdf)

default: html

all: pdf

html: $(HTML)

pdf: $(PDF)

%.html: %.adoc
	if [ ! -d reveal.js ]; then git clone -b 3.0.0 https://github.com/hakimel/reveal.js.git; fi
	asciidoctor-revealjs -r asciidoctor-diagram -b revealjs $<

%.pdf: %.html
	docker run --rm -v `pwd`:/pwd astefanutti/decktape /pwd/$< /pwd/$@

clean:
	rm -f *.html *.pdf
	rm -rf images

clean-all: clean
	rm -rf asciidoctor-reveal.js
	rm -rf reveal.js

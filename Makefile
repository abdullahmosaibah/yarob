#/usr/bin/sh
# Build alyahmor package

default: all
# Clean build files
clean:
	
backup: 
	
#create all files 
all: 

# Publish to github
publish:
	git push origin main

md2rst:
	pandoc -s -r markdown -w rst README.md -o README.rst
md2html:
	pandoc -s -r markdown -w html README.md -o README.html

wheel:
	sudo python3 setup.py bdist_wheel
install:
	sudo python3 setup.py install
sdist:
	sudo python3 setup.py sdist
upload:
	echo "use twine upload dist/yarob-0.1-py2-none-any.whl"

doc:
	epydoc -v --config epydoc.conf

build_verb_inflect:OUTPUT=tests/output/verbs_conjug_const.py
build_verb_inflect:
	# build a const for verb conjugation inflection
	#Data file : data/verb.csv
	# print into stdout
	# saved into tests/output/verbs_conjug_const.py
	echo "# This Table is generated automaticly by yarob/tools/gen_verb_inflect.py" > $(OUTPUT)
	echo "# Based on yarob/data-source/verbs.csv" >> $(OUTPUT)
	cd tools; python3 gen_verb_inflect.py >> ../$(OUTPUT)
example_count:
	#
	awk 'BEGIN { FS="\n"; RS=""; OFS="\t"} {print $$1}END {}' data-source/examples  | wc -l

samples_build:
	# convert examples.txt which contains multiline records
	# into a dictionary as json
	awk -f tools/record2json.awk data-source/examples > tests/output/samples.py

samples_build2:DATE=`date +%Y-%m-%d`
samples_build2:
	# convert examples.txt which contains multiline records
	# into a dictionary as json
#~ 	awk -v ref=aljazeera -f tools/record2json.awk data-source/examples-part-jazeera > tests/output/samples-jazeera.py
#~ 	awk -v ref=elite.forumfa.net -f tools/record2json.awk data-source/example-part-quran> tests/output/example-part-quran.py
	awk -v ref=tahadz.com -v date=$(DATE) -f tools/record2json.awk data-source/examples-divers-part> tests/output/examples-divers-part1.py

server:
	cd web; python3 yarob_flask.py
test:
	#cd tests;python3 -m pytest test_*
	cd tests;python3 -m pytest test_sampledb.py
	#cd tests;python3 -m pytest test_adaat.py

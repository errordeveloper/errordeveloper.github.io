create: index.html archive.html

update: addlink.rb details.yml
	@diff -q details.yml details.yml~ || \
		cp details.yml details.yml~
	@ruby $< && \
		make index.html

upload:
	@cd ../ && make push

GENPAGE_PIPE = bluecloth --fragment | sed 's/amp\;//g'

index.html: genpage.erb details.yml
	env GENPAGE_DATA=archive.yml erb $< | $(GENPAGE_PIPE) >$@

archive.html: genpage.erb archive.yml
	env GENPAGE_DATA=details.yml erb $< | $(GENPAGE_PIPE) >$@

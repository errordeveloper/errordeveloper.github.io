create: index.html

update: addlink.rb details.yml
	@diff -q details.yml details.yml~ || \
		cp details.yml details.yml~
	@ruby $< && \
		make index.html

upload:
	@cd ../ && make push

index.html: genpage.erb details.yml
	erb $< | bluecloth --fragment | sed 's/amp\;//g' >$@


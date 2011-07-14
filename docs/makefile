index.html: genpage.erb details.yml
	erb $< | bluecloth --fragment | sed 's/amp\;//g' >$@

update: addlink.rb details.yml
	@diff -q details.yml details.yml~ || \
		cp details.yml details.yml~
	@ruby $< && \
		make index.html

commit: index.html
	@git status && \
		printf "Commit? (Enter/Cancel): " && read && \
		git commit -a --edit && \
		printf "Push? (Enter/Cancel): " && read && \
		git push

browse: index.html
	surf $<

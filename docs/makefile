index.html: gdocs_pubs.erb gdocs_pubs.yml
	erb $< | bluecloth --fragment > $@

browse: index.html
	surf $<

commit: index.html
	@git status && \
		printf "Commit? (Enter/Cancel): " && read && \
		git commit -a --edit && \
		printf "Push? (Enter/Cancel): " && read && \
		git push

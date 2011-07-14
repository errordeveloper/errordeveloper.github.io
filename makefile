home: pubs root push

root: index.html

pubs:
	@cd pubs/ && make

help:
	${info In /:}
	${info - `make` regenerates the entire website}
	${info - `make root` generates 'index.html'}
	${info - `make push` does commits and pushes to the repository}

	${info In pubs/:}
	${info - `make compile` generates 'pubs/index.html'}
	${info - `make update` adds an entry and regenerates 'pubs/index.html'}

push:
	@git status && \
		printf "Commit? (Enter/Cancel): " && read && \
		git commit -a --edit && \
		printf "Push? (Enter/Cancel): " && read && \
		git push

view: index.html
	surf $<

index.html: index.md
	bluecloth --fragment $< | sed 's/amp\;//g' >$@

SHELL := /bin/sh

init:
	asdf plugin add ruby || true
	asdf install

run:
	ruby main.rb

.PHONY: init run

#!/bin/sh

# Node
# TODO: Deprecate commitizen and cz-conventional-changelog after building a
# custom commitizen with lazygit
npm i -g pnpm \
	@antfu/ni \
	typescript \
	@angular/cli \
	react-native \
	npm-check \
	yarn \
	commitizen \
	cz-conventional-changelog

pip3 install fb-idb

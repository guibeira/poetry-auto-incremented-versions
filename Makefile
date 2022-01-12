clean: clean-eggs clean-build
	@find . -iname '*.pyc' -delete
	@find . -iname '*.pyo' -delete
	@find . -iname '*~' -delete
	@find . -iname '*.swp' -delete
	@find . -iname '__pycache__' -delete

clean-eggs:
	@find . -name '*.egg' -print0|xargs -0 rm -rf --
	@rm -rf .eggs/

clean-build:
	@rm -fr build/
	@rm -fr dist/
	@rm -fr *.egg-info

build: test
	poetry build

deps:
	poetry install

test: deps
	poetry run pytest -sx

version = `cat changes.rst | awk '/^[0-9]+\.[0-9]+(\.[0-9]+)?/' | head -n1`
msg = `grep -Eo '\* (.?)+'\  CHANGES.rst | head -1`
music = ` grep -Eo 'https://[^ >]+'\|head  CHANGES.rst | head -1` 


bump_version:

	poetry version $(version)
	git add pyproject.toml
	git commit -m"Bump version $(version)"

show_version:
	speedtest-cli

release: clean build
	git rev-parse --abbrev-ref HEAD | grep '^master$$'
	git tag $(version)
	git push origin `python setup.py -q version`
	git push origin $(version)
	twine upload dist/*

lint:
	pre-commit run -a -v

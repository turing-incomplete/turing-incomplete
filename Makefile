all: clean build/

build/: deps
	time bundle exec middleman build

deps:
	bundle check || bundle install

clean:
	rm -rf build/

.PHONY: all clean

# Turing-Incomplete [![Build Status](https://travis-ci.org/turing-incomplete/turing-incomplete.svg?branch=master)](https://travis-ci.org/turing-incomplete/turing-incomplete)

Source code for [turing.cool](http://turing.cool)

## Developing Locally

The site uses [Middleman](http://middlemanapp.com) for generating static HTML and assets from source files. To setup Middleman and other dependencies, use [Bundler](http://bundler.io):

    $ bundle
    Using middleman-core
    Using middleman
    ...
    Your bundle is complete!

You can now host the site locally by running Middleman:

    $ middleman
    == The Middleman is loading
    == The Middleman is standing watch at http://0.0.0.0:4567
    == Inspect your site configuration at http://0.0.0.0:4567/__middleman/

The site should now be viewable at [http://localhost:4567](http://localhost:4567). Any changes made to the source should be viewable after a page refresh in your browser.

## Deploying

[Travis CI](https://travis-ci.org) tests every branch to ensure that the site can be built.

If the branch is on this repo ([turing-incomplete/turing-incomplete](https://github.com/turing-incomplete/turing-incomplete)), each successful branch build will be deployed to [beta.turing.cool](http://beta.turing.cool).

Merging any branch to master will deploy to [turing.cool](http://turing.cool).

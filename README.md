Greenscreen
===========

An evolving suite of tools for interacting with environmental data.

Includes:

 * United States EPA green vehicle data
 * ...

Installation
------------

After cloning the repository you should:

    bundle install
    bundle exec rake epa:download_all
    time bundle exec rake epa:import_all
    bundle exec rails s

Tests
-----

To run all tests

    bundle exec rake test:all

TODO
----

Some half-baked ideas for where this could go might include:

* map fuel consumption
* by vehicle style/type
* experiments -- what influences decision to use low-emission vehicle?
* compare fuel efficiency
* green reporting api
* impact of proximity to mass transit
* environmental metadata display during web browsing



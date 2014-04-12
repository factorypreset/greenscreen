Greenscreen
===========

An evolving suite of tools for interacting with environmental data.

Includes:

 * United States EPA green vehicle data
 * ...

Pre-requisites
--------------

 * Some environment capable of running ruby 2.1+
 * npm


Installation
------------

After cloning the repository you should:

    bundle install

Download and import latest source data:

    bundle exec rake epa:download_all
    time bundle exec rake epa:import_all

(warning: that second step can take several minutes to complete).

Update and build front-end components:

    cd vendor/assets/javascripts/greenscreen/
    sudo npm install -g grunt-cli bower
    sudo npm install
    bower cache clean && bower install
    grunt


Using the application
---------------------

Start the server:

    bundle exec rails s

JSON feeds will now be available at:

 * http://localhost:3000/vehicle_makes.json
 * http://localhost:3000/vehicle_models.json

vehicle_models.json responds to 'year' and 'make' filters, e.g.

 * http://localhost:3000/vehicle_models.json?year=2013&make=Tesla

The app interacting with these feeds will be available at:

 * http://localhost:3000/vehicles.html


Tests
-----

Run all ruby tests:

    bundle exec rake test:all

Run all js tests:

    cd app/assets/javascripts/greenscreen/
    grunt karma:run

TODO
----

Some half-baked ideas for where this could go might include:

 * move js to its own repository
 * map fuel consumption
 * by vehicle style/type
 * experiments -- what influences decision to use low-emission vehicle?
 * compare fuel efficiency
 * green reporting api
 * impact of proximity to mass transit
 * environmental metadata display during web browsing

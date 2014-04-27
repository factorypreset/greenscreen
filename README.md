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
    bundle exec rake db:setup

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

 * http://localhost:3000/vehicle-makes.json
 * http://localhost:3000/vehicle-makes/:vehicle_make_id.json
 * http://localhost:3000/vehicle-makes/:vehicle_make_id/vehicle-models.json
 * http://localhost:3000/vehicle-makes/:vehicle_make_id/vehicle-models/:vehicle_model_id.json

The app interacting with these feeds will be available at:

 * http://localhost:3000/vehicles-makes


Tests
-----

Set up the test database:

    RAILS_ENV=test bundle exec rake db:setup

Run all ruby tests:

    bundle exec rake test:all

Run all js tests:

    cd app/assets/javascripts/greenscreen/
    grunt karma:run

TODO
----

Some half-baked ideas for where this could go might include:

 * move js to its own repository
 * handle year revisions for vehicle models
 * handle different reporting jurisdictions (particularly CA vs Federal)
 * handle different data sources
 * map fuel consumption
 * by vehicle style/type
 * experiments -- what influences decision to use low-emission vehicle?
 * compare fuel efficiency
 * green reporting api
 * impact of proximity to mass transit
 * environmental metadata display during web browsing

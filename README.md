# Production Features Incorporated:

* JWT-Secured (stubbed)
* CORS incorporated (rules are loose)
* Versioned APIs
* Versioned Serializers
* Swagger Documentation with Functional Example Area
* Unit tests at model, controller, and full stack level
* TDD-build code base
* High performance serialization (using Netflix Serializer)
* High performance data filtering (using Rack::Reducer)
* Data Seed file
* Basic Data Validations, Relationships, Database Constraints (foreign keys, defaults)
* Deployed to publicly assessible location
* Console tools & helpers

# Other "Production" Considerations (i.e. what I'd do next if this were going to prod)

* User Authentication, Authorization and Tokenization using Users, Devise and JWT:
  * Use JWT - DONE
  * Add user class, and Devise, Cancancan for authorization - set up cancancan rules for different user types (specifically a user can only edit their own data)
  * Add and implement devise-jwt for token management -- https://github.com/waiting-for-dev/devise-jwt
  * Implement expiry of tokens

* Dev-Ops:
  * Integration to Log Tooling such as paper trail
  * Incorporation of Rollbar for errors
  * Deploy on AWS instead of Heroku (primarily a $$ consideration - I chose Heroku because it's easy)
  * Incorporate a CI tool (along with automatic unit testing and Capistrano-based deployment with successful build)

* Security:
  * Force SSL!! (get a certificate, turn force SSL at Rack layer)
  * Tighten up the CORS rules once we know where the client is
  * Put the behind Cloudflare and add Rack::Attack blocking/throttling middleware (to doubly prevent DDoS attacks)
  * Implement authorization library and user roles (ex. a trainer can't change another trainer's workout)

* Code Quality:
  * Use Rubocop to ensure there’s consistency in coding standards
  * Use Code Climate and/or simplecov to ensure coverage is constantly increasing and that code quality is strong, consistent
  * Beef up the model spec and add more end-to-end / corner case specs
  * Split up request (full stack) and controller tests that are together right now
  * Code Refactoring & Tightening up (likely would be triggered by addition of models and business logic)
  * Drying up some of the spec, adding helpers (ex. JSON parse, which I ended up adding)

* Documentation:
  * Build out documentation

* Functional Quality
  * API Versioning (both Controllers and Serializers) - Done
  * Additional Validations: Date-Time, etc.
  * Adding constraints on the database beyond FKs (ex. Non-null values)
  * Server-side options on Index actions: Pagination / Batching, Ordering
  * Add functionality that's clearly missing (but out of scope) - e.g. Images, other meta data, more associations, tags, etc.
  * Better description searching (elastic, solr)

# Some Choices I made during the exercise

* API Namespace: I chose /v1/{resource}, under the assumption that this will live at a subdomain api.plankk.com
* CORS -- Chose to allow all origins for now to allow it to be queried live
* Decided to use the Netflix model serialization Library instead of the standard AMS -- performs better and AMS is no longer being maintained. Also, wanted to learn something new.
  * Faster Performance
  * Includes options for cache-ing which will be useful for optimizing front-end experiences (ex. workout lists)
* I did a value class extraction for Influencer Age to demonstrate the composition concept I'd use for the inevitable set of other things we'd want to add here (ex. followers, classes viewed via Plankk Studio, etc.)
* For API Index Filtering -- Used https://github.com/chrisfrank/rack-reducer, simple to define and seems 
* Kept the full CRUD, but would add authorization to make sure deletions aren’t possible




# SETUP

TBD. This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

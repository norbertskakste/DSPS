[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![Build Status](https://travis-ci.org/norbertskakste/DSPS.svg?branch=master)](https://travis-ci.org/norbertskakste/DSPS)[![Inline docs](http://inch-ci.org/github/norbertskakste/DSPS.svg?branch=master)](http://inch-ci.org/github/norbertskakste/DSPS)

# Dsps
To start your Phoenix app:
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).


## Builds

* Master
    * TravisCI: [![Build Status](https://travis-ci.org/norbertskakste/DSPS.svg?branch=master)](https://travis-ci.org/norbertskakste/DSPS)
    * Inch-CI: [![Inline docs](http://inch-ci.org/github/norbertskakste/DSPS.svg?branch=master)](http://inch-ci.org/github/norbertskakste/DSPS)
* Develop
    * TravisCI: [![Build Status](https://travis-ci.org/norbertskakste/DSPS.svg?branch=develop)](https://travis-ci.org/norbertskakste/DSPS)
    * Inch-CI: [![Inline docs](http://inch-ci.org/github/norbertskakste/DSPS.svg?branch=develop)](http://inch-ci.org/github/norbertskakste/DSPS)
* Experimental
    * TravisCI: [![Build Status](https://travis-ci.org/norbertskakste/DSPS.svg?branch=experimental)](https://travis-ci.org/norbertskakste/DSPS)
    * Inch-CI: [![Inline docs](http://inch-ci.org/github/norbertskakste/DSPS.svg?branch=experimental)](http://inch-ci.org/github/norbertskakste/DSPS)

## Setting up development DB

```sql
-- STEP 1:
-- Create Database dsps_dev, for development env.
CREATE DATABASE dsps_dev;

-- STEP 2:
-- Create User dsps_dev_user with password dsps_dev_user
CREATE USER dsps_dev_user WITH PASSWORD 'dsps_dev_user';

-- STEP 3:
-- Grant all privileges on database dsps_dev to user dsps_dev_user
GRANT ALL PRIVILEGES ON DATABASE "dsps_dev" TO dsps_dev_user;
```

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

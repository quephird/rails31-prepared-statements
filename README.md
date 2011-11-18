## Description

This is a simple demonstration of how the new Rails 3.1 ActiveRecord implementation interacts with Oracle database now that it supports prepared statements.
Up until Rails 3.1, even though the enhanced Oracle OCI driver supports them, ActiveRecord still constructed SQL statements by concatenating parameter values.

## Set up and installation

Steps to setting up your environment and running this little application:

1. Install Oracle XE 11g. Go to http://www.oracle.com/technetwork/database/express-edition/overview/index.html to download it and for documentation
2. Run the SQL script, create_db_user.sql, in the db directory to create the rails31 user as well as to give it the grants needed in this demonstration.
3. Run bundle install to get all the required gems.
4. At the command line, run "set RAILS_ENV=local"
5. run "rails server"

## License

Copyright (C) 2011, dan kefford
Distributed under the Eclipse Public License.

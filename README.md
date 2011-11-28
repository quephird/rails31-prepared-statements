## Description

This is a simple demonstration of how the new Rails 3.1 ActiveRecord implementation interacts with Oracle database now that it supports prepared statements and bind variables.
Up until Rails 3.1, even though the enhanced Oracle OCI driver supports them, ActiveRecord still constructed SQL statements by concatenating parameter values.

## Set up and installation

Steps to setting up your environment and running this application:

1. Install Oracle XE 11g. Go to http://www.oracle.com/technetwork/database/express-edition/overview/index.html to download it and its documentation.
2. Run the SQL script, create_db_user.sql, in the db directory to create the rails31 user as well as to give it the grants needed in this demonstration.
3. Run bundle install to get all the required gems.
4. At the command line, run "set RAILS_ENV=local".
5. run "rails server".

## Background

Prior to ActiveRecord 3.1, all SQL queries that it generated were constructed by dynamically concatenating strings, substituting values for any query parameters via string interpolation.
The problem with this approach is that query execution plans generated by Oracle's optimizer cannot be shared across queries (assuming cursor sharing is not enabled; more on this below) for which the only differences between them are the values used in the predicates, such as below:

select person.* from person where id = 1  
select person.* from person where id = 314  
select person.* from person where id = 42  

Each of these queries would result in a parse, a separate query plan, and a distinct area of memory in Oracle's query cache.
Ideally, even though an application may issue these three queries, the same query, and its resultant plan, ought to be used such as below:

select person.* from person where id = :id

Other ORM's such as Hibernate _do_ support prepared statements right out of the box, so this does appear a bit troubling for Rails.
Even more frustrating, the underlying ruby-oci driver _has_ supported bind variables (I believe since 1.0) but ActiveRecord hasn't until very recently taken advantage of this feature.

However, all is not completely lost for pre-Rails 3.1 applications; the ruby-oci driver (and Oracle DB) supports the specification of the cursor sharing variable at the session level.
The cursor sharing setting controls, on the server side, how queries are parsed and cached.
In a nutshell, when the cursor sharing setting is set to "force" all inbound queries are first examined to see if they contain literals, and if so, they are replaced with bind variables.
This way, SQL query plans can now be shared, with the only disadvantage being that the database server is burdened preparing statements instead of the client driver.
The "force" setting is now the default for the ruby-oci driver.

Now with Rails 3.1, certain SQL queries generated by ActiveRecord are now prepared; the following statement types now use bind variables:

* INSERT by id
* SELECT by id
* DELETE by id

However, the following queries generated by ActiveRecord 3.1 still _not_ take advantage of them:

* UPDATE by id
* All other SELECTS, including those correspondent with Rails' "magical" finders (e.g., find_by_shoe_size_and_hair_color)

## Demonstration

One of the reasons why I embarked on this project is that I originally planned on inspecting the behavior of an application under development at my job.
Upon requesting access to a couple of Oracle's v$ views, and being immediately rejected, and seeing that Oracle 11g XE can be easily installed on Windows 7, I decided to conduct this experiment solely locally.
Needless to say, you are unlikely to be able to run this application against any database supervised by a DBA, as they are typically averse to giving grants (even just SELECTs) on v$ views. <sigh>

So, I wanted to create a simple application that allowed one to perform CRUD against the database, as well as execute a set of ad hoc queries, and see the resultant state of Oracle's query cache.
I wanted to be able to verify the behavior of ActiveRecord 3.1 as stated in the release notes, and also wanted to be able to demonstrate the difference in behavior between the two cursor sharing strategies.

## Useful links

Rails 3.1 release announcement:  
http://weblog.rubyonrails.org/2011/8/31/rails-3-1-0-has-been-released

This is a fairly good discussion on using Rails against an Oracle database:  
http://www.oracle.com/technetwork/articles/dsl/mearelli-optimizing-oracle-rails-092774.html

## License

Copyright (C) 2011, dan kefford
Distributed under the Eclipse Public License.

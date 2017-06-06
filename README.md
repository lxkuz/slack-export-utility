### INSTALLATION


```bash
git clone git@github.com:lxkuz/slack-export-utility.git
cd slack-export-utility
# using PostgreSQL
cp config/database.yml.example cp config/database.yml
# using ruby 2.4.1
bundle install
rake db:create db:migrate
rails s
```

### TESTS

```bash
  rspec spec
```
### TECHNOLOGIES

* Ruby 2.4.1
* Rails 5
* PosgreSQL 9.4
* Rubocop with git precommit hook
* Axlsx for Excel generation
* bulk_insert - gem to increase export perfomance
* Rspec, Webmock, Simplecov, Travis CI - testing infrastucture
* Heroku deployment

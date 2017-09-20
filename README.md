# Koine::DbBkp

Backup for Databases

- MySQL (with rake task)
- MySQL on Rails (with rake task)

[![Build Status](https://travis-ci.org/mjacobus/koine-db_bkp.svg?branch=master)](https://travis-ci.org/mjacobus/koine-db_bkp)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'koine-db_bkp'
```

## Usage

### MySql

```ruby
require 'koine/db_bkp/mysql/dump'

backup = Koine::DbBkp::Mysql::Dump.new(
  hostname: 'host',
  database: 'db',
  username: 'username',
  password: 'password',
)

backup.to_sql_file('/bkp/file.sql')
```

### MySql on Rails

```ruby
require 'koine/db_bkp/mysql/rails_dump'

# credentials taken from current Rails.configuration.database_configuration[Rails.env]
backup = Koine::DbBkp::Mysql::RailsDump.new
backup.to_sql_file('/bkp/file.sql')
```

### Rake tasks

```ruby
require "koine/db_bkp"

import 'lib/koine/tasks/mysql_dump.rake'
import 'lib/koine/tasks/mysql_rails_dump.rake'
```

```bash
export DB_HOST=some_host
export DB_NAME=some_name
export DB_USER=some_user
export DB_PASSWORD=some_password
export MYSQL_BACKUP_FILE='/foo/bar_{timestamp}.sql'

rake koine:mysql:dump
```

```bash
# database config will be taken from the Rails.configuration.database_configuration[ENV['RAILS_ENV']]

export MYSQL_BACKUP_FILE='/foo/bar_{timestamp}.sql'

rake koine:mysql:rails_dump
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mjacobus/koine-db_bkp. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


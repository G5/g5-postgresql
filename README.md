# G5 PostgreSQL #

A wrapper cookbook to install [PostgreSQL](http://www.postgresql.org)
with the defaults for a G5 development environment.

## Current version ##

0.1.1

## Requirements ##

* [Chef](http://www.getchef.com) >= 10
* [Vagrant](http://www.vagrantup.com) >= 1.5
* [Ruby](http://www.ruby-lang.org) >= 1.9

## Installation ##

Add a dependency on g5-postgresql to your cookbook's metadata.rb:

```ruby
depends 'g5-postgresql'
```

The cookbook is currently only available via git. We recommend
using [Berkshelf](http://berkshelf.com) to manage the installation.

To initialize Berkshelf in your project, if you haven't done so
already:

```console
$ cd my-chef-cookbook
$ gem install berkshelf
$ berks init
```

To reference the git version, simply add the following line to your
`Berksfile`:

```ruby
cookbook 'g5-postgresql', git: 'git@github.com:G5/g5-postgresql.git', tag: '0.1.0'
```

## Usage ##

### Attributes ###

* `node['postgresql']['password']['postgres']` - the encrypted value of the password
  that should be set on the postgres user. To generate the md5-hashed value from the
  command line:

  ```console
  echo -n 'iloverandompasswordsbutthiswilldo''postgres' | openssl md5 | sed -e 's/.* /md5/'
  ```

  For more information on how to set this attribute, see the [Chef Solo Note](https://github.com/hw-cookbooks/postgresql#chef-solo-note) in the documentation for the wrapped cookbook.

See the wrapped [postgresql cookbook](https://github.com/hw-cookbooks/postgresql#attributes)
for more attributes.

### Recipes ###

#### default ####

Installs PostgreSQL server and client, and configures them for use
by the `vagrant` user.

### Resources / Providers ###

See the wrapped [postgresql cookbook](https://github.com/hw-cookbooks/postgresql#resourcesproviders)
for more information.

## Examples ##

### Default configuration ###

Include the default recipe in one of your cookbook's
recipes:

```ruby
include_recipe 'g5-postgresql::default'
```

Set the postgres user's encrypted password in your Vagrantfile:

```ruby
config.vm.provision :chef_solo do |chef|
  # ...
  chef.json = {
    postgresql: {
      password: {
        postgres: 'my-md5-hashed-password-value'
      }
    }
  end
end
```

## Authors ##

* Maeve Revels / [@maeve](https://github/maeve)

## Contributions ##

1. Fork it
2. Set up your [development environment](#development-setup)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Write your code and **specs**
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new Pull Request

If you find bugs, have feature requests or questions, please
[file an issue](https://github.com/G5/g5-postgresql/issues).

### Development Setup ###

1. Clone the repository locally:

  ```console
  $ git clone git@github.com:G5/g5-postgresql.git
  $ cd g5-postgresql
  ```

2. Install required gems using [Bundler](http://bundler.io):

  ```console
  $ bundle install
  ```

3. Install required cookbooks using [Berkshelf](http://berkshelf.com/):

  ```console
  $ bundle exec berks install
  ```

4. Provision an instance for testing using [test-kitchen](http://kitchen.ci):

  ```console
  $ bundle exec kitchen converge
  ```

  See `bundle exec kitchen help` for more test-kitchen commands.

### Specs ###

The unit tests use [ChefSpec](http://sethvargo.github.io/chefspec/),
and live in the `test/unit` directory. To execute the entire
suite:

```console
$ bundle exec rspec
```

To run the [foodcritic](http://acrmp.github.io/foodcritic) linting tool:

```console
$ bundle exec foodcritic .
```

The integration tests use [ServerSpec](http://serverspec.org), and live
in the `test/integration/default/serverspec` directory. To execute
the test suite:

```console
$ bundle exec kitchen verify
```

If you would prefer to automatically monitor the filesystem for changes
to execute tests, [Guard](https://github.com/guard/guard) has been
configured:

```console
$ bundle exec guard start
```

### Releasing ###

We strive to follow [semantic versioning](http://semver.org). After all
pull requests have been merged to master and you determine the
version number for the next release:

1. Update [CHANGELOG.md](CHANGELOG.md) with the new version, release
   date, and a synopsis of changes included in this release.

   ```
   ## v0.1.1 (2014-08-04)

   * Fixed #42: A short description here
   ```

2. Update [metadata.rb](metadata.rb) with the new version.

   ```ruby
   name 'g5-postgresql'
   description 'G5 wrapper cookbook for installing PostgreSQL'
   version '0.1.1'
   # ...
   ```

3. Update [README.md](README.md#current-version) with the new version.

   ```markdown
   ## Current version

   0.1.1
   ```

4. Commit your changes and create a tag for the new version.

   ```console
   git commit -m "Prepare to release v0.1.1"
   git push origin master
   git tag -a v0.1.1 -m "Minor bug fixes"
   git push --tags
   ```

## License ##

Copyright (c) 2014 G5

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

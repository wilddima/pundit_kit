# PunditKit

[![Maintainability](https://api.codeclimate.com/v1/badges/edeb93a920e210fa3b85/maintainability)](https://codeclimate.com/github/WildDima/pundit_kit/maintainability)
[![Build Status](https://travis-ci.org/WildDima/pundit_kit.svg?branch=master)](https://travis-ci.org/WildDima/pundit_kit)

## Instalation

Add pundit_kit to your gemfile:

```ruby
gem 'pundit_kit'
```

## Usage

Example of initializer routes:

``` ruby
class ClientNotAllowedError < StandardError; end
class UserNotAllowedError < StandardError; end

PunditKit.routes do
  namespace :staff, if: -> (user) { user.staff? }, presence: false do
    namespace :admin, if: -> (user) { user.admin? }
    namespace :user, if: -> (user) { user.user? }, error: UserNotAllowedError
  end

  namespace :client, if: -> (user) { user.client? }, error: ClientNotAllowedError do
    namespace :superclient,
              if: -> (user) { user.superclient? },
              error: ClientNotAllowedError,
              presence: false
  end
end

```

Each namespace has these options:

|options|default|description|
|-------|-------|-----------|
|if:|-> { true }| lamda(or any callable object) evaluation of which determines should be used this namespace or not|
|presence:| true | if true then will raise error if policy in this namespace can't be found |
|error:| Pundit::NotAuthorizedError | error which would be raised if authorize call will return false |

## Example

For example yours application logic looks like this:
Include PunditKit to ApplicationController

```
class ApplicationController <  ActionController::Base
  include PunditKit
end
```

This'll add helpers to yours controllers:
* `authorize_all` - this method will call authorize on every namespace
* `all_policies` - this method will return all namespaces matches to `pundit_namespace_matcher`

## TODO
* scope
* fallbacks

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wilddima/pundit_kit.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PunditKit project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/wilddima/pundit_kit/blob/master/CODE_OF_CONDUCT.md).

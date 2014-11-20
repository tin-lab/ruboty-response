# Ruboty::Response

Ruboty handler to register a response.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-response'
```

## Usage

```
@ruboty add response /<regex>/ <response>
@ruboty list responses
@ruboty delete response <id>
```

If you would like to run a shell command, you need to surround it in back quotes.

e.g. ``@ruboty add response /^time$/ `date```

## Example

```
> @ruboty add response /^foo$/ bar
Response 533 is registered.
> foo
bar
> fooo
>
> @ruboty add response /^time$/ `ruby -e 'puts Time.now.to_s'`
Response 464 is registered.
> time
2014-11-20 14:00:00 +0900
```

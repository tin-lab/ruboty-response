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

## Example

```
> @ruboty add response /^foo$/ bar
Response 533 registered.
> foo
bar
> fooo
>
```

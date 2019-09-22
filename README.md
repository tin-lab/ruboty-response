# Ruboty::Response

Ruboty handler to register a response.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-response', '=<version>', github: "tin-lab/ruboty-response.git"
```

## Usage

```
@ruboty add response <mention(optional)> /<regex>/ <response>
@ruboty list responses
@ruboty delete response <id>
```

## Env

```
REACTION_TO_BOT - Receive reaction from bots(default: false)
```

## Example

```
> ruboty add response /^foo$/ bar
Response 256 is registered.
> foo
bar
> fooo
```

## Example On Your Slack

```
> @ruboty add response @hoge /^foo$/ bar
Response 637 is registered.
> @hoge echo foo
foo
bar
> foo
```

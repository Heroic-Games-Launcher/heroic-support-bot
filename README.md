# HeroicSupport

## Development

### Setup

- Run `mix deps.get` to install dependencies

### Tests

- Run `mix test` to run all tests

Note that Nostrum is disabled in the test environment, we don't really need to test it and we can abstract code if needed to other modules to not need Nostrum for tests.

### Local dev

- Create your bot and get the BOT_TOKEN
- Copy `dev.sample.exs` as `dev.exs` and configure a BOT_TOKEN variable
- Add the bot to a server
- Run `mix run --no-halt` to run the bot

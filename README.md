# json-generator package

Generates random dummy JSON data atom package.

![overview](https://raw.githubusercontent.com/KunihikoKido/atom-json-generator/master/screenshots/overview.gif)

## Commands
* Json Generator: New Template
* Json Generator: Generate (ctrl-alt-g)

## Available helpers
This package is used based on the [dummy-json](https://github.com/webroo/dummy-json).

You can see the  details of available helpers on the dummy-json.

I am grateful to the dummy-json.

## Overriding built-in mock data.
You can override the built-in data using the package settings.

## My Own Available helpers

### Language Code

`{{languageCode}}`

Generates a random language code.

### Currency Code

`{{currencyCode}}`

Generates a random currency code.

### Japanese Lorem ipsum

`{{jaLorem [sentenceCount]}}`

* `sentenceCount` Number of sentences to generate (optional, default is 1)

Generates random sentences of japanese lorem ipsum text.

### Random Keyword
`{{random [text] [separator]}}`

* `text` keywords string
* `separator` separator (default is ',')

`{{random 'apple,orange,banana', ','}}`

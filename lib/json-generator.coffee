{allowUnsafeEval, allowUnsafeNewFunction} = require 'loophole'
{CompositeDisposable} = require 'atom'
dummyjson = require 'dummy-json'
fs = require 'fs'
helpers = require './helpers'
path = require 'path'
utils = require './utils'
mockdata = require './mockdata'

module.exports = JsonGenerator =
  config:
    mockdataFirstNames:
      title: "Mock data: firstNames"
      description: "You can override the built-in firstNames data."
      type: "array"
      default: dummyjson.mockdata.firstNames
    mockdataLastNames:
      title: "Mock data: lastNames"
      description: "You can override the built-in lastNames data."
      type: "array"
      default: dummyjson.mockdata.lastNames
    mockdataCompanies:
      title: "Mock data: companies"
      description: "You can override the built-in companies data."
      type: "array"
      default: dummyjson.mockdata.companies
    mockdataTlds:
      title: "Mock data: tlds"
      description: "You can override the built-in tlds data."
      type: "array"
      default: dummyjson.mockdata.tlds
    mockdataStreets:
      title: "Mock data: streets"
      description: "You can override the built-in streets data."
      type: "array"
      default: dummyjson.mockdata.streets
    mockdataCities:
      title: "Mock data: cities"
      description: "You can override the built-in cities data."
      type: "array"
      default: dummyjson.mockdata.cities
    mockdataCountries:
      title: "Mock data: countries"
      description: "You can override the built-in countries data."
      type: "array"
      default: dummyjson.mockdata.countries
    mockdataCountryCodes:
      title: "Mock data: countryCodes"
      description: "You can override the built-in countryCodes data."
      type: "array"
      default: dummyjson.mockdata.countryCodes
    mockdataColors:
      title: "Mock data: colors"
      description: "You can override the built-in colors data."
      type: "array"
      default: dummyjson.mockdata.colors
    mockdataLanguages:
      title: "Mock data: languages"
      description: "You can override the built-in languages data."
      type: "array"
      default: mockdata.languages
    mockdataCurrencies:
      title: "Mock data: currencies"
      description: "You can override the built-in currencies data."
      type: "array"
      default: mockdata.currencies
    mockdataGenders:
      title: "Mock data: genders"
      description: "You can override the built-in genders data."
      type: "array"
      default: mockdata.genders
    mockdataGenres:
      title: "Mock data: genres"
      description: "You can override the built-in genres data."
      type: "array"
      default: mockdata.genres
    mockdataMovies:
      title: "Mock data: movies"
      description: "You can override the built-in movies data."
      type: "array"
      default: mockdata.movies
    mockdataOccupations:
      title: "Mock data: occupations"
      description: "You can override the built-in occupations data."
      type: "array"
      default: mockdata.occupations
    mockdataContactTypes:
      title: "Mock data: contact types"
      description: "You can override the built-in contact types data."
      type: "array"
      default: mockdata.contactTypes
    mockdataPaymentTypes:
      title: "Mock data: payment types"
      description: "You can override the built-in payment types data."
      type: "array"
      default: mockdata.paymentTypes
    outputFormat:
      title: "JSON Output format"
      description: "The format to generate dummy json data with.<br/>json: Pretty JSON format. / jsonlines: newline-delimited JSON format. / elasticsearch: Elasticsearch Bulk API format."
      type: "string"
      enum: ["json", "jsonlines", "elasticsearch"]
      default: "json"

  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'json-generator:generate': => @generate()
    @subscriptions.add atom.commands.add 'atom-workspace', 'json-generator:new-template': => @newTemplate()

  deactivate: ->
    @subscriptions.dispose()

  toggle: ->
    console.log 'JsonGenerator was toggled!'

  generate: ->
    editor = atom.workspace.getActiveTextEditor()
    return unless editor?

    console.log mockdata

    myMockdata =
      firstNames: atom.config.get('json-generator.mockdataFirstNames')
      lastNames: atom.config.get('json-generator.mockdataLastNames')
      companies: atom.config.get('json-generator.mockdataCompanies')
      tlds: atom.config.get('json-generator.mockdataTlds')
      streets: atom.config.get('json-generator.mockdataStreets')
      cities: atom.config.get('json-generator.mockdataCities')
      countries: atom.config.get('json-generator.mockdataCountries')
      countryCodes: atom.config.get('json-generator.mockdataCountryCodes')
      colors: atom.config.get('json-generator.mockdataColors')
      languages: atom.config.get('json-generator.mockdataLanguages')
      currencies: atom.config.get('json-generator.mockdataCurrencies')
      genders: atom.config.get('json-generator.mockdataGenders')
      genres: atom.config.get('json-generator.mockdataGenres')
      movies: atom.config.get('json-generator.mockdataMovies')
      occupations: atom.config.get('json-generator.mockdataOccupations')
      contactTypes: atom.config.get('json-generator.mockdataContactTypes')
      paymentTypes: atom.config.get('json-generator.mockdataPaymentTypes')

    myHelpers =
      currency: helpers.currency
      date: helpers.date
      loremja: helpers.loremja
      language: helpers.language
      random: helpers.random
      gender: helpers.gender
      genre: helpers.genre
      movie: helpers.movie
      occupation: helpers.occupation
      contactType: helpers.contactType
      paymentType: helpers.paymentType

    try
      result = allowUnsafeNewFunction -> dummyjson.parse(
        editor.getText(), {mockdata: myMockdata, helpers: myHelpers})

      json = JSON.parse(result)

      outputFormat = atom.config.get("json-generator.outputFormat")
      switch outputFormat
        when "jsonlines"
          text = utils.jsonlines(json)
        when "elasticsearch"
          text = utils.esBulk(json)
        else
          text = JSON.stringify(json, null, '  ')

      atom.workspace.open('').then((newEditor) ->
        newEditor.setGrammar(atom.grammars.selectGrammar('JSON'))
        newEditor.setText(text)
      )
      atom.notifications.addSuccess(
        'json-generator', {detail: "Success! Generated dummy JSON."})

    catch error
      atom.notifications.addError(
        'json-generator', {detail: "Error! #{error.message}"})

  newTemplate: ->
    template = fs.readFileSync(path.join(__dirname, 'template.hbs'), {encoding: 'utf8'})
    atom.workspace.open('').then((newEditor) ->
      newEditor.setGrammar(atom.grammars.grammarForScopeName('source.json.mustache'))
      newEditor.setText(template)
    )

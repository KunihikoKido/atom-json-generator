{allowUnsafeEval, allowUnsafeNewFunction} = require 'loophole'
dummyjson = require 'dummy-json'
{CompositeDisposable} = require 'atom'
fs = require 'fs'
path = require 'path'


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

    mockdata =
      firstNames: atom.config.get('json-generator.mockdataFirstNames')
      lastNames: atom.config.get('json-generator.mockdataLastNames')
      companies: atom.config.get('json-generator.mockdataCompanies')
      tlds: atom.config.get('json-generator.mockdataTlds')
      streets: atom.config.get('json-generator.mockdataStreets')
      cities: atom.config.get('json-generator.mockdataCities')
      countries: atom.config.get('json-generator.mockdataCountries')
      countryCodes: atom.config.get('json-generator.mockdataCountryCodes')
      colors: atom.config.get('json-generator.mockdataColors')

    try
      result = allowUnsafeNewFunction -> dummyjson.parse(editor.getText(), {mockdata: mockdata})
      atom.workspace.open('').then((newEditor) ->
        newEditor.setGrammar(atom.grammars.selectGrammar('JSON'))
        newEditor.setText(result)
      )
      atom.notifications.addSuccess('json-generator', {
          detail: "Success! Generated dummy JSON."
      })
    catch error
      atom.notifications.addError('json-generator', {
        detail: "Error! #{error.message}"
      })

  newTemplate: ->
    template = fs.readFileSync(path.join(__dirname, 'template.hbs'), {encoding: 'utf8'})
    atom.workspace.open('').then((newEditor) ->
      newEditor.setGrammar(atom.grammars.grammarForScopeName('source.json.mustache'))
      newEditor.setText(template)
    )

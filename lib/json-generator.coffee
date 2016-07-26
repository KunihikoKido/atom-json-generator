{allowUnsafeEval, allowUnsafeNewFunction} = require 'loophole'
dummyjson = require 'dummy-json'
{CompositeDisposable} = require 'atom'
fs = require 'fs'
path = require 'path'


module.exports = JsonGenerator =
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

    try
      result = allowUnsafeNewFunction -> dummyjson.parse(editor.getText())
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

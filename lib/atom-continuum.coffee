AtomContinuumView = require './continuum-atom-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomContinuum =
  atomContinuumView: null
  modalPanel: null
  subscriptions: null

  config:
    includeCompletionsFromAllBuffers:
      type: 'boolean'
      default: false

  activate: (state) ->
    @atomContinuumView = new AtomContinuumView(state.atomContinuumViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomContinuumView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'continuum-atom:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomContinuumView.destroy()

  serialize: ->
    atomContinuumViewState: @atomContinuumView.serialize()

  toggle: ->
    console.log 'AtomContinuum was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

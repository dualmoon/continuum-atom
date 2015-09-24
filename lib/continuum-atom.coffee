ContinuumAtomView = require './continuum-atom-view'
{CompositeDisposable} = require 'atom'

module.exports = ContinuumAtom =
  ContinuumAtomView: null
  modalPanel: null
  subscriptions: null

  config:
    includeCompletionsFromAllBuffers:
      type: 'boolean'
      default: false


  activate: (state) ->
    @ContinuumAtomView = new ContinuumAtomView(state.ContinuumAtomViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @ContinuumAtomView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'continuum-atom:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @ContinuumAtomView.destroy()

  serialize: ->
    ContinuumAtomViewState: @ContinuumAtomView.serialize()

  toggle: ->
    console.log 'ContinuumAtom was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

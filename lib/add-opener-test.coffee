AddOpenerTestView = require './add-opener-test-view'
{CompositeDisposable} = require 'atom'

module.exports = AddOpenerTest =
  addOpenerTestView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @addOpenerTestView = new AddOpenerTestView(state.addOpenerTestViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @addOpenerTestView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'add-opener-test:toggle': => @toggle()

    # following hex package
    @openerDisposable = atom.workspace.addOpener(openURI)

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @addOpenerTestView.destroy()
    @openerDisposable.dispose()

  serialize: ->
    addOpenerTestViewState: @addOpenerTestView.serialize()

  toggle: ->
    console.log 'AddOpenerTest was toggled!'
    paneItem = atom.workspace.getActivePaneItem()
    filePath = paneItem.getPath()
    atom.workspace.open(filePath)
    #if @modalPanel.isVisible()
    #  @modalPanel.hide()
    #else
    #  @modalPanel.show()

openURI = (uriToOpen) ->
  console.log 'openURI called with '+uriToOpen

hints = ->
  @attributes
    step: 1

  @runHints = ->
    intro = introJs()
    intro.setOptions
      exitOnOverlayClick: false
      showStepNumbers: false
      disableInteraction: false
      steps: toprater.hints
    console.log toprater.hints
    intro.goToStep(@attr.step).start()
    intro.onchange (target) ->
      console.log $(target).data('step')

  @after "initialize", ->
    @on document, 'pageLoaded', @runHints

Toprater.Hints = flight.component(hints)

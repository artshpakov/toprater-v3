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
    intro.goToStep(@attr.step).start()

  @after "initialize", ->
    @on document, 'dataPageLoaded', @runHints

Toprater.Hints = flight.component(hints)

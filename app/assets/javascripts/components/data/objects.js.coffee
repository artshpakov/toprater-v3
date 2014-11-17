$ ->
  objectsData =  ->
    @attributes({
      selectedCriteria: []
    })

    @getAlternatives = (criteria, filters) ->
      address = "objects?criteria=[#{ @attr.selectedCriteria }]"
      console.log address
      @get
        url: address
        done: ->
          console.log "yep!"
      alert 'selected!'

    @after "initialize", ->
      @on "criterionSelected", (e, data)->
        @attr.selectedCriteria.push(data.name)
        console.log @attr.selectedCriteria
        @getAlternatives()


  Toprater.ObjectsData = flight.component(objectsData, withRequest)
  Toprater.ObjectsData.attachTo document

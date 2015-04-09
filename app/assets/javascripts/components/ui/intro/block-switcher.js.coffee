blockSwitcher = ->
  @attributes
    currentSphere: -> new String()


  @after "initialize", ->
    @attr.currentSphere = "movies"

    @on @$node.find("[role=choose-list] a"), "click", (event) ->
      console.log event.target.getAttribute "data-choose"
      choosedSphere = event.target.getAttribute "data-choose"
      @$node.find("[data-sphere=#{ @attr.currentSphere }]").hide()
      @$node.find("[data-sphere=#{ choosedSphere }]").show()
      @attr.currentSphere = choosedSphere
      @$node.find(".current").html(@attr.currentSphere)
      @$node.click()



Toprater.BlockSwitcher = flight.component blockSwitcher

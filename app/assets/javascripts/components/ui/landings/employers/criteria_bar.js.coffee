criteriaBar = ->

  @after "initialize", ->
    # @$node.width(@$node.find($(".criterion-bar")).width() * @$node.find($(".criterion-bar")).length)
    @$node.width(10000)



Toprater.CriteriaBar = flight.component criteriaBar

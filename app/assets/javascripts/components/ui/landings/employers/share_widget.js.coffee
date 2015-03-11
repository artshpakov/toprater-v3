shareWidget = ->

  @viewType = (event, data) ->
    if data?
      if event.type == "slideScrollReq"
        if data.name == "header"
          console.log "header"
        else
          @$node.removeClass "vertical"
        
      if event.type == "slideScrolled"
        if data.name == "header"
          @$node.addClass "vertical"


  @toggle = ->


  @after "initialize", ->
    @on document, "slideScrollReq", @viewType
    @on document, "slideScrolled", @viewType


Toprater.EmployersShareWidget = flight.component shareWidget, Toprater.WithShareMixin

withShare = ->
  @attributes
    buttons: "[role=share-button]"


  @after "initialize", ->
    @select("buttons").prettySocial()



Toprater.WithShareMixin = withShare

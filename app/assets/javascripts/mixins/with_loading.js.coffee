withLoadingCtr = ->
  @attributes
    loading: false
    template: "<div class='loader'></div>"

  @on "initialize", ->


window.withLoading = withLoadingCtr

class Toprater.State

  @criteria: []

  @pickCriterion: (criterion) =>
    @criteria.push criterion unless criterion in @criteria

  @dropCriterion: (criterion) =>
    @criteria = _.without @criteria, criterion


  @parameterize: ->
    criteria: (criterion.name for criterion in @criteria)

  @toUrl: =>
    ("#{ param }=#{ JSON.stringify value }" for param, value of @parameterize()).join '&'

class Toprater.State

  @criteria: []

  @pickCriterion: (criterion) =>
    @criteria.push criterion unless criterion in @criteria
    Toprater.Alternative.rate()


  @parameterize: ->
    criteria: (criterion.name for criterion in @criteria)

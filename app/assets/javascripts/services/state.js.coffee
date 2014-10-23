class Toprater.State

  @criteria: []

  @pickCriterion: (criterion) =>
    @criteria.push criterion unless criterion in @criteria

  @parameterize: ->
    criteria: (criterion.name for criterion in @criteria)

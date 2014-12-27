pricesCalendar = ->

  @loadPrices = ->
    @trigger 'pricesLoad'
    $.ajax "/en/hotels/objects/#{ toprater.state.options.id }/prices",
      data:
        prices:
          from_date:  $("[name='prices[arrival]']", @$node).val()
          until_date: $("[name='prices[departure]']", @$node).val()
          adults:     $("[name='prices[adults]']", @$node).val()
      dataType: 'json'
      success: (prices) => @trigger 'pricesLoaded', { prices }

  @after 'initialize', ->
    @on '[role=get-prices]', 'click', @loadPrices


Toprater.PricesCalendar = flight.component pricesCalendar
Toprater.PricesCalendar.attachTo "[role=prices-calendar]"

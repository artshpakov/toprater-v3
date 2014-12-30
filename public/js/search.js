$(function() {

  $("input#search").change(function() {
    var url = "/en/movies/search.json?term=" + $("input#search").val()
    $.ajax({
      url: url,
      method: "GET"
    })
    .fail(function(data) {
      console.log(data)
    })
    .done(function(data) {
      _.each(data.objects, function(object) {
        $(".result").append($("<a href='/en/landings/similar/" + object.id + "'>" + object.label + "</a>"));
      })
    })

  });

  

});


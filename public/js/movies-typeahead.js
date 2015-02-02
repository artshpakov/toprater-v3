$(function() {
  function updateList() {
    $(".result").html("");
    console.log($("input#search").val());
    var url = "/en/movies/search.json?term=" + $("input#search").val();
    $.ajax({
      url: url,
      method: "GET"
    })
    .fail(function(data) {
      console.log(data);
    })
    .done(function(data) {
      _.each(data.body.objects, function(object) {
        $(".result").append($("<a href='/en/landings/similar-movies/" + object.id + "'>" + object.label + "</a>"));
      });
    });
  }

  $("input#search").keyup(function(e) {
    if ($.inArray(e.keyCode, [13,16,17,18,19,20,27,35,36,37,38,39,40,91,93,224]) === -1 ) {
      updateList();
    }
  });

  $(".prettySocial").prettySocial();
});

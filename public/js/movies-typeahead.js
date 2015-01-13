$(function() {
  function updateList() {
    $(".result").html("");
    var url = "/en/movies/search.json?term=" + $("input#search").val();
    $.ajax({
      url: url,
      method: "GET"
    })
    .fail(function(data) {
      console.log(data);
    })
    .done(function(data) {
      _.each(data.objects, function(object) {
        $(".result").append($("<a href='/en/landings/similar/" + object.id + "'>" + object.label + "</a>"));
      });
    });
  }
  $("input#search").keypress(function(e) {
    if (e.which != 0) {
      updateList();
    }
  });
  $("input#search").keyup(function(e) {
    if (e.keyCode == 8 || e.keyCode == 46) {
      updateList();
    }
  });

  $(".prettySocial").prettySocial();
});

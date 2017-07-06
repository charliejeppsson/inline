
$(function(){

  $(".search-click").on("click", function(e){
    // Change active tab
      // $(".search-click").removeClass("active");
      // $(this).addClass("active");
    // Hide all tab-content (use class="hidden")
    $(".search-click-content").removeClass("hidden");
    // // Show target tab-content (use class="hidden")
    // var active_id = $(".search-click-content").data("target");
    // $(active_id).removeClass("hidden");
  });

});


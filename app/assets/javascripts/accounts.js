$(document).ready(function() {
    /* Activating Best In Place */
    jQuery(".best_in_place").best_in_place();
});

$('.bounce_on_success').bind("ajax:success", function(){$(this).closest('tr').effect('bounce');});

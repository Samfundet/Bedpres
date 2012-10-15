$(function () {
    $("#upcoming-presentations tbody tr").each(function () {
        $("td:last", this).expander({
            expandText: "Les mer",
            userCollapseText: "Les mindre"
        });
    });
});

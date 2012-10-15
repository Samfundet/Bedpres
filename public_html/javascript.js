$(function () {
    $("#upcoming-presentations tbody tr").each(function () {
        $("td:last", this).expander({
            expandText: "Les mer",
            userCollapseText: "Les mindre"
        });
    });

    $(".btn-primary").click(function () {
        $('select[name=presentation] option:eq(1)').attr('selected', 'selected');
    });
});

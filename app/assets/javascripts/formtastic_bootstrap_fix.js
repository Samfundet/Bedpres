// See https://github.com/mjbellantoni/formtastic-bootstrap/issues/42.

$(function () {
    $('.form-horizontal .help-inline').each(function () {
        var l = $(this);
        l.appendTo(l.siblings('.controls'));
    });

    $('.form-horizontal .help-block').each(function () {
        var l = $(this);
        l.removeClass("help-block");
        l.addClass("help-inline");
    });
});

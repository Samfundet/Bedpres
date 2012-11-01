// See https://github.com/mjbellantoni/formtastic-bootstrap/issues/42.

$(function () {
    $('.formtastic .help-inline').each(function () {
        var l = $(this);
        l.appendTo(l.siblings('.controls'));
    });
});

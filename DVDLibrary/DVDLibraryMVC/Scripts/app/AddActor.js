

$(document).ready(function () {
    $('#btnShowAddActor').click(function () {
        $('#addActorModal').modal('show');
    });

    $('#btnSaveActor').click(function () {
        var actor = {};

        actor.firstName = $('#firstname').val();
        actor.lastName = $('#lastname').val();

        $.post(index, actor)
            .done()
        .fail(function (jqXhr, status, err) {
            alert(status + ' - ' + err);
        });
    });
});


$(document).ready(function () {
    $('#btnShowAddActor').click(function () {
        $('#addActorModal').modal('show');
    });

    $('#btnSaveActor').click(function () {
        var actor = {};

        actor.firstName = $('#inputactorfirstname').val();
        actor.lastName = $('#inputactorlastname').val();

        $.post(index, actor)
            .done()
        .fail(function (jqXhr, status, err) {
            alert(status + ' - ' + err);
        });
    });
});
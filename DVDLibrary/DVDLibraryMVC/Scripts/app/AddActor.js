var actoruri = "/api/Actors";

$(document).ready(function () {
    loadActors();
});

function loadActors() {
    $.getJSON(actoruri)
        .done(function (data) {
            $('#inputActors option').remove();

            $.each(data, function (index, actor) {
                $(createOptionActor(actor)).appendTo($('#inputActors'));
            });
        });
};

function createOptionActor(actor) {
    return '<option value="' + actor.ActorID + '">' + actor.FirstName + ' ' + actor.LastName + '</option>';
}

$(document).ready(function () {
    $('#btnShowAddActor').click(function () {
        $('#addActorModal').modal('show');
    });

    $('#btnSaveActor').click(function () {
        var actor = {};

        actor.FirstName = $('#actorfirstName').val();
        actor.LastName = $('#actorlastName').val();

        $.post(actoruri, actor)
            .done(function () {
                loadActors();
                $('#addActorModal').modal('hide');
            })
            .fail(function (jqXhr, status, err) {
                alert(status + ' - ' + err);
            });
    });
});
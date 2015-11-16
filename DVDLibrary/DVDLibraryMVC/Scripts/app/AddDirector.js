

$(document).ready(function () {
    $('#btnShowAddDirector').click(function () {
        $('#addDirectorModal').modal('show');
    });

    $('#btnSaveDirector').click(function () {
        var director = {};

        director.firstName = $('#inputdirectorfirstname').val();
        director.lastName = $('#inputdirectorlastname').val();

        $.post(index, director)
            .done()
        .fail(function (jqXhr, status, err) {
            alert(status + ' - ' + err);
        });
    });
});
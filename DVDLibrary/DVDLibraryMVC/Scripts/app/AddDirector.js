var directoruri = "/api/Directors";

$(document).ready(function () {
    loadDirectors();
});

function loadDirectors() {
    $.getJSON(directoruri)
        .done(function (data) {
            $('#inputDirectors option').remove();

            $.each(data, function (index, director) {
                $(createOption(director)).appendTo($('#inputDirectors'));
            });
        });
};

function createOption(director) {
    return '<option value="' + director.DirectorID + '">' + director.FirstName + ' ' + director.LastName + '</option>';
}

$(document).ready(function () {
    $('#btnShowAddDirector').click(function () {
        $('#addDirectorModal').modal('show');
    });

    $('#btnSaveDirector').click(function () {
        var director = {};

        director.FirstName = $('#directorfirstName').val();
        director.LastName = $('#directorlastName').val();

        $.post(directoruri, director)
            .done(function () {
                loadDirectors();
                $('#addDirectorModal').modal('hide');
            })
            .fail(function (jqXhr, status, err) {
                alert(status + ' - ' + err);
            });
    });
});
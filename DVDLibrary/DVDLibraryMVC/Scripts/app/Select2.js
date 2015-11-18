$(document).ready(function () {
   
    $('.mselect').select2();

    $('#resetBtn').click(function() {
        $('#inputActors').select2('val', 'All');
        $('#inputDirectors').select2('val', 'All');
    });
});
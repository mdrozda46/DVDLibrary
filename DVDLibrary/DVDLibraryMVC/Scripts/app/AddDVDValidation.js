$(document).ready(function() {
    $('#AddDVDForm').validate({
        rules: {
            Title: {
                required: true
            },
            DateReleased: {
                required: true
            },
            MPAARatings: {
                required: true
            },
            Genres: {
                required: true
            },
            RunTime: {
                required: true
            },
            directorForm: {
                required: true
            },
            Studios: {
                required: true
            },
            Synopsis: {
                required: true
            },
            Ratings: {
                required: true
            },
            Copies: {
                required: true
            },
            ImageURL: {
                required: true
            }
        }
    });
});
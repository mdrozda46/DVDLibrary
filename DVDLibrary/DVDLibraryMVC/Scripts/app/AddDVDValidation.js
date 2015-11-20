$(document).ready(function() {
    $('#AddDVDForm').validate({
        rules: {
            Title: {
                required: true,
                maxlength: 30
            },
            DateReleased: {
                required: true,
                date: true
            },
            MPAARatingID: {
                required: true
            },
            GenreID: {
                required: true
            },
            RunTime: {
                required: true,
                digits: true,
                maxlength: 3
            },
            DirectorID: {
                required: true
            },
            ActorID: {
                required: true
            },
            StudioID: {
                required: true
            },
            Synopsis: {
                required: true,
                maxlength: 2000
            },
            OwnerRatingID: {
                required: true
            },
            Copies: {
                required: true,
                digits: true
            },
            ImageURL: {
                required: true,
                maxlength: 1000
            }
        }
    });
});
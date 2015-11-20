$(document).ready(function() {
    $('#AddDVDForm').validate({
        rules: {
            Title: {
                required: true
            },
            DateReleased: {
                required: true
            },
            MPAARatingID: {
                required: true
            },
            GenreID: {
                required: true
            },
            RunTime: {
                required: true,
                digits: true
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
                required: true
            },
            OwnerRatingID: {
                required: true
            },
            Copies: {
                required: true,
                digits: true
            },
            ImageURL: {
                required: true
            }
        }
    });
});
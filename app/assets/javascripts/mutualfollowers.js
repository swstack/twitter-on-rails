spinner = null;


function startLoading () {
    target = document.getElementById('loading-overlay');
    spinner.spin(target);
    $('#loading-overlay').addClass('loading-overlay')
}

function stopLoading () {
    spinner.stop();
    $('#loading-overlay').removeClass('loading-overlay')
}

function findMutualFollowersCallback(data) {
    var template = Handlebars.compile($('#dyn-followers').html());
    $("#user-followers-body").html(template({followers: data.user_followers}));
    $("#mutual-followers-body").html(template({followers: data.mutual_followers}));
    $("#target-followers-body").html(template({followers: data.target_followers}));
    stopLoading();
}

function findMutualFollowersErrback(err) {
    stopLoading();
}

$(document).ready(function () {
    $('.tooltip').tooltipster({
        minWidth: 20,
        minHeight: 20
    });

    $('#btn-find').click(function () {
        target_screenname = $('#input-screenname');
        if (target_screenname) {
            $.ajax({
                method: "GET",
                url: "/mutualfollowers/find?screen_name=" + target_screenname.val(),
                success: findMutualFollowersCallback,
                error: findMutualFollowersErrback,
                dataType: "json"
            })
            startLoading();
        }
    });

    var opts = {
        lines: 13, // The number of lines to draw
        length: 20, // The length of each line
        width: 10, // The line thickness
        radius: 30, // The radius of the inner circle
        corners: 1, // Corner roundness (0..1)
        rotate: 0, // The rotation offset
        direction: 1, // 1: clockwise, -1: counterclockwise
        color: '#000', // #rgb or #rrggbb or array of colors
        speed: 1, // Rounds per second
        trail: 60, // Afterglow percentage
        shadow: false, // Whether to render a shadow
        hwaccel: false, // Whether to use hardware acceleration
        className: 'spinner', // The CSS class to assign to the spinner
        zIndex: 2e9, // The z-index (defaults to 2000000000)
        top: '50%', // Top position relative to parent
        left: '50%' // Left position relative to parent
    };
    spinner = new Spinner(opts);

});





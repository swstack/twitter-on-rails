function findMutualFollowersCallback(data) {
    console.log(data)
}


function findMutualFollowersErrback(err) {
    console.log(err)
}


$(document).ready(function () {
    $('#tt-in').tooltip({title: 'Enter Twitter Screen name'})

    $('#btn-find').click(function () {
        target_screenname = $('#input-screenname');
        if (target_screenname) {
            $.ajax({
                method: "GET",
                url: "/mutualfollowers/find?screen_name=" + target_screenname.val(),
                success: findMutualFollowersCallback,
                dataType: "json"
            })
        }
    });

});





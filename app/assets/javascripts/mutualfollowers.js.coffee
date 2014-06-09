findMutualFollowersCallback = (data) ->
  console.log(data)

findMutualFollowersErrback = (err) ->
  console.log(err)


$(document).ready(() ->
  $('#tt-in').tooltip({title: 'Enter Twitter Screen name'})

  $('#btn-find').click(() ->
    target_screenname = $('#input-screenname');
    if target_screenname
      $.ajax({
        method: "GET",
        url: "/mutualfollowers/find?screen_name=" + target_screenname.val(),
        success: findMutualFollowersCallback,
        dataType: "json"
      })
    else
  )
)
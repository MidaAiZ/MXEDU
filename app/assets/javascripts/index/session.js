// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
	var $phone = $("#phone"),
		$code = $("#code");
	$code.on("click", function() {
		if($phone.val().length != 11) return false;
		$.ajax({
			url: "/send_msg",
			type: "post",
			data: {
				"phone": $phone.val(),
				"handle": "login"
			},
			dataType: "json",
			success: function(res) {
				if (res.code == 'Success') {
					$code.addClass("disabled");
					var time = 60;
					$code.text("60s");
					var i = setInterval(function() {
						$code.text(--time + 'S');
						if (time == 0) {
							$code.removeClass("disabled");
							$code.text("重新发送");
							clearInterval(i);
						}
					}, 1000)
				}
			},
			error: function() {
				alert("发送失败,请稍后尝试");
			}
		})
	})
});

$(function(){
	$("#login").on("click", function() {
		$.ajax({
			url: "/login",
			type: "post",
			data: $("#login-form").serialize(),
			dataType: "json",
			success: function(res) {
				if (res.code == 'Success') {
					if (window.location.pathname = '/login') {
						window.location = "/"
					} else {
						window.location.reload();
					}
				} else if (res.code == 'WrongMsgCode') {
					alert("验证码错误")
				} else {
					alert("登录失败")
				}
			},
			error: function() {
				alert("登录失败,请稍后尝试");
			}
		})

		return false;
	})
});

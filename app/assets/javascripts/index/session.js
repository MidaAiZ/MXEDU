// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
	var $phone = $("#phone"),
		$code = $("#code");
	$code.on("click", function() {
		if($phone.val().length != 11) {
			alert("请填写正确的手机号");
			return false;
		}
		$code.addClass("disabled").text("发送中...");
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
					$code.attr("disabled", "true");
					var time = 60;
					$code.text(time + "S");
					var i = setInterval(function() {
						$code.text(--time + 'S');
						if (time == 0) {
							$code.removeClass("disabled");
							$code.text("重新发送");
							clearInterval(i);
						}
					}, 1000)
				} else {
					$code.removeClass("disabled").text("获取验证码");
					alert("发送失败,请稍后尝试");
				}
			},
			error: function() {
				$code.removeClass("disabled").text("获取验证码");
				alert("发送失败,请稍后尝试");
			}
		})
	})
});

$(function(){
	$("#login").on("click", function() {
		$(this).attr("disabled", true).html("<small>登录中...</small>");
		$.ajax({
			url: "/login",
			type: "post",
			data: $("#login-form").serialize(),
			dataType: "json",
			success: function(res) {
				if (res.code == 'Success') {
					window.location = res.url
				} else if (res.code == 'WrongMsgCode') {
					alert("验证码错误")
				} else {
					alert("登录失败")
				}
			},
			error: function() {
				alert("登录失败");
			},
			complete: function() {
				$("#login").removeAttr("disabled", true).html("<i class='fa fa-check'></i>");
			}
		})

		return false;
	})
});

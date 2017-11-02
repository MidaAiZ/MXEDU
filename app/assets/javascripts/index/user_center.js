//= require ../share/crop

// 修改头像
$(function() {
    //文件上传
    $('#subcrop').on("click", function() {
        uploadCrop("/users/update/avatar", avatarCB, "POST");
    });

	function avatarCB(res) {
		$("#userAvatar, .u-avatar").attr("src", res.avatar.url)
	}
})

// 修改密码
$(function() {
    $("#user_pwd").on("input propertychange", function() {
        var $this = $(this);
        if (/^([a-zA-Z0-9]|[._,@]){8,16}$/.test($this.val())) {
            $("#pwd-tip").text("");
        }
    });

    $("#user_pwd").on("blur", function() {
        var $this = $(this);
        if (!$this.val().length) return;
        if (!(/^([a-zA-Z0-9]|[._,@]){8,16}$/.test($this.val()))) {
            $("#pwd-tip").text("密码不符合要求")
        }
    })

    $("#pwd-form").on("submit", function(e) {
        e.preventDefault();
        var $form = $(this);
        $.ajax({
            url: $form.attr("action"),
            data: $form.serialize(),
            dataType: "JSON",
            type: "PUT",
            success: function(data) {
                $("#pwdModal").modal("hide");
            },
            error: function(err) {
                $("#pwd-tip").text("修改失败");
            }
        })
        return false;
    })
})

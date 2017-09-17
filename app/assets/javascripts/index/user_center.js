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

//= require ../share/posts
//= require ../share/lightbox

$(function() {
	$("#post_form").on("submit", function(e) {
		e.preventDefault()
		return false;
	});

	$("#post_submit").on("click", function() {
		$("#post_submit").attr("disabled", true).val("请稍候...")

		if ($("#img-pane .fileBoxUl").find("li.diyUploadHover").length > 0) {
			return false;
		}
		submitPost();
	})

	if ($("#post-content").html() && $("#post-content").html().trim() != "") $("#post_submit").removeAttr("disabled");
	$("#post-content").on("input", function() {
		if ($(this).html()) $("#post_submit").removeAttr("disabled");
		if (!$(this).html()) $("#post_submit").attr("disabled", true);
	})

	$("#img-pane").on("click", ".diyDel", function() {
		var $imgInput = $("#post_images");
		var val = $imgInput.data("value");
		if (!val || typeof(val) != "object") val = {};
		delete(val[$(this).data("img-id")])
		$imgInput.data("value", val);
		$(this).parents("li").remove();
	})

	$("#open-img-btn").on("click", function() {
		$("#img-upload").find("input[type=file]").trigger("click");
	})
})

function submitPost(url) {
	var $form = $("#post_form");
	var url = "/posts";
	if ($form.data("post-id")) url += ("/" + $form.data("post-id"));
	var type = $form.data("post-id") ? "PATCH" : "POST"
	// var fd = new FormData($form[0]);
	$.ajax({
		url: url,
		type: type,
		dataType: "JSON",
		data: {
			"post[content]": $form.find("#post-content").html(),
			"post[images]": $form.find("#post_images").data("value")
		},
		// contentType: false,
		// processData: false,
		success: function(data) {
			window.location = "/posts/" + data.id
		},
		error: function(error) {
			$("#post_submit").removeAttr("disabled").val("发表")
		}
	})
}

// $("#img_input").on("change",function(){
// 	var objUrl = getObjectURL(this.files[0]) ; //获取图片的路径，该路径不是图片在本地的路径
// 	if (objUrl) {
// 		$("#img-pane").append("\
// 			<img src=" + objUrl + " style='width: 200px;'>\
// 		")
// 		var $imgForm = $("#image_form");
// 		console.log($(this)[0].files)
// 		var fd = new FormData($imgForm[0])
// 		$.ajax({
// 			url: $imgForm.attr("action"),
// 			type: "POST",
// 			dataType: "JSON",
// 			data: fd,
// 			contentType: false,
// 			processData: false,
// 			success: function(data) {
// 				console.log(data);
// 			},
// 			error: function(error) {
// 				console.log(error);
// 			}
// 		})
// 	}
// });

//建立一个可存取到file的url
// function getObjectURL(file) {
// 	var url = null ;
// 	if (window.createObjectURL!=undefined) { // basic
// 	url = window.createObjectURL(file) ;
// 	} else if (window.URL!=undefined) { // mozilla(firefox)
// 	url = window.URL.createObjectURL(file) ;
// 	} else if (window.webkitURL!=undefined) { // webkit or chrome
// 	url = window.webkitURL.createObjectURL(file) ;
// 	}
// 	return url ;
// }

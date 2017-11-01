//= require ../share/lightbox
$(function() {
	$("[role=post-top]").click(function() {
		var $this = $(this);
		$.ajax({
			url: $this.data("href"),
			type: $this.data("method"),
			dataType: "json",
			success: function() {
				if ($this.data("method") == "post") {
					$this.text("取消置顶").data("method", "delete");
					$this.parents(".opt-menu").after('\
						<div class="pull-right top-pane">\
							<label class="label label-success p-top">置顶</label>\
						</div>\
					')
				} else {
					$this.text("置顶").data("method", "post");
					$this.parents(".opt-menu").siblings(".top-pane").remove();
				}
			}
		})
	})
	$("body").on("click", ".img-more", function() {
		location = $(this).data("url");
	})
})


//= require ../share/posts
//= require ../share/lightbox
//= require ../share/tagsinput-init

$(function() {
	$("#post_form").on("submit", function(e) {
		e.preventDefault()
		return false;
	});

	$("#post_submit").on("click", function() {
		$("#post_submit").attr("disabled", true).val("请稍候...")
		showLoading("发表中...");

		if ($("#img-pane .fileBoxUl").find("li.diyUploadHover").not("[error]").length > 0) {
			return false;
		}
		submitPost();
	})

	if ($("#post-content").html() && $("#post-content").html().trim() != "") $("#post_submit").removeAttr("disabled");
	$("#post-content").on("input", function() {
		if ($(this).html() && $(this).text().trim().length) $("#post_submit").removeAttr("disabled");
		if (!$(this).html()) $("#post_submit").attr("disabled", true);
	})

	$("#img-pane").on("click", ".diyDel", function() {
		var $imgInput = $("#post_images");
		var val = $imgInput.data("value");
		if (!val || typeof(val) != "object") val = {};
		delete(val[$(this).data("img-id")])
		$imgInput.data("value", val);
		$(this).parents("li").remove();
		console.log(val);
	})

	$("#open-img-btn").on("click", function() {
		$("#img-upload").find("input[type=file]").trigger("click");
	})
})

function submitPost(url) {
	var $form = $("#post_form");
	if ($("#img-pane .fileBoxUl").find("[error]").length > 0) {
		hideLoading();
		alert("请移除上传失败的图片");
		$("#post_submit").removeAttr("disabled").val("重新发表");
		 return false;
	}

	var url = "/manage/posts";
	if ($form.data("post-id")) url += ("/" + $form.data("post-id"));
	var type = $form.data("post-id") ? "PATCH" : "POST"
	// var fd = new FormData($form[0]);
	$.ajax({
		url: url,
		type: type,
		dataType: "JSON",
		data: {
			"post[content]": $form.find("#post-content").html().trim(),
			"post[images]": getImages(),
			"post[tag]": getTags(),
			"post[title]": getTitle(),
			"post[readtimes]":$("#read_input").val(),
			"post[thumbs_count]": $("#thumb_input").val()
		},
		// contentType: false,
		// processData: false,
		success: function(data) {
			window.location = "/manage/posts/" + data.id +"?back=-2"
		},
		error: function(error) {
			hideLoading();
			alert("系统繁忙，发表失败");
			$("#post_submit").removeAttr("disabled").val("重新发表")
		}
	})
}

function getImages() {
	var $imgs = $("#post_images");
	var imgsObj = $imgs.data("value");
	if (imgsObj && typeof(imgsObj) == 'object') {
		for (var i in imgsObj) {
			if (!i.trim().length) {
				delete imgsObj[i]
			}
		}
		return imgsObj
	}
}

function getTitle() {
	var $title = $("#post_title");
	if ($title.val() && $title.val.length) {
		return $title.val();
	}
}

function getTags() {
	var $tag = $("#tags_input");
	if ($tag.val() && $tag.val.length) {
		return $tag.val();
	}
}

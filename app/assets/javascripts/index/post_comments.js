//= require ../share/lightbox

$(function() {
	$("#comment_form").on("submit", function(e) {
		e.preventDefault()
		return false;
	});

	$("#comment_submit").on("click", function() {
		if ($("#img-pane .fileBoxUl").find("li.diyUploadHover").length > 0) {
			return false;
		}
		submitPost();
	})

	if ($("#comment-content").html()) $("#comment_submit").removeAttr("disabled");
	$("#comment-content").on("input", function() {
		if ($(this).html()) $("#comment_submit").removeAttr("disabled");
		if (!$(this).html()) $("#comment_submit").attr("disabled", true);
	})

	$("#img-pane").on("click", ".diyDel", function() {
		var $imgInput = $("#comment_images");
		var val = $imgInput.data("value");
		if (!val || typeof(val) != "object") val = {};
		delete(val[$(this).data("img-id")])
		$imgInput.data("value", val);
		console.log(val);
		$(this).parents("li").remove();
	})

	$("#open-img-btn").on("click", function() {
		$("#img-upload").find("input[type=file]").trigger("click");
	})
})

function submitPost(url) {
	var $form = $("#comment_form");
	var url = $form.attr("action");
	// var fd = new FormData($form[0]);
	$.ajax({
		url: url,
		type: "POST",
		dataType: "JSON",
		data: {
			"comment[content]": $form.find("#comment-content").html(),
			"comment[images]": $form.find("#comment_images").data("value")
		},
		// contentType: false,
		// processData: false,
		success: function(data) {
			window.location = "/posts/" + data.post_id
		},
		error: function(error) {

		}
	})
}
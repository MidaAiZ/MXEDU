$(function() {
	$("body").on("click", "[role=thumb]", function() {
		if ($(this).hasClass("active")) {
			thumbCancel($(this));
		} else {
			thumbUp($(this));
		}
	})

	$("body").on("click", "[role=comment]", function() {
	})
})

function thumbUp($ele) {
	$.ajax({
		url: $ele.data("action"),
		type: "POST",
		dataType: "JSON",
		success: function() {
			var val = $ele.siblings("span").text();
			if (!val || val == '') val = 0;
			$ele.siblings("span").text(parseInt(val) + 1)
			$ele.removeClass("fa-thumbs-o-up").addClass("active fa-thumbs-up");
		}
	})
}

function thumbCancel($ele) {
	if (!$ele.hasClass("active")) return false
	$.ajax({
		url: $ele.data("action"),
		type: "delete",
		dataType: "JSON",
		success: function() {
			var val = $ele.siblings("span").text();
			$ele.siblings("span").text(parseInt(val) - 1)
			$ele.removeClass("fa-thumbs-up active").addClass("fa-thumbs-o-up");
		}
	})
}

function commentPost() {

}

function commentCmt() {

}

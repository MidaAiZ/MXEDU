
function filesize(size) {
  var string;
  if (size >= 100000000000) {
	size = size / 100000000000;
	string = "TB";
  } else if (size >= 100000000) {
	size = size / 100000000;
	string = "GB";
  } else if (size >= 100000) {
	size = size / 100000;
	string = "MB";
  } else if (size >= 100) {
	size = size / 100;
	string = "KB";
  } else {
	size = size * 10;
	string = "b";
  }
  return ((Math.round(size) / 10) + string);
};

$(function() {
	$(".size").each(function() {
		$(this).text(filesize($(this).text()));
	})

	$(".dload").on("click", function() {
		var $form = buildForm();
		$form.attr("action", $(this).data("src"))
		$form.attr("method", "get");
		$form.trigger("submit");
	})
})// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
    $("#matSearch").on("submit", function(e) {
        e.preventDefault();
        var $this = $(this);
        var value = $this.find("input").val();
        if (value)
            window.location = window.location.pathname + encodeURI('?search=true&cdts=false&school=NONE&name=' + value + '&tag=' + value);
        else
            alert("请输入搜索关键词!");
        return false;
    });

    if(getQueryString("name")) {
        $("#matSearch").find("input").attr("placeholder", getQueryString("name"));
    }
})

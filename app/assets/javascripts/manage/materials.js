//= require ios-switch/switchery
//= require ios-switch/ios-init

$(function() {
	$("#del").click(function() {
		var f = confirm("确定要删除该产品吗?");
        if (f == false) {
            return;
        }

		$("#del-material").trigger("submit")
	})

	// 评星
	$(".recom.editable").on("click", ".fa-star", function() {
		var $this = $(this);
		$this.prevAll().andSelf().addClass("active").end().end().nextAll().removeClass("active");
		$("#material_recommend").val($this.index() + 1);
	})

})

$(function() {
	var type = getQueryString('type');
	if (!type) type = 'all';
	$("#filters").find("li[data-type=" + type + "]").addClass("active");
})


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
})

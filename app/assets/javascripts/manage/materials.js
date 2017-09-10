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

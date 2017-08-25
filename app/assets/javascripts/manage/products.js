// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
	$("#btn-show-table").click(function() {
		$(".show-table").show();
		$(".show-block").hide();
		$(this).addClass("active").siblings().removeClass("active");
	})
	$("#btn-show-block").click(function() {
		$(".show-block").show();
		$(".show-table").hide();
		$(this).addClass("active").siblings().removeClass("active");
	})

	$("#del").click(function() {
		var f = confirm("确定要删除该产品吗?");
        if (f == false) {
            return;
        }

		$("#del-product").trigger("submit")
	})
})

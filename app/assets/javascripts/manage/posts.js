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
})

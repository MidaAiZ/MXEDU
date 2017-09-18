//= require tags-input/tagsinput.min
//= require share/tagsinput-init

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

	// 评星
	$(".recom.editable").on("click", ".fa-star", function() {
		var $this = $(this);
		$this.prevAll().andSelf().addClass("active").end().end().nextAll().removeClass("active");
		$("#product_recommend").val($this.index() + 1);
	})

})

$(function() {
	var type = getQueryString('type');
	if (!type) type = 'all';
	$("#filters").find("li[data-type=" + type + "]").addClass("active");
})

function onAddTag(tag) {
    alert("添加标签" + tag);
}
function onRemoveTag(tag) {
    alert("删除标签 " + tag);
}

function onChangeTag(input,tag) {
    alert("修改标签 " + tag);
}

$(function() {
    $('#tags_input').tagsInput({width:'auto'});
});

$(function() {
    $("#proSearch").on("submit", function(e) {
        e.preventDefault();
        var $this = $(this);
        var value = $this.find("input").val();
        if (value)
            window.location = window.location.pathname + '?name=' + value + '&tag=' + value;
        else
            window.location = window.location.pathnames;
        return false;
	})

	if(getQueryString("name")) {
		$("#proSearch").find("input").attr("placeholder", getQueryString("name"));
	}
})

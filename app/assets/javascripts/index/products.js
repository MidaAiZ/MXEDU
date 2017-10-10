
$(function() {
	// var type = getQueryString('type');
	// if (!type) type = 'all';
	// $("#filters").find("li[data-type=" + type + "]").addClass("active");
})

$(function() {
    $("#proSearch").on("submit", function(e) {
        e.preventDefault();
        var $this = $(this);
        var value = $this.find("input").val();
        if (value)
            window.location = window.location.pathname + encodeURI('?search=true&cdts=false&school=NONE&name=' + value + '&tag=' + value);
        else
            alert("请输入搜索关键词!");
        return false;
	})

	if(getQueryString("name")) {
		$("#proSearch").find("input").attr("placeholder", getQueryString("name"));
	}
})

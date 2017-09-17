//= require share/tagsinput-init

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
            window.location = '/products?school=NONE&name=' + value + '&tag=' + value;
        else
            window.location = '/products?school=NONE';
        return false;
	})

	if(getQueryString("name")) {
		$("#proSearch").find("input").attr("placeholder", getQueryString("name"));
	}
})

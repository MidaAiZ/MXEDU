//  条件选择器

$(function() {
	$(".cdts").on("click", "li a", function() {
		var search = location.search;
		if (!search) search = "?";
		var $this = $(this);
		if ($this.parent("li").hasClass("active")) {
			$this.parent("li").removeClass("active");
		} else {
			$this.parent("li").addClass("active").siblings().removeClass("active");
		};
		search = changeQuery(search);
		doSearch(search);
	})

	function changeQuery(search) {
		var cons = [];
		var $conE = $("#cdts").find("li.con-item");
		$conE.each(function(ele) {
			var $this = $(this);
			if ($this.siblings("li.active").length != 0) {
				cons.push([$this.data("name"), $this.siblings("li.active").find("a").data("value")]);
			} else {
				cons.push([$this.data("name"), null]);
			}
		})
		for(var i in cons) {
			search = replaceQuery(search, cons[i][0], cons[i][1]);
		}
		return search;
	}

	function replaceQuery(search, name, value) {
		var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
		var r = search.substr(1).match(reg);
		if (r) {
			if (!value) return search.replace(reg, "");
			search.replace(reg, name + "=" + value);
		} else if (value) {
			if (search.length == 1) {
				search += (name + "=" + value);
			} else {
				search += ("&" + name + "=" + value);
			}
		}
		return search;
	}

	function doSearch(search) {
		$.ajax({
			url: location.pathname + search,
			type: "GET",
			success: function(res) {
				$("body").find("#pjax-replace").replaceWith($(res).find("#pjax-replace"));
				$('.tooltips').tooltip();
			},
			error: function(err) {

			}
		})
	}
})

// 禁止分页默认事件
$(function() {
	$("body").on("click", ".pagination li a", function(e) {
		e.preventDefault();
		$.ajax({
			url: $(this).attr("href"),
			type: "GET",
			success: function(res) {
				$("body").find("#pjax-replace").replaceWith($(res).find("#pjax-replace"));
				$('.tooltips').tooltip();
			},
			error: function(err) {

			}
		})
	})
})

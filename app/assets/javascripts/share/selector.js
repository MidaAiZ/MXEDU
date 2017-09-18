//= require share/pjax
//  条件选择器

$(function() {
	$(".cdts").on("click", "li a", function(e) {
		e.preventDefault();
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
		return search.replace(/&$/, "").replace(/&{2,}/, "&");
	}

	function replaceQuery(search, name, value) {
		var reg = new RegExp(name +"=([^&]*)");
		var r = search.substr(1).match(reg);
		if (r) {
			if (!value) return search.replace(reg, "");
			return search.replace(reg, name + "=" + value);
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
		var url = location.pathname + search;
		$.pjax({
			url: url,
			type: "GET",
			container: "#pjax-replace",
			success: function(res) {
				sucBK(res, url)
			},
			error: errBK
		})
	}
})

// 禁止分页默认事件
$(function() {
	$("body").on("click", ".pagination li a", function(e) {
		e.preventDefault();
		var url = $(this).attr("href");
		$.pjax({
			url: url,
			type: "GET",
			container: "#pjax-replace",
			success: function(res) {
				sucBK(res, url)
			},
			error: errBK
		})
	})
})

function sucBK(res, url) {
	$("body").find("#pjax-replace").replaceWith($(res).find("#pjax-replace"));
	$('.tooltips').tooltip();
}

function errBK(err) {
	alert("加载失败!");
}

$(function() {
	var search = window.location.search.substr(1);
	var arr = search.split("&");
	var cons = [];
	var arg = [];
	for (var i in arr) {
		if (arr[i] != "") {
			arg = arr[i].split("=");
			cons.push([arg[0], arg[1]]);
		}
	}

	for (var i in cons) {
		$(".con-item[data-name=" + decodeURI(cons[i][0]) + "]")
			.parent().find("[data-value=" + decodeURI(cons[i][1]) + "]")
			.parent().addClass("active");
	}

	if ($("#cdts").find("li.active").length != 0) {
		$(".cdts-panel .tools .fa-chevron-down").trigger("click");
	}
})

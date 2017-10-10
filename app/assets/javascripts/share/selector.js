//= require share/pjax
//= require cdtSelector/cdtSelect

//  条件选择器

$(function() {
	$(".cdts").on("click", "li a[data-role=opt]", function(e) {
		e.preventDefault();
		var search = location.search;
		if (!search) search = "?";
		var $this = $(this);
		if ($this.parent("li").hasClass("active")) {
			$this.parent("li").removeClass("active");
		} else {
			$this.parent("li").addClass("active").siblings().removeClass("active");
			$this.parent("li").parent().find(".cdt-info span").remove();
		};
		search = changeQuery(search);
		doSearch(search);
	})
})

function changeQuery(search) {
	var cons = [];
	var $conE = $("#cdts").find("li.con-item");
	$conE.each(function(ele) {
		var $this = $(this);
		if ($this.siblings("li.active").length != 0) {
			cons.push([$this.data("name"), $this.siblings("li.active").find("a").data("value")]);
		} else if ($this.parent().find(".cdt-info span").length == 0) {
			cons.push([$this.data("name"), null]);
		}
	})
	cons.push(["page", 0]) // 定位到第一页
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
		error: errBK,
		complete: completeBK
	})
}

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
	if ($.dataUpdatedCBs) {
		for (var i in $.dataUpdatedCBs) {
			$.dataUpdatedCBs[i](res);
		}
	}
}

function completeBK() {
	// TODO 以下代码适配上拉加载插件，耦合性较高
	if ($.myDropload) {
		$.dropLoadPage = 2;
		$.dropLoadUrl = location.pathname + location.search;
		$.myDropload.unlock();
		$.myDropload.noData(false);
		$.myDropload.resetload();
	}
}

function errBK(err) {
	console.log(err);
}

// 自定义查询
$(function() {
	$('.cdt-select').each(function() {
		var json = $(this).data("json");
		var hots = [];
		for (var i in json) {
			hots.push(json[i].name)
		}
		$(this).cdtSelect({
			dataJson: json,
			multiSelect: false,
			search: true,
			searchPlaceholder: $(this).data("placeholder"),
			hotcdt: hots,
			onInit: function () {
				// console.log(this)
			},
			onForbid: function () {
				// console.log(this)
			},
			onTabsAfter: function (target) {
				console.log(event)
			},
			onCallerAfter: function (target, values) {
				var $option = target.parents("li").siblings(".con-item");
				var search = location.search;
				if (!search) search = "?";
				search = replaceQuery(search, $option.data("name"), values.id);
				$option.siblings(".active").removeClass("active");
				doSearch(search);
			},
			onAjaxSearch: function(value, $ele) {
				var result = [];
				$.ajax({
					url: $ele.parents("li").siblings(".con-item").data("search-url") + "?name=" + encodeURI(value),
					type: "GET",
					async: false,
					success: function(data) {
						result = data;
					},
					error: function(err) {

					}
				})
				return result;
			}
		});
	})
})


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

	if ($("#cdts").find("li.active").length != 0 && getQueryString("cdts") != 'false' ) {
		$(".cdts-panel .tools .fa-chevron-down").trigger("click");
	}
})

// 数据加载成功后的回调
if (!$.dataUpdatedCBs) $.dataUpdatedCBs = {};
$.dataUpdatedCBs.tooltipInit = function() {
	$('.tooltips').tooltip();
}

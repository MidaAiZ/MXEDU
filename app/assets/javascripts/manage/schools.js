//= require 'data-tables/jquery.dataTables'
//= require 'data-tables/DT_bootstrap'

var EditableTable = function () {

    return {

        //main function to initiate the module
        init: function () {
			$("tbody").show();

            function restoreRow(oTable, nRow) {
                var aData = oTable.fnGetData(nRow);
                var jqTds = $('>td', nRow);

                for (var i = 0, iLen = jqTds.length; i < iLen; i++) {
                    oTable.fnUpdate(aData[i], nRow, i, false);
                }

                oTable.fnDraw();
            }

            function editRow(oTable, nRow, id) {
                var aData = oTable.fnGetData(nRow);
                var jqTds = $('>td', nRow);
                jqTds[0].innerHTML = '<input type="text" class="form-control small" value="' + aData[0] + '">';
                jqTds[1].innerHTML = '<input type="text" class="form-control small" value="' + aData[1] + '">';
                jqTds[2].innerHTML = '<input type="text" class="form-control small" value="' + aData[2] + '">';
                jqTds[3].innerHTML = '<input type="text" class="form-control small" value="' + aData[3] + '">';
                jqTds[7].innerHTML = '<a class="edit" href="">保存</a>';
				if (id) $(jqTds[7]).find("a.edit").attr("data-id", id);
                jqTds[8].innerHTML = '<a class="cancel" href="">取消</a>';
            }

            function saveRow(oTable, nRow, id) {
                var jqInputs = $('input', nRow);
				type = id ? 'PATCH' : "POST";
				url = id ? ('/manage/schools/' + id) : '/manage/schools';

				$.ajax({
					url:  url,
					data: {
						'school[name]': jqInputs[0].value,
						'school[city]': jqInputs[1].value,
						'school[cate]': jqInputs[2].value,
						'school[sign]': jqInputs[3].value
					},
					type: type,
					dataType: 'JSON',
					success: function(res) {
						oTable.fnUpdate(res.name, nRow, 0, false);
						oTable.fnUpdate(res.city, nRow, 1, false);
						oTable.fnUpdate(res.cate, nRow, 2, false);
						oTable.fnUpdate(res.sign, nRow, 3, false);
						oTable.fnUpdate('<a class="edit" href="" data-id=' + res.id + '>编辑</a>', nRow, 7, false);
						oTable.fnUpdate('<a class="delete" href="" data-id=' + res.id + '>删除</a>', nRow, 8, false);
						oTable.fnDraw();
					},
					error: function(err) {
						// for(var i in err) alert(err[i]);
                        if (id) {
                            alert("修改失败!");
                            cancelEditRow(oTable, nRow);
                        } else {
                            alert("创建失败!");
                            oTable.fnDeleteRow(nRow);
                        }
					}
				})
            }

            function cancelEditRow(oTable, nRow) {
                var jqInputs = $('input', nRow);
                oTable.fnUpdate(jqInputs[0].value, nRow, 0, false);
                oTable.fnUpdate(jqInputs[1].value, nRow, 1, false);
                oTable.fnUpdate(jqInputs[2].value, nRow, 2, false);
                oTable.fnUpdate(jqInputs[3].value, nRow, 3, false);
                oTable.fnUpdate('<a class="edit" href="">编辑</a>', nRow, 7, false);
                oTable.fnUpdate('<a class="delete" href="">删除</a>', nRow, 8, false);
                oTable.fnDraw();
            }

            var oTable = $('#editable-sample').dataTable({
                "aLengthMenu": [
                    [5, 15, 20, -1],
                    [5, 15, 20, "所有"] // change per page values here
                ],
                // set the initial value
                "iDisplayLength": 5,
                "sDom": "<'row'<'col-lg-6'l><'col-lg-6'f>r>t<'row'<'col-lg-6'i><'col-lg-6'p>>",
                "sPaginationType": "bootstrap",
                "oLanguage": {
                    "sLengthMenu": "_MENU_ 条记录/页",
                    "oPaginate": {
                        "sPrevious": "上一页",
                        "sNext": "下一页"
                    }
                },
                "aoColumnDefs": [{
                        'bSortable': false,
                        'aTargets': [0]
                    }
                ]
            });

            jQuery('#editable-sample_wrapper .dataTables_filter input').addClass("form-control medium"); // modify table search input
            jQuery('#editable-sample_wrapper .dataTables_length select').addClass("form-control xsmall"); // modify table per page dropdown

            var nEditing = null;

            $('#editable-sample_new').click(function (e) {
                e.preventDefault();
                var aiNew = oTable.fnAddData(['', '', '', '', '', '', '',
                        '<a class="edit" href="">编辑</a>', '<a class="cancel" data-mode="new" href="">取消</a>'
                ]);
                var nRow = oTable.fnGetNodes(aiNew[0]);
                editRow(oTable, nRow);
                nEditing = nRow;
            });

            $('#editable-sample').on('click', 'a.delete', function (e) {
                e.preventDefault();

                if (confirm("确定删除该条记录 ?") == false) {
                    return;
                }

				var nRow = $(this).parents('tr')[0];

				$.ajax({
					url: '/manage/schools/' + $(this).data("id"),
					type: 'delete',
					dataType: 'JSON',
					success: function(res) {
						oTable.fnDeleteRow(nRow);
					},
					error: function(err) {
						// for(var i in err) alert(err[i]);
                        alert("删除失败,该院校已绑定相关资源!");
					}
				})

            });

            $('#editable-sample').on('click', 'a.cancel', function (e) {
                e.preventDefault();
                if ($(this).attr("data-mode") == "new") {
                    var nRow = $(this).parents('tr')[0];
                    oTable.fnDeleteRow(nRow);
                } else {
                    restoreRow(oTable, nEditing);
                    nEditing = null;
                }
            });

            $('#editable-sample').on('click', 'a.edit', function (e) {
                e.preventDefault();

                /* Get the row as a parent of the link that was clicked on */
                var nRow = $(this).parents('tr')[0];

                if (nEditing !== null && nEditing != nRow) {
                    /* Currently editing - but not this row - restore the old before continuing to edit mode */
                    // restoreRow(oTable, nEditing);
                    editRow(oTable, nRow, $(this).data("id"));
                    nEditing = nRow;
                } else if (nEditing == nRow && this.innerHTML == "保存") {
                    /* Editing this row and want to save it */
					saveRow(oTable, nEditing, $(this).data("id"));
					nEditing = null;
                } else {
                    /* No edit in progress - let's start one */
					editRow(oTable, nRow, $(this).data("id"));
					nEditing = nRow;
                }
            });
        }

    };

}();

// = require bootstrap/carousel
// = require cropper

$(function() {
    $('.carousel').carousel({
        interval: 3000
    });

    // 移动轮播图

    $("[role=carousel-clt-control]").click(function() {
        buildForm().attr("action", $(this).data("href")).submit();
    });
    // 移除轮播图
    $("#rm-carousel, #reshow-carousel").click(function() {
        buildForm().attr("action", $(this).data("href")).submit();
    });
    // 删除轮播图
    $("#delete-carousel").click(function() {
        var $input = $(`<input type="hidden" name="_method" value="delete" />`);
        buildForm($input).attr("action", $(this).data("href")).submit();
    })

})

/**
 * 图片裁剪
 *
 */
var imageFile = $('#imagefile'),
    options = {
        //在这里改变裁剪框默认大小 删除即不制定裁剪比例
        aspectRatio: 5 / 2,
        preview: '.imgpreview',
        //the crop box should be within the canvas 0:后端补白
        viewMode: 1,
    };

//裁剪函数初始化
function croppics() {
    imageFile.cropper(options);
    //逆时针90度
    $('#lrotate').on("click", 'built.cropper', function() {
        imageFile.cropper('rotate', -90);
    });
    //顺时针90度
    $('#rrotate').on("click", 'built.cropper', function() {
        imageFile.cropper('rotate', 90);
    });
    //初始化还原
    $('#reset').on("click", 'built.cropper', function() {
        imageFile.cropper('reset');
    });
}

//图像裁剪
function imageCrop() {
    //判断上传文件是否具有可裁剪属性
    var crop = this.classList.contains("cropable");
    if (window.FileReader && crop) {
        var fileType = /^image\//;
        var files = this.files[0];
        if (fileType.test(files.type)) {
            var maxNameLength = 15;
            var name = files.name;
            //列出文件名 需要修改 比如一个中文字符等价于两个英文字符eg..
            if (name.length > maxNameLength) {
                $('#file-tip').text("已选择：" + name.slice(0, maxNameLength) + "...");
            } else {
                $('#file-tip').text("已选择：" + name);
            }
            var reader = new FileReader();
            reader.onload = function() {
                var url = reader.result;
                imageFile.attr("src", url);
                //动态替换图片
                imageFile.cropper('replace', url);
            }
            reader.readAsDataURL(this.files.item(0));
            $("[disabled='disabled']").trigger("haveImg");
        } else $('#file-tip').text("请上传正确格式图片!");
    }
}

function upLoader() {
    var croppedImage = imageFile.cropper("getCroppedCanvas");
    croppedImage.toBlob(function(image) {
        var fd = new FormData();
        fd.append($('meta[name=csrf-param]').attr('content'), $('meta[name=csrf-token]').attr('content'));
        fd.append('manage_carousel[image]', image);
        fd.append('manage_carousel[link]', $("input[role='add-link']").val())
        $.post({
            url: $("#subcrop").parents("form").attr("action"),
            data: fd,
            dataType: "json",
            processData: false,
            contentType: false,
            success: function(res) {
                window.location = res.target;
            },
            fail: function() {
                alert("编辑失败！")
            }
        })
    });
    return false
}

// 移动轮播图位置
function moveImgLocation() {
    var fd = new FormData();

    if ($(this).attr('role') === 'move-left') {
        fd.append('carousel[location]', 'advance');
    } else if ($(this).attr('role') === 'move-right') {
        fd.append('carousel[location]', 'back');
    } else {
        return false;
    }
    fd.append('carousel[id]', $(this).parents("li").data('carousel-id'))
    $.post({
        url: $("#subcrop").parents("form").attr("action"),
        data: fd,
        processData: false,
        contentType: false,
        success: function(res) {
            window.location = location;
        },
        fail: function() {
            alert("移动失败！")
        }
    })
}

$(function() {

    croppics();
    $('#inputFile').change(imageCrop);

    //监听表单提交并拦截 使用AJAX提交
    $("#subcrop").on("click", function() {
        return upLoader();
    });
    $("#subcrop").parents("form").submit(function() {
            return $("#imagefile").attr('src') ? upLoader() : false
        })
        //监听编辑器中是否含有图片，改变按钮状态
    if ($("#imagefile").attr('src')) {
        $("[disabled='disabled']").removeAttr("disabled")
            //如果是已经有图片则移除‘添加图片’的提示
        $(".img-bg").remove()

    } else {
        //判断按钮是否可用
        $("[disabled='disabled']").on('haveImg', function() {
            $(this).removeAttr("disabled")
                //顺带移除’添加图片'提示
            $(".img-bg").remove()
        })
    }

});

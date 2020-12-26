// Press F12 in Chrome and open console

// Remove follows
$(".be-dropdown-item:contains('取消关注')").click()

// Remove followers
var count = 0;
a = function () {
    $(".be-dropdown-item").each(function (a, b) {
        if ("移除粉丝" == b.innerHTML) {
            b.click();
            return false;
        }
    })
};
b = function () {
    $(".modal").each(function (a, b) {
        $c = $(b).find(".modal-title");
        if ($c[0].innerText == "确认移除粉丝") {
            console.log("正在删除粉丝:" + $(b).find("em").get(0).innerText);
            $(b).find(".btn-content").get(0).click()
        }
    });
};
function timeout() {
    setTimeout(function () {
        if (count % 2 == 0) {
            a();
        } else {
            b();
        };
        count++;
        timeout();
    },
        2100);
};
timeout();
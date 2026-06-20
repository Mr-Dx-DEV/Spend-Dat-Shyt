function Show(data) {
    $(".interaction-menu").html("");
    $(".interaction-menu").append("<span class='status-label'>"+data.text+"</span>");
    if (data.type == "error") {
        $(".interaction-menu").css({"background-color":"#fc2a2a"});
    }
    else if (data.type == "success"){
        $(".interaction-menu").css({"background-color":"#15ba07"});
    }
    else if (data.type == "warning"){
        $(".interaction-menu").css({"background-color":"#136cd1"});
    }
    $(".root-wrapper").animate({
        left: '-1vh',
        opacity: 1,
    }, 350);
}

function Hide() {
    $(".root-wrapper").animate({
        left: '-11vh',
        opacity: 0,
    }, 350, function() {
        $(".interaction-menu").html("");
    });
}

window.addEventListener("message", (evt) => {
    const data = evt.data
    const action = data.action
    switch (action) {
        case "showStatus":
            Show(data);
            break;
        case "hideStatus":
            Hide();
            break;
    }
})
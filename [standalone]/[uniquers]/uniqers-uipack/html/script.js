var currentIndex = 0
var totalItems = $('.item').length;
var screenFocus = false;
var totalItemsPerPage = 2; 
var totalPages = 0; 
var allData = [];
var lastData = [];
var colorArr = []
var color = "blue";
var page = {
  ["1"] : [1,2],
  ["2"] : [3,4],
  ["3"] : [5,6]
}
let nuiData = {}; // Tanımlama yapıldı

function FadeIn(Object, Timeout) {
    $(Object).fadeIn(Timeout).css('display', 'block');
}

function FadeOut(Object, Timeout) {
    $(Object).fadeOut(Timeout)
    setTimeout(function(){
        $(Object).css("display", "none");
    }, Timeout)
}

            function showInfo(text) {
				$('.drawinfo').css("display", "flex");
                $(".drawinfotext").fadeIn();
                $(".drawinfotext").html(text);
				setTimeout(function () {
				$(".drawinfo").addClass("expanded");
				}, 500);
            }

            // Sayfa açıldığında veya tetiklendiğinde çağırılabilir


window.onload = function (e) {
    window.addEventListener("message", function (event) {
        let e = event.data;
        switch (e.action) {
            case "open":
                return open(e.data, e.coords, e.dist, e.color, e.colorData);
            case "close":
                append = false;
                return $(".main").fadeOut(500);
            case "key":
                return changeItem(e.key);
			case "showNotification":
	            showNotification(e.image, e.title, e.message, e.duration, e.color);
                break;	
			case "showNotificationv2":
	            showNotificationv2(e.title, e.message, e.howto1, e.howto2, e.howto3, e.lasttext, e.duration);
                break;					
            case "drawInfo":
                let info = e.post;
				var text = info.text;
                showInfo(text);
                break;	
            case "closeInfo":
			   $(".drawinfotext").fadeOut();
                setTimeout(function(){				
                        $(".drawinfo").removeClass("expanded");
                }, 500);
				setTimeout(function(){	
				$('.drawinfo').fadeOut();
				}, 500);
                break;					
            case "drawText":
                let x = e.post;
                $(".press2 .text2").html(x.key);
                $(".index2 .text2").html(x.text);
                FadeIn(".text-container2", 200);
                break;
            case "changeText":
                $(".index2 .text2").html(e.post.text);
                break;
            case "drawTextUpdate":
                let x2 = e.post;
                $(".index2 .text2").html(x2.text);
                break;
            case "drawTextClose":
                FadeOut(".text-container2", 200);
                break;
case "drawTextPress":
    $(".text-container2 .press2, .text-container2 .index2")
        .css({
            "text-shadow": "0px 0px 20px #fff",
            "transform": "scale(1.1)", // Hafif büyütme efekti
            "transition": "all 0.1s ease-out"
        });

    setTimeout(function () {
        $(".text-container2 .press2, .text-container2 .index2")
            .css({
                "text-shadow": "0px 0px 0px #ffffff00",
                "transform": "scale(1)" // Normal boyuta dönme efekti
            });

        setTimeout(function () {
            FadeOut(".text-container2", 200);
        }, 50);
    }, 100);

                break;
            default:
                return;
        }
    });
};



append = false
function open(data,coords,distance,colour,colorData) {
  $('page-count').html("1");
  color = colour;
  colorArr = colorData;
  var bg = colorData["keybox"];
  var keyColor = colorData["color"];
  var border = colorData["border"];
  var background = colorData["background"];
  var iconcolor = colorData["iconcolor"];
  $('.loader').css({ 'background': bg, 'color': keyColor, 'border': border, 'box-shadow': `0 0 0 0 ${bg}` });
  $('.circledot').css({ 'border': border, 'filter' : colorData["filterShadow"]});
  $('.key-box').css({ 'background': bg , 'color' : keyColor, 'border' : border});
  $('.borderr').css({'border' : border , 'background': bg});
  $('.item-right i').css({'color' : iconcolor , 'filter' : colorData["filterShadow"]});
  if (distance < 1.5) {
    $('.right-box , .direction , .page-count').show();
    $('.key-box').html(`<div class="key-box-border"><div class="progress"></div></div>E`)
  }else{
    $('.right-box , .direction , .page-count').hide();
    $('.key-box').html(`<div class="key-box-border"><div class="progress"></div></div>E`)
  }
  $('.key-box-border').css({'background': colorData["progress"], 'box-shadow': `${colorData["progressshadow"]} 0px 0px 20px 6px`});
  if (distance <= 2) {
    $('.circledot').hide();
    $('.key-box').show();
  } else if (distance <= 4) {
    $('.circledot').show();
    $('.key-box').hide();
  } else {
    $('.circledot').hide();
    $('.key-box').hide();
  }
  totalPages = Math.ceil(data["item"].length / totalItemsPerPage);
      

  $(".main-box").css("top", coords.y-10 + "%");
  $(".main-box").css("left", coords.x + "%");
    // if (JSON.stringify(data) === JSON.stringify(lastData)) return;
    // lastData = data;

    if (append) return;

    allData = data;
    $('.right-box').empty();
    $.each(data["item"], function (index, value) {
        append = true;
        $('.right-box').append(`
        
        <div id="${index+1}" class="item">   
          <div class="item-right">
          <div class="square">
          <div class="borderr"></div>
          </div>
          <i id="${value.icon}" class="${value.icon}"></i>${value.name}</div>
        </div>

        `)
    });
    $('.item:not([id="1"]):not([id="2"])').hide();
    totalItems = $('.item').length;
    $('.main').fadeIn(500);
    append = true;
}

function resetStyles(index) {
    $('.item').eq(index).find('.item-right,.border,.square').css('background', 'rgba(181, 181, 181, 0.42)');
    $('.item').eq(index).find('.border,.item-right,.square').css('border', 'none')
    $('.item').eq(index).find('.borderr').css('display', 'none');
}

function applyStyles(index) {
  currentPage = Math.floor(index / totalItemsPerPage);

  $('.page-count')
    .attr('data-text', currentPage + 1) // before/after için
    .html(currentPage + 1)
    .addClass('glitch');

  // Glitch efektini geçici yapmak istersen class'ı kaldırabilirsin:
  setTimeout(() => {
    $('.page-count').removeClass('glitch');
  }, 200); // animasyon uzunluğuna göre ayarlanabilir

  bg = colorArr["backgroundhoverselect"];
  border = colorArr["borderhoverselect"];
  console.log(bg);

  $('.item').eq(index).find('.border, .item-right, .square').css('background', bg);
  $('.item').eq(index).find('.square').css('width', '12%');
  $('.item').eq(index).find('.square').css('height', '75%');

  $('.item').eq(index).find('.border, .item-right, .square').css('border', border);
  $('.item').eq(index).find('.borderr').css('display', 'block');

  $(".item").hide();

  $.each(page[currentPage + 1], function (index, value) {
    $("#" + value).show();
  });
}



function changeItem(direction) {
    resetStyles(currentIndex);
    if (direction == "down") {
        currentIndex = (currentIndex + 1) % totalItems;
        $('.down').css('color', 'rgb(1, 104, 76)');
        $('.up').css('color','rgb(255 ,255 ,255 ,0.7)')
        setTimeout(() => {
          $('.down').css('color','rgb(255 ,255 ,255 ,0.7)')
        }, 100);
        applyStyles(currentIndex);
    } else if (direction == "up") {
        currentIndex = (currentIndex - 1 + totalItems) % totalItems;
        $('.down').css('color', 'rgb(255 ,255 ,255 ,0.7)');
        $('.up').css('color','rgb(1, 104, 76)')
        setTimeout(() => {
          $('.up').css('color', 'rgb(255 ,255 ,255 ,0.7)');
        }, 100);
        applyStyles(currentIndex);
    } else if (direction == "enter") {
        $.post(`http://uniqers-uipack/enter`, JSON.stringify({currentIndex:currentIndex }), function (x) {});
    } else if (direction == "backspace") {
        $('.main').fadeOut(500);
    } else if (direction == "e") {
        screenFocus = true
        // $('.item-right,.border').css('background', 'rgb(53, 53, 53,0.29)');
        // $('.border,.item-right').css('border', ' 2px solid #353535')
    }
}

$(document).ready(function() {
  $('.right-box').on('mouseenter', '.item', function() {
    var $item = $(this);
    bg = colorArr["backgroundhoverselect"]
    border = colorArr["borderhoverselect"]
    leftBox = colorArr["keybox"]

    $item.find('.item-right, .border, .square').css({
      'background': bg ,
      'border': border
    });

    $item.find('.left-box').css('background', leftBox);
  });

  $('.right-box').on('mouseleave', '.item', function() {
    var $item = $(this);

    $item.find('.item-right, .border, .square').css({
      'background': '',
      'border': ''
    });

    $item.find('.left-box').css('background', '');
  });
});


$(document).on('click', '.item', function (e) {
  currentIndex = $(this).index();
  resetStyles(currentIndex)
  applyStyles(currentIndex);
  $.post(`http://uniqers-uipack/enter`, JSON.stringify({currentIndex:currentIndex }), function (x) {});
});

$(document).on('click', '.direction', function (e) {
  direction = $(this).data('direction');
  changeItem(direction);
});

$(document).on('keydown', function (e) {
  if (e.key == "Escape" || e.key == "Backspace" && screenFocus) {
    $.post(`http://uniqers-uipack/exit`, JSON.stringify({}), function (x) {});
  }
});






    function showNotification(image, title, message, duration, color) {
        const notification = $(
            `<div class="notification">
                <img style="background:${color};" src="${image}" alt="Icon">
				<div class="progress"></div>
                <div class="text">
                    <div class="title">${title}</div>
                    <div class="message" style="color:${color};">${message}</div>
                </div>
            </div>`
        );

        $('#notifications-container').append(notification);

        // Animate progress bar
        notification.find('.progress').animate({ height: '0%' }, duration, 'linear');

        // Remove notification after duration
        setTimeout(() => {
            notification.fadeOut(500, () => {
                notification.remove();
            });
        }, duration);
    }
	
function showNotificationv2(title, message, howto1, howto2, howto3, lasttext, duration) { 
    // Bildirim içeriği dinamik olarak oluşturulacak
    let howtosContent = "";
    if (howto1) howtosContent += `<div class="howto1">${howto1}</div>`;
    if (howto2) howtosContent += `<div class="howto2">${howto2}</div>`;
    if (howto3) howtosContent += `<div class="howto3">${howto3}</div>`;

    let lastTextContent = lasttext ? `<div class="lasttext">${lasttext}</div>` : "";

    const notification = $(`
        <div class="notificationv2">
            <div class="titlev2">${title}</div>
            <div class="messagev2">${message}</div>
            ${howtosContent ? `<div class="howtos">${howtosContent}</div>` : ""}
            ${lastTextContent}
            <div class="progress-wrapper">
                <div class="progressv2"></div>
            </div>
        </div>
    `);

    // Bildirimi ekle
    $('#notifications-containerv2').append(notification);

    // Progress bar animasyonu
    notification.find('.progressv2').css({ width: '100%' }).animate({ width: '0%' }, duration, 'linear');

    // Bildirimi belirli bir süre sonra kaldır
    setTimeout(() => {
        notification.fadeOut(500, () => {
            notification.remove();
        });
    }, duration);
}





	

var progbar = false

window.addEventListener('message', function(e) {
    
    if (e.data.message == "notify"){
       
        ShowNotif(e.data);
    }

    if (e.data.message == "progbar"){
        ProgBar(e.data);
    }

    if (e.data.message == "info"){
        $('.leftinfo').fadeIn(100);
        $('.leftinfo_top').html(e.data.toptext);
        $('.leftinfo_bottom').html(e.data.text);

        
        
    }

    if (e.data.message == "closeinfo"){
        $('.leftinfo').fadeOut(100);
      

        
        
    }
	
if (e.data.message == "info2") {
    $('.hintinfo').css({
        display: 'flex',
        opacity: 1
    }).animate({
        top: '1vh' // Yukarıdan aşağı iniyor
    }, 500);
    
    $('.hintinfo_bottom').html(e.data.text);

}

if (e.data.message == "closeinfo2") {
    $('.hintinfo').animate({
        top: '-20vh', // Geri yukarı çıkıyor
        opacity: 0
    }, 500, function() {
        $(this).css('display', 'none');
    });
}


    if (e.data.message == "info3"){
        $('.infomiddle').fadeIn(100);
		$('.infomiddle_top').html('<img class="imgmidicon" src="' + e.data.icon + '">');
        $('.infomiddle_top2').html(e.data.toptext);
        $('.infomiddle_bottom').html(e.data.text);

        
        
    }

    if (e.data.message == "closeinfo3"){
        $('.infomiddle').fadeOut(100);
      

        
        
    }
	
if (e.data.message == "payinfo") {
    $('.payday-container').css({
        display: 'block',
        opacity: 1
    }).animate({
        top: '1vh' // Yukarıdan aşağı iniyor
    }, 500);
    
    $('#jobname').html(e.data.money);
    $('.salary-breakdown').html(e.data.job);
}

if (e.data.message == "payclose") {
    $('.payday-container').animate({
        top: '-20vh', // Geri yukarı çıkıyor
        opacity: 0
    }, 500, function() {
        $(this).css('display', 'none');
    });
}	

    if (e.data.action === "showHUD") {
        let currentLevel = e.data.currentLevel;
        let progress = e.data.progress;
        let nextLevel = e.data.nextLevel;

        document.getElementById("current-level").innerText = currentLevel;
        document.getElementById("next-level").innerText = nextLevel;

        let progressDotsContainer = document.getElementById("progress-dots");
        progressDotsContainer.innerHTML = ""; // Önceki çubukları temizle

        let totalDots = 25; // Çubuk sayısı
        let filledDots = Math.round((progress / 100) * totalDots); // Dolması gereken çubuk sayısı

        // Çubukları ekle
        for (let i = 0; i < totalDots; i++) {
            let dot = document.createElement("div");
            dot.classList.add("dot");
            progressDotsContainer.appendChild(dot);

            // Çubukların tek tek dolması için gecikme ekle
            if (i < filledDots) {
                setTimeout(() => {
                    dot.classList.add("active");
                }, i * 100);
            }
        }

        let hud = document.getElementById("hudlevel");
        $("#hudlevel").css("display", "block");

        // 5 saniye sonra HUD'u gizle
        setTimeout(() => {
            $("#hudlevel").css("display", "none");
        }, 5000);
    }
	
if (e.data.message == "info4") {
    $('.inviteshud').fadeIn(100);
    $('#playerid').html(e.data.playerid);
    $('#textinvite').html(e.data.text);

    // NUI Verilerini Kaydet
    nuiData = {
        event: e.data.event,           // Gelen event verisini sakla
        eventParams: e.data.eventParams // Event parametrelerini sakla
    };
}

    if (e.data.message == "closeinfo5"){
        $('.inviteshud').fadeOut(100);       
    }

	
    
});

let holdTime = 3000; // 3 saniye
let holdY = 0, holdN = 0;
let yInterval, nInterval;

document.addEventListener("keydown", function (event) {
    if (event.key.toLowerCase() === "y") {
        if (!yInterval) {
            yInterval = setInterval(() => {
                holdY += 100;
                updateHoldEffect("y-hold", holdY);
                if (holdY >= holdTime) {
                    $.post("https://uniqers-uipack/acceptInvite", JSON.stringify({
                        event: nuiData.event || "",
                        eventParams: nuiData.eventParams || {}
                    }));
                    clearInterval(yInterval);
                    yInterval = null;
                    holdY = 0;
                    closeInviteUI();

                    // 🎯 Kullandıktan sonra sıfırla
                    nuiData = {};
                }
            }, 100);
        }
    }
    
    if (event.key.toLowerCase() === "n") {
        if (!nInterval) {
            nInterval = setInterval(() => {
                holdN += 100;
                updateHoldEffect("n-hold", holdN);
                if (holdN >= holdTime) {
                    $.post("https://uniqers-uipack/declineInvite", JSON.stringify({}));
                    clearInterval(nInterval);
                    nInterval = null;
                    holdN = 0;
                    closeInviteUI();

                    // 🎯 Kullandıktan sonra sıfırla
                    nuiData = {};
                }
            }, 100);
        }
    }
});



document.addEventListener("keyup", function(event) {
    if (event.key.toLowerCase() === "y") {
        clearInterval(yInterval);
        yInterval = null;
        holdY = 0;
        resetHoldEffect("y-hold");
    }
    if (event.key.toLowerCase() === "n") {
        clearInterval(nInterval);
        nInterval = null;
        holdN = 0;
        resetHoldEffect("n-hold");
    }
});

function updateHoldEffect(elementId, value) {
    let percentage = (value / holdTime) * 360;
    document.getElementById(elementId).querySelector('.progresskeyp').style.background = `conic-gradient(#fff ${percentage}deg, transparent ${percentage}deg)`;
}

function resetHoldEffect(elementId) {
    document.getElementById(elementId).querySelector('.progresskeyp').style.background = `conic-gradient(transparent 0deg, #ffffff21 0deg)`;
}

function closeInviteUI() {
    document.querySelector('.inviteshud').style.display = 'none';
}




function ProgBar(data) {
    if (progbar == false) {

    
        $('.progbarmain_2_item').removeClass('addhover');
        $('.progbarmain').fadeIn(200);

        $('.progbarmain_text').html(data.mtext);
        i = 0
        
        progbar = true;

        var count = $(".progbarmain_2_item").length;
        var speed = data.mtime/count;

        $(".progbarmain_2_item").each(function(index){
    
            $(this).delay(speed*index).queue(function(next){
              
              i = i + 1
              $('.progbarmain_yuzde').html((i*5)+"%");

              $(this).addClass('addhover');
              if (i == 20){
                progbar = false;
                $('.progbarmain').fadeOut(200);
                $.post('https://dr-uipack/FinishAction', JSON.stringify({}));

              }
              
             
              next();
            });
        });


    }

    
}

function CreateNotification(data) {
    
    let $notification = $(document.createElement('div'));
  
    if (data.ntype == "error"){
       $notification.html('<div class="notifymain_item"> <div class="notifymain_item_icon"> <svg style="margin-top: 2px; margin-left: 2px; opacity:0.3;" width="12px" height="12px" viewBox="0 0 512 512" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <title>cancel</title> <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"> <g id="work-case" fill="#000000" transform="translate(91.520000, 91.520000)"> <polygon id="Close" points="328.96 30.2933333 298.666667 1.42108547e-14 164.48 134.4 30.2933333 1.42108547e-14 1.42108547e-14 30.2933333 134.4 164.48 1.42108547e-14 298.666667 30.2933333 328.96 164.48 194.56 298.666667 328.96 328.96 298.666667 194.56 164.48"> </polygon> </g> </g> </svg> </div> <div class="notifymain_item_text">'+data.ntext+'</div> <div class="notifymain_item_time"> <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="11"> <defs> <linearGradient id="circle.progress.color"> <stop offset="0%" stop-color="red" /> <stop offset="100%" stop-color="#a74f55e1" /> </linearGradient> <filter id="shadow"> <feDropShadow dx=".4" dy=".4" stdDeviation="1" flood-color="red"/> </filter> </defs> <circle r="40" stroke="white" stroke-width="5" fill="none" transform="translate(50 50)" filter="url(#shadow)"/> <circle id="'+data.dataid+'" r="40" stroke="#a74f55e1" stroke-width="8" fill="none" pathLength="100" stroke-dasharray="0 100" transform="translate(50 50) rotate(-90)" stroke-linecap="round"/> </svg> </div> </div>')
  
    }
  
    if (data.ntype == "info"){
      $notification.html('<div class="notifymain_item2"> <div class="notifymain_item_icon2"> <svg style="margin-top: 0px; margin-left: 1.5px;"  width="25px" height="25px" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" fill="#44c3a3" class="bi bi-info"> <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/> </svg> </div> <div class="notifymain_item_text2">'+data.ntext+'</div> <div class="notifymain_item_time2"> <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="11"> <defs> <linearGradient id="circle.progress.color"> <stop offset="0%" stop-color="BlueViolet" /> <stop offset="100%" stop-color="MediumVioletRed" /> </linearGradient> <filter id="shadow"> <feDropShadow dx=".4" dy=".4" stdDeviation="1" flood-color="gray"/> </filter> </defs> <circle r="40" stroke="white" stroke-width="5" fill="none" transform="translate(50 50)" filter="url(#shadow)"/> <circle id="'+data.dataid+'" r="40" stroke="#1b6f5ef2" stroke-width="8" fill="none" pathLength="100" stroke-dasharray="0 100" transform="translate(50 50) rotate(-90)" stroke-linecap="round"/> </svg> </div> </div>')
   }
  
   if (data.ntype == "success"){
    $notification.html('<div class="notifymain_item3"> <div class="notifymain_item_icon3"> <svg style="margin-top: 3px; margin-left: 2.5px;" width="12px" height="12px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M4 12.6111L8.92308 17.5L20 6.5" stroke="white" stroke-width="5" stroke-linecap="round" stroke-linejoin="round"/> </svg> </div> <div class="notifymain_item_text">'+data.ntext+'</div> <div class="notifymain_item_time"> <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="11"> <defs> <linearGradient id="circle.progress.color"> <stop offset="0%" stop-color="BlueViolet" /> <stop offset="100%" stop-color="MediumVioletRed" /> </linearGradient> <filter id="shadow"> <feDropShadow dx=".4" dy=".4" stdDeviation="1" flood-color="gray"/> </filter> </defs> <circle r="40" stroke="white" stroke-width="5" fill="none" transform="translate(50 50)" filter="url(#shadow)"/> <circle id="'+data.dataid+'" r="40" stroke="#283047f0" stroke-width="8" fill="none" pathLength="100" stroke-dasharray="0 100" transform="translate(50 50) rotate(-90)" stroke-linecap="round"/> </svg> </div> </div>')
  }
   
  
    $notification.fadeIn();
    if (data.style !== undefined) {
        Object.keys(data.style).forEach(function(css) {
            $notification.css(css, data.style[css])
        });
    }
  
    return $notification;
}

function ShowNotif(data) {
    
    if (data.id != null) {
        if (notifs[data.id] === undefined) {
            let $notification = CreateNotification(data);
            $('.notifymain').append($notification);
            notifs[data.id] = {
                notif: $notification,
                timer: setTimeout(function() {
                    let $notification = notifs[data.id].notif;
                    $.when($notification.fadeOut()).done(function() {
                        $notification.remove();
                        clearTimeout(notifs[data.id].timer);
                        delete notifs[data.id];
                    });
                }, data.ntime != null ? data.ntime : 2500)
            };

            
        } else {
            clearTimeout(notifs[data.id].timer);
            // UpdateNotification(data);

            notifs[data.id].timer = setTimeout(function() {
                let $notification = notifs[data.id].notif;
                $.when($notification.fadeOut()).done(function() {
                    $notification.remove();
                    clearTimeout(notifs[data.id].timer);
                    delete notifs[data.id];
                });
            }, data.ntime != null ? data.ntime : 2500)
        }
    } else {
        let $notification = CreateNotification(data);
       
        $('.notifymain').append($notification);
        trythis(data.dataid, data.ntime)
        setTimeout(function() {
            $.when($notification.fadeOut()).done(function() {
                $notification.remove()
            });
        }, data.ntime != null ? data.ntime : 2500);
    }

   

}


function trythis(id, value) {
   

     const progress = document.getElementById(String(id));
  


    var progressKeyframes = new KeyframeEffect(
        progress, 
        [
            { strokeDasharray: '0 100' }, 
            { strokeDasharray: '100 100' }
        ], 
        { duration:Number(value), fill: 'forwards' }
        );

        
    var a1 = new Animation(progressKeyframes, document.timeline);
    a1.play();
    
    let timer = setInterval(function(){
        if(a1.playState == 'running'){
        // console.log('sss')
        }else if(a1.playState == 'finished'){
        // text.textContent = Math.round(e.target.value/1000);
        clearInterval(timer);
        }
    }, 100);
}	


let hData = [];
let hDataType = [];
window.addEventListener('message', function(event) {
    ed = event.data;
	if (ed.action === "textUI") {
		if (ed.show) {
							color = ed.color;
        colorArr = ed.colorData;
		console.log(color);
		console.log(colorArr);
  var bg = colorArr["keybox"];
  var keyColor = colorArr["color"];
  var border = colorArr["border"];
  var background = colorArr["background"];
  var iconcolor = colorArr["iconcolor"];
			document.getElementById("TUKeyDivInside").innerHTML=`<span>${ed.key}</span>`;
			document.getElementById("textUIH4").innerHTML=ed.text;
			$("#textUI").show().css({bottom: "-10%", position:'absolute', display:'flex'}).animate({bottom: "4%"}, 800, function() {});
			    setTimeout(() => {
	$('.tuborderr').css({'border-color': colorArr["progress"], 'background': colorArr["progress"], 'box-shadow': `${colorArr["progressshadow"]} 0px 0px 20px 6px`});		
	$('#TUKeyDivInside').css({ 'background': bg , 'color' : keyColor, 'border' : border});
	}, 20); // 500 ms sonra çalışır, istersen 300, 1000 vs. yapabilirsin			
		} else {
			$("#textUI").show().css({bottom: "4%", position:'absolute', display:'flex'}).animate({bottom: "-10%"}, 800, function() {});
		}
    } else if (ed.action === "textUIUpdate") {
        document.getElementById("TUKeyDivInside").innerHTML=`<span>${ed.key}</span>`;
        document.getElementById("textUIH4").innerHTML=ed.text;
	} else if (ed.action === "show3DText") {
		show3DText(ed);
	} else if (ed.action === "hide3DText") {
if (hData[ed.id] !== undefined && hData[ed.id] === true) {
    hData[ed.id] = false;
    if (document.getElementById(ed.id)) {
        $("#" + ed.id).remove();
    }
}
	} else if (ed.action === "update3DText") {
				color = ed.color;
        colorArr = ed.colorData;
		console.log(color);
		console.log(colorArr);
  var bg = colorArr["keybox"];
  var keyColor = colorArr["color"];
  var border = colorArr["border"];
  var background = colorArr["background"];
  var iconcolor = colorArr["iconcolor"];
		if (document.getElementById(ed.id)) {
            document.getElementById(ed.id).classList.remove("circledot2");
			document.getElementById(ed.id).classList.remove("ThreeDTextMain");
            document.getElementById(ed.id).innerHTML="";
            hDataType[ed.id] = ed.type;
console.log("anan")			
			if (ed.type === "svg") {
				console.log("anan2")
				document.getElementById(ed.id).classList.remove("ThreeDTextMain");
                document.getElementById(ed.id).classList.add("circledot2");
				document.getElementById(ed.id).innerHTML="<div class='loader2'></div>";
			    $(".circledot2").css({ 
        'border': border, 
        'filter': colorArr["filterShadow"]
    });					
			    $(".loader2").css({ 
        'background': bg, 
        'color': keyColor, 
        'border': border, 
        'box-shadow': `0 0 0 0 ${bg}` 
    });	
            } else if (ed.type === "text") {
				console.log("anan3")
				document.getElementById(ed.id).classList.remove("circledot2");
                document.getElementById(ed.id).classList.add("ThreeDTextMain");
                document.getElementById(ed.id).innerHTML=`<div id="ThreeDTextMainLeft"><div id="ThreeDTextMainLeftInside">${ed.key}</div></div><div id="ThreeDTextMainRight"><div id="ThreeDTextMainRightInside">${ed.text}</div></div><div class="tuborderr2"></div>`;
			    $(".circledot2").css({ 
        'border': '0px solid #000', 
        'filter': colorArr["filterShadow"] 
    });	       
$('#ThreeDTextMainLeftInside').css({ 'background': bg , 'color' : keyColor, 'border' : border});  
			    $('.ThreeDTextMain').css({ 
        'border': '0px solid #000'
    });	 
$('.tuborderr2').css({'border-color': colorArr["progress"], 'background': colorArr["progress"], 'box-shadow': `${colorArr["progressshadow"]} 0px 0px 20px 6px`});		
		   }
        }
	} else if (ed.action === "update3DText2") {
		console.log("anan4")
        if (document.getElementById(ed.id)) {
            if (hDataType[ed.id] === "text") {
                    document.getElementById(ed.id).innerHTML=`<div id="ThreeDTextMainLeft"><div id="ThreeDTextMainLeftInside">${ed.key}</div></div><div id="ThreeDTextMainRight"><div id="ThreeDTextMainRightInside">${ed.text}</div></div><div class="tuborderr2"></div>`;
            }
        }
    }
})

function create3DText(data) {
    if (hData[data.id] === false || hData[data.id] === undefined) {
        hData[data.id] = true;
        let x = (data.x * 100) + '%';
        let y = (data.y * 100) + '%';
        let $svg = $(document.createElement('div'));
        hDataType[ed.id] = data.type;
		color = data.color;
        colorArr = data.colorData;
		console.log(color);
		console.log(colorArr);
  var bg = colorArr["keybox"];
  var keyColor = colorArr["color"];
  var border = colorArr["border"];
  var background = colorArr["background"];
  var iconcolor = colorArr["iconcolor"];
        if (data.type === "svg") {
			console.log("5")
			$svg.removeClass("ThreeDTextMain");
            $svg.addClass("circledot2");
            $svg.html(`<div class="loader2"></div>`);  // İçeriği ekliyoruz
setTimeout(() => {
    $('.circledot2').css({ 
        'border': border, 
        'filter': colorArr["filterShadow"] 
    });	

    $('.loader2').css({ 
        'background': bg, 
        'color': keyColor, 
        'border': border, 
        'box-shadow': `0 0 0 0 ${bg}` 
    });
}, 10); // 500 ms sonra çalışır, istersen 300, 1000 vs. yapabilirsin

        } else if (data.type === "text") {
			console.log("6")
			$svg.removeClass("circledot2");
            $svg.addClass("ThreeDTextMain");
            $svg.html(`<div id="ThreeDTextMainLeft"><div id="ThreeDTextMainLeftInside">${data.key}</div></div><div id="ThreeDTextMainRight"><div id="ThreeDTextMainRightInside">${data.text}</div></div>`);      
			    setTimeout(() => {
				$('.circledot2').css({ 
        'border': '0px solid #000', 
        'filter': colorArr["filterShadow"] 
    });	  
			    $('.ThreeDTextMain').css({ 
        'border': '0px solid #000'
    });	  
	$('.tuborderr2').css({'border-color': colorArr["progress"], 'background': colorArr["progress"], 'box-shadow': `${colorArr["progressshadow"]} 0px 0px 20px 6px`});		
	$('#ThreeDTextMainLeftInside').css({ 'background': bg , 'color' : keyColor, 'border' : border});
	}, 20); // 500 ms sonra çalışır, istersen 300, 1000 vs. yapabilirsin	
	  }

        $svg.attr("id", data.id);
        $svg.css('display', 'flex');
        $svg.css('left', x);
        $svg.css('top', y);
        $svg.fadeIn();
        return $svg;
    } else {
        let x = (data.x * 100) + '%';
        let y = (data.y * 100) + '%';
        document.getElementById(data.id).style.left = x;
        document.getElementById(data.id).style.top = y;
    }
}

function show3DText(data) {
	let $svg = create3DText(data);
	$('#body').append($svg);
}

         window.addEventListener('message', function(event) {
            let data = event.data;
            if (data.action === "show_notifyV1") {
                showNotification1(data.message, data.type, data.duration);
            }
            if (data.action === "show_notifyV2") {
                showNotification2(data.message, data.type, data.duration);
            }		
    if (data.action == "rednotify"){
		$('.notify-red').html(data.message);
$('.notify-red').fadeIn(200);
        setTimeout(() => {
		  $('.notify-red').fadeOut(200);
        }, data.duration);
    }			
        });

        function showNotification1(message, type, duration) {
            let container = document.getElementById("notify-containergrand");

            let notify = document.createElement("div");
            notify.classList.add("notifygrand");

            notify.innerHTML = `
                <div class="notify-title">notification</div>
                <div class="notify-message">${message}</div>
            `;

            let progress = document.createElement("div");
            progress.classList.add("progressnotify");
            notify.appendChild(progress);

            container.appendChild(notify);

            setTimeout(() => {
                progress.style.width = "0%";
                progress.style.transition = `width ${duration}ms linear`;
            }, 100);

            setTimeout(() => {
                notify.style.animation = "fade-out 0.5s ease-out";
                setTimeout(() => notify.remove(), 500);
            }, duration);
        }
	
function showNotification2(message, type, duration) { 
    let container = document.getElementById("notify-containergrand2");

    // Eski bildirimleri kaldır
    let existingNotify = container.querySelector(".notifygrand2");
    if (existingNotify) {
        existingNotify.style.animation = "fade-out 0.2s ease-out";
        setTimeout(() => existingNotify.remove(), 200);
    }

    // Yeni bildirim oluştur
    let notify = document.createElement("div");
    notify.classList.add("notifygrand2");

    notify.innerHTML = `
        <div class="notify-title2">NOTIFICATION</div>
        <div class="progress-container">
            <div class="progressnotify2"></div>
        </div>
        <div class="notify-message2">${message}</div>
    `;

    let title = notify.querySelector(".notify-title2");

    // Title rengini türüne göre ayarla
    if (type === "success") {
        title.style.color = "rgb(76, 175, 80)"; // Yeşil
    } else if (type === "error") {
        title.style.color = "rgb(244, 67, 54)"; // Kırmızı
    } else if (type === "inform") {
        title.style.color = "rgb(255, 193, 7)"; // Sarı
    }

    let progress = notify.querySelector(".progressnotify2");

    container.appendChild(notify);

    // Progress bar dolarak ilerleme
    setTimeout(() => {
        progress.style.width = "100%"; // Çubuk %100 dolana kadar genişler
        progress.style.transition = `width ${duration}ms linear`;
    }, 100);

    // Bildirimi süresi dolunca kaldır
    setTimeout(() => {
        notify.style.animation = "fade-out 0.5s ease-out";
        setTimeout(() => notify.remove(), 500);
    }, duration);
}


$(document).ready(function() {
    // Lua'dan gelen ana mesaj dinleyicisi
    window.addEventListener('message', function(event) {
        const item = event.data;
        if (item.action === 'showNotify') {
            ShowNuiNotify(item.data);
        } else if (item.action === 'showHistory') {
            // Geçmişi göster
            ShowHistory(item.history);
        } else if (item.action === 'hideHistory') {
            // Geçmişi gizle (opsiyonel, /gecmis komutunu tekrar kullanınca kapatmak için)
            $('#history-container').fadeOut(200);
        }
    });

    // Bildirim içindeki interaktif butonlara tıklama olayı
    $('#nui-notify-container').on('click', '[data-action]', function() {
        const action = $(this).data('action');
        const value = $(this).data('value');

        // Bildirimi animasyonla kapat
        $(this).closest('.nui-notify-card').addClass('closing');
        setTimeout(() => $(this).closest('.nui-notify-card').remove(), 500);

        // Lua'ya tıklama bilgisini gönder
        fetch(`https://uniqers-uipack/notify:buttonClicked`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
            body: JSON.stringify({ action: action, value: value })
        });
    });

    // Geçmiş panelini kapatma butonu
    $('#close-history-btn').on('click', function() {
        $('#history-container').fadeOut(200);
        // Lua'ya focus'u kaldırması için mesaj gönder
        fetch(`https://uniqers-uipack/closeHistory`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
            body: JSON.stringify({})
        });
    });
});

/**
 * Ekranda yeni bir bildirim gösterir.
 * @param {object} data - Bildirim verileri (type, duration, style, title, message vb.)
 */
function ShowNuiNotify(data) {
    const container = $('#nui-notify-container');
    const notifyId = `notify-${Date.now()}`;
    // Varsayılan değerleri atama
    const { type = 'inform', duration = 5000, style = {}, interactive = false, title = 'Bilgi', message = '' } = data;

    // Özel HTML içeriği kontrolü
    let contentHtml = (type === 'custom' && style.html) ? style.html : `
        <strong class="nui-notify-title">${title}</strong>
        <div class="nui-notify-message">${message}</div>`;

    // Bildirim kartının HTML yapısı
    const notifyHtml = `
        <div class="nui-notify-card ${type}" id="${notifyId}">
            <div class="nui-notify-bg"></div>
            <div class="nui-notify-content-wrapper">
                <div class="nui-notify-content">${contentHtml}</div>
            </div>
            <div class="nui-notify-progress-bar">
                <div class="nui-notify-progress-inner" style="animation-duration: ${duration / 1000}s;"></div>
            </div>
        </div>`;
    
    const $newNotify = $(notifyHtml);

    // JavaScript üzerinden özel stilleri uygula
    if (style.color) {
        $newNotify.find('.nui-notify-title').css('color', style.color);
        $newNotify.find('.nui-notify-progress-inner').css('background-color', style.color);
    }
    if (style.backgroundImage) {
        $newNotify.find('.nui-notify-bg').css('background-image', `linear-gradient(to top, rgb(0 0 0), transparent), url(${style.backgroundImage})`);
    } else {
        $newNotify.find('.nui-notify-bg').css('background', 'linear-gradient(125deg, rgb(0 0 0) 0%, rgba(30,30,30,1) 100%)');
    }
    
    container.append($newNotify);

    // Süre sonunda bildirimi kaldır
    setTimeout(() => {
        $newNotify.addClass('closing');
        setTimeout(() => $newNotify.remove(), 500);
    }, duration);
}

/**
 * Bildirim geçmişi panelini gösterir ve doldurur.
 * @param {Array} historyData - Lua'dan gelen bildirim geçmişi dizisi.
 */
function ShowHistory(historyData) {
    const historyList = $('#history-list');
    historyList.empty();

    if (!historyData || historyData.length === 0) {
        historyList.html('<div class="history-item empty">Görüntülenecek bildirim geçmişi yok.</div>');
    } else {
        [...historyData].reverse().forEach(notif => {
            let itemContentHtml = '';

            // Bildirim türüne göre içeriği belirle
            if (notif.type === 'custom' && notif.html_content) {
                // Eğer tür 'custom' ise ve html_content varsa, bu HTML'i doğrudan içerik olarak kullan
                itemContentHtml = notif.html_content;
            } else {
                // Diğer türler için standart başlık ve mesaj formatını kullan
                const cleanTitle = $('<div>').text(notif.title).html();
                const cleanMessage = $('<div>').text(notif.message).html();
                // Custom olmayanlar için başlığı burada oluşturuyoruz
                itemContentHtml = `
                    <strong class="history-item-title">${cleanTitle}</strong>
                    <div class="history-item-message">${cleanMessage}</div>
                `;
            }

            // Her bir geçmiş öğesi için dış çerçeveyi oluştur
            // Custom olanlar için başlık dışarıda, içerik içeride olacak şekilde
            const historyItemHtml = `
                <div class="history-item ${notif.type}">
                    <div class="history-item-header">
                        <span class="history-item-header-title">${notif.type === 'custom' ? notif.title : ''}</span>
                        <span class="history-item-timestamp">${notif.timestamp}</span>
                    </div>
                    <div class="history-item-body">
                        ${itemContentHtml}
                    </div>
                </div>`;
            
            historyList.append(historyItemHtml);
        });
    }

    $('#history-container').fadeIn(200);
}
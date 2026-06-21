
var distributorNumber = 1;
var distributorTimer;
var distributorRotateTime = 3000;
var distributorRotatedCount = 0;


function EndTask(success) {
    console.log(success)
    if (success) {
      $('.modal__alert').text('Task completed!');
    }else {
      $('.modal__alert').text('Task Failed!');

    }

    $('.modal').addClass('modal_show');
    setTimeout(function(){
      $('.modal').removeClass('modal_show');
      $('.modal').addClass('hidden');
      $('.task').addClass('hidden');
      $.post('https://devm-minigames/callback', JSON.stringify({
        success
      }));
    }, 1500);

}

function startDistributor() {
  distributorNumber = 1;
  $('.distributor__block').removeClass('distributor__block_active').removeClass('distributor__block_set');
  $('.distributor__thumb').stop();
  $('.distributor__thumb').css('margin-right', '').css('transform', 'translate(0px, -5px) rotate(-150deg)');
  $('.distributor__btn').prop('disabled', false);
  launchDistributor();
}

function launchDistributor() {
  clearTimeout(distributorTimer);
  distributorRotatedCount = 0;
  distributorRotateTime = 3000;
  $('.distributor__left-panel .distributor__block').removeClass('distributor__block_active');
  $('.distributor__left-panel .distributor__block:nth-child(' + (distributorNumber + 1) + ')').addClass('distributor__block_active');
  $('.distributor__block_active .distributor__thumb').stop();
  $('.distributor__block_active .distributor__thumb').css('margin-right', '').css('transform', 'translate(0px, -5px) rotate(-150deg)');
  startDistributorRotation();
  distributorTimer = setTimeout(startDistributorRotation, distributorRotateTime > 0 ? distributorRotateTime : 3000);
}

function startDistributorRotation() {
  clearTimeout(distributorTimer);
  $('.distributor__block_active .distributor__thumb').animate({ 'margin-right': 100 }, {
    step: function(now, fx) {
      var angle = now / 100 * 360;
      $('.distributor__block_active .distributor__thumb').css('transform', 'translate(0px, -5px) rotate(calc(-150deg - ' + (angle) + 'deg))');
      if (Math.abs(angle - 120) <= 10) {
        $('.distributor__block:nth-child(' + (distributorNumber + 1) + ')').addClass('distributor__block_set');
      } else {
        $('.distributor__block:nth-child(' + (distributorNumber + 1) + ')').removeClass('distributor__block_set');
      }
    },
    duration: distributorRotateTime > 0 ? distributorRotateTime : 3000,
    easing: 'linear',
    complete: function() {
      $('.distributor__block_active .distributor__thumb').css('margin-right', '').css('transform', 'translate(0px, -5px) rotate(-150deg)');
      distributorRotatedCount++;
    }
  },);
  distributorTimer = setTimeout(startDistributorRotation, distributorRotateTime);
  distributorRotatedCount++;
  if (distributorRotatedCount == 1) {
    distributorRotateTime = 4000;
  } else if (distributorRotatedCount > 1) {
    distributorRotateTime = 5000;
  }
}

$('.distributor__btn').on('click', function() {
  if ($(this).closest('.distributor__block').hasClass('distributor__block_set') && distributorNumber == $(this).closest('.distributor__block').index()) {
    clearTimeout(distributorTimer);
    $('.distributor__block_active .distributor__thumb').stop();
    $('.distributor__block_active .distributor__thumb').css('transform', 'translate(0px, -5px) rotate(-270deg)');
    distributorNumber++;
    if (distributorNumber == 4) {
      success = true;
      EndTask(true);
    }
    launchDistributor();
    $(this).prop('disabled', true);
  } else {
    // startDistributor();
    $(this).prop('disabled', false);
    EndTask(false);

  }
});



window.addEventListener('message', function (event) {
    if (event.data.action == "ui") {
        if (event.data.toggle) {
            $('.modal').removeClass('hidden');
            $('.task').removeClass('hidden');
            startDistributor();
        } else {
            $('.modal').removeClass('modal_show');
            $('.modal').addClass('hidden');
            $('.task').addClass('hidden');
        }
    } else if (event.data.action == 'swipe') {
      if (event.data.toggle) {
        $('.wrapper').removeClass('hidden');
        console.log(event.data.toggle)

    } else {

        $('.wrapper').addClass('hidden');

    }
    }
})


window.addEventListener("keydown", function (e) {
    if (e.keyCode == 27) {
        $('body').fadeOut(50);
        setTimeout(() => {
            $('.modal').removeClass('modal_show');
            $('.modal').addClass('hidden');
            $('.task').addClass('hidden');
        }, 250)
    }
})


const card = document.getElementById('card');
const reader = document.getElementById('reader');
let active = false;
let initialX;
let timeStart, timeEnd;
const soundAccepted = new Audio('https://thomaspark.co/projects/among-us-card-swipe/audio/CardAccepted.mp3');
const soundDenied = new Audio('https://thomaspark.co/projects/among-us-card-swipe/audio/CardDenied.mp3');

document.addEventListener('mousedown', dragStart);
document.addEventListener('mouseup', dragEnd);
document.addEventListener('mousemove', drag);
document.addEventListener('touchstart', dragStart);
document.addEventListener('touchend', dragEnd);
document.addEventListener('touchmove', drag);

function dragStart(e) {
  if (e.target !== card) return;

  if (e.type === 'touchstart') {
    initialX = e.touches[0].clientX;
  } else {
    initialX = e.clientX;
  }

  timeStart = performance.now();
  card.classList.remove('slide');
  active = true;
}

function dragEnd(e) {
  if (!active) return;

  e.preventDefault();
  let x;
  let status;

  if (e.type === 'touchend') {
    x = e.touches[0].clientX - initialX;
  } else {
    x = e.clientX - initialX;
  }

  if (x < reader.offsetWidth) {
    status = 'invalid';
  }

  timeEnd = performance.now();
  card.classList.add('slide');
  active = false;

  setTranslate(0);
  setStatus(status);
}

function drag(e) {
  if (!active) return;

  e.preventDefault();
  let x;

  if (e.type === 'touchmove') {
    x = e.touches[0].clientX - initialX;
  } else {
    x = e.clientX - initialX;
  }

  setTranslate(x);
}

function setTranslate(x) {
  if (x < 0) {
    x = 0;
  } else if (x > reader.offsetWidth) {
    x = reader.offsetWidth;
  }

  x -= (card.offsetWidth / 2);

  card.style.transform = 'translateX(' + x + 'px)';
}

function setStatus(status) {
  if (typeof status === 'undefined') {
    let duration = timeEnd - timeStart;

    if (duration > 700) {
      status = 'slow';
    } else if (duration < 400) {
      status = 'fast';
    } else {
      status = 'valid';
    }
  }

  reader.dataset.status = status;
  playAudio(status);
}
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function playAudio(status) {
  soundDenied.pause();
  soundAccepted.pause();
  soundDenied.currentTime = 0;
  soundAccepted.currentTime = 0;

  if (status === 'valid') {
    soundAccepted.play();
    success = true
    $.post('https://devm-minigames/callback', JSON.stringify({
      success
    }));
    sleep(1000).then(() => {     $('.wrapper').addClass('hidden'); });

  } else {
    soundDenied.play();
  }
}
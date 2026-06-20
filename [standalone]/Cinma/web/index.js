  window.ResourceName = 'Cinma'
let AllMovies = {}
let Theater = 1
let LastKey = 0
function openModal(modalId , key ) {
    const modal = document.getElementById(modalId);
    modal.style.display = "block";
    if (key ) {
      LastKey = key
    }
}
function closeModal(modalId) {
    const modal = document.getElementById(modalId);
    
    if (!modal) return;
    modal.classList.add("animate__animated", "animate__fadeOut");

    const animationDuration = parseFloat(getComputedStyle(modal).animationDuration) * 1000;
    setTimeout(() => {
        modal.style.display = "none";
        modal.classList.remove("animate__fadeOut"); 
    }, animationDuration);
}

window.addEventListener("click", (event) => {
    if (event.target.classList.contains("modal")) {
        event.target.style.display = "none";
    }
});

document.addEventListener("DOMContentLoaded", function () {
    const firstElement = document.querySelector('.toppartmodal');
    if (firstElement) {
      firstElement.style.setProperty('--animate-delay', '0.2s');
      firstElement.style.animationDelay = '0.2s';
    }
  
    function setDelay(className, delay) {
      const elements = document.querySelectorAll(className);
      elements.forEach(element => {
        element.style.setProperty('--animate-delay', delay);
        element.style.animationDelay = delay;
      });
    }
  
    setDelay('.anim1', '0.4s');
    setDelay('.anim2', '0.5s');
    setDelay('.anim3', '0.6s');
    setDelay('.anim4', '0.7s');
    setDelay('.anim5', '0.8s');
    setDelay('.anim6', '0.9s');
    setDelay('.anim7', '1s');
  });

  function pageHandler(page , Key ) {
    let pages = ["homepage", "managemovies", "addmovie","ManageEdite"];
    if ( page == 'ManageEdite') {ManageEditeMoive(Key)}
    if ( page == 'managemovies') {ReloadCinma()}
    pages.forEach(p => {
        document.getElementById(p).style.display = (p === page) ? "flex" : "none";
    });
  }

  const maxGenres = 3;

  document.querySelectorAll('[data-genre-section]').forEach(section => {
    const input = section.querySelector('input');
    const tagsContainer = section.querySelector('.genre-tags');
    const genres = [];
  
    input.addEventListener('keydown', function (e) {
      if ((e.key === 'Enter' || e.key === ',') && input.value.trim() !== '') {
        e.preventDefault();
        const genre = input.value.trim().toLowerCase();
  
        let AllTags = []
        $(".genre-tags li").each(function() { 
          let textContent = $(this).text().trim().replace('×', '').trim(); 
        //  console.log( textContent)
          AllTags.push(textContent); 
        }); 

        if (AllTags.length >= maxGenres) {
       //   alert(`You can only add up to ${maxGenres} genres.`);
          input.value = '';
          return;
        }
  
        if (!genres.includes(genre)) {
          genres.push(genre);
          addGenreTag(genre, genres, tagsContainer, input);
          updatePlaceholder(input, genres);
        }
  
        input.value = '';
      } else if (e.key === 'Backspace' && input.value === '') {
        genres.pop();
        tagsContainer.lastChild?.remove();
        updatePlaceholder(input, genres);
      }
    });
  });
  
  function addGenreTag(genre, genres, container, input) {
    const li = document.createElement('li');
    li.textContent = genre;
  
    const removeBtn = document.createElement('span');
    removeBtn.innerHTML = '&times;';
    removeBtn.onclick = () => {
      genres.splice(genres.indexOf(genre), 1);
      container.removeChild(li);
      updatePlaceholder(input, genres);
    };
  
    li.appendChild(removeBtn);
    container.appendChild(li);
  }
  
  function updatePlaceholder(input, genres) {
    input.placeholder = genres.length === 0 ? 'Movie Genre' : '';
  }
  
  document.querySelectorAll(".customTimeInput").forEach((timeInput) => {
    timeInput.addEventListener("blur", () => {
      const val = timeInput.value.trim();
      if (val === "") return;
  
      const timePattern = /^([01]\d|2[0-3]):([0-5]\d)$/;
  
      if (!timePattern.test(val)) {
      //  alert("Please enter time in HH:MM format (00:00 - 23:59)");
        timeInput.focus();
      }
    });
  
    timeInput.addEventListener("input", () => {
      let val = timeInput.value.replace(/[^0-9]/g, "");
  
      if (val.length >= 3) {
        timeInput.value = val.slice(0, 2) + ":" + val.slice(2, 4);
      } else {
        timeInput.value = val;
      }
    });
  });
  

  flatpickr("#datePicker", {
    dateFormat: "Y-m-d",
    defaultDate: "today",
    allowInput: true,
    theme: "dark",
    clickOpens: true,
    onReady: function (selectedDates, dateStr, instance) {
      instance._input.addEventListener("focus", () => {
        instance.open();
      });
    }
  });

  function RemovepageHandler(page , Key) {
    let pages = ["removepage", "moviesmanagepage"];

    if (Key ) {
      LastKey = Key
    }
    pages.forEach(p => {
        document.getElementById(p).style.display = (p === page) ? "flex" : "none";
    });
  }


  const elements = document.querySelectorAll(".textgenrefilter");

  elements.forEach(el => {
    const text = el.textContent;
    if (text.length > 8) {
      const truncated = text.slice(0, 7) + '..';
      el.textContent = truncated;
    }
  });
  

  const elements2 = document.querySelectorAll(".moneyfilter");

  elements2.forEach(el => {
    const text = el.textContent;
    if (text.length > 12) {
      const truncated = text.slice(0, 10) + '..';
      el.textContent = truncated;
    }
  });
  
  const elements3 = document.querySelectorAll(".textfilter");

  elements3.forEach(el => {
    const text = el.textContent;
    if (text.length > 18) {
      const truncated = text.slice(0, 16) + '..';
      el.textContent = truncated;
    }
  });

  const selectorBox = document.getElementById('selectorBox');
  const triggerText = document.getElementById('triggerText');
  const optionRow = document.getElementById('optionRow');
  const options = optionRow.querySelectorAll('.option-box');

  let opened = false;

  selectorBox.addEventListener('click', () => {
    if (!opened) {
      triggerText.classList.add('fade-out');

      setTimeout(() => {
        triggerText.classList.add('hidden');
        optionRow.classList.remove('hidden');
        requestAnimationFrame(() => {
          optionRow.classList.add('show');
        });
      }, 300);

      opened = true;
    }
  });

  options.forEach(option => {
    option.addEventListener('click', (e) => {
      e.stopPropagation();
      options.forEach(o => o.classList.remove('selected'));
      option.classList.add('selected');
      Theater = option.dataset.value
      //console.log("Selected Theater:", option.dataset.value);
    });
  });


  const selectorBox2 = document.getElementById('selectorBox2');
  const triggerText2 = document.getElementById('triggerText2');
  const optionRow2 = document.getElementById('optionRow2');
  const options2 = optionRow2.querySelectorAll('.option-box');

  let opened2 = false;

  selectorBox2.addEventListener('click', () => {
    if (!opened2) {
      triggerText2.classList.add('fade-out');

      setTimeout(() => {
        triggerText2.classList.add('hidden');
        optionRow2.classList.remove('hidden');
        requestAnimationFrame(() => {
          optionRow2.classList.add('show');
        });
      }, 300);

      opened2 = true;
    }
  });

  options2.forEach(option => {
    option.addEventListener('click', (e) => {
      e.stopPropagation();
      options2.forEach(o => o.classList.remove('selected'));
      option.classList.add('selected');
      Theater = option.dataset.value
      //console.log("Selected Theater:", option.dataset.value);
    });
  });

/////
let closeKeys = [ 27];
window.addEventListener("keyup", (e) => {
  if (closeKeys.includes(e.keyCode)) {
    CLOSE()
  }
})

$("#CLOSEADMINMENU").click(function () { 
  CLOSE()
}); 

function CLOSE() {
  $('body').css('background-color' , 'rgba(0, 0, 0, 0.0)')
  $('#liveeditordivID').css('display' , 'none')
  $.post('http://'+ window.ResourceName  + '/CLOSE', JSON.stringify( {} ));

}


window.addEventListener('message', (event) => { 
 
  if (event.data.name == 'openadmin') {
      $('#ADMINPLANMENU').css('display' , 'flex')
      var snd = new Audio('beep.mp3');
      snd.volume = 0.3; 
      snd.play()
      $('body').css('background-color' , 'rgba(0, 0, 0, 0.695)')
      SetMoviesToList(event.data.value)
      $("#MOVIENAME").val('')
      $("#MOVIEPRICE").val('')
      $("#MOVIEDISC").val('')
      $("#MOVIETIME").val('')
      $("#MOVIELINK").val('') 
      $("#MOVIEURL").val('') 
      $("#TAGS").html('')
      $("#MOVIENAMEM").val('')
      $("#MOVIEPRICEM").val('')
      $("#MOVIEDISCM").val('')
      $("#MOVIETIMEM").val('')
      $("#MOVIELINKM").val('') 
      $("#MOVIEURLM").val('') 
      $("#TAGSM").html('')
      Theater = 1
  }
 else if (event.data.name == 'openmoviespanel') {
      var snd = new Audio('beep.mp3');
      snd.volume = 0.3; 
      snd.play()
      $('#SELLPANEL').css('display' , 'flex')
      $('body').css('background-color' , 'rgba(0, 0, 0, 0.695)')
      SetMoviesToList(event.data.value)
  }
  else if (event.data.name == 'closeadmin') {
      $('#ADMINPLANMENU').css('display' , 'none')
      $('body').css('background-color' , 'rgba(0, 0, 0, 0.0)')
  }
  else if (event.data.name == 'closemoviespanel') {
      $('#SELLPANEL').css('display' , 'none')
      $('body').css('background-color' , 'rgba(0, 0, 0, 0.0)')
  }
  else if (event.data.name == 'HOMEPAGE') {
    pageHandler('homepage')
  }
  else if (event.data.name == 'Notification') {
    CNotification(event.data.txt)
  }

})
function SetMoviesToList(List) {
  $("#SELL_BOXES_MOVIES").html('')
  $("#MANAGE_MOVIE_LIST").html('')
  AllMovies = List
  let bicolor = false 

  for (const key in List ) { 
      if ( List[key] !== null ) {
      $("#SELL_BOXES_MOVIES").append(SellBoxHtml(List[key], bicolor ))
      $("#MANAGE_MOVIE_LIST").append(MangeMovieHtml(List[key] , bicolor))
        bicolor = !bicolor

      }
  } 

}

function AddMovie() {
  let name = $("#MOVIENAME").val()
  let price = $("#MOVIEPRICE").val()
  let disc = $("#MOVIEDISC").val()
  let time = $("#MOVIETIME").val()
  let date = $("#datePicker").val()
  let link = $("#MOVIELINK").val() 
  let url = $("#MOVIEURL").val() 
  let CinmaHall = Theater
  let tags = []; 
  //console.log(date)
  //console.log(CinmaHall)
  // Get all span elements with class "tag" using jQuery 
  $("#TAGS li").each(function() { 
    let textContent = $(this).text().trim().replace('×', '').trim(); 
  
    tags.push(textContent); 
  }); 

// Create the table using jQuery 
  let $table = $("#tagTable"); 
  let $row = $("<tr>").appendTo($table); 
  $("<td>Tags:</td>").appendTo($row); 

  $row = $("<tr>").appendTo($table); 
  $.each(tags, function(index, tag) { 
    $("<td>").text(tag).appendTo($row); 
  }); 


  $.post('http://'+ window.ResourceName  + '/ADDNEWMOVIE', JSON.stringify(
      { name : name , price : price , disc : disc ,  time : time ,  tags : tags ,  date : date ,  url : url , link:link   , cinmahall : CinmaHall })  
  );

}
function SaveEdit() {
  let name = $("#MOVIENAMEM").val()
  let price = $("#MOVIEPRICEM").val()
  let disc = $("#MOVIEDISCM").val()
  let time = $("#MOVIETIMEM").val()
  let date = $("#datePicker").val()
  let link = $("#MOVIELINKM").val() 
  let url = $("#MOVIEURLM").val() 
  let CinmaHall = Theater
  let tags = []; 
  //console.log(date)
  //console.log(CinmaHall)
  // Get all span elements with class "tag" using jQuery 
  $("#TAGSM li").each(function() { 
    let textContent = $(this).text().trim().replace('×', '').trim(); 
  
    tags.push(textContent); 
  }); 

// Create the table using jQuery 
  let $table = $("#tagTable"); 
  let $row = $("<tr>").appendTo($table); 
  $("<td>Tags:</td>").appendTo($row); 

  $row = $("<tr>").appendTo($table); 
  $.each(tags, function(index, tag) { 
    $("<td>").text(tag).appendTo($row); 
  }); 


  $.post('http://'+ window.ResourceName  + '/CHANGEMOVIENAME', JSON.stringify(
      { Key : LastKey , name : name , price : price , disc : disc ,  time : time ,  tags : tags ,  date : date ,  url : url , link:link   , cinmahall : CinmaHall })  
  );
 
 
}
function StartMovie(key) {
  $.post('http://'+ window.ResourceName  + '/STARTMOVIE', JSON.stringify( {Key : key }));
}
function StopMovie(key) {
  $.post('http://'+ window.ResourceName  + '/STOPMOVIE', JSON.stringify( {Key : key }));
}
function BuyATicket() {
  $.post('http://'+ window.ResourceName  + '/BUYTICKET', JSON.stringify( {Key : LastKey }));
}
function ResumeMoive() {
  $.post('http://'+ window.ResourceName  + '/RESUME', JSON.stringify( {Key : LastKey }));
}
function PauseMoive() {
  $.post('http://'+ window.ResourceName  + '/PAUSE', JSON.stringify( {Key : LastKey }));
}
function DeleteMovie() {
 // console.log(true)
  $.post('http://'+ window.ResourceName  + '/DELETEMOVIE', JSON.stringify( {Key : LastKey }));
  $('#removepage').css('display' , 'none')
RemovepageHandler('moviesmanagepage')
}

function ReloadCinma() {
  $.post('http://'+ window.ResourceName  + '/RELOAD', JSON.stringify( { }));
}
function StopMov() {
  StopMovie(LastKey) 
  $('#liveeditordivID').css('display' , 'none')
}
function ReplayMovie() {
  $.post('http://'+ window.ResourceName  + '/REPLAY', JSON.stringify( {Key : LastKey }));
}
function ManageEditeMoive(Key) {
  $("#MOVIENAMEM").val('')
  $("#MOVIEPRICEM").val('')
  $("#MOVIEDISCM").val('')
  $("#MOVIETIMEM").val('')
  $("#MOVIELINKM").val('') 
  $("#MOVIEURLM").val('') 
  $("#TAGSM").html('')


  if (Key ) {
  LastKey = Key
  const moive = AllMovies[Key]
  $("#MOVIENAMEM").val(moive.name)
  $("#MOVIEPRICEM").val(moive.price)
  $("#MOVIEDISCM").val(moive.disc)
  $("#MOVIETIMEM").val(moive.time)
  $("#MOVIEDATEM").val(moive.date)
  $("#MOVIELINKM").val(moive.link) 
  $("#MOVIEURLM").val(moive.url) 
  $("#TAGSM").html('')
  $(".optionRow2").html('')
  const input = document.getElementById('TAGSMINPUT');
  const tagsContainer = document.getElementById('TAGSM'); 
  for (const k in moive.tags ) { 
    addGenreTag(moive.tags[k], moive.tags , tagsContainer, input); 
  }
  
  let orow = `   
  <div class="option-box  text-center border w-[8rem] h-[1.5rem] items-center  text-[9px]  cursor-pointer"id = T1 data-value="1"><p class="pt-[4.5px]">Theater 1</p></div>
  <div class="option-box  text-center border w-[8rem] h-[1.5rem] items-center  text-[9px] cursor-pointer" id = T2 data-value="2"><p class="pt-[4.5px]">Theater 2</p></div>
  <div class="option-box  text-center border w-[8rem] h-[1.5rem] items-center  text-[9px] cursor-pointer"id = T3 data-value="3"><p class="pt-[4.5px]">Theater 3</p></div>
  `

  $(".optionRow2").prepend(orow)
  const triggerText2 = document.getElementById('triggerText2');
  const optionRow2 = document.getElementById('optionRow2');
  const Theaterh1 = document.getElementById('T1');
  const Theaterh2 = document.getElementById('T2');
  const Theaterh3 = document.getElementById('T3');
  Theaterh1.classList.remove('selected');
  Theaterh2.classList.remove('selected');
  Theaterh3.classList.remove('selected');
  const Theaterh = document.getElementById('T'+moive.cinmahall);
  console.log(moive.cinmahall)
  Theaterh.classList.add('selected');
  triggerText2.classList.add('fade-out');
  Theater = moive.cinmahall
  setTimeout(() => {
    triggerText2.classList.add('hidden');
    optionRow2.classList.remove('hidden');
    requestAnimationFrame(() => {
      optionRow2.classList.add('show');
    });
  }, 300);

  opened2 = true;
}}
function SellBoxHtml(data) {

const icons = {
  Waiting : `   <ul class="condition_box">
                    <li class="icon-content">
                      <svg width="4" height="16" viewBox="0 0 4 28" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M2 0C2.53043 0 3.03914 0.210714 3.41421 0.585787C3.78929 0.96086 4 1.46957 4 2V20C4 20.5304 3.78929 21.0391 3.41421 21.4142C3.03914 21.7893 2.53043 22 2 22C1.46957 22 0.96086 21.7893 0.585787 21.4142C0.210714 21.0391 0 20.5304 0 20V2C0 1.46957 0.210714 0.96086 0.585787 0.585787C0.96086 0.210714 1.46957 0 2 0ZM2 28C2.53043 28 3.03914 27.7893 3.41421 27.4142C3.78929 27.0391 4 26.5304 4 26C4 25.4696 3.78929 24.9609 3.41421 24.5858C3.03914 24.2107 2.53043 24 2 24C1.46957 24 0.96086 24.2107 0.585787 24.5858C0.210714 24.9609 0 25.4696 0 26C0 26.5304 0.210714 27.0391 0.585787 27.4142C0.96086 27.7893 1.46957 28 2 28Z" fill="white"/>
                        </svg>
                      <div class="tooltip">Waiting</div>
                    </li>
                  </ul>` , 
  Playing : `<ul class="condition_box">
                    <li class="icon-content">
                        <svg width="15" height="15" viewBox="0 0 22 22" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path opacity="0.5" d="M20.8535 4.58203C20.8535 4.20234 20.5457 3.89453 20.166 3.89453C19.7863 3.89453 19.4785 4.20234 19.4785 4.58203V17.4154C19.4785 17.7951 19.7863 18.1029 20.166 18.1029C20.5457 18.1029 20.8535 17.7951 20.8535 17.4154V4.58203Z" fill="white"/>
                            <path d="M15.2722 13.4255C16.9101 12.3678 16.9101 9.62963 15.2722 8.5719L5.38225 2.18538C3.79033 1.15739 1.83398 2.49541 1.83398 4.61219V17.3852C1.83398 19.502 3.79033 20.84 5.38225 19.812L15.2722 13.4255Z" fill="white"/>
                            </svg>
                      <div class="tooltip">Playing</div>
                    </li>
                  </ul>` , 
  FINISHED : `  <ul class="condition_box">
                    <li class="icon-content">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <g id="System / Wifi_Off">
                            <path id="Vector" d="M17.8506 11.5442C17.0475 10.6829 16.0641 10.0096 14.9707 9.57227M20.7759 8.81625C19.5712 7.52437 18.0961 6.51439 16.4561 5.8584C14.816 5.20241 13.0514 4.91635 11.2881 5.02111M8.34277 14.5905C8.95571 13.9332 9.73448 13.4532 10.5971 13.2012C11.4598 12.9491 12.3745 12.9335 13.2449 13.1574M6.14941 11.5438C7.09778 10.5268 8.29486 9.77461 9.62259 9.36133M3.22363 8.81604C4.1215 7.85319 5.17169 7.04466 6.33211 6.42285M4.41406 4L18.5562 18.1421M12 19C11.4477 19 11 18.5523 11 18C11 17.4477 11.4477 17 12 17C12.5523 17 13 17.4477 13 18C13 18.5523 12.5523 19 12 19Z" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </g>
                            </svg>
                      <div class="tooltip">FINISHED</div>
                    </li>
                  </ul>` , 
}
let html = `
<div class="box_movie items-center ">
<img src=`+ data.url +` alt="">
<div class="detailmoviebox">
<h1 class="h1tx">`+ data.name +`</h1>
<p class="ptext">`+ data.disc +` </p>
<div class="flex flex-row gap-2 ltbox">
`

let html2 = ''
for (const key in data.tags ) { 
  html2 = html2 + `<div class="littleboxdiv">`+data.tags[key]+`</div>`
}
let htm3 =` </div>
</div>

<div class="rightpart">
<h1 class="price">$`+ data.price +`</h1>
<h1 class="date">`+ data.date +`</h1>
<h1 class="time">`+ data.time +`</h1>
</div>

<div class="buyticket" onclick="openModal('modal1' , '`+ data.Key +`')">
<svg class="svgbutt" width="55" height="33.5" viewBox="0 0 95 50" fill="none" xmlns="http://www.w3.org/2000/svg">
<g opacity="0.3">
<path fill-rule="evenodd" clip-rule="evenodd" d="M13.2856 -7.38866L-6.14483 9.60474C-14.2969 16.7343 -18.3729 20.2991 -17.3734 24.0233C-17.3569 24.085 -17.3394 24.1464 -17.321 24.2076C-16.2075 27.9033 -10.7776 29.0932 0.0823368 31.4729C6.11723 32.7953 9.13467 33.4565 10.6373 35.6513L10.7147 35.767L34.5665 17.5526L34.4892 17.4369C33.0349 15.2124 33.6702 12.3132 34.9408 6.51494L35.2729 4.99916C38.7956 -11.0769 40.5569 -19.115 36.3411 -21.4902C32.1254 -23.8654 25.8455 -18.3732 13.2856 -7.38866Z" fill="white"></path>
<path opacity="0.5" d="M10.2638 46.689L9.93174 48.2041C6.40879 64.2803 4.64732 72.3184 8.86309 74.6937C13.0789 77.0689 19.3589 71.5767 31.9189 60.5922L51.3493 43.5991C59.5015 36.4695 63.5776 32.9047 62.5781 29.1805C62.5616 29.1188 62.5441 29.0574 62.5256 28.9962C61.4122 25.3004 55.9822 24.1106 45.1222 21.7309C39.0874 20.4085 36.07 19.7473 34.5674 17.5525L10.7155 35.7669C12.1697 37.9914 11.5344 40.8906 10.2638 46.689Z" fill="white"></path>
</g>
</svg>
<h1>BUY TICKET</h1>
</div>

`
let html4 = icons[data.Status]

return html + html2 + htm3 + html4 + `</div>`
}
function MangeMovieHtml(data , bicolor) {
  let color = 'bacolor'
  if (bicolor) {
    color = 'bicolor'
  }
if (data.started) {
const phtml = `
<div class="w-[100%] min-h-[83px] `+color+` rounded-[8px] flex justify-center items-center relative">
<img src=`+ data.url +` class="w-[60px] h-[60px] absolute left-[15px] object-cover rounded-[8px] animate__fadeIn animate__animated anim1" alt="" style="--animate-delay: 0.4s; animation-delay: 0.4s;">
<div class=" absolute  left-[90px]">
<h1 class=" textfilter  font-['roboto'] font-bold text-[17px] animate__fadeIn animate__animated anim2" style="--animate-delay: 0.5s; animation-delay: 0.5s;">`+ data.name +`</h1>
<h1 class=" textfilter  font-['roboto'] font-bold text-[11px] animate__fadeIn animate__animated anim2 text-[#D2162D] flex items-center" style="--animate-delay: 0.5s; animation-delay: 0.5s;"><div class="w-[7px] rounded-[100%] h-[7px] mr-[5px] bg-[#D2162D]"></div>Movie is live</h1>
</div>
<div class="absolute font-['roboto'] left-[16rem] font-bold text-[12.5px] flex flex-row gap-3 anim3 animate__fadeIn animate__animated " style="--animate-delay: 0.6s; animation-delay: 0.6s;">`
let phtml2 = ``
for (const key in data.tags ) { 
  phtml2 = phtml2 + `<h1 class="textgenrefilter">`+data.tags[key]+`</h1>`
}
const phtml3 = `
</div>
<div class="absolute font-['roboto'] left-[28.62rem] font-bold text-[12.5px] animate__fadeIn animate__animated anim4 flex flex-row" style="--animate-delay: 0.7s; animation-delay: 0.7s;"><span>$</span><p class="moneyfilter">`+ data.price +`</p></div>
<div class="absolute font-['roboto'] left-[36.5rem] font-bold text-[12.5px] animate__fadeIn animate__animated anim5" style="--animate-delay: 0.8s; animation-delay: 0.8s;">`+ data.date +`</div>
<div class="absolute font-['roboto'] left-[43rem] font-bold text-[12.5px] animate__fadeIn animate__animated anim5" style="--animate-delay: 0.8s; animation-delay: 0.8s;">`+ data.cinmahall +`</div>
<div class="buttonmanage absolute font-['roboto'] left-[52.3rem] font-bold text-[11px] animate__fadeIn animate__animated anim6" onclick="pageHandler('ManageEdite','`+ data.Key +`' )" style="--animate-delay: 0.9s; animation-delay: 0.9s;"><p>Manage</p></div>

<div class="buttonremove absolute font-['roboto'] left-[56.9rem] font-bold text-[11px] animate__fadeIn animate__animated anim7 " onclick="RemovepageHandler('removepage' , '`+ data.Key +`')" style="--animate-delay: 1s; animation-delay: 1s;">
<svg width="15" height="15" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M9.33073 6.6667V11.3334M6.66406 6.6667V11.3334M3.9974 4.00003V11.8667C3.9974 12.6134 3.9974 12.9865 4.14272 13.2718C4.27055 13.5226 4.47438 13.727 4.72526 13.8548C5.0102 14 5.38339 14 6.12867 14H9.86612C10.6114 14 10.9841 14 11.269 13.8548C11.5199 13.727 11.7244 13.5226 11.8522 13.2718C11.9974 12.9868 11.9974 12.614 11.9974 11.8688V4.00003M3.9974 4.00003H5.33073M3.9974 4.00003H2.66406M5.33073 4.00003H10.6641M5.33073 4.00003C5.33073 3.37878 5.33073 3.0683 5.43222 2.82327C5.56755 2.49657 5.82694 2.23685 6.15365 2.10152C6.39867 2.00003 6.70947 2.00003 7.33073 2.00003H8.66406C9.28532 2.00003 9.59594 2.00003 9.84097 2.10152C10.1677 2.23685 10.4272 2.49657 10.5625 2.82327C10.664 3.0683 10.6641 3.37878 10.6641 4.00003M10.6641 4.00003H11.9974M11.9974 4.00003H13.3307" stroke="white" stroke-linecap="round" stroke-linejoin="round"></path>
</svg>
</div>

<div class="buttonstart absolute font-['roboto'] left-[46.7rem] font-bold text-[11px] animate__fadeIn animate__animated anim6 flex flex-row gap-1 hidden" style="--animate-delay: 0.9s; animation-delay: 0.9s;"  onclick="StartMovie( '`+ data.Key +`')" ><p>Start movie</p>
</div>

<div class="buttonstop absolute font-['roboto'] left-[46.7rem] font-bold text-[11px] animate__fadeIn animate__animated anim6 flex flex-row gap-2 " style="--animate-delay: 0.9s; animation-delay: 0.9s;" onclick="StopMovie( '`+ data.Key +`')"><svg width="15" height="15" viewBox="0 0 17 17" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M12.5 12.5L8.50001 8.50001M8.50001 8.50001L4.5 4.5M8.50001 8.50001L12.5 4.5M8.50001 8.50001L4.5 12.5" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
</svg><p>Stop</p>
</div>
</div>
`
return phtml  + phtml2 + phtml3
}
else {
const html = `
<div class="w-[100%] min-h-[83px]  `+color+` rounded-[8px] flex justify-center items-center relative">
<img src=`+ data.url +` class="w-[60px] h-[60px] absolute left-[15px] object-cover rounded-[8px] animate__fadeIn animate__animated anim1" alt="" style="--animate-delay: 0.4s; animation-delay: 0.4s;">
<div class=" absolute  left-[90px]">
<h1 class=" textfilter  font-['roboto'] font-bold text-[17px] animate__fadeIn animate__animated anim2" style="--animate-delay: 0.5s; animation-delay: 0.5s;">`+ data.name +`</h1>
<h1 class=" textfilter  font-['roboto'] font-bold text-[11px] animate__fadeIn animate__animated anim2 text-[#D2162D] flex items-center hidden" style="--animate-delay: 0.5s; animation-delay: 0.5s;"><div class="w-[7px] rounded-[100%] h-[7px] mr-[5px] bg-[#D2162D]"></div>Movie is live</h1>
</div>
<div class="absolute font-['roboto'] left-[16rem] font-bold text-[12.5px] flex flex-row gap-3 anim3 animate__fadeIn animate__animated " style="--animate-delay: 0.6s; animation-delay: 0.6s;">
`
let html2 = ``
for (const key in data.tags ) { 
  html2 = html2 + `<h1 class="textgenrefilter">`+data.tags[key]+`</h1>`
}
const html3 = `
</div>
<div class="absolute font-['roboto'] left-[28.62rem] font-bold text-[12.5px] animate__fadeIn animate__animated anim4 flex flex-row" style="--animate-delay: 0.7s; animation-delay: 0.7s;"><span>$</span><p class="moneyfilter">`+ data.price +`</p></div>
<div class="absolute font-['roboto'] left-[36.5rem] font-bold text-[12.5px] animate__fadeIn animate__animated anim5" style="--animate-delay: 0.8s; animation-delay: 0.8s;">`+ data.date +`</div>
<div class="absolute font-['roboto'] left-[43rem] font-bold text-[12.5px] animate__fadeIn animate__animated anim5" style="--animate-delay: 0.8s; animation-delay: 0.8s;">`+ data.cinmahall +`</div>
<div class="buttonmanage absolute font-['roboto'] left-[52.3rem] font-bold text-[11px] animate__fadeIn animate__animated anim6" onclick="pageHandler('ManageEdite' ,'`+ data.Key +`'  )" style="--animate-delay: 0.9s; animation-delay: 0.9s;"><p>Manage</p></div>

<div class="buttonremove absolute font-['roboto'] left-[56.9rem] font-bold text-[11px] animate__fadeIn animate__animated anim7 " onclick="RemovepageHandler('removepage' ,'`+ data.Key +`' )" style="--animate-delay: 1s; animation-delay: 1s;">
<svg width="15" height="15" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M9.33073 6.6667V11.3334M6.66406 6.6667V11.3334M3.9974 4.00003V11.8667C3.9974 12.6134 3.9974 12.9865 4.14272 13.2718C4.27055 13.5226 4.47438 13.727 4.72526 13.8548C5.0102 14 5.38339 14 6.12867 14H9.86612C10.6114 14 10.9841 14 11.269 13.8548C11.5199 13.727 11.7244 13.5226 11.8522 13.2718C11.9974 12.9868 11.9974 12.614 11.9974 11.8688V4.00003M3.9974 4.00003H5.33073M3.9974 4.00003H2.66406M5.33073 4.00003H10.6641M5.33073 4.00003C5.33073 3.37878 5.33073 3.0683 5.43222 2.82327C5.56755 2.49657 5.82694 2.23685 6.15365 2.10152C6.39867 2.00003 6.70947 2.00003 7.33073 2.00003H8.66406C9.28532 2.00003 9.59594 2.00003 9.84097 2.10152C10.1677 2.23685 10.4272 2.49657 10.5625 2.82327C10.664 3.0683 10.6641 3.37878 10.6641 4.00003M10.6641 4.00003H11.9974M11.9974 4.00003H13.3307" stroke="white" stroke-linecap="round" stroke-linejoin="round"></path>
</svg>
</div>

<div class="buttonstart absolute font-['roboto'] left-[46.7rem] font-bold text-[11px] animate__fadeIn animate__animated anim6 flex flex-row gap-1 " style="--animate-delay: 0.9s; animation-delay: 0.9s;"  onclick="StartMovie( '`+ data.Key +`')" ><p>Start movie</p>
</div>

<div class="buttonstop absolute font-['roboto'] left-[46.7rem] font-bold text-[11px] animate__fadeIn animate__animated anim6 flex flex-row gap-2 hidden" style="--animate-delay: 0.9s; animation-delay: 0.9s;" nclick="StopMovie( '`+ data.Key +`')"><svg width="15" height="15" viewBox="0 0 17 17" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M12.5 12.5L8.50001 8.50001M8.50001 8.50001L4.5 4.5M8.50001 8.50001L12.5 4.5M8.50001 8.50001L4.5 12.5" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
</svg><p>Stop</p>
</div>

</div>`
return html + html2  + html3
}
}


/// NEW

const stopBtn = document.getElementById('stopBtn');
const startBtn = document.getElementById('startBtn');



function OpenLiveEditor() {
  let moive = AllMovies[LastKey]
  if (moive.started === true) {
    $.post('http://'+ window.ResourceName  + '/LOOKATSCREEN', JSON.stringify( {Hall :moive.cinmahall  }));
    $('#ADMINPLANMENU').css('display' , 'none')
    $('body').css('background-color' , 'rgba(0, 0, 0, 0.0)')
    $('#liveeditordivID').css('display' , 'flex')
    pageHandler('homepage')
  }
  else {
    CNotification('This Movie Is Not Live')
  }

}

let Notif = false 
function CNotification(txt) {
  if (!Notif) { 
    Notif = true 
    $('#NotifText').text( txt )
    $('#CinmaNotif').css('display' , 'flex')
    var snd = new Audio('beep2.mp3');
    snd.volume = 0.3; 
    snd.play()
    setTimeout(() => {
      Notif = false 
      $('#CinmaNotif').css('display' , 'none')
    }, 3000);
}}
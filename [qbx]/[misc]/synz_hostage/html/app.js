const menu      = document.getElementById('menu');
const titleText = document.getElementById('title-text');
const options   = document.getElementById('options');
const hint      = document.getElementById('hint');
const timer     = document.getElementById('timer');
const timerContent = document.querySelector('.timer-content');
const timerLabel   = document.getElementById('timer-label');
const timerFill    = document.getElementById('timer-fill');
const timerRem     = document.getElementById('timer-remaining');

let state = { open: false, index: 1, items: [], x: 0.5, y: 0.5 };
let timerState = { show: false, total: 0, left: 0, int: null };

// Icons mapped to each menu option index
const optionIcons = [
  'fa-solid fa-person-arrow-down-to-line',  // Kneel
  'fa-solid fa-money-bill-wave',             // Give money
  'fa-solid fa-person-walking',              // Follow
  'fa-solid fa-handcuffs',                   // Hostage
  'fa-solid fa-person-running',              // Leave
];

function renderMenu() {
  if (!state.open) { menu.classList.add('hidden'); return; }
  menu.classList.remove('hidden');

  titleText.textContent = window.menuTitle || 'INTERACTION';
  hint.textContent = window.menuHint || '';

  options.innerHTML = '';
  state.items.forEach((txt, i) => {
    const li = document.createElement('li');
    li.className = 'option' + ((i + 1) === state.index ? ' active' : '');

    const icon = optionIcons[i] || 'fa-solid fa-circle';
    li.innerHTML = `<span class="opt-icon"><i class="${icon}"></i></span><span class="opt-label">${txt}</span>`;
    options.appendChild(li);
  });

  const vw = innerWidth;
  const vh = innerHeight;
  const px = Math.max(10, Math.min(vw - 260, state.x * vw + 40));
  const py = Math.max(10, Math.min(vh - 300, state.y * vh - 20));
  menu.style.left = px + 'px';
  menu.style.top  = py + 'px';
}

function renderTimer() {
  if (!timerState.show) { timer.classList.add('hidden'); return; }
  timer.classList.remove('hidden');

  timerLabel.textContent = timerState.label || 'TIME';
  const secs = Math.max(0, Math.ceil(timerState.left));
  timerRem.textContent = secs + 's';

  const pct = timerState.total > 0 ? (1 - (timerState.left / timerState.total)) : 0;
  timerFill.style.width = Math.max(0, Math.min(100, pct * 100)) + '%';

  if (timerState.left < timerState.total * 0.25 && timerState.left > 0) {
    timerContent.classList.add('warning');
  } else {
    timerContent.classList.remove('warning');
  }
}

function startTimer(seconds, label) {
  clearInterval(timerState.int);
  timerState.show  = true;
  timerState.total = seconds;
  timerState.left  = seconds;
  timerState.label = label || '';
  renderTimer();
  timerState.int = setInterval(() => {
    timerState.left -= 0.1;
    if (timerState.left <= 0) {
      timerState.left = 0;
      clearInterval(timerState.int);
    }
    renderTimer();
  }, 100);
}

function stopTimer() {
  clearInterval(timerState.int);
  timerState.show = false;
  if (timerContent) timerContent.classList.remove('warning');
  renderTimer();
}

window.addEventListener('message', (e) => {
  const d = e.data || {};
  switch (d.action) {
    case 'open':
      state.open  = true;
      state.index = d.index || 1;
      window.menuTitle = d.title || 'INTERACTION';
      window.menuHint  = d.hint || '';
      state.items = d.options || [];
      state.x = d.x || 0.5;
      state.y = d.y || 0.5;
      renderMenu();
      break;
    case 'move':
      state.x = d.x ?? state.x;
      state.y = d.y ?? state.y;
      renderMenu();
      break;
    case 'setIndex':
      state.index = d.index || state.index;
      renderMenu();
      break;
    case 'close':
      state.open = false;
      renderMenu();
      break;
    case 'timer':
      d.show ? startTimer(d.seconds || 0, d.label || '') : stopTimer();
      break;
  }
});

renderMenu();
renderTimer();

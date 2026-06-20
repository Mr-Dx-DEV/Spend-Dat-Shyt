let currentOpenButton = null;
let currentMenuId = null;
let currentSearch = '';
let currentFilter = 'all';
let selectedLocation = null;
let adminData = null;
let adminLogs = [];
let currentLogPage = 1;
const logsPerPage = 10;
let isAdminPanelOpen = false;
let locale = {};

function t(key, fallback) {
  return locale[key] || fallback || key;
}

function applyLocaleToDOM() {
  document.querySelectorAll('[data-locale]').forEach(el => {
    const key = el.getAttribute('data-locale');
    if (locale[key]) el.textContent = locale[key];
  });
  document.querySelectorAll('[data-locale-ph]').forEach(el => {
    const key = el.getAttribute('data-locale-ph');
    if (locale[key]) el.placeholder = locale[key];
  });
  const hudTitle = document.getElementById('hud-title');
  const lblHudAdmin = document.getElementById('lbl-hud-admin');
  const lblHudTasks = document.getElementById('lbl-hud-tasks');
  const lblHudReason = document.getElementById('lbl-hud-reason');
  const panelTitle = document.getElementById('panel-title');
  const membersHeading = document.getElementById('members-heading');
  const membersDesc = document.getElementById('members-desc');
  const logHeading = document.getElementById('log-heading');
  const logDesc = document.getElementById('log-desc');
  const modalHeading = document.getElementById('modal-heading');

  if (hudTitle) hudTitle.textContent = t('hud_title', 'Community Service');
  if (lblHudAdmin) lblHudAdmin.textContent = t('hud_admin', 'Admin:');
  if (lblHudTasks) lblHudTasks.textContent = t('hud_tasks', 'Tasks:');
  if (lblHudReason) lblHudReason.textContent = t('hud_reason', 'Reason:');
  if (panelTitle) panelTitle.textContent = t('title', 'Community Service');
  if (membersHeading) membersHeading.textContent = t('members_title', 'Members');
  if (membersDesc) membersDesc.textContent = t('members_desc', 'View and manage all members assigned to community service.');
  if (logHeading) logHeading.textContent = t('log_title', 'Admin Log');
  if (logDesc) logDesc.textContent = t('log_desc', 'A log of all administrative actions taken in this panel.');
  if (modalHeading) modalHeading.textContent = t('modal_title', 'Punish Player');
}

if (typeof GetParentResourceName === 'undefined') {
  function GetParentResourceName() {
    return 'fearx-communityservicev1';
  }
}

window.addEventListener('message', function(event) {
  const data = event.data;
  
  switch(data.action) {
    case 'openAdminPanel':
      openAdminPanel(data.data);
      break;
    case 'show':
      showPlayerHUD(data);
      break;
    case 'hide':
      hidePlayerHUD();
      break;
    case 'updateTasks':
      updateTasks(data.remaining);
      break;
    case 'closeAllUI':
      closeAdminPanel();
      hidePlayerHUD();
      break;
  }
});

document.addEventListener('keydown', function(event) {
  if (event.key === 'Escape' && isAdminPanelOpen) {
    event.preventDefault();
    closeAdminPanel();
  }
});

function getDiscordAvatar(member) {
  if (member.avatar) {
    if (member.avatar.startsWith('https://')) {
      return member.avatar;
    }
    if (member.discordId) {
      return `https://cdn.discordapp.com/avatars/${member.discordId}/${member.avatar}.png?size=128`;
    }
  }
  return `https://placehold.co/40x40/5A5A5A/FFFFFF?text=${member.name.charAt(0).toUpperCase()}`;
}

function openAdminPanel(data) {
  if (!data || !data.isAdmin) {
    return;
  }

  const adminPanel = document.getElementById('admin-panel');
  const modalOverlay = document.getElementById('punish-modal-overlay');
  
  if (!adminPanel) {
    return;
  }

  if (modalOverlay) {
    modalOverlay.style.display = 'none';
    modalOverlay.style.opacity = '0';
    modalOverlay.classList.add('pointer-events-none');
    const modalContent = document.getElementById('punish-modal-content');
    if (modalContent) {
      modalContent.classList.remove('modal-slide-up', 'bounce-in');
      modalContent.style.transform = 'scale(0.95)';
    }
  }
  
  adminPanel.style.display = 'block';
  adminData = data;
  adminLogs = data.logs || [];
  currentLogPage = 1;
  isAdminPanelOpen = true;
  if (data.locale) {
    locale = data.locale;
    applyLocaleToDOM();
  }

  requestAnimationFrame(() => {
    updateMembersTable(data);
    updateLocationButtons(data);
    updateAdminLog();
  });
}

function closeAdminPanel() {
  if (!isAdminPanelOpen) return;
  
  isAdminPanelOpen = false;
  
  const adminPanel = document.getElementById('admin-panel');
  const modalOverlay = document.getElementById('punish-modal-overlay');
  
  if (modalOverlay) {
    modalOverlay.style.display = 'none';
    modalOverlay.style.opacity = '0';
    modalOverlay.classList.add('pointer-events-none');
  }
  
  if (adminPanel) {
    const mainContainer = adminPanel.querySelector('.max-w-7xl');
    if (mainContainer) {
      mainContainer.classList.remove('load-in');
      mainContainer.classList.add('scale-out');
    }
    
    setTimeout(() => {
      adminPanel.style.display = 'none';
      if (mainContainer) {
        mainContainer.classList.remove('scale-out');
        mainContainer.classList.add('load-in');
      }
    }, 300);
  }
  
  fetch(`https://${GetParentResourceName()}/closeAdminPanel`, {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify({})
  }).catch(() => {});
}

function showPlayerHUD(data) {
  const playerHud = document.getElementById('player-hud');
  if (playerHud) {
    if (data.locale) {
      locale = data.locale;
      applyLocaleToDOM();
    }
    const na = t('na', 'N/A');
    const hudAdmin = document.getElementById('hud-admin');
    const hudTasks = document.getElementById('hud-tasks');
    const hudReason = document.getElementById('hud-reason');

    if (hudAdmin) hudAdmin.textContent = data.admin || na;
    if (hudTasks) hudTasks.textContent = data.amount || '0';
    if (hudReason) hudReason.textContent = data.reason || na;

    playerHud.style.display = 'block';
  }
}

function hidePlayerHUD() {
  const playerHud = document.getElementById('player-hud');
  if (!playerHud) return;
  
  playerHud.style.display = 'none';
}

function updateTasks(remaining) {
  const hudTasks = document.getElementById('hud-tasks');
  if (hudTasks) {
    hudTasks.classList.add('pulse');
    hudTasks.textContent = remaining;
    setTimeout(() => {
      hudTasks.classList.remove('pulse');
    }, 2000);
  }
}

function getActionIcon(action) {
  const icons = {
    'punish': 'gavel',
    'release': 'check_circle',
    'system': 'info',
    'edit': 'edit',
    'penalty': 'warning'
  };
  return icons[action] || 'info';
}

function getActionColor(action) {
  const colors = {
    'punish': 'bg-gray-500/20',
    'release': 'bg-gray-300/20',
    'system': 'bg-gray-600/20',
    'edit': 'bg-gray-400/20',
    'penalty': 'bg-gray-700/20'
  };
  return colors[action] || 'bg-gray-800';
}

function formatTimestamp(timestamp) {
  const now = Math.floor(Date.now() / 1000);
  const diff = now - timestamp;

  if (diff < 60) return t('time_just_now', 'Just now');
  if (diff < 3600) return t('time_minutes_ago', '%s minutes ago').replace('%s', Math.floor(diff / 60));
  if (diff < 86400) return t('time_hours_ago', '%s hours ago').replace('%s', Math.floor(diff / 3600));
  if (diff < 604800) return t('time_days_ago', '%s days ago').replace('%s', Math.floor(diff / 86400));

  const date = new Date(timestamp * 1000);
  return date.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
}

function getLogDescription(log) {
  if (!log || !log.details) return 'Unknown action';

  const details = log.details;
  const s = (str) => `<span class="font-medium">${str}</span>`;
  const g = (str) => `<span class="text-gray-300">${str}</span>`;

  switch(log.action) {
    case 'punish':
      return t('log_sent', '%s sent %s to %s for %s tasks').replace('%s', s(log.adminName)).replace('%s', s(details.target)).replace('%s', g(details.location)).replace('%s', g(details.amount));
    case 'release':
      return t('log_released', '%s released %s from community service').replace('%s', s(log.adminName)).replace('%s', s(details.target));
    case 'system':
      return details.message || t('log_system', 'System action');
    case 'edit':
      return t('log_edited', '%s edited tasks for %s').replace('%s', s(log.adminName)).replace('%s', s(details.target));
    case 'penalty':
      return t('log_penalty', '%s received penalty: +%s tasks').replace('%s', s(details.target)).replace('%s', details.amount);
    default:
      return t('log_action_by', 'Action performed by %s').replace('%s', s(log.adminName));
  }
}

function updateAdminLog() {
  const logList = document.getElementById('admin-log-list');
  const pageInfo = document.getElementById('page-info');
  const prevButton = document.getElementById('prev-page');
  const nextButton = document.getElementById('next-page');
  
  if (!logList) return;
  
  logList.style.opacity = '0';
  logList.style.transform = 'translateY(10px)';
  
  setTimeout(() => {
    logList.innerHTML = '';
    
    if (!adminLogs || adminLogs.length === 0) {
      logList.innerHTML = `
        <div class="flex flex-col items-center gap-3 py-8 fade-in">
          <span class="material-icons-outlined text-5xl text-gray-700">history</span>
          <p class="text-lg text-gray-500">${t('no_logs', 'No admin logs available')}</p>
        </div>
      `;
      logList.style.opacity = '1';
      logList.style.transform = 'translateY(0)';
      if (pageInfo) pageInfo.textContent = t('page_info', 'Page %s of %s').replace('%s', '0').replace('%s', '0');
      if (prevButton) prevButton.disabled = true;
      if (nextButton) nextButton.disabled = true;
      return;
    }
    
    const totalPages = Math.ceil(adminLogs.length / logsPerPage);
    const startIndex = (currentLogPage - 1) * logsPerPage;
    const endIndex = Math.min(startIndex + logsPerPage, adminLogs.length);
    const logsToDisplay = adminLogs.slice(startIndex, endIndex);
    
    logsToDisplay.forEach((log, index) => {
      const logItem = document.createElement('div');
      logItem.className = 'flex items-start gap-3 p-3 rounded-lg hover:bg-gray-900/50 transition-all duration-200 slide-in-right';
      logItem.style.animationDelay = `${index * 0.05}s`;
      
      logItem.innerHTML = `
        <div class="p-2 ${getActionColor(log.action)} rounded-full flex-shrink-0 mt-1">
          <span class="material-icons-outlined text-base text-gray-300">${getActionIcon(log.action)}</span>
        </div>
        <div class="flex-1 min-w-0">
          <p class="text-sm text-white leading-relaxed">${getLogDescription(log)}</p>
          <p class="text-xs text-gray-500 mt-1">${formatTimestamp(log.timestamp)}</p>
          ${log.details && log.details.reason ? `<p class="text-xs text-gray-400 mt-1 italic">${t('log_reason', 'Reason: %s').replace('%s', log.details.reason)}</p>` : ''}
        </div>
      `;
      
      logList.appendChild(logItem);
    });
    
    logList.style.transition = 'opacity 0.3s cubic-bezier(0.4, 0, 0.2, 1), transform 0.3s cubic-bezier(0.4, 0, 0.2, 1)';
    logList.style.opacity = '1';
    logList.style.transform = 'translateY(0)';
    
    if (pageInfo) {
      pageInfo.textContent = t('page_info', 'Page %s of %s').replace('%s', currentLogPage).replace('%s', totalPages);
    }
    
    if (prevButton) {
      prevButton.disabled = currentLogPage === 1;
    }
    
    if (nextButton) {
      nextButton.disabled = currentLogPage === totalPages;
    }
  }, 150);
}

function updateLocationButtons(data) {
  const locationsContainer = document.querySelector('.grid.grid-cols-2');
  if (!locationsContainer || !data || !data.locations) return;
  
  locationsContainer.innerHTML = '';
  
  data.locations.forEach((location, index) => {
    const button = document.createElement('button');
    button.className = 'location-option-button group relative rounded-lg overflow-hidden focus:outline-none transition-all stagger-animation';
    button.dataset.location = index;
    button.style.animationDelay = `${index * 0.1}s`;
    
    button.innerHTML = `
      <img src="${location.image}" alt="${location.label}" class="w-full h-28 object-cover transition-transform duration-300 group-hover:scale-110">
      <div class="absolute inset-0 bg-gradient-to-t from-black/70 to-transparent"></div>
      <div class="absolute bottom-3 left-3 text-left">
        <h3 class="font-semibold text-white">${location.label}</h3>
      </div>
      <div class="location-checkmark absolute top-2 right-2 h-6 w-6 rounded-full flex items-center justify-center opacity-0 scale-75 transition-all duration-200">
        <span class="material-icons-outlined text-white" style="font-size: 16px;">check</span>
      </div>
    `;
    
    button.addEventListener('click', (e) => {
      e.preventDefault();
      selectedLocation = index;

      document.querySelectorAll('.location-option-button').forEach(btn => {
        btn.classList.remove('selected');
        const checkmark = btn.querySelector('.location-checkmark');
        if (checkmark) {
          checkmark.classList.add('opacity-0', 'scale-75');
        }
        btn.style.borderColor = 'transparent';
      });
      
      button.classList.add('selected');
      const checkmark = button.querySelector('.location-checkmark');
      if (checkmark) {
        checkmark.classList.remove('opacity-0', 'scale-75');
        checkmark.classList.add('bounce-in');
        setTimeout(() => {
          checkmark.classList.remove('bounce-in');
        }, 600);
      }
    });
    
    locationsContainer.appendChild(button);
  });
}

function updateMembersTable(data) {
  const tableBody = document.getElementById('members-table-body');
  if (!tableBody) return;
  
  tableBody.style.opacity = '0';
  tableBody.style.transform = 'translateY(10px)';
  
  setTimeout(() => {
    tableBody.innerHTML = '';
    
    if (!data || !data.members || data.members.length === 0) {
      tableBody.innerHTML = `
        <tr class="bg-[#030303]">
          <td colspan="5" class="px-6 py-8 text-center text-gray-500">
            <div class="flex flex-col items-center gap-3 fade-in">
              <span class="material-icons-outlined text-5xl text-gray-700">info</span>
              <p class="text-lg">${t('no_members', 'No members in community service')}</p>
            </div>
          </td>
        </tr>
      `;
      tableBody.style.opacity = '1';
      tableBody.style.transform = 'translateY(0)';
      return;
    }
    
    data.members.forEach((member, index) => {
      const row = document.createElement('tr');
      row.className = 'bg-[#030303] hover:bg-gray-900 transition-colors duration-150 member-row';
      row.dataset.name = member.name.toLowerCase();
      row.dataset.id = member.serverId;
      row.dataset.status = member.status || 'inprogress';
      row.style.animationDelay = `${index * 0.05}s`;
      
      const progressPercent = Math.round((member.tasks.completed / member.tasks.total) * 100);
      const avatarUrl = getDiscordAvatar(member);
      
      row.innerHTML = `
        <td class="px-6 py-4 whitespace-nowrap">
          <div class="flex items-center gap-3">
            <img alt="${member.name}" class="h-10 w-10 rounded-full object-cover ring-2 ring-gray-700" src="${avatarUrl}" onerror="this.src='https://placehold.co/40x40/5A5A5A/FFFFFF?text=${member.name.charAt(0).toUpperCase()}'" />
            <div class="font-medium text-white">${member.name}</div>
          </div>
        </td>
        <td class="px-6 py-4 text-gray-400 font-mono">${member.serverId}</td>
        <td class="px-6 py-4 text-gray-400">${member.reason || t('no_reason', 'No reason provided')}</td>
        <td class="px-6 py-4 text-center">
          <div class="flex flex-col items-center gap-1">
            <span class="px-2 py-1 font-semibold text-sm leading-tight text-white bg-gray-700/50 rounded-full">${member.tasks.completed} / ${member.tasks.total}</span>
            <div class="w-20 h-1.5 bg-gray-800 rounded-full overflow-hidden">
              <div class="h-full bg-gradient-to-r from-white to-gray-400 transition-all duration-500" style="width: ${progressPercent}%"></div>
            </div>
          </div>
        </td>
        <td class="px-6 py-4 text-right">
          <button class="action-menu-button p-2 rounded-md text-gray-400 hover:bg-gray-800 transition-colors" data-menu-id="action-menu-${member.serverId}">
            <span class="material-icons-outlined">more_horiz</span>
          </button>
        </td>
      `;
      
      tableBody.appendChild(row);
    });
    
    tableBody.style.transition = 'opacity 0.4s cubic-bezier(0.4, 0, 0.2, 1), transform 0.4s cubic-bezier(0.4, 0, 0.2, 1)';
    tableBody.style.opacity = '1';
    tableBody.style.transform = 'translateY(0)';
    
    applyFilters();
  }, 100);
}

document.addEventListener('DOMContentLoaded', function() {
  const tabButtons = document.querySelectorAll('.tab-button');
  tabButtons.forEach(button => {
    button.addEventListener('click', () => {
      tabButtons.forEach(btn => {
        btn.classList.remove('bg-gray-200', 'text-gray-900', 'shadow-sm', 'font-semibold');
        btn.classList.add('text-gray-400', 'font-medium');
      });
      button.classList.add('bg-gray-200', 'text-gray-900', 'shadow-sm', 'font-semibold');
      button.classList.remove('text-gray-400', 'font-medium');

      document.querySelectorAll('.tab-content').forEach(content => {
        content.classList.remove('active');
      });
      const tabContent = document.getElementById(button.dataset.tab + '-content');
      if (tabContent) {
        tabContent.classList.add('active');
      }
    });
  });

  const closeButton = document.getElementById('close-button');
  if (closeButton) {
    closeButton.addEventListener('click', closeAdminPanel);
  }
  
  const prevButton = document.getElementById('prev-page');
  if (prevButton) {
    prevButton.addEventListener('click', () => {
      if (currentLogPage > 1) {
        currentLogPage--;
        updateAdminLog();
      }
    });
  }
  
  const nextButton = document.getElementById('next-page');
  if (nextButton) {
    nextButton.addEventListener('click', () => {
      const totalPages = Math.ceil(adminLogs.length / logsPerPage);
      if (currentLogPage < totalPages) {
        currentLogPage++;
        updateAdminLog();
      }
    });
  }
});

function openDropdown(button, menuId) {
  const menuContainer = document.getElementById('floating-menu-container');
  if (!menuContainer) return;
  
  if (currentMenuId === menuId && menuContainer.classList.contains('open')) {
    closeAllDropdowns();
    return;
  }

  closeAllDropdowns();

  const rect = button.getBoundingClientRect();
  const playerId = menuId.replace('action-menu-', '');
  
  menuContainer.innerHTML = `
    <div class="dropdown-menu w-48 bg-[#111111] border border-gray-800 rounded-md shadow-lg overflow-hidden">
      <button class="w-full flex items-center gap-3 px-4 py-2 text-sm text-gray-300 hover:bg-gray-800 transition-colors cursor-pointer text-left" onclick="viewPlayer('${playerId}')">
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/></svg>
        <span>${t('view_details', 'View Details')}</span>
      </button>
      <button class="w-full flex items-center gap-3 px-4 py-2 text-sm text-gray-300 hover:bg-gray-800 transition-colors cursor-pointer text-left" onclick="releasePlayer('${playerId}')">
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
        <span>${t('release_player', 'Release Player')}</span>
      </button>
    </div>
  `;

  menuContainer.style.display = 'block';
  menuContainer.style.left = `${rect.left}px`;
  menuContainer.style.top = `${rect.bottom + 5}px`;

  requestAnimationFrame(() => {
    menuContainer.classList.add('open');
  });

  currentOpenButton = button;
  currentMenuId = menuId;
}

function closeAllDropdowns() {
  const menuContainer = document.getElementById('floating-menu-container');
  if (menuContainer && menuContainer.classList.contains('open')) {
    menuContainer.classList.remove('open');
    currentOpenButton = null;
    currentMenuId = null;
    setTimeout(() => {
      if (!menuContainer.classList.contains('open')) {
        menuContainer.innerHTML = '';
        menuContainer.style.display = 'none';
      }
    }, 200);
  }
}

document.addEventListener('click', (e) => {
  if (!e.target.closest('[data-menu-id]') && !e.target.closest('#floating-menu-container')) {
    closeAllDropdowns();
  }
});

document.addEventListener('click', (e) => {
  const button = e.target.closest('[data-menu-id]');
  if (button) {
    e.stopPropagation();
    openDropdown(button, button.dataset.menuId);
  }
});

function viewPlayer(playerId) {
  closeAllDropdowns();
  
  if (!adminData || !adminData.members) return;
  
  const member = adminData.members.find(m => m.serverId === parseInt(playerId));
  if (!member) return;
  
  const detailsOverlay = document.getElementById('player-details-overlay');
  if (!detailsOverlay) return;
  
  const avatarUrl = getDiscordAvatar(member);
  
  const detailsContent = document.getElementById('player-details-content');
  if (detailsContent) {
    detailsContent.innerHTML = `
      <header class="p-5 flex justify-between items-center border-b border-gray-800">
        <h2 class="text-lg font-bold text-white">${t('details_title', 'Player Details')}</h2>
        <button id="details-close-button" class="p-2 rounded-md text-gray-400 hover:bg-gray-800 transition-colors btn-press">
          <span class="material-icons-outlined text-2xl">close</span>
        </button>
      </header>

      <div class="p-6">
        <div class="flex items-center gap-4 mb-6 pb-6 border-b border-gray-800">
          <img alt="${member.name}" class="h-16 w-16 rounded-full object-cover ring-2 ring-gray-700" src="${avatarUrl}" onerror="this.src='https://placehold.co/64x64/5A5A5A/FFFFFF?text=${member.name.charAt(0).toUpperCase()}'" />
          <div>
            <h3 class="text-xl font-bold text-white">${member.name}</h3>
            <p class="text-sm text-gray-400">${t('lbl_server_id', 'Server ID: %s').replace('%s', member.serverId)}</p>
          </div>
        </div>

        <div class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-gray-400 mb-1">${t('lbl_admin', 'Admin')}</label>
            <p class="text-white font-medium">${member.adminName || 'Unknown'}</p>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-400 mb-1">${t('th_reason', 'Reason')}</label>
            <p class="text-white">${member.reason || t('no_reason', 'No reason provided')}</p>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-400 mb-1">${t('th_tasks', 'Tasks')}</label>
            <div class="flex items-center gap-3">
              <span class="text-white font-semibold text-lg">${member.tasks.completed} / ${member.tasks.total}</span>
              <div class="flex-1 h-2 bg-gray-800 rounded-full overflow-hidden">
                <div class="h-full bg-gradient-to-r from-white to-gray-400 transition-all duration-500" style="width: ${Math.round((member.tasks.completed / member.tasks.total) * 100)}%"></div>
              </div>
            </div>
          </div>

          <div class="pt-4 border-t border-gray-800">
            <label for="edit-tasks-input" class="block text-sm font-medium text-gray-400 mb-2">${t('lbl_edit_tasks', 'Edit Task Amount')}</label>
            <div class="flex gap-2">
              <input type="number" id="edit-tasks-input" class="flex-1 pl-4 pr-4 py-2 text-sm border border-gray-800 bg-[#111111] rounded-md focus:ring-2 focus:ring-white focus:border-white text-gray-100 placeholder-gray-500 transition-all" placeholder="${t('ph_new_tasks', 'New task amount')}" min="1" value="${member.tasks.total}" />
              <button id="update-tasks-button" class="px-4 py-2 text-sm font-medium border border-transparent bg-gray-200 text-gray-900 rounded-md hover:opacity-90 transition-opacity btn-press" data-player-id="${member.serverId}">
                <span class="material-icons-outlined text-xl">edit</span>
              </button>
            </div>
          </div>
        </div>
      </div>

      <footer class="p-5 flex justify-end gap-3 bg-[#030303] border-t border-gray-800">
        <button id="details-release-button" class="px-4 py-2 text-sm font-medium border border-gray-800 bg-[#111111] rounded-md hover:bg-gray-800 text-gray-300 transition-colors btn-press" data-player-id="${member.serverId}">
          <span class="flex items-center gap-2">
            <span class="material-icons-outlined text-lg">check_circle</span>
            <span>${t('btn_release', 'Release Player')}</span>
          </span>
        </button>
        <button id="details-close-button-2" class="px-4 py-2 text-sm font-medium border border-transparent bg-gray-200 text-gray-900 rounded-md hover:opacity-90 transition-opacity btn-press">
          ${t('btn_close', 'Close')}
        </button>
      </footer>
    `;
    
    const closeBtn1 = document.getElementById('details-close-button');
    const closeBtn2 = document.getElementById('details-close-button-2');
    const releaseBtn = document.getElementById('details-release-button');
    const updateBtn = document.getElementById('update-tasks-button');
    
    if (closeBtn1) closeBtn1.addEventListener('click', closePlayerDetails);
    if (closeBtn2) closeBtn2.addEventListener('click', closePlayerDetails);
    
    if (releaseBtn) {
      releaseBtn.addEventListener('click', () => {
        const pid = releaseBtn.getAttribute('data-player-id');
        releasePlayer(pid);
        closePlayerDetails();
      });
    }
    
    if (updateBtn) {
      updateBtn.addEventListener('click', () => {
        const pid = updateBtn.getAttribute('data-player-id');
        const newAmount = document.getElementById('edit-tasks-input').value;
        
        if (!newAmount || parseInt(newAmount) < 1) {
          const input = document.getElementById('edit-tasks-input');
          if (input) {
            input.classList.add('animate-shake');
            setTimeout(() => input.classList.remove('animate-shake'), 500);
          }
          return;
        }
        
        updateBtn.disabled = true;
        updateBtn.innerHTML = '<span class="material-icons-outlined text-xl animate-spin">refresh</span>';
        
        fetch(`https://${GetParentResourceName()}/editTasks`, {
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify({
            serverId: parseInt(pid),
            amount: parseInt(newAmount)
          })
        }).then(r => r.json()).then(data => {
          if (data) {
            adminData = data;
            adminLogs = data.logs || [];
            updateMembersTable(data);
            updateAdminLog();
          }
          
          updateBtn.innerHTML = '<span class="material-icons-outlined text-xl">check</span>';
          setTimeout(() => {
            updateBtn.innerHTML = '<span class="material-icons-outlined text-xl">edit</span>';
            updateBtn.disabled = false;
            closePlayerDetails();
          }, 800);
        }).catch(err => {
          updateBtn.innerHTML = '<span class="material-icons-outlined text-xl">edit</span>';
          updateBtn.disabled = false;
        });
      });
    }
  }
  
  detailsOverlay.style.display = 'flex';
  requestAnimationFrame(() => {
    detailsOverlay.style.opacity = '1';
    const content = document.getElementById('player-details-content');
    if (content) {
      content.classList.add('modal-slide-up');
    }
  });
}

function closePlayerDetails() {
  const detailsOverlay = document.getElementById('player-details-overlay');
  const detailsContent = document.getElementById('player-details-content');
  
  if (!detailsOverlay) return;
  
  if (detailsContent) {
    detailsContent.classList.remove('modal-slide-up');
    detailsContent.classList.add('modal-slide-down');
  }
  
  detailsOverlay.style.opacity = '0';
  
  setTimeout(() => {
    detailsOverlay.style.display = 'none';
    if (detailsContent) {
      detailsContent.classList.remove('modal-slide-down');
    }
  }, 300);
}

function releasePlayer(playerId) {
  closeAllDropdowns();
  fetch(`https://${GetParentResourceName()}/removePlayer`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ serverId: parseInt(playerId) })
  }).then(r => r.json()).then(data => {
    if (data) {
      adminData = data;
      adminLogs = data.logs || [];
      updateMembersTable(data);
      updateAdminLog();
    }
  }).catch(() => {});
}

const searchInput = document.getElementById('search-input');

function applyFilters() {
  if (!searchInput) return;
  currentSearch = searchInput.value.toLowerCase();
  document.querySelectorAll('.member-row').forEach(row => {
    const name = row.dataset.name.toLowerCase();
    const id = row.dataset.id.toLowerCase();
    const status = row.dataset.status;

    const matchesSearch = name.includes(currentSearch) || id.includes(currentSearch);
    const matchesFilter = (currentFilter === 'all') || (status === currentFilter);

    if (matchesSearch && matchesFilter) {
      row.style.display = '';
    } else {
      row.style.display = 'none';
    }
  });
}

if (searchInput) {
  searchInput.addEventListener('keyup', applyFilters);
}

const refreshButton = document.getElementById('refresh-button');
if (refreshButton) {
  refreshButton.addEventListener('click', () => {
    const icon = document.getElementById('refresh-icon');
    const text = document.getElementById('refresh-text');
    const tableBody = document.getElementById('members-table-body');

    if (!icon || !text || !tableBody) return;

    icon.classList.add('animate-spin');
    text.textContent = t('btn_refreshing', 'Refreshing...');
    refreshButton.disabled = true;
    tableBody.classList.add('opacity-50', 'transition-opacity');

    fetch(`https://${GetParentResourceName()}/refreshData`, {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({})
    }).then(r => r.json()).then(data => {
      setTimeout(() => {
        icon.classList.remove('animate-spin');
        text.textContent = t('btn_refresh', 'Refresh');
        refreshButton.disabled = false;
        tableBody.classList.remove('opacity-50');

        if (searchInput) searchInput.value = '';
        currentSearch = '';
        currentFilter = 'all';
        
        adminData = data;
        adminLogs = data.logs || [];
        updateMembersTable(data);
        updateAdminLog();
      }, 500);
    }).catch(err => {
      icon.classList.remove('animate-spin');
      text.textContent = t('btn_refresh', 'Refresh');
      refreshButton.disabled = false;
      tableBody.classList.remove('opacity-50');
    });
  });
}

const modalOverlay = document.getElementById('punish-modal-overlay');
const modalContent = document.getElementById('punish-modal-content');
const openModalButton = document.getElementById('punish-player-button');
const closeModalButton = document.getElementById('modal-close-button');
const cancelButton = document.getElementById('modal-cancel-button');
const submitButton = document.getElementById('modal-submit-button');

function openModal() {
  if (!modalOverlay || !modalContent) return;
  
  modalOverlay.style.display = 'flex';
  modalOverlay.classList.remove('pointer-events-none');
  
  modalContent.classList.remove('modal-slide-down');
  modalContent.classList.add('modal-slide-up');
  
  requestAnimationFrame(() => {
    modalOverlay.style.opacity = '1';
  });
}

function closeModal() {
  if (!modalOverlay || !modalContent) return;
  
  modalContent.classList.remove('modal-slide-up');
  modalContent.classList.add('modal-slide-down');
  modalOverlay.style.opacity = '0';
  
  setTimeout(() => {
    modalOverlay.style.display = 'none';
    modalOverlay.classList.add('pointer-events-none');
    modalContent.classList.remove('modal-slide-down');
    resetModalForm();
  }, 300);
}

function resetModalForm() {
  const playerIdInput = document.getElementById('player-id-input');
  const taskAmountInput = document.getElementById('task-amount-input');
  const reasonInput = document.getElementById('reason-input');

  if (playerIdInput) playerIdInput.value = '';
  if (taskAmountInput) taskAmountInput.value = '';
  if (reasonInput) reasonInput.value = '';

  selectedLocation = null;
  document.querySelectorAll('.location-option-button').forEach(btn => {
    btn.classList.remove('selected');
    const checkmark = btn.querySelector('.location-checkmark');
    if (checkmark) {
      checkmark.classList.add('opacity-0', 'scale-75');
    }
    btn.style.borderColor = 'transparent';
  });
}

if (openModalButton) {
  openModalButton.addEventListener('click', function(e) {
    e.preventDefault();
    e.stopPropagation();
    openModal();
  });
}

if (closeModalButton) {
  closeModalButton.addEventListener('click', function(e) {
    e.preventDefault();
    e.stopPropagation();
    closeModal();
  });
}

if (cancelButton) {
  cancelButton.addEventListener('click', function(e) {
    e.preventDefault();
    e.stopPropagation();
    closeModal();
  });
}

if (modalOverlay) {
  modalOverlay.addEventListener('click', (e) => {
    if (e.target === modalOverlay) {
      closeModal();
    }
  });
}

if (submitButton) {
  submitButton.addEventListener('click', (e) => {
    e.preventDefault();
    e.stopPropagation();
    
    const playerId = document.getElementById('player-id-input').value;
    const taskAmount = document.getElementById('task-amount-input').value;
    const reason = document.getElementById('reason-input').value;

    if (!playerId || selectedLocation === null || !taskAmount || !reason) {
      if (modalContent) {
        modalContent.classList.add('animate-shake');
        setTimeout(() => {
          if (modalContent) modalContent.classList.remove('animate-shake');
        }, 500);
      }
      return;
    }

    submitButton.disabled = true;
    submitButton.innerHTML = `<span class="material-icons-outlined text-xl animate-spin">refresh</span><span>${t('btn_processing', 'Processing...')}</span>`;
    submitButton.classList.add('loading-shimmer');

    fetch(`https://${GetParentResourceName()}/punishPlayer`, {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({
        playerId: playerId,
        amount: parseInt(taskAmount),
        reason: reason,
        location: selectedLocation
      })
    }).then(r => r.json()).then(data => {
      setTimeout(() => {
        if (data) {
          adminData = data;
          adminLogs = data.logs || [];
          updateMembersTable(data);
          updateAdminLog();
        }

        submitButton.disabled = false;
        submitButton.classList.remove('loading-shimmer');
        submitButton.innerHTML = `<span class="material-icons-outlined text-xl">check</span><span>${t('btn_success', 'Success!')}</span>`;
        
        setTimeout(() => {
          submitButton.innerHTML = `<span class="material-icons-outlined text-xl">gavel</span><span>${t('btn_submit', 'Submit Punishment')}</span>`;
          closeModal();
        }, 800);
      }, 300);
    }).catch(err => {
      submitButton.disabled = false;
      submitButton.classList.remove('loading-shimmer');
      submitButton.innerHTML = `<span class="material-icons-outlined text-xl">gavel</span><span>${t('btn_submit', 'Submit Punishment')}</span>`;
    });
  });
}
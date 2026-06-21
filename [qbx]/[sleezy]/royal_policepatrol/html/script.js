/*
    ╔═══════════════════════════════════════════════════════════════════╗
    ║                     ROYAL POLICE DISPATCH                         ║
    ║                       Alert System UI                             ║
    ╚═══════════════════════════════════════════════════════════════════╝
*/

// Active dispatch alerts (keyed by dispatch ID)
const activeDispatches = new Map();

// Priority configuration
const priorityConfig = {
    1: { label: 'CODE 1 - MINOR', icon: 'ℹ️', crimeIcon: '📋' },
    2: { label: 'CODE 2 - LOW', icon: '⚡', crimeIcon: '⚠️' },
    3: { label: 'CODE 3 - URGENT', icon: '⚠️', crimeIcon: '🚨' },
    4: { label: 'CODE 4 - EMERGENCY', icon: '🔴', crimeIcon: '🚔' },
    5: { label: 'CODE 5 - CRITICAL', icon: '☠️', crimeIcon: '💀' }
};

// ============================================
// NUI MESSAGE HANDLER
// ============================================
window.addEventListener('message', (event) => {
    const data = event.data;
    
    switch (data.action) {
        case 'showDispatch':
            showDispatch(data.dispatch);
            break;
            
        case 'hideDispatch':
            hideDispatch(data.dispatchId);
            break;
            
        case 'hideAllDispatches':
            hideAllDispatches();
            break;
            
        case 'updateTimer':
            updateTimer(data.dispatchId, data.remaining, data.total);
            break;
            
        case 'dispatchAccepted':
            markDispatchAccepted(data.dispatchId, data.acceptedBy);
            break;
            
        case 'dispatchExpired':
            markDispatchExpired(data.dispatchId);
            break;
            
        case 'openMDT':
            openMDT();
            break;
            
        case 'closeMDT':
            closeMDT();
            break;
            
        case 'updateMDT':
            updateMDTData(data.data);
            break;
    }
});

// ============================================
// SHOW DISPATCH ALERT
// ============================================
function showDispatch(dispatch) {
    const container = document.getElementById('dispatch-container');
    const template = document.getElementById('dispatch-template');
    
    // Clone the template
    const alert = template.content.cloneNode(true).querySelector('.dispatch-alert');
    
    // Set dispatch ID
    alert.dataset.dispatchId = dispatch.id;
    alert.dataset.priority = dispatch.priority;
    
    // Get priority config
    const priorityCfg = priorityConfig[dispatch.priority] || priorityConfig[3];
    
    // Update priority badge
    alert.querySelector('.priority-text').textContent = priorityCfg.label;
    alert.querySelector('.priority-icon').textContent = priorityCfg.icon;
    
    // Update crime details
    alert.querySelector('.crime-icon span').textContent = priorityCfg.crimeIcon;
    alert.querySelector('.crime-title').textContent = dispatch.label;
    alert.querySelector('.location-text').textContent = dispatch.street || 'Unknown Location';
    alert.querySelector('.zone-text').textContent = dispatch.zone || 'Unknown Area';
    
    // Set initial timer
    alert.querySelector('.timer-text').textContent = dispatch.expireTime || 30;
    
    // Show container if hidden
    container.classList.remove('hidden');
    
    // Add to container
    container.appendChild(alert);
    
    // Store reference
    activeDispatches.set(dispatch.id, {
        element: alert,
        data: dispatch,
        timerInterval: null,
        remaining: dispatch.expireTime || 30,
        total: dispatch.expireTime || 30
    });
    
    // Start timer animation
    startTimer(dispatch.id);
    
    // Play sound effect (handled by Lua, but we can add visual feedback)
    if (dispatch.priority >= 4) {
        // Add screen shake effect for high priority
        alert.style.animation = 'slideIn 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275), shake 0.5s ease-in-out';
    }
}

// ============================================
// TIMER FUNCTIONS
// ============================================
function startTimer(dispatchId) {
    const dispatchData = activeDispatches.get(dispatchId);
    if (!dispatchData) return;
    
    dispatchData.timerInterval = setInterval(() => {
        dispatchData.remaining--;
        updateTimerDisplay(dispatchId, dispatchData.remaining, dispatchData.total);
        
        if (dispatchData.remaining <= 0) {
            clearInterval(dispatchData.timerInterval);
            // NUI callback for expiration (Lua handles the actual expiration)
        }
    }, 1000);
}

function updateTimer(dispatchId, remaining, total) {
    const dispatchData = activeDispatches.get(dispatchId);
    if (!dispatchData) return;
    
    dispatchData.remaining = remaining;
    dispatchData.total = total;
    updateTimerDisplay(dispatchId, remaining, total);
}

function updateTimerDisplay(dispatchId, remaining, total) {
    const dispatchData = activeDispatches.get(dispatchId);
    if (!dispatchData) return;
    
    const alert = dispatchData.element;
    const timerText = alert.querySelector('.timer-text');
    const timerFg = alert.querySelector('.timer-fg');
    
    // Update text
    timerText.textContent = Math.max(0, remaining);
    
    // Update ring progress
    const progress = (remaining / total) * 100;
    timerFg.setAttribute('stroke-dasharray', `${progress}, 100`);
    
    // Critical warning when low
    if (remaining <= 10) {
        timerText.classList.add('timer-critical');
    } else {
        timerText.classList.remove('timer-critical');
    }
}

// ============================================
// HIDE DISPATCH
// ============================================
function hideDispatch(dispatchId) {
    const dispatchData = activeDispatches.get(dispatchId);
    if (!dispatchData) return;
    
    const alert = dispatchData.element;
    
    // Clear timer
    if (dispatchData.timerInterval) {
        clearInterval(dispatchData.timerInterval);
    }
    
    // Add closing animation
    alert.classList.add('closing');
    
    // Remove after animation
    setTimeout(() => {
        alert.remove();
        activeDispatches.delete(dispatchId);
        
        // Hide container if no more alerts
        if (activeDispatches.size === 0) {
            document.getElementById('dispatch-container').classList.add('hidden');
        }
    }, 300);
}

function hideAllDispatches() {
    activeDispatches.forEach((data, id) => {
        hideDispatch(id);
    });
}

// ============================================
// DISPATCH STATE UPDATES
// ============================================
function markDispatchAccepted(dispatchId, acceptedBy) {
    const dispatchData = activeDispatches.get(dispatchId);
    if (!dispatchData) return;
    
    const alert = dispatchData.element;
    alert.classList.add('accepted');
    
    // Disable buttons
    const buttons = alert.querySelectorAll('.btn');
    buttons.forEach(btn => btn.disabled = true);
    
    // Update status
    const statusText = alert.querySelector('.status-text');
    if (acceptedBy) {
        statusText.textContent = `ACCEPTED BY ${acceptedBy}`;
    } else {
        statusText.textContent = 'RESPONDING';
    }
    
    // Auto-hide after delay if accepted by someone else
    if (acceptedBy && dispatchData.data.isSelf !== true) {
        setTimeout(() => hideDispatch(dispatchId), 3000);
    }
}

function markDispatchExpired(dispatchId) {
    const dispatchData = activeDispatches.get(dispatchId);
    if (!dispatchData) return;
    
    const alert = dispatchData.element;
    alert.classList.add('ignored');
    
    // Update status
    alert.querySelector('.status-text').textContent = 'EXPIRED';
    
    // Auto-hide after delay
    setTimeout(() => hideDispatch(dispatchId), 2000);
}

// ============================================
// BUTTON ACTIONS
// ============================================
function acceptCall(button) {
    const alert = button.closest('.dispatch-alert');
    const dispatchId = parseInt(alert.dataset.dispatchId);
    
    // Send to Lua
    fetch(`https://${GetParentResourceName()}/acceptDispatch`, {
        method: 'POST',
        body: JSON.stringify({ dispatchId: dispatchId })
    });
    
    // Visual feedback
    alert.classList.add('accepted');
    button.disabled = true;
    alert.querySelector('.btn-ignore').disabled = true;
    alert.querySelector('.status-text').textContent = 'RESPONDING';
}

function ignoreCall(button) {
    const alert = button.closest('.dispatch-alert');
    const dispatchId = parseInt(alert.dataset.dispatchId);
    
    // Send to Lua
    fetch(`https://${GetParentResourceName()}/ignoreDispatch`, {
        method: 'POST',
        body: JSON.stringify({ dispatchId: dispatchId })
    });
    
    // Hide the alert
    hideDispatch(dispatchId);
}

// ============================================
// KEYBOARD SHORTCUTS
// ============================================
document.addEventListener('keydown', (e) => {
    // Only handle if we have active dispatches
    if (activeDispatches.size === 0) return;
    
    // Get the most recent (topmost) dispatch
    const lastDispatch = Array.from(activeDispatches.values()).pop();
    if (!lastDispatch || lastDispatch.element.classList.contains('accepted')) return;
    
    const dispatchId = parseInt(lastDispatch.element.dataset.dispatchId);
    
    if (e.key.toLowerCase() === 'e') {
        // Accept
        fetch(`https://${GetParentResourceName()}/acceptDispatch`, {
            method: 'POST',
            body: JSON.stringify({ dispatchId: dispatchId })
        });
        lastDispatch.element.classList.add('accepted');
        lastDispatch.element.querySelector('.status-text').textContent = 'RESPONDING';
        lastDispatch.element.querySelectorAll('.btn').forEach(b => b.disabled = true);
    } else if (e.key.toLowerCase() === 'q') {
        // Ignore
        fetch(`https://${GetParentResourceName()}/ignoreDispatch`, {
            method: 'POST',
            body: JSON.stringify({ dispatchId: dispatchId })
        });
        hideDispatch(dispatchId);
    }
});

// ============================================
// UTILITY: Get parent resource name for NUI callbacks
// ============================================
// Store reference to native function before we define our own
let nativeGetParentResourceName = null;
if (typeof GetParentResourceName !== 'undefined' && typeof GetParentResourceName === 'function') {
    nativeGetParentResourceName = GetParentResourceName;
} else if (window.GetParentResourceName && typeof window.GetParentResourceName === 'function') {
    nativeGetParentResourceName = window.GetParentResourceName;
}

function GetParentResourceName() {
    if (nativeGetParentResourceName) {
        return nativeGetParentResourceName();
    }
    return 'royal_policepatrol';
}

// ============================================
// MDT FUNCTIONS
// ============================================

function openMDT() {
    const container = document.getElementById('mdt-container');
    container.classList.remove('hidden');
}

function closeMDT() {
    const container = document.getElementById('mdt-container');
    container.classList.add('hidden');
    
    // Send close callback to Lua
    fetch(`https://${GetParentResourceName()}/closeMDT`, {
        method: 'POST',
        body: JSON.stringify({})
    });
}

function updateMDTData(data) {
    if (!data) return;
    
    // Update officer name
    const officerNameEl = document.getElementById('officer-name');
    if (officerNameEl) {
        officerNameEl.textContent = data.officerName || 'Unknown Officer';
    }
    
    // Update badge number
    const badgeNumberEl = document.getElementById('badge-number');
    if (badgeNumberEl) {
        badgeNumberEl.textContent = data.badgeNumber || 'N/A';
    }
    
    // Update patrol status
    const patrolStatusEl = document.getElementById('patrol-status-text');
    const patrolIndicatorEl = document.getElementById('patrol-indicator');
    const patrolBadgeEl = document.getElementById('patrol-status-badge');
    
    if (patrolStatusEl) {
        patrolStatusEl.textContent = data.patrolStatus || 'OFF DUTY';
    }
    
    if (patrolBadgeEl) {
        if (data.patrolStatus === 'ON DUTY') {
            patrolBadgeEl.classList.add('status-on-duty');
            patrolBadgeEl.classList.remove('status-off-duty');
            if (patrolIndicatorEl) {
                patrolIndicatorEl.style.background = '#27ae60';
            }
        } else {
            patrolBadgeEl.classList.add('status-off-duty');
            patrolBadgeEl.classList.remove('status-on-duty');
            if (patrolIndicatorEl) {
                patrolIndicatorEl.style.background = '#7f8c8d';
            }
        }
    }
    
    // Update call info
    const callInfo = data.callInfo || {};
    const callLabelEl = document.getElementById('call-label');
    const callPriorityEl = document.getElementById('call-priority');
    const callLocationEl = document.getElementById('call-location');
    const callStatusEl = document.getElementById('call-status');
    const callPriorityItem = document.getElementById('call-priority-item');
    const callLocationItem = document.getElementById('call-location-item');
    const callStatusItem = document.getElementById('call-status-item');
    
    if (callLabelEl) {
        callLabelEl.textContent = callInfo.callLabel || 'No Active Calls';
    }
    
    if (callInfo.hasCall) {
        if (callPriorityEl) {
            callPriorityEl.textContent = callInfo.callPriority || '-';
        }
        if (callLocationEl) {
            callLocationEl.textContent = callInfo.callLocation || '-';
        }
        if (callStatusEl) {
            callStatusEl.textContent = callInfo.callStatus || '-';
        }
        
        // Show call details
        if (callPriorityItem) callPriorityItem.style.display = 'flex';
        if (callLocationItem) callLocationItem.style.display = 'flex';
        if (callStatusItem) callStatusItem.style.display = 'flex';
    } else {
        // Hide call details
        if (callPriorityItem) callPriorityItem.style.display = 'none';
        if (callLocationItem) callLocationItem.style.display = 'none';
        if (callStatusItem) callStatusItem.style.display = 'none';
    }
    
    // Update crime responses
    updateCrimeResponses(data.crimeResponses || []);
    
    // Update dispatch history
    updateDispatchHistory(data.playerDispatchStats || {});
    
    // Update leaderboard
    updateDispatchLeaderboard(data.dispatchLeaderboard || []);
}

// ============================================
// UPDATE CRIME RESPONSES DISPLAY
// ============================================
function updateCrimeResponses(responses) {
    const container = document.getElementById('crime-responses');
    if (!container) return;
    
    if (!responses || responses.length === 0) {
        container.innerHTML = '<div class="crime-responses-empty">No crime response records available.</div>';
        return;
    }
    
    // Outcome labels
    const outcomeLabels = {
        resolved: 'Resolved',
        suspect_fled: 'Suspect Fled',
        suspect_arrested: 'Suspect Arrested'
    };
    
    // Outcome colors
    const outcomeColors = {
        resolved: '#27ae60',
        suspect_fled: '#e67e22',
        suspect_arrested: '#3498db'
    };
    
    // Build HTML
    let html = '<div class="crime-responses-list">';
    
    responses.forEach((record) => {
        const outcome = record.outcome || 'resolved';
        const outcomeLabel = outcomeLabels[outcome] || outcome;
        const outcomeColor = outcomeColors[outcome] || '#7f8c8d';
        
        html += `
            <div class="crime-response-item">
                <div class="crime-response-header">
                    <span class="crime-response-type">${escapeHtml(record.crimeType || 'Unknown')}</span>
                    <span class="crime-response-outcome" style="color: ${outcomeColor}">${outcomeLabel}</span>
                </div>
                <div class="crime-response-details">
                    <div class="crime-response-detail">
                        <span class="detail-label">Location:</span>
                        <span class="detail-value">${escapeHtml(record.locationString || 'Unknown Location')}</span>
                    </div>
                    <div class="crime-response-detail">
                        <span class="detail-label">Officer:</span>
                        <span class="detail-value">${escapeHtml(record.officerName || 'Unknown')}</span>
                    </div>
                    <div class="crime-response-detail">
                        <span class="detail-label">Time:</span>
                        <span class="detail-value">${escapeHtml(record.dateTime || 'Unknown')}</span>
                    </div>
                </div>
            </div>
        `;
    });
    
    html += '</div>';
    container.innerHTML = html;
}

// ============================================
// UPDATE DISPATCH HISTORY DISPLAY
// ============================================
function updateDispatchHistory(stats) {
    const container = document.getElementById('dispatch-history');
    if (!container) return;
    
    if (!stats || !stats.acceptedDispatches || stats.acceptedDispatches.length === 0) {
        container.innerHTML = '<div class="dispatch-history-empty">No dispatch history available.</div>';
        return;
    }
    
    const priorityLabels = {
        1: 'CODE 1',
        2: 'CODE 2',
        3: 'CODE 3',
        4: 'CODE 4',
        5: 'CODE 5'
    };
    
    const priorityColors = {
        1: '#27ae60',
        2: '#f39c12',
        3: '#e67e22',
        4: '#e74c3c',
        5: '#9b59b6'
    };
    
    let html = '<div class="dispatch-history-stats">';
    html += `<div class="history-stat-item"><span class="stat-label">Total Responses:</span><span class="stat-value">${stats.acceptedCount || 0}</span></div>`;
    html += '</div>';
    
    html += '<div class="dispatch-history-list">';
    
    stats.acceptedDispatches.forEach((dispatch) => {
        const priority = dispatch.priority || 3;
        const priorityLabel = priorityLabels[priority] || 'CODE 3';
        const priorityColor = priorityColors[priority] || '#7f8c8d';
        const dateTime = dispatch.acceptedAt ? new Date(dispatch.acceptedAt * 1000).toLocaleString() : 'Unknown';
        
        html += `
            <div class="dispatch-history-item">
                <div class="history-item-header">
                    <span class="history-priority" style="color: ${priorityColor}">${priorityLabel}</span>
                    <span class="history-time">${escapeHtml(dateTime)}</span>
                </div>
                <div class="history-item-details">
                    <div class="history-detail">
                        <span class="detail-label">Call:</span>
                        <span class="detail-value">${escapeHtml(dispatch.label || 'Unknown')}</span>
                    </div>
                    <div class="history-detail">
                        <span class="detail-label">Type:</span>
                        <span class="detail-value">${escapeHtml(dispatch.type || 'Unknown')}</span>
                    </div>
                </div>
            </div>
        `;
    });
    
    html += '</div>';
    container.innerHTML = html;
}

// ============================================
// UPDATE DISPATCH LEADERBOARD DISPLAY
// ============================================
function updateDispatchLeaderboard(leaderboard) {
    const container = document.getElementById('dispatch-leaderboard');
    if (!container) return;
    
    if (!leaderboard || leaderboard.length === 0) {
        container.innerHTML = '<div class="leaderboard-empty">No leaderboard data available.</div>';
        return;
    }
    
    let html = '<div class="leaderboard-list">';
    
    leaderboard.forEach((entry, index) => {
        const rank = index + 1;
        const rankClass = rank === 1 ? 'rank-first' : rank === 2 ? 'rank-second' : rank === 3 ? 'rank-third' : '';
        const rankIcon = rank === 1 ? '🥇' : rank === 2 ? '🥈' : rank === 3 ? '🥉' : '';
        
        html += `
            <div class="leaderboard-item ${rankClass}">
                <div class="leaderboard-rank">
                    <span class="rank-number">${rankIcon || rank}</span>
                </div>
                <div class="leaderboard-info">
                    <div class="leaderboard-name">${escapeHtml(entry.playerName || 'Unknown')}</div>
                    <div class="leaderboard-stats">
                        <span class="stat-badge">${entry.acceptedCount || 0} Responses</span>
                    </div>
                </div>
            </div>
        `;
    });
    
    html += '</div>';
    container.innerHTML = html;
}

// Escape HTML to prevent XSS
function escapeHtml(text) {
    if (!text) return '';
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

// Handle ESC key to close MDT
document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
        const mdtContainer = document.getElementById('mdt-container');
        if (mdtContainer && !mdtContainer.classList.contains('hidden')) {
            closeMDT();
        }
    }
});

// ============================================
// Add shake animation for critical alerts
// ============================================
const style = document.createElement('style');
style.textContent = `
    @keyframes shake {
        0%, 100% { transform: translateX(0); }
        10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
        20%, 40%, 60%, 80% { transform: translateX(5px); }
    }
`;
document.head.appendChild(style);


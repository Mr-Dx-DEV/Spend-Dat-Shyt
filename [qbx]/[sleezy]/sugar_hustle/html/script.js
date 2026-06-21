// ════════════════════════════════════════════════════════════════
// SUGARHUSTLE NUI - JAVASCRIPT CONTROLLER
// ════════════════════════════════════════════════════════════════

// State Management
let currentPartner = null;
let currentProfile = null;
let relationshipLevel = 0;
let soundEnabled = true;
let notificationsEnabled = true;
let profilesData = [];
let usedProfileIds = [];
let nuiIsOpen = false; // tracks whether the NUI has been opened via Lua

// DOM Elements
const appContainer = document.getElementById('app-container');
const noPartnerState = document.getElementById('no-partner');
const partnerProfile = document.getElementById('partner-profile');

// Buttons
const closeBtn = document.getElementById('closeBtn');
const findPartnerBtn = document.getElementById('findPartnerBtn');
const flirtBtn = document.getElementById('flirtBtn');
const giftBtn = document.getElementById('giftBtn');
const argueBtn = document.getElementById('argueBtn');
const dateBtn = document.getElementById('dateBtn');
const robberyBtn = document.getElementById('robberyBtn');
const endArrangementBtn = document.getElementById('endArrangementBtn');
const plugBtn = document.getElementById('plugBtn');

// ════════════════════════════════════════════════════════════════
// INITIALIZATION
// ════════════════════════════════════════════════════════════════

document.addEventListener('DOMContentLoaded', () => {
    console.log('=== SUGAR HUSTLE NUI LOADED ===');
    console.log('App container element:', appContainer);
    console.log('Starting initialization...');
    
    initializeEventListeners();
    initializeTabSwitching();
    loadProfiles();
    
    console.log('=== INITIALIZATION COMPLETE ===');
});

// Listen for messages from Lua
window.addEventListener('message', (event) => {
    const data = event.data;
    
    console.log('NUI Message received:', data.action, data);
    
    switch(data.action) {
        case 'openUI':
            console.log('Opening UI...');
            nuiIsOpen = true;
            openUI();
            if (plugBtn) {
                plugBtn.style.display = data.showPlugButton ? '' : 'none';
            }
            break;
        case 'closeUI':
            nuiIsOpen = false;
            closeUI();
            break;
        case 'updatePartner':
            updatePartnerDisplay(data.partner, data.partners, data.currentPartnerId, data.maxPartners);
            break;
        case 'updateRelationship':
            updateRelationship(data.level);
            break;
        case 'showNotification':
            showNotification(data.message, data.type);
            break;
        case 'showCooldown':
            showCooldown(data.message, data.duration);
            break;
        case 'clearPartner':
            clearPartner(data.partners, data.currentPartnerId);
            break;
        case 'triggerHearts':
            createFloatingHearts();
            break;
        case 'playAnimation':
            playAnimation(data.animationType);
            break;
        case 'getRandomProfile':
            handleGetRandomProfile();
            break;
        case 'openPlugConversation':
            openPlugConversation(data);
            break;
        case 'plugConversationAdd':
            if (data.message) plugConversationAddMessage(data.message, data.isPlug !== false);
            plugConversationSetReplies(data.replies || []);
            break;
        case 'closePlugConversation':
            closePlugConversation();
            break;
        case 'setPartnerMessages':
            setPartnerMessages(data.partnerName, data.messages || []);
            break;
        case 'addPartnerChatReply':
            addPartnerChatReply(data.playerText, data.partnerText);
            break;
    }
});

function handleGetRandomProfile() {
    // This is called from Lua to trigger profile selection
    // The actual profile will be applied when updatePartner is called
}

// ════════════════════════════════════════════════════════════════
// EVENT LISTENERS
// ════════════════════════════════════════════════════════════════

function initializeEventListeners() {
    // Close button
    closeBtn.addEventListener('click', () => {
        closeUI();
        sendNUIMessage('closeApp');
    });
    
    // ESC key to close
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
            closeUI();
            sendNUIMessage('closeApp');
        }
    });
    
    // Find Partner button – disabled while request is in-flight to prevent duplicate fetches
    findPartnerBtn.addEventListener('click', () => {
        if (findPartnerBtn.disabled) return;
        findPartnerBtn.disabled = true;
        createFloatingHearts();
        if (!nuiIsOpen) {
            findPartnerBtn.disabled = false;
            return;
        }
        fetch(`https://sugar_hustle/findPartner`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({})
        })
        .then(response => {
            console.log('NUI callback response: findPartner', response);
        })
        .catch(err => {
            console.error('NUI callback error: findPartner', err);
        })
        .finally(() => {
            findPartnerBtn.disabled = false;
            const findAnotherBtn = document.getElementById('findAnotherPartnerBtn');
            if (findAnotherBtn) findAnotherBtn.disabled = false;
        });
    });
    
    // Find another partner (same action as Find Partner, when already have partner(s))
    const findAnotherPartnerBtn = document.getElementById('findAnotherPartnerBtn');
    if (findAnotherPartnerBtn) {
        findAnotherPartnerBtn.addEventListener('click', () => {
            if (findAnotherPartnerBtn.disabled || (findPartnerBtn && findPartnerBtn.disabled)) return;
            findAnotherPartnerBtn.disabled = true;
            if (findPartnerBtn) findPartnerBtn.disabled = true;
            fetch(`https://sugar_hustle/findPartner`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            })
            .then(response => {})
            .catch(err => console.error('NUI callback error: findPartner', err))
            .finally(() => {
                findAnotherPartnerBtn.disabled = false;
                if (findPartnerBtn) findPartnerBtn.disabled = false;
            });
        });
    }
    
    // Action buttons
    flirtBtn.addEventListener('click', () => {
        createFloatingHearts();
        sendNUIMessage('flirt');
    });
    
    giftBtn.addEventListener('click', () => {
        sendNUIMessage('askGift');
    });
    
    argueBtn.addEventListener('click', () => {
        playAnimation('shake');
        sendNUIMessage('argue');
    });
    
    if (plugBtn) {
        plugBtn.addEventListener('click', () => {
            sendNUIMessage('contactPlug');
        });
    }

    const plugConversationBack = document.getElementById('plugConversationBack');
    if (plugConversationBack) {
        plugConversationBack.addEventListener('click', () => {
            closePlugConversation();
            sendNUIMessage('plugConversationReply', { step: 'cancel' });
        });
    }
    
    // Go on date button
    dateBtn.addEventListener('click', () => {
        console.log('Go on date button clicked');
        sendNUIMessage('goOnDate');
    });
    
    // Robbery button
    robberyBtn.addEventListener('click', () => {
        console.log('Robbery button clicked');
        playAnimation('shake');
        sendNUIMessage('lureAndRob');
    });
    
    // End arrangement
    endArrangementBtn.addEventListener('click', () => {
        console.log('End arrangement button clicked');
        console.log('Sending endArrangement callback');
        sendNUIMessage('endArrangement');
    });
    
    // Partner selector (multiple partners)
    const partnerSelector = document.getElementById('partnerSelector');
    if (partnerSelector) {
        partnerSelector.addEventListener('change', () => {
            const id = partnerSelector.value;
            if (id) sendNUIMessage('selectPartner', { partnerId: id });
        });
    }
    
    // Text partner (AI chat) - Send button and Enter key
    const partnerChatInput = document.getElementById('partnerChatInput');
    const partnerChatSend = document.getElementById('partnerChatSend');
    if (partnerChatSend && partnerChatInput) {
        function sendPartnerChat() {
            const text = partnerChatInput.value.trim();
            if (!text) return;
            sendNUIMessage('sendPartnerChatMessage', { message: text });
            partnerChatInput.value = '';
        }
        partnerChatSend.addEventListener('click', sendPartnerChat);
        partnerChatInput.addEventListener('keydown', (e) => {
            if (e.key === 'Enter') { e.preventDefault(); sendPartnerChat(); }
        });
    }
}

// ════════════════════════════════════════════════════════════════
// TAB SWITCHING
// ════════════════════════════════════════════════════════════════

function initializeTabSwitching() {
    const navTabs = document.querySelectorAll('.nav-tab');
    const tabContents = document.querySelectorAll('.tab-content');
    
    navTabs.forEach(tab => {
        tab.addEventListener('click', () => {
            const targetTab = tab.getAttribute('data-tab');
            
            // Remove active class from all tabs and contents
            navTabs.forEach(t => t.classList.remove('active'));
            tabContents.forEach(c => c.classList.remove('active'));
            
            // Add active class to clicked tab and corresponding content
            tab.classList.add('active');
            document.getElementById(`${targetTab}-tab`).classList.add('active');
        });
    });
}

// ════════════════════════════════════════════════════════════════
// PROFILE LOADING
// ════════════════════════════════════════════════════════════════

async function loadProfiles() {
    try {
        const response = await fetch('profiles.json');
        const data = await response.json();
        profilesData = data.profiles;
        console.log('Loaded', profilesData.length, 'profiles');
    } catch (error) {
        console.error('Failed to load profiles:', error);
        // Fallback to empty array
        profilesData = [];
    }
}

function getRandomProfile(gender = null) {
    if (profilesData.length === 0) {
        console.warn('No profiles loaded');
        return null;
    }
    
    // Filter by gender if specified
    let availableProfiles = gender 
        ? profilesData.filter(p => p.gender === gender && !usedProfileIds.includes(p.id))
        : profilesData.filter(p => !usedProfileIds.includes(p.id));
    
    // If all profiles used, reset the used list
    if (availableProfiles.length === 0) {
        usedProfileIds = [];
        availableProfiles = gender 
            ? profilesData.filter(p => p.gender === gender)
            : profilesData;
    }
    
    // Select random profile
    const randomIndex = Math.floor(Math.random() * availableProfiles.length);
    const profile = availableProfiles[randomIndex];
    
    // Mark as used
    usedProfileIds.push(profile.id);
    
    return profile;
}

// ════════════════════════════════════════════════════════════════
// UI CONTROL FUNCTIONS
// ════════════════════════════════════════════════════════════════

function openUI() {
    console.log('openUI() called');
    console.log('App container before:', appContainer.style.display, appContainer.classList);
    
    appContainer.style.display = 'flex';
    appContainer.classList.add('show');
    appContainer.classList.remove('hidden');
    document.body.style.overflow = 'hidden';
    
    console.log('App container after:', appContainer.style.display, appContainer.classList);
    console.log('UI should now be visible');
}

function closeUI() {
    console.log('closeUI() called');
    
    nuiIsOpen = false;
    appContainer.style.display = 'none';
    appContainer.classList.remove('show');
    appContainer.classList.add('hidden');
    document.body.style.overflow = '';
    if (findPartnerBtn) findPartnerBtn.disabled = false;
    
    console.log('UI closed');
}

function updatePartnerDisplay(partner, partnersList, currentPartnerId, maxPartners) {
    if (!partner) {
        clearPartner(partnersList || [], currentPartnerId);
        return;
    }
    
    currentPartner = partner;
    
    // Partner selector: show when multiple partners
    const selectorWrap = document.getElementById('partner-selector-wrap');
    const selectorEl = document.getElementById('partnerSelector');
    if (selectorWrap && selectorEl && partnersList && partnersList.length > 1) {
        selectorWrap.classList.remove('hidden');
        selectorEl.innerHTML = '';
        partnersList.forEach(p => {
            const opt = document.createElement('option');
            opt.value = p.id;
            opt.textContent = p.name || 'Partner';
            if (p.id === currentPartnerId) opt.selected = true;
            selectorEl.appendChild(opt);
        });
        selectorEl.value = currentPartnerId || (partnersList[0] && partnersList[0].id);
    } else if (selectorWrap) {
        selectorWrap.classList.add('hidden');
    }
    
    // Find another partner: show when under max (so player can add more)
    const findAnotherWrap = document.getElementById('find-another-partner-wrap');
    const findAnotherBtn = document.getElementById('findAnotherPartnerBtn');
    const count = (partnersList && partnersList.length) || 0;
    const max = (typeof maxPartners === 'number' && maxPartners >= 1) ? maxPartners : 1;
    if (findAnotherWrap && findAnotherBtn) {
        if (count < max) {
            findAnotherWrap.classList.remove('hidden');
        } else {
            findAnotherWrap.classList.add('hidden');
        }
    }
    
    if (partner.hasProfileData && profilesData.length > 0) {
        let matchingProfile = null;

        // If partner already has a saved profileId, look it up instead of picking randomly
        if (partner.profileId) {
            matchingProfile = profilesData.find(p => p.id === partner.profileId) || null;
        }

        // First time: pick a random profile and persist the choice
        if (!matchingProfile) {
            const profileGender = partner.gender.toLowerCase();
            matchingProfile = getRandomProfile(profileGender);
        }
        
        if (matchingProfile) {
            currentProfile = matchingProfile;
            partner.profile = matchingProfile;
            partner.name = matchingProfile.name;
            partner.profileId = matchingProfile.id;
            
            sendNUIMessage('updatePartnerName', {
                name: matchingProfile.name,
                profileId: matchingProfile.id
            });
            
            displayProfileData(matchingProfile, partner);
        } else {
            displayBasicPartner(partner);
        }
    } else if (partner.profileId && profilesData.length > 0) {
        const savedProfile = profilesData.find(p => p.id === partner.profileId);
        if (savedProfile) {
            currentProfile = savedProfile;
            partner.profile = savedProfile;
            partner.name = savedProfile.name;
            displayProfileData(savedProfile, partner);
        } else {
            displayBasicPartner(partner);
        }
    } else if (partner.profile) {
        currentProfile = partner.profile;
        displayProfileData(partner.profile, partner);
    } else {
        displayBasicPartner(partner);
    }
    
    // Hide no partner state, show profile
    noPartnerState.classList.add('hidden');
    partnerProfile.classList.remove('hidden');
    
    // Show "Text partner" compose when partner exists
    const compose = document.getElementById('partnerChatCompose');
    if (compose) compose.classList.remove('hidden');
    
    // Update relationship
    updateRelationship(partner.relationshipLevel);
}

function displayProfileData(profile, partner) {
    // Update profile picture
    const profilePic = document.getElementById('profilePicture');
    const profileIconFallback = document.getElementById('profileIconFallback');
    
    if (profile.image) {
        // Ensure proper path for NUI
        const imagePath = profile.image.startsWith('http') ? profile.image : profile.image;
        console.log('Loading profile image:', imagePath);
        
        profilePic.src = imagePath;
        profilePic.style.display = 'block';
        profileIconFallback.style.display = 'none';
        
        // Add error handler
        profilePic.onerror = function() {
            console.error('Failed to load image:', imagePath);
            profilePic.style.display = 'none';
            profileIconFallback.style.display = 'flex';
        };
    } else {
        console.log('No image for profile');
        profilePic.style.display = 'none';
        profileIconFallback.style.display = 'flex';
    }
    
    // Update name and age
    document.getElementById('partnerName').textContent = profile.name;
    document.getElementById('partnerAge').textContent = profile.age || '';
    
    // Update occupation
    document.getElementById('partnerOccupation').textContent = profile.occupation || '';
    
    // Update bio
    document.getElementById('partnerBio').textContent = profile.bio || getPersonalityBio(profile.personality);
    
    // Update gender tag
    const genderTag = document.getElementById('genderTag');
    const genderIcon = document.getElementById('genderIcon');
    const genderText = document.getElementById('genderText');
    
    if (profile.gender === 'male') {
        genderTag.classList.add('male');
        genderTag.classList.remove('female');
        genderIcon.className = 'fas fa-mars';
        genderText.textContent = 'Male';
    } else {
        genderTag.classList.add('female');
        genderTag.classList.remove('male');
        genderIcon.className = 'fas fa-venus';
        genderText.textContent = 'Female';
    }
    
    // Update personality tag
    const personalityTag = document.getElementById('personalityTag');
    personalityTag.textContent = profile.personalityLabel || partner.personality.label;
    personalityTag.className = 'tag personality-tag ' + profile.personality;
    
    // Update personality icon
    document.getElementById('personalityIcon').textContent = profile.personalityIcon || partner.personality.icon;
    
    // Update traits
    const traitsContainer = document.getElementById('profileTraits');
    traitsContainer.innerHTML = '';
    if (profile.traits && profile.traits.length > 0) {
        profile.traits.forEach(trait => {
            const traitBadge = document.createElement('span');
            traitBadge.className = 'trait-badge';
            traitBadge.textContent = trait;
            traitsContainer.appendChild(traitBadge);
        });
    }
}

function displayBasicPartner(partner) {
    // Fallback for partners without profile data
    const profileIconFallback = document.getElementById('profileIconFallback');
    const profilePic = document.getElementById('profilePicture');
    
    profilePic.style.display = 'none';
    profileIconFallback.style.display = 'flex';
    
    document.getElementById('partnerName').textContent = partner.name;
    document.getElementById('partnerAge').textContent = '';
    document.getElementById('partnerOccupation').textContent = '';
    document.getElementById('partnerBio').textContent = getPersonalityBio(partner.personality.type);
    
    const genderTag = document.getElementById('genderTag');
    const genderIcon = document.getElementById('genderIcon');
    const genderText = document.getElementById('genderText');
    
    if (partner.gender === 'Male') {
        genderTag.classList.add('male');
        genderIcon.className = 'fas fa-mars';
        genderText.textContent = 'Male';
    } else {
        genderTag.classList.add('female');
        genderIcon.className = 'fas fa-venus';
        genderText.textContent = 'Female';
    }
    
    document.getElementById('personalityTag').textContent = partner.personality.label;
    document.getElementById('personalityIcon').textContent = partner.personality.icon;
    
    document.getElementById('profileTraits').innerHTML = '';
}

function clearPartner(partnersList, currentPartnerId) {
    console.log('clearPartner() called');
    
    currentPartner = null;
    currentProfile = null;
    relationshipLevel = 0;
    
    const selectorWrap = document.getElementById('partner-selector-wrap');
    const selectorEl = document.getElementById('partnerSelector');
    if (selectorWrap) selectorWrap.classList.add('hidden');
    if (selectorEl) selectorEl.innerHTML = '';
    
    // Show no partner state, hide profile and chat compose
    noPartnerState.classList.remove('hidden');
    partnerProfile.classList.add('hidden');
    const compose = document.getElementById('partnerChatCompose');
    if (compose) compose.classList.add('hidden');
    
    console.log('Partner cleared, showing empty state');
}

function updateRelationship(level) {
    relationshipLevel = level;
    
    // Update value text
    document.getElementById('relationshipValue').textContent = `${level}/100`;
    
    // Update progress bar
    const fillBar = document.getElementById('relationshipFill');
    fillBar.style.width = `${level}%`;
    
    // Update hearts
    const hearts = document.querySelectorAll('.heart-icon');
    const filledHearts = Math.floor(level / 20);
    hearts.forEach((heart, index) => {
        if (index < filledHearts) {
            heart.classList.add('filled');
        } else {
            heart.classList.remove('filled');
        }
    });
    
    // Update tier text
    const tierText = getRelationshipTier(level);
    document.getElementById('relationshipTier').textContent = tierText;
}

// ════════════════════════════════════════════════════════════════
// NOTIFICATION SYSTEM
// ════════════════════════════════════════════════════════════════

function showNotification(message, type = 'success') {
    const notification = document.getElementById('notification');
    const notificationText = document.querySelector('.notification-text');
    const notificationIcon = document.querySelector('.notification-icon');
    
    // Set icon based on type
    notificationIcon.className = 'notification-icon';
    if (type === 'error') {
        notificationIcon.classList.add('error');
        notificationIcon.className = 'fas fa-times-circle notification-icon error';
    } else if (type === 'warning') {
        notificationIcon.classList.add('warning');
        notificationIcon.className = 'fas fa-exclamation-triangle notification-icon warning';
    } else {
        notificationIcon.className = 'fas fa-check-circle notification-icon';
    }
    
    // Set message
    notificationText.textContent = message;
    
    // Show notification
    notification.classList.remove('hidden');
    
    // Auto-hide after 3 seconds
    setTimeout(() => {
        notification.classList.add('hidden');
    }, 3000);
}

function showCooldown(message, duration) {
    const cooldownOverlay = document.getElementById('cooldownOverlay');
    const cooldownMessage = document.getElementById('cooldownMessage');
    const cooldownTimer = document.getElementById('cooldownTimer');
    
    cooldownMessage.textContent = message;
    cooldownOverlay.classList.remove('hidden');
    
    // Update timer
    let remaining = duration;
    const timerInterval = setInterval(() => {
        const minutes = Math.floor(remaining / 60);
        const seconds = remaining % 60;
        cooldownTimer.textContent = `${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`;
        
        remaining--;
        
        if (remaining < 0) {
            clearInterval(timerInterval);
            cooldownOverlay.classList.add('hidden');
        }
    }, 1000);
}

// ════════════════════════════════════════════════════════════════
// ANIMATIONS
// ════════════════════════════════════════════════════════════════

function createFloatingHearts() {
    const container = document.getElementById('heartsContainer');
    
    for (let i = 0; i < 10; i++) {
        setTimeout(() => {
            const heart = document.createElement('div');
            heart.className = 'floating-heart';
            heart.innerHTML = '❤️';
            heart.style.left = `${Math.random() * 100}%`;
            heart.style.animationDelay = `${Math.random() * 0.5}s`;
            
            container.appendChild(heart);
            
            // Remove heart after animation
            setTimeout(() => {
                heart.remove();
            }, 3000);
        }, i * 100);
    }
}

function playAnimation(animationType) {
    const profileCard = document.querySelector('.profile-card');
    
    if (animationType === 'shake') {
        profileCard.classList.add('shake');
        setTimeout(() => {
            profileCard.classList.remove('shake');
        }, 500);
    } else if (animationType === 'pulse') {
        profileCard.classList.add('pulse');
        setTimeout(() => {
            profileCard.classList.remove('pulse');
        }, 1000);
    }
}

// ════════════════════════════════════════════════════════════════
// UTILITY FUNCTIONS
// ════════════════════════════════════════════════════════════════

function getPersonalityBio(personalityType) {
    const bios = {
        'generous': 'A generous soul who loves to spoil their partners with gifts and experiences.',
        'jealous': 'Passionate and intense, expects loyalty and attention at all times.',
        'cheap': 'Prefers experiences over material things, but can be stingy with gifts.',
        'mysterious': 'An enigmatic personality that keeps you guessing and wanting more.'
    };
    return bios[personalityType] || 'A fascinating individual with unique charm.';
}

function getRelationshipTier(level) {
    if (level >= 76) return '💕 Passionate';
    if (level >= 51) return '🔥 Hot';
    if (level >= 26) return '🌤️ Warm';
    return '❄️ Cold';
}

// ════════════════════════════════════════════════════════════════
// PLUG CONVERSATION
// ════════════════════════════════════════════════════════════════

function openPlugConversation(data) {
    const panel = document.getElementById('plugConversation');
    const nameEl = document.getElementById('plugConversationName');
    const messagesEl = document.getElementById('plugConversationMessages');
    const repliesEl = document.getElementById('plugConversationReplies');
    if (!panel || !messagesEl || !repliesEl) return;

    nameEl.textContent = data.contactName || 'The Plug';
    messagesEl.innerHTML = '';
    repliesEl.innerHTML = '';

    if (data.openingMessage) {
        const bubble = document.createElement('div');
        bubble.className = 'msg-bubble plug';
        bubble.textContent = data.openingMessage;
        messagesEl.appendChild(bubble);
    }
    plugConversationSetReplies(data.replies || []);
    panel.classList.remove('hidden');
}

function plugConversationAddMessage(text, isPlug = true) {
    const messagesEl = document.getElementById('plugConversationMessages');
    if (!messagesEl) return;
    const bubble = document.createElement('div');
    bubble.className = 'msg-bubble ' + (isPlug ? 'plug' : 'player');
    bubble.textContent = text;
    messagesEl.appendChild(bubble);
    messagesEl.scrollTop = messagesEl.scrollHeight;
}

function plugConversationSetReplies(replies) {
    const repliesEl = document.getElementById('plugConversationReplies');
    if (!repliesEl) return;
    repliesEl.innerHTML = '';
    replies.forEach(r => {
        const btn = document.createElement('button');
        btn.className = 'reply-btn' + (r.cancel ? ' cancel' : '');
        btn.type = 'button';
        if (r.icon) {
            const icon = document.createElement('i');
            icon.className = 'fas fa-' + r.icon;
            btn.appendChild(icon);
        }
        btn.appendChild(document.createTextNode(r.label));
        btn.addEventListener('click', () => {
            repliesEl.innerHTML = '';
            plugConversationAddMessage(r.label, false);
            sendNUIMessage('plugConversationReply', { step: r.step, choice: r.choice, drugId: r.drugId });
        });
        repliesEl.appendChild(btn);
    });
}

function closePlugConversation() {
    const panel = document.getElementById('plugConversation');
    if (panel) panel.classList.add('hidden');
}

function sendNUIMessage(action, data = {}) {
    if (!nuiIsOpen) {
        console.warn('sendNUIMessage skipped (NUI not open):', action);
        return;
    }
    console.log('Sending NUI callback:', action, data);
    
    fetch(`https://sugar_hustle/${action}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
    .then(response => {
        console.log('NUI callback response:', action, response);
    })
    .catch(err => {
        console.error('NUI callback error:', action, err);
    });
}

// ════════════════════════════════════════════════════════════════
// MESSAGES TAB FUNCTIONALITY
// ════════════════════════════════════════════════════════════════

function addMessage(sender, text, time) {
    const messagesList = document.getElementById('messagesList');
    const emptyMessages = messagesList.querySelector('.empty-messages');
    
    // Remove empty state if exists
    if (emptyMessages) {
        emptyMessages.remove();
    }
    
    const messageItem = document.createElement('div');
    messageItem.className = 'message-item';
    messageItem.innerHTML = `
        <div class="message-sender">${sender}</div>
        <div class="message-text">${text}</div>
        <div class="message-time">${time}</div>
    `;
    
    messagesList.insertBefore(messageItem, messagesList.firstChild);
}

/** Append one message to the messages list (for AI chat reply). Sender = 'You' or partner name. */
function addMessageToMessagesList(sender, text, timeAgo) {
    const messagesList = document.getElementById('messagesList');
    const emptyMessages = messagesList.querySelector('.empty-messages');
    if (emptyMessages) emptyMessages.remove();
    const messageItem = document.createElement('div');
    messageItem.className = 'message-item' + (sender === 'You' ? ' message-item--you' : '');
    messageItem.innerHTML = `
        <div class="message-sender">${sender}</div>
        <div class="message-text">${text}</div>
        <div class="message-time">${timeAgo || 'Just now'}</div>
    `;
    messagesList.insertBefore(messageItem, messagesList.firstChild);
}

/** Add AI chat exchange: player message + partner reply (called from Lua after server returns). */
function addPartnerChatReply(playerText, partnerText) {
    if (!currentPartner) return;
    const partnerName = currentPartner.name || 'Partner';
    addMessageToMessagesList(partnerName, partnerText, 'Just now');
    addMessageToMessagesList('You', playerText, 'Just now');
}

/** Populate Messages tab from Lua (partner name + array of { text, timeAgo, isMeetRequest?, locationIndex?, locationLabel?, expiresInSeconds? }) */
function setPartnerMessages(partnerName, messages) {
    const messagesList = document.getElementById('messagesList');
    messagesList.innerHTML = '';

    if (!partnerName || !messages || messages.length === 0) {
        const empty = document.createElement('div');
        empty.className = 'empty-messages';
        empty.innerHTML = '<i class="fas fa-envelope-open"></i><p>No messages yet. Find a partner to start chatting!</p>';
        messagesList.appendChild(empty);
        return;
    }

    const sender = partnerName;
    messages.forEach(msg => {
        if (msg.isBlackmail && msg.amount != null) {
            const item = document.createElement('div');
            item.className = 'message-item message-item--blackmail';
            const payLabel = `Pay $${msg.amount}`;
            const expiresAt = msg.expiresAt || 0;
            item.innerHTML = `
                <div class="message-sender">${msg.partnerName || sender}</div>
                <div class="message-text">${msg.text || ''}</div>
                <div class="message-time">${msg.timeAgo || 'Just now'}</div>
                <div class="message-blackmail-timer" data-expires="${expiresAt}">Time left: --</div>
                <button type="button" class="message-blackmail-pay-btn" data-partner-id="${msg.partnerId || ''}" data-amount="${msg.amount}">
                    <i class="fas fa-dollar-sign"></i> ${payLabel}
                </button>
            `;
            const btn = item.querySelector('.message-blackmail-pay-btn');
            if (btn) {
                btn.addEventListener('click', () => {
                    sendNUIMessage('payBlackmail', { partnerId: btn.getAttribute('data-partner-id') || '' });
                });
            }
            const timerEl = item.querySelector('.message-blackmail-timer');
            if (timerEl && expiresAt > 0) {
                const updateTimer = () => {
                    const now = Math.floor(Date.now() / 1000);
                    const left = Math.max(0, expiresAt - now);
                    if (left <= 0) {
                        timerEl.textContent = 'Time\'s up!';
                        timerEl.classList.add('expired');
                        if (btn) btn.disabled = true;
                        return;
                    }
                    const m = Math.floor(left / 60);
                    const s = left % 60;
                    timerEl.textContent = `Time left: ${m}:${s.toString().padStart(2, '0')}`;
                };
                updateTimer();
                const interval = setInterval(updateTimer, 1000);
                setTimeout(() => clearInterval(interval), (expiresAt - Math.floor(Date.now() / 1000)) * 1000 + 2000);
            }
            messagesList.appendChild(item);
        } else if (msg.isMeetRequest && msg.locationLabel != null) {
            const item = document.createElement('div');
            item.className = 'message-item message-item--meet-request';
            const expiresNote = msg.expiresInSeconds ? `<span class="message-meet-expiry">Limited time</span>` : '';
            item.innerHTML = `
                <div class="message-sender">${sender}</div>
                <div class="message-text">${msg.text}</div>
                <div class="message-time">${msg.timeAgo || 'Just now'}</div>
                ${expiresNote}
                <button type="button" class="message-meet-btn" data-location-index="${msg.locationIndex}">
                    <i class="fas fa-map-marker-alt"></i> Meet at ${msg.locationLabel}
                </button>
            `;
            const btn = item.querySelector('.message-meet-btn');
            if (btn) {
                btn.addEventListener('click', () => {
                    sendNUIMessage('acceptMeetRequest', { locationIndex: parseInt(btn.getAttribute('data-location-index'), 10) });
                });
            }
            messagesList.appendChild(item);
        } else {
            const messageItem = document.createElement('div');
            messageItem.className = 'message-item';
            messageItem.innerHTML = `
                <div class="message-sender">${sender}</div>
                <div class="message-text">${msg.text}</div>
                <div class="message-time">${msg.timeAgo || 'Just now'}</div>
            `;
            messagesList.appendChild(messageItem);
        }
    });
}

// Add sample messages when partner is found (browser test fallback)
function addSampleMessages(partnerName) {
    const messages = [
        { text: 'Hey there! Looking forward to meeting you 💕', time: 'Just now' },
        { text: 'I love spending time with interesting people', time: '2 minutes ago' },
        { text: 'Let me know when you want to meet up', time: '5 minutes ago' }
    ];
    
    messages.forEach(msg => {
        addMessage(partnerName, msg.text, msg.time);
    });
}

// ════════════════════════════════════════════════════════════════
// TESTING FUNCTIONS (for browser development)
// ════════════════════════════════════════════════════════════════

// Test function to simulate partner data (only for browser testing)
if (window.location.protocol === 'file:') {
    console.log('Running in browser test mode');
    
    // Auto-open UI for testing ONLY in browser
    setTimeout(() => {
        openUI();
        
        // Test with sample partner
        const testPartner = {
            name: 'Victoria Diamond',
            gender: 'Female',
            personality: {
                type: 'generous',
                icon: '💎',
                label: 'Generous'
            },
            relationshipLevel: 45,
            hasProfileData: true
        };
        
        updatePartnerDisplay(testPartner);
        addSampleMessages('Victoria Diamond');
    }, 500);
} else {
    console.log('Running in FiveM - UI hidden by default');
}


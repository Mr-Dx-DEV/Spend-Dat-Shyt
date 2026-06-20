document.addEventListener('DOMContentLoaded', function () {

    /* ── Helpers ───────────────────────────────────────────────────── */
    const $ = id => document.getElementById(id);
    const clickSound = $('click-sound');
    const notifSound = $('notification-sound');

    function playClick() {
        if (clickSound) { clickSound.currentTime = 0; clickSound.play().catch(() => {}); }
    }

    /* ── Time & status ─────────────────────────────────────────────── */
    function updateTime() {
        const el = $('status-time');
        if (!el) return;
        const now = new Date();
        el.textContent = now.getHours().toString().padStart(2, '0') + ':' +
                         now.getMinutes().toString().padStart(2, '0');
    }
    updateTime();
    setInterval(updateTime, 1000);

    function updateWifi() {
        const el = $('wifi-icon');
        if (el) el.className = navigator.onLine ? 'fas fa-wifi' : 'fas fa-times-circle';
    }
    updateWifi();
    window.addEventListener('online',  updateWifi);
    window.addEventListener('offline', updateWifi);

    /* ── In-screen view navigation ─────────────────────────────────── */
    const homeView = $('view-home');

    function openPanel(panelId) {
        playClick();
        homeView.classList.add('slide-out');
        const panel = $(panelId);
        panel.classList.add('slide-in');
    }

    function closePanel(panelId) {
        playClick();
        const panel = $(panelId);
        panel.classList.remove('slide-in');
        homeView.classList.remove('slide-out');
    }

    /* Deliver */
    $('btn-deliver').addEventListener('click', () => openPanel('view-deliver'));
    $('back-deliver').addEventListener('click', () => closePanel('view-deliver'));

    /* Settings */
    $('btn-settings').addEventListener('click', () => openPanel('view-settings'));
    $('back-settings').addEventListener('click', () => closePanel('view-settings'));

    /* ── Start delivery ────────────────────────────────────────────── */
    $('btn-start-delivery').addEventListener('click', function () {
        playClick();

        // Close the panel & the phone
        closePanel('view-deliver');

        setTimeout(() => {
            const iphone = $('iphone');
            iphone.style.animation = 'none';
            iphone.style.display = 'none';

            // Tell FiveM client
            fetch(`https://${GetParentResourceName()}/startDelivery`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json; charset=UTF-8' },
                body: JSON.stringify({})
            }).catch(console.error);

            fetch(`https://${GetParentResourceName()}/close`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json; charset=UTF-8' },
                body: JSON.stringify({})
            }).catch(console.error);
        }, 350);
    });

    /* ── Settings: apply border colour ────────────────────────────── */
    $('btn-apply-color').addEventListener('click', function () {
        playClick();
        const color = $('border-color-picker').value;
        $('iphone').style.borderColor = color;
        closePanel('view-settings');
    });

    /* ── Notification toast ────────────────────────────────────────── */
    function showNotification(message) {
        const toast = $('notification');
        const msg   = $('notification-message');
        if (!toast || !msg) return;

        msg.textContent = message;
        toast.style.display = 'block';
        toast.style.animation = 'none';
        void toast.offsetWidth; // reflow
        toast.style.animation = 'toast-in 0.4s cubic-bezier(0.34, 1.56, 0.64, 1) forwards';

        if (notifSound) { notifSound.currentTime = 0; notifSound.play().catch(() => {}); }

        clearTimeout(toast._timer);
        toast._timer = setTimeout(() => {
            toast.style.display = 'none';
        }, 5000);
    }

    /* ── NUI message listener ──────────────────────────────────────── */
    window.addEventListener('message', function (event) {
        const data = event.data;

        if (data.action === 'showNotification') {
            showNotification(data.message);
        }

        if (data.type === 'ui') {
            const iphone = $('iphone');
            if (data.display) {
                iphone.style.display = 'flex';
                iphone.style.animation = 'phone-in 0.45s cubic-bezier(0.34, 1.56, 0.64, 1) forwards';
                updateTime();
            } else {
                iphone.style.display = 'none';
                // Reset panels when phone is closed
                $('view-deliver').classList.remove('slide-in');
                $('view-settings').classList.remove('slide-in');
                homeView.classList.remove('slide-out');
            }
        }
    });

    /* ── Escape key ────────────────────────────────────────────────── */
    document.addEventListener('keydown', function (e) {
        if (e.key !== 'Escape') return;
        const iphone = $('iphone');
        if (iphone.style.display !== 'flex') return;

        iphone.style.display = 'none';
        fetch(`https://${GetParentResourceName()}/close`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
            body: JSON.stringify({})
        }).catch(console.error);
    });

    /* ── Polyfill GetParentResourceName for browser preview ───────── */
    if (typeof GetParentResourceName === 'undefined') {
        window.GetParentResourceName = () => 'sneakerphone';
    }
});

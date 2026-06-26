let lastDone = 0;

function formatTime(seconds) {
    if (seconds == null || isNaN(seconds)) return '--:--';
    if (seconds < 0) seconds = 0;

    const m = Math.floor(seconds / 60);
    const s = seconds % 60;
    const mm = (m < 10 ? '0' : '') + m;
    const ss = (s < 10 ? '0' : '') + s;
    return `${mm}:${ss}`;
}

window.addEventListener('message', (event) => {
    const data = event.data;
    if (!data || !data.action) return;

    const container = document.getElementById('contract-container');
    const statusEl  = document.getElementById('contract-status');
    const progressEl = document.getElementById('contract-progress');
    const timerEl   = document.getElementById('contract-timer');
    const checkEl   = document.getElementById('contract-check');

    if (data.action === 'contract:update') {
        if (!data.active) {
            container.classList.add('hidden');
            return;
        }

        container.classList.remove('hidden');

        const done  = data.done || 0;
        const total = data.total || 0;
        const timeLeft = data.timeLeft; // seconds

        statusEl.textContent = 'You\'re on a contract run.';
        progressEl.textContent = `${done} / ${total} mailboxes hit.`;
        timerEl.textContent = `Time left: ${formatTime(timeLeft)}`;

        // Animated check when progress increases
        if (done > lastDone) {
            checkEl.classList.add('tick-visible');
            checkEl.classList.remove('tick-animate'); // reset
            void checkEl.offsetWidth; // force reflow to restart animation
            checkEl.classList.add('tick-animate');
        }

        lastDone = done;
    }

    if (data.action === 'contract:hide') {
        container.classList.add('hidden');
        lastDone = 0;
    }
});

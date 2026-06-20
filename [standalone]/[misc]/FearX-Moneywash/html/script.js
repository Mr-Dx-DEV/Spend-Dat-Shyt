const body = document.body;
const app = document.getElementById('app');
const amountInput = document.getElementById('amount');

const summaryCard = document.getElementById('summary-card');
const overviewTitle = document.getElementById('overview-title');
const overviewSub = document.getElementById('overview-sub');

const rowDirty = document.getElementById('row-dirty');
const rowTax = document.getElementById('row-tax');
const rowTaxLabel = document.getElementById('row-tax-label');
const rowClean = document.getElementById('row-clean');
const rowTime = document.getElementById('row-time');
const rowTimeLabel = document.getElementById('row-time-label');
const progressFill = document.getElementById('progress-fill');

const hintEl = document.getElementById('hint-bounds');
const messageEl = document.getElementById('message');
const btnDeposit = document.getElementById('btn-deposit');
const btnWithdraw = document.getElementById('btn-withdraw');
const btnClose = document.getElementById('btn-close');
const btnRefresh = document.getElementById('btn-refresh');
const btnCancel = document.getElementById('btn-cancel');
const btnCancelLabel = document.getElementById('btn-cancel-label');

let cancelArmedHandle = null;

let countdownHandle = null;
let messageHandle = null;
let startedAt = 0;
let finishesAt = 0;
let readyRefreshed = false;
let lastStatus = null;

function resourceName() {
    return typeof GetParentResourceName === 'function' ? GetParentResourceName() : 'fearx-moneywash';
}

function post(cb, body) {
    return fetch(`https://${resourceName()}/${cb}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify(body || {}),
    }).catch(() => ({}));
}

function formatMoney(n) {
    const v = Math.max(0, Math.floor(Number(n) || 0));
    return '$' + v.toLocaleString('en-US');
}

function formatMoneyNeg(n) {
    const v = Math.max(0, Math.floor(Number(n) || 0));
    if (v === 0) return '-$0';
    return '-$' + v.toLocaleString('en-US');
}

function formatTime(seconds) {
    const total = Math.max(0, Math.floor(Number(seconds) || 0));
    const h = Math.floor(total / 3600);
    const m = Math.floor((total % 3600) / 60);
    const s = total % 60;
    const pad = (n) => n.toString().padStart(2, '0');
    if (h > 0) return `${pad(h)}:${pad(m)}:${pad(s)}`;
    return `${pad(m)}:${pad(s)}`;
}

function setMessage(text, kind) {
    if (messageHandle) {
        clearTimeout(messageHandle);
        messageHandle = null;
    }
    messageEl.textContent = text || '';
    messageEl.className = 'fx-message' + (kind ? ' ' + kind : '');
    if (text) {
        messageHandle = setTimeout(() => {
            messageEl.textContent = '';
            messageEl.className = 'fx-message';
            messageHandle = null;
        }, 4500);
    }
}

function show() {
    body.classList.remove('fx-hidden');
    app.dataset.state = 'open';
    setTimeout(() => amountInput && amountInput.focus(), 50);
}

function hide() {
    body.classList.add('fx-hidden');
    app.dataset.state = 'closed';
    stopCountdown();
    setMessage('');
    if (amountInput) amountInput.value = '';
}

function stopCountdown() {
    if (countdownHandle) {
        clearInterval(countdownHandle);
        countdownHandle = null;
    }
}

function updateActiveProgress() {
    if (!finishesAt || !startedAt || finishesAt <= startedAt) {
        progressFill.style.width = '0%';
        return;
    }
    const now = Date.now();
    const total = finishesAt - startedAt;
    const elapsed = Math.max(0, Math.min(total, now - startedAt));
    const pct = (elapsed / total) * 100;
    progressFill.style.width = `${pct.toFixed(1)}%`;
}

function startActiveCountdown(targetMs, startMs) {
    stopCountdown();
    finishesAt = Number(targetMs) || 0;
    startedAt = Number(startMs) || Date.now() - 1;
    readyRefreshed = false;
    const tick = () => {
        const remainingSec = Math.max(0, Math.floor((finishesAt - Date.now()) / 1000));
        rowTime.textContent = formatTime(remainingSec);
        updateActiveProgress();
        if (remainingSec <= 0) {
            stopCountdown();
            if (!readyRefreshed) {
                readyRefreshed = true;
                post('refreshStatus', {});
            }
        }
    };
    tick();
    countdownHandle = setInterval(tick, 500);
}

function applyHint(data) {
    if (data.restartLockout) {
        hintEl.textContent = 'Server restart soon — deposits paused';
        return;
    }
    if (data.cooldownEndsAt && data.cooldownEndsAt > Date.now()) {
        const remainingSec = Math.max(0, Math.floor((data.cooldownEndsAt - Date.now()) / 1000));
        hintEl.textContent = `Cooldown ${formatTime(remainingSec)}`;
        return;
    }
    const tax = Number(data.taxPercent) || 0;
    const min = formatMoney(data.minDeposit || 0);
    const max = formatMoney(data.maxDeposit || 0);
    hintEl.textContent = `Min ${min} • Max ${max} • Tax ${tax}%`;
}

function renderPreview() {
    if (!lastStatus) return;
    stopCountdown();

    const tax = Number(lastStatus.taxPercent) || 0;
    const secPerK = Number(lastStatus.secondsPer1000Dirty) || 0;
    const raw = parseInt(amountInput.value, 10);
    const amount = Number.isFinite(raw) && raw > 0 ? raw : 0;

    const taxCut = Math.floor(amount * (tax / 100));
    const clean = amount - taxCut;
    const durationSec = Math.floor((amount / 1000) * secPerK);

    summaryCard.dataset.mode = 'preview';
    overviewTitle.textContent = 'Wash Preview';
    overviewSub.textContent = amount > 0
        ? 'Live forecast based on the amount you entered'
        : 'Type an amount below to see your payout';

    rowTaxLabel.textContent = `Tax (${tax}%)`;
    rowTimeLabel.textContent = 'Wash Time';

    rowDirty.textContent = formatMoney(amount);
    rowTax.textContent = formatMoneyNeg(taxCut);
    rowClean.textContent = formatMoney(clean);
    rowTime.textContent = durationSec > 0 ? formatTime(durationSec) : '--:--';
    progressFill.style.width = '0%';
}

function renderActive(data) {
    const tax = Number(data.taxPercent) || 0;
    const dirty = Number(data.dirty) || 0;
    const clean = Number(data.clean) || 0;
    const taxCut = Math.max(0, dirty - clean);

    summaryCard.dataset.mode = data.ready ? 'ready' : 'active';
    overviewTitle.textContent = data.ready ? 'Ready to Withdraw' : 'Wash in Progress';
    overviewSub.textContent = data.ready
        ? 'Your clean cash is waiting — press Withdraw'
        : 'Come back when the timer runs out';

    rowTaxLabel.textContent = `Tax (${tax}%)`;
    rowTimeLabel.textContent = data.ready ? 'Status' : 'Time Remaining';

    rowDirty.textContent = formatMoney(dirty);
    rowTax.textContent = formatMoneyNeg(taxCut);
    rowClean.textContent = formatMoney(clean);

    if (data.ready) {
        stopCountdown();
        rowTime.textContent = 'READY';
        progressFill.style.width = '100%';
    } else if (data.finishesAt) {
        startActiveCountdown(Number(data.finishesAt), Number(data.startedAt) || Date.now() - 1);
    }
}

function disarmCancel() {
    if (cancelArmedHandle) {
        clearTimeout(cancelArmedHandle);
        cancelArmedHandle = null;
    }
    btnCancel.classList.remove('fx-chip-confirm');
    if (btnCancelLabel) btnCancelLabel.textContent = 'Cancel Wash';
}

function applyStatus(data) {
    if (!data) return;
    lastStatus = data;

    btnDeposit.disabled = !!data.active || !!data.restartLockout || (data.cooldownEndsAt && data.cooldownEndsAt > Date.now());
    btnWithdraw.disabled = !data.active || !data.ready;

    const canCancel = !!data.active && !data.ready;
    if (canCancel) {
        btnCancel.classList.remove('fx-chip-hidden');
    } else {
        btnCancel.classList.add('fx-chip-hidden');
        disarmCancel();
    }

    if (amountInput) {
        amountInput.disabled = !!data.active;
    }

    if (data.active) {
        renderActive(data);
    } else {
        renderPreview();
    }

    applyHint(data);
}

window.addEventListener('message', (event) => {
    const data = event.data || {};
    switch (data.action) {
        case 'open':
            show();
            applyStatus(data.status);
            break;
        case 'close':
            hide();
            break;
        case 'update':
            applyStatus(data.status);
            break;
        case 'result':
            setMessage(data.message, data.kind);
            if (data.status) applyStatus(data.status);
            break;
    }
});

amountInput.addEventListener('input', () => {
    if (lastStatus && !lastStatus.active) {
        renderPreview();
    }
});

amountInput.addEventListener('keydown', (e) => {
    if (e.key === 'Enter' && !btnDeposit.disabled) {
        btnDeposit.click();
    }
});

btnDeposit.addEventListener('click', () => {
    const amount = parseInt(amountInput.value, 10);
    if (!Number.isFinite(amount) || amount <= 0) {
        setMessage('Enter a valid amount', 'error');
        amountInput.focus();
        return;
    }
    btnDeposit.disabled = true;
    post('deposit', { amount });
});

btnWithdraw.addEventListener('click', () => {
    btnWithdraw.disabled = true;
    post('withdraw', {});
});

btnClose.addEventListener('click', () => {
    post('close', {});
    hide();
});

if (btnRefresh) {
    btnRefresh.addEventListener('click', () => {
        post('refreshStatus', {});
    });
}

if (btnCancel) {
    btnCancel.addEventListener('click', () => {
        if (btnCancel.classList.contains('fx-chip-confirm')) {
            disarmCancel();
            btnCancel.classList.add('fx-chip-hidden');
            post('cancel', {});
            return;
        }
        btnCancel.classList.add('fx-chip-confirm');
        if (btnCancelLabel) btnCancelLabel.textContent = 'Confirm Cancel?';
        if (cancelArmedHandle) clearTimeout(cancelArmedHandle);
        cancelArmedHandle = setTimeout(disarmCancel, 3500);
    });
}

document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && app.dataset.state === 'open') {
        post('close', {});
        hide();
    }
});

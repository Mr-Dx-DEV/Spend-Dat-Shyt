window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.action === 'showProgress') {
        const container = document.getElementById('progress-container');
        const fill = document.getElementById('progress-fill');
        const label = document.getElementById('progress-label');

        label.textContent = data.label || 'Vapeando...';
        container.style.display = 'block';
        fill.style.width = '100%';
        fill.style.transition = `width ${data.duration}ms linear`;

        setTimeout(() => {
            fill.style.width = '0%';
        }, 50);
    } else if (data.action === 'hideProgress') {
        const container = document.getElementById('progress-container');
        container.style.display = 'none';
    }
});
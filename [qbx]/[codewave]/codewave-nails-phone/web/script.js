document.addEventListener('DOMContentLoaded', function() {
    function showNotification(message) {
        const notification = document.getElementById('notification');
        const notificationMessage = document.getElementById('notification-message');
        const notificationSound = document.getElementById('notification-sound');
        if (notification && notificationMessage && notificationSound) {
            notificationMessage.textContent = message;
            notification.style.display = 'block';
            notificationSound.play();
            setTimeout(() => {
                notification.style.display = 'none';
            }, 5000);
        } else {
            console.error('Notification elements not found');
        }
    }

    function updateStatus() {
        navigator.getBattery().then(battery => {
            const batteryElement = document.querySelector('.battery i');
            if (batteryElement) {
                // const batteryLevel = Math.round(battery.level * 100);
                // batteryElement.textContent = `${batteryLevel}%`;
            } else {
                console.error('Battery element not found');
            }
        }).catch(error => {
            console.error('Battery status could not be retrieved', error);
        });

        const wifi = document.querySelector('.wifi');
        if (wifi) {
            if (navigator.onLine) {
                wifi.innerHTML = '<i class="fas fa-wifi"></i>';
            } else {
                wifi.innerHTML = '<i class="fas fa-wifi-slash"></i>';
            }
        } else {
            console.error('Wi-Fi element not found');
        }
    }

    function updateTime() {
        const timeElement = document.querySelector('.time');
        if (timeElement) {
            const now = new Date();
            const hours = now.getHours().toString().padStart(2, '0');
            const minutes = now.getMinutes().toString().padStart(2, '0');
            timeElement.textContent = `${hours}:${minutes}`;
        } else {
            console.error('Time element not found');
        }
    }

    setInterval(updateStatus, 60000);
    updateStatus();
    updateTime();
    setInterval(updateTime, 1000);

    document.querySelectorAll('.app').forEach(app => {
        app.addEventListener('click', () => {
            openModal(app.id);
        });
    });

    function openModal(appId) {
        const modal = document.getElementById('modal');
        const modalTitle = document.getElementById('modal-title');
        const modalDescription = document.getElementById('modal-description');
        const startButton = document.getElementById('start-button');
        const settingsContent = document.getElementById('settings-content');

        if (appId === 'deliver-products') {
            modalTitle.textContent = 'Deliver Products';
            modalDescription.textContent = 'Start delivering products to your customers.';
            startButton.style.display = 'block';
            settingsContent.style.display = 'none';
        } else if (appId === 'settings-app') {
            modalTitle.textContent = 'Settings';
            modalDescription.textContent = 'Change your phone settings.';
            startButton.style.display = 'none';
            settingsContent.style.display = 'block';
        }

        modal.style.display = 'block';
    }

    document.querySelector('.close').addEventListener('click', () => {
        document.getElementById('modal').style.display = 'none';
    });

    window.addEventListener('click', (event) => {
        const modal = document.getElementById('modal');
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    });

    document.getElementById('start-button').addEventListener('click', () => {
        const modal = document.getElementById('modal');
        const modalTitle = document.getElementById('modal-title').textContent;
        const iphoneElement = document.getElementById('iphone');
        
        if (modalTitle === 'Deliver Products') {
            fetch(`https://${GetParentResourceName()}/startDelivery`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8'
                },
                body: JSON.stringify({})
            }).then(resp => resp.json()).then(resp => {
                console.log(resp);
            }).catch(error => console.error('Error:', error));
        }

        // Hide the modal and the main UI
        modal.style.display = 'none';
        iphoneElement.style.display = 'none';

        // Send a message to the server to close the UI
        fetch(`https://${GetParentResourceName()}/close`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8'
            },
            body: JSON.stringify({})
        }).then(resp => resp.json()).then(resp => {
            console.log(resp);
        }).catch(error => console.error('Error:', error));
    });

    document.getElementById('apply-color-button').addEventListener('click', () => {
        const colorPicker = document.getElementById('border-color-picker');
        const selectedColor = colorPicker.value;
        const iphoneElement = document.getElementById('iphone');
        iphoneElement.style.borderColor = selectedColor;
        document.getElementById('modal').style.display = 'none';
    });

    window.addEventListener('message', function(event) {
        if (event.data.action === 'showNotification') {
            showNotification(event.data.message);
        } else if (event.data.type === 'ui') {
            const iphoneElement = document.getElementById('iphone');
            if (iphoneElement) {
                iphoneElement.style.display = event.data.display ? 'block' : 'none';
                if (event.data.display) {
                    iphoneElement.style.animation = 'slideInUp 0.5s ease-out forwards';
                }
            }
        }
    });

    document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape') {
            const iphoneElement = document.getElementById('iphone');
            if (iphoneElement.style.display === 'block') {
                iphoneElement.style.display = 'none';
                fetch(`https://${GetParentResourceName()}/close`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json; charset=UTF-8'
                    },
                    body: JSON.stringify({})
                }).then(resp => resp.json()).then(resp => {
                    console.log(resp);
                }).catch(error => console.error('Error:', error));
            }
        }
    });

    const callButton = document.getElementById('call-button');
    const phoneInput = document.getElementById('phone-input');

    if (callButton && phoneInput) {
        callButton.addEventListener('click', function() {
            const number = phoneInput.value;
            if (number) {
                showNotification(`Calling ${number}...`);
                phoneInput.value = ''; // Clear input after calling
            } else {
                showNotification('Please enter a number.');
            }
        });
    }
});

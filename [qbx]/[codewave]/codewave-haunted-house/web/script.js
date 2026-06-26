document.addEventListener("DOMContentLoaded", function() {
    const overlay = document.getElementById("overlay");
    const playerOverlay = document.getElementById("player-overlay");
    const startButton = document.getElementById("start-btn");
    const exitButton = document.getElementById("exit-btn");  // Get the exit button
    const horrorMusic = document.getElementById("horror-music");
    const jumpScareElement = document.getElementById("jump-scare");
    const jumpScareSound = document.getElementById("jump-scare-sound");

    // Preload and ensure the horror music is set to loop
    horrorMusic.loop = true;

    // Check if the audio is properly loaded
    horrorMusic.addEventListener('canplaythrough', function() {
        console.log('Horror music is ready to play.');
    });

    // Listen for the NUI message from FiveM to show the overlay or jump scare
    window.addEventListener('message', function(event) {
        if (event.data.action === 'showOverlay') {
            overlay.style.display = 'block';  // Show the initial game start overlay
            overlay.style.opacity = '1';  // Reset opacity in case it was previously faded out
        } else if (event.data.action === 'hideOverlay') {
            overlay.style.display = 'none';  // Hide the UI overlay
            playerOverlay.style.display = 'none';

            // Stop the horror background music when overlay is hidden
            horrorMusic.pause();
            horrorMusic.currentTime = 0;  // Reset the music to the start
        } else if (event.data.action === 'triggerJumpScare') {
            // Call the jump scare with the image type (1, 2, or 3)
            triggerJumpScare(event.data.jumpScareType);
        }
    });

    // Add event listener for the start button click
    startButton.addEventListener("click", function() {
        overlay.style.opacity = '0';  // Fade out the initial overlay
        setTimeout(() => {
            overlay.style.display = 'none';  // Hide overlay after fade-out
            playerOverlay.style.display = 'block';  // Show the dark game overlay

            // Play the horror background music and ensure it loops
            horrorMusic.play()
                .then(() => {
                    console.log('Horror music started playing.');
                })
                .catch(error => {
                    console.error('Failed to play horror music:', error);
                });

            // Send message to FiveM to remove NUI focus so the player can move
            fetch(`https://${GetParentResourceName()}/closeOverlay`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            });
        }, 1000);  // Adjust this delay to match the fade-out duration
    });

    // Add event listener for the exit button click
    exitButton.addEventListener("click", function() {
        overlay.style.display = 'none';  // Hide the main menu overlay
        playerOverlay.style.display = 'none';  // Hide the player overlay

        // Stop the background music
        horrorMusic.pause();
        horrorMusic.currentTime = 0;  // Reset the music to the start

        // Send message to Lua to set NUI focus to false
        fetch(`https://${GetParentResourceName()}/closeOverlay1`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({})
        });
    });

    // Function to trigger the jump scare
    function triggerJumpScare(jumpScareType) {
        // Hide all jump scare images
        document.querySelectorAll('.jump-scare-image').forEach(function(img) {
            img.style.display = 'none';
        });

        // Show the appropriate jump scare image based on the random type
        const jumpScareImage = document.getElementById(`jump-scare-image-${jumpScareType}`);
        jumpScareElement.style.display = 'flex';
        jumpScareImage.style.display = 'block';  // Show the selected image

        // Play jump scare sound aggressively at the start
        jumpScareSound.currentTime = 0;  // Reset sound to the start in case of overlap
        jumpScareSound.play();

        // Hide the jump scare after 3 seconds
        setTimeout(() => {
            jumpScareElement.style.display = 'none';
            jumpScareImage.style.display = 'none';  // Hide the image again
        }, 3000);
    }
});

document.addEventListener("keydown", function(event) {
    if (event.key === "Escape") {  // Check if the Escape key is pressed
        const overlay = document.getElementById("overlay");
        const playerOverlay = document.getElementById("player-overlay");

        // Hide both the main menu (overlay) and the player overlay if they're visible
        overlay.style.display = "none";
        playerOverlay.style.display = "none";

        // Stop the background music when the menu is closed
        const horrorMusic = document.getElementById("horror-music");
        horrorMusic.pause();
        horrorMusic.currentTime = 0;  // Reset the music to the start

        // Send message to the client Lua script to set NUI focus to false
        fetch(`https://${GetParentResourceName()}/closeOverlay`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({})
        });
    }
});

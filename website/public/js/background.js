function createRandomDots() {
    const dotContainer = document.getElementById('dot-container');
    const numDots = 500; // Number of dots to create

    for (let i = 0; i < numDots; i++) {
        const dot = document.createElement('div');
        dot.classList.add('dot');
        dot.style.left = Math.random() * 100 + 'vw'; // Random horizontal position
        dot.style.top = Math.random() * 100 + 'vh'; // Random vertical position
        dotContainer.appendChild(dot);
        fadeInOut(dot); // Apply fade in/out animation to the dot
    }
}

function fadeInOut(dot) {
    const duration = Math.random() * 20000 + 15000; // Random duration between 5 and 13 seconds
    const delay = Math.random() * 10000; // Random delay up to 10 seconds
    const fadeOutStart = duration - 1000; // Start fading out 1 second before the end

    // Apply fade in animation
    dot.animate([
        { opacity: 0 },
        { opacity: 1 }
    ], {
        duration: duration,
        delay: delay,
        fill: 'forwards'
    });

    // Apply fade out animation
    dot.animate([
        { opacity: 1 },
        { opacity: 0 }
    ], {
        duration: 1000,
        delay: fadeOutStart,
        fill: 'forwards'
    });

    // Repeat the animation after it's finished
    setTimeout(() => {
        fadeInOut(dot);
    }, duration + delay);
}

// Call the function to create random dots when the page loads
window.onload = createRandomDots;
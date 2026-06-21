// Warrant Document NUI Handler
window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.action === 'showWarrant') {
        showWarrantDocument(data.warrant);
    } else if (data.action === 'hideWarrant') {
        hideWarrantDocument();
    }
});

function showWarrantDocument(warrant) {
    const body = document.body;
    const container = document.getElementById('warrant-container');

    if (!warrant) {
        return;
    }

    // Populate warrant data
    document.getElementById('warrant-number').textContent = warrant.warrantNumber || 'W-2025-000000';
    document.getElementById('footer-warrant-number').textContent = warrant.warrantNumber || 'W-2025-000000';

    // Warrant type formatting
    const typeMap = {
        'arrest': 'ARREST WARRANT',
        'search': 'SEARCH WARRANT',
        'bench': 'BENCH WARRANT',
        'seizure': 'SEIZURE WARRANT'
    };
    document.getElementById('warrant-type').textContent = typeMap[warrant.warrantType] || 'ARREST WARRANT';

    // Subject information
    document.getElementById('subject-name').textContent = warrant.subjectName || 'Unknown';

    // Dates
    try {
        const issuedDateFormatted = formatDate(warrant.issuedDate) || formatDate(new Date());
        document.getElementById('issued-date').textContent = issuedDateFormatted;
    } catch (e) {
        document.getElementById('issued-date').textContent = warrant.issuedDate || 'N/A';
    }

    try {
        const expiryDateFormatted = warrant.expiryDate ? formatDate(warrant.expiryDate) : 'Never';
        document.getElementById('expiry-date').textContent = expiryDateFormatted;
    } catch (e) {
        document.getElementById('expiry-date').textContent = warrant.expiryDate || 'Never';
    }

    try {
        const stampDateFormatted = formatStampDate(warrant.issuedDate) || formatStampDate(new Date());
        document.getElementById('stamp-date').textContent = stampDateFormatted;
    } catch (e) {
        document.getElementById('stamp-date').textContent = '00/00/0000';
    }

    // Location (only show for search/seizure warrants)
    const locationRow = document.getElementById('location-row');
    if (warrant.location && (warrant.warrantType === 'search' || warrant.warrantType === 'seizure')) {
        locationRow.style.display = 'grid';
        document.getElementById('location').textContent = warrant.location;
    } else {
        locationRow.style.display = 'none';
    }

    // Reason
    document.getElementById('warrant-reason').textContent = warrant.reason || 'No reason provided';

    // Authorization
    document.getElementById('issued-by').textContent = warrant.issuedByName || 'Unknown Officer';
    document.getElementById('judge-name').textContent = warrant.judgeName || 'Hon. District Judge';

    // Judge signature (use judge name in script font)
    const judgeSignature = warrant.judgeName || 'Judge Signature';
    document.getElementById('judge-signature').textContent = judgeSignature;

    // Show the document with animation
    body.style.display = 'flex';
    body.classList.add('show-warrant');
    container.classList.add('show');

    // Enable ESC key to close
    document.addEventListener('keydown', handleEscKey);
}

function hideWarrantDocument() {
    const body = document.body;
    const container = document.getElementById('warrant-container');

    // Add hiding animation
    container.classList.add('hiding');

    // Completely hide after animation
    setTimeout(() => {
        container.classList.remove('show', 'hiding');
        body.classList.remove('show-warrant');
        body.style.display = 'none';
    }, 300); // Match fadeOut animation duration

    // Remove ESC key listener
    document.removeEventListener('keydown', handleEscKey);
}

function closeWarrant() {
    hideWarrantDocument();

    // Send close event to parent frame
    window.parent.postMessage({ closeFrame: 'warrant' }, '*');

    // Send close event to FiveM client
    fetch('https://fs-doj/closeWarrant', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    });
}

function handleEscKey(event) {
    if (event.key === 'Escape') {
        closeWarrant();
    }
}

// Date formatting functions
function formatDate(dateInput) {
    if (!dateInput) return 'N/A';

    let date;

    // Handle different date formats
    if (typeof dateInput === 'string') {
        // Check if it's a YYYY-MM-DD format string
        const dateMatch = dateInput.match(/^(\d{4})-(\d{1,2})-(\d{1,2})/);
        if (dateMatch) {
            const year = parseInt(dateMatch[1]);
            const month = parseInt(dateMatch[2]) - 1;
            const day = parseInt(dateMatch[3]);
            date = new Date(year, month, day);
        } else {
            // Try parsing other date formats
            date = new Date(dateInput);
        }
    } else if (typeof dateInput === 'number') {
        // Check if it's already in milliseconds (> year 3000 when converted from seconds)
        if (dateInput > 32503680000) {
            date = new Date(dateInput);
        } else {
            // Unix timestamp in seconds
            date = new Date(dateInput * 1000);
        }
    } else if (dateInput instanceof Date) {
        date = dateInput;
    } else {
        // Unknown format
        return String(dateInput);
    }

    // Check if date is valid
    if (!date || isNaN(date.getTime())) {
        return 'Invalid Date';
    }

    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    const month = months[date.getMonth()];
    const day = date.getDate();
    const year = date.getFullYear();

    // Add ordinal suffix (1st, 2nd, 3rd, 4th, etc.)
    const suffix = getDaySuffix(day);

    return `${month} ${day}${suffix}, ${year}`;
}

function formatStampDate(dateInput) {
    if (!dateInput) return '00/00/0000';

    let date;

    // Handle different date formats
    if (typeof dateInput === 'string') {
        // Check if it's a YYYY-MM-DD format string
        const dateMatch = dateInput.match(/^(\d{4})-(\d{1,2})-(\d{1,2})/);
        if (dateMatch) {
            const year = parseInt(dateMatch[1]);
            const month = String(dateMatch[2]).padStart(2, '0');
            const day = String(dateMatch[3]).padStart(2, '0');
            return `${month}/${day}/${year}`;
        } else {
            // Try parsing other date formats
            date = new Date(dateInput);
        }
    } else if (typeof dateInput === 'number') {
        // Check if it's already in milliseconds (> year 3000 when converted from seconds)
        if (dateInput > 32503680000) {
            date = new Date(dateInput);
        } else {
            // Unix timestamp in seconds
            date = new Date(dateInput * 1000);
        }
    } else if (dateInput instanceof Date) {
        date = dateInput;
    } else {
        return '00/00/0000';
    }

    // Check if date is valid
    if (!date || isNaN(date.getTime())) {
        return '00/00/0000';
    }

    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const year = date.getFullYear();

    return `${month}/${day}/${year}`;
}

function getDaySuffix(day) {
    if (day >= 11 && day <= 13) return 'th';

    switch (day % 10) {
        case 1: return 'st';
        case 2: return 'nd';
        case 3: return 'rd';
        default: return 'th';
    }
}

// Prevent right-click context menu on document
document.addEventListener('contextmenu', function(event) {
    event.preventDefault();
});

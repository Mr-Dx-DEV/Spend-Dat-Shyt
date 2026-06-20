// DOJ Document & Photo Viewer
let currentView = null;

// Listen for messages from client
window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.action === 'showDocument') {
        showDocument(data.document);
    } else if (data.action === 'showPhoto') {
        showPhoto(data.photo);
    } else if (data.action === 'hide') {
        hideViewer();
    }
});

// Show document viewer
function showDocument(docData) {
    currentView = 'document';

    // Populate document data
    window.document.getElementById('doc-title').textContent = docData.title || 'Untitled Document';
    window.document.getElementById('doc-content').textContent = docData.content || 'No content available.';
    window.document.getElementById('printed-by').textContent = docData.printed_by || 'Unknown';
    window.document.getElementById('printed-at').textContent = docData.printed_at || 'Unknown';

    // Handle optional fields
    if (docData.evidence_number) {
        window.document.getElementById('evidence-row').style.display = 'flex';
        window.document.getElementById('evidence-number').textContent = docData.evidence_number;
    } else {
        window.document.getElementById('evidence-row').style.display = 'none';
    }

    if (docData.case_number) {
        window.document.getElementById('case-row').style.display = 'flex';
        window.document.getElementById('case-number').textContent = docData.case_number;
    } else {
        window.document.getElementById('case-row').style.display = 'none';
    }

    // Show container
    window.document.getElementById('document-container').classList.remove('hidden');
    window.document.getElementById('photo-container').classList.add('hidden');
}

// Show photo viewer
function showPhoto(photo) {
    currentView = 'photo';

    // Populate photo data
    document.getElementById('photo-evidence-number').textContent = photo.evidence_number || 'Unknown';
    document.getElementById('photo-description').textContent = photo.description || 'No description available.';
    document.getElementById('photo-printed-by').textContent = photo.printed_by || 'Unknown';
    document.getElementById('photo-printed-at').textContent = photo.printed_at || 'Unknown';

    // Handle case number
    if (photo.case_number) {
        document.getElementById('photo-case-row').style.display = 'flex';
        document.getElementById('photo-case-number').textContent = photo.case_number;
    } else {
        document.getElementById('photo-case-row').style.display = 'none';
    }

    // Handle photo display
    const photoImage = document.getElementById('photo-image');
    const photoPlaceholder = document.getElementById('photo-placeholder');

    if (photo.file_ref && photo.file_ref !== '') {
        photoImage.src = photo.file_ref;
        photoImage.style.display = 'block';
        photoPlaceholder.style.display = 'none';

        // Handle image load error
        photoImage.onerror = function() {
            photoImage.style.display = 'none';
            photoPlaceholder.style.display = 'flex';
        };
    } else {
        photoImage.style.display = 'none';
        photoPlaceholder.style.display = 'flex';
    }

    // Show container
    document.getElementById('photo-container').classList.remove('hidden');
    document.getElementById('document-container').classList.add('hidden');
}

// Hide viewer
function hideViewer() {
    document.getElementById('document-container').classList.add('hidden');
    document.getElementById('photo-container').classList.add('hidden');
    currentView = null;

    // Send close event to parent frame
    window.parent.postMessage({ closeFrame: 'document' }, '*');

    // Send close message to client
    fetch(`https://${GetParentResourceName()}/closeViewer`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    });
}

// Close button event listeners
document.getElementById('close-btn').addEventListener('click', hideViewer);
document.getElementById('close-photo-btn').addEventListener('click', hideViewer);

// ESC key to close
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape' && currentView !== null) {
        hideViewer();
    }
});

// Click outside to close
document.getElementById('document-container').addEventListener('click', function(event) {
    if (event.target === this) {
        hideViewer();
    }
});

document.getElementById('photo-container').addEventListener('click', function(event) {
    if (event.target === this) {
        hideViewer();
    }
});

// Helper function to get parent resource name
function GetParentResourceName() {
    return 'fs-doj';
}

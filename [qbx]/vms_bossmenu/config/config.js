const config = {}

config.debug = false

function Debug(message, type) {
    if (!config.debug) return;

    if (type) {
        if (type == 'error') {
            console.error(message)
        } else if (type == 'warn') {
            console.warn(message)
        }
    } else {
        console.log(message)
    }
}
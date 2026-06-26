--[[
    nex_uipack configuration.

    Changes here apply after a resource restart (`ensure nex_uipack`).
    Values are sent to the UI when it loads; anything invalid falls back
    to the defaults shown below.
]]

Config = {

    --[[
        Language.

        Picks which locales/<code>.json file the UI loads its own text from
        (dialog buttons, the radial "More..." entry). 'en' and 'es' ship with
        the pack.

        Speak another language? Copy locales/en.json to locales/<code>.json,
        translate the values, set this to that <code>, and restart. Locale
        files are plain JSON and stay fully editable — they are never part of
        the escrowed bundle. An unknown or broken file falls back to English.
    ]]
    locale = 'en',

    --[[
        Accent color.

        All UI text and highlight elements derive from this color: bright
        text (titles, percentages, labels) uses it at full strength, while
        secondary/muted text uses faded shades of it. Progress fills, the
        skillcheck ring, checkboxes, the radial menu and primary buttons
        follow it too. Semantic colors (error red, success green, warning
        yellow) are unaffected.

        Any hex color works. '#fafafa' is the stock white look.
        Examples: '#3b82f6' (blue), '#22c55e' (green), '#ef4444' (red),
                  '#a855f7' (purple), '#f59e0b' (amber)
    ]]
    accentColor = '#3b82f6',

    --[[
        Default on-screen positions per component.

        For notifications, textUI, listMenu and circleProgress a script can
        still pass its own position per call — the value here is used
        whenever a call doesn't specify one. progressBar and contextMenu are
        controlled entirely by this config.

        Dialogs, the skillcheck and the radial menu stay centered by design
        and are not configurable.
    ]]
    positions = {
        -- 'top-left' | 'top-center' | 'top-right' | 'bottom-left' | 'bottom-center' | 'bottom-right'
        notifications = 'top-center',

        -- 'right-center' | 'left-center' | 'top-center' | 'bottom-center'
        textUI = 'right-center',

        -- 'bottom-center' | 'middle-center' | 'top-center'
        progressBar = 'bottom-center',

        -- 'middle' | 'bottom'
        circleProgress = 'bottom',

        -- 'top-right' | 'top-left' | 'center-right' | 'center-left'
        contextMenu = 'top-right',

        -- 'top-left' | 'top-right' | 'bottom-left' | 'bottom-right'
        listMenu = 'top-left',
    },
}

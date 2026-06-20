--[[
Help blocks that will show in the help page.
Add more blocks as needed.
This is Markdown, so please take that into account when writing the content.
]]

return { {
    ["title"] = "Getting Started",
    ["description"] = "Learn how to use the panel",
    ["content"] = [[
The `luxu_admin` panel is your web-based control center for server moderation, player management, and staff tooling.

Use it to:

- View connected players and open their management page.
- Search online players instantly with <kbd>Ctrl + K</kbd>.
- Manage offline players with the `off:` search operator.
- Review staff tools, punishments, notes, and other server utilities.

Tip: most actions are available directly from the player management view after selecting a player from the search modal or player list.
    ]]
},

    {
        ["title"] = "Quick Search",
        ["description"] = "Searching players is very easy",
        ["content"] = [[
Press <kbd>Ctrl + K</kbd> to open the search bar.

You can search by free text or by using operators.

<p class="font-semibold">Supported operators:</p>

- `off:` Search offline players.
- `nearby:` Search players near you within a radius.
- `job:` Filter players by job name or label.
- `grade:` Combine with `job:` to filter by job grade number or grade name.

<p class="font-semibold">Examples:</p>

- `1` finds the player with server id `1`.
- `john` searches online players by name and other indexed fields.
- `off:john` searches offline players.
- `nearby:50` finds players within a radius of `50`.
- `job:police` finds players with the police job.
- `job:police grade:officer` finds police players with the `officer` grade.
- `job:ems grade:4` finds EMS players with grade `4`.

<p class="font-semibold">Sample queries:</p>

```text
off:john
nearby:50
job:police
job:police grade:officer
job:ems grade:4
```

Use the arrow keys to move through the results and press <kbd>Enter</kbd> to open the highlighted player.
    ]]
    },

}

# Sugar Hustle – AI Integration

This document describes the AI features added to Sugar Hustle. They use an **OpenAI-compatible API** (e.g. OpenClaw, OpenAI, or any gateway that accepts the same request format).

---

## What Was Added

### 1. AI-generated partner messages (Messages tab)

When a player opens the app and has a partner, the **Messages** tab can show short, AI-generated SMS-style lines instead of (or in addition to) the static config messages. The AI is given the partner’s name, personality, and relationship level so messages stay in character.

- **Config:** `Config.AI.GeneratePartnerMessages = true`
- **Flow:** Client requests messages from the server → server calls your AI API → response is merged with the “Meet at X” meet-request (if any) and sent to the NUI.

### 2. “Text your partner” chat (Messages tab)

Players can type a message in the Messages tab and get an **in-character reply** from their current sugar partner. The server loads the saved partner, builds a system prompt (name, personality, relationship level), and sends the player’s message to the AI; the reply is shown in the same tab.

- **Config:** `Config.AI.EnablePartnerChat = true`
- **Flow:** NUI → client → server → AI API → server → client → NUI (adds “You” + “Partner” bubbles).

---

## Configuration (`config.lua`)

All AI settings are under **`Config.AI`**:

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Enabled` | boolean | `false` | Master switch for all AI features. |
| `ApiUrl` | string | `''` | Full URL of your OpenAI-compatible endpoint (e.g. OpenClaw gateway). |
| `ApiKey` | string | `''` | API key if your endpoint requires auth. Leave empty if not needed. |
| `Model` | string | `'gpt-4o-mini'` | Model name your gateway expects (e.g. `gpt-4o-mini`, `claude-3-sonnet`). |
| `GeneratePartnerMessages` | boolean | `true` | When opening the app, request AI-generated messages for the Messages tab. |
| `EnablePartnerChat` | boolean | `true` | Allow “Text your partner” input and AI replies. |
| `RequestTimeoutMs` | number | `15000` | Reserved for future use (FiveM server HTTP has no timeout param). |

### Example (OpenClaw local gateway)

```lua
Config.AI = {
    Enabled = true,
    ApiUrl = 'http://localhost:11434/v1/chat/completions',  -- or your OpenClaw URL
    ApiKey = '',
    Model = 'gpt-4o-mini',
    GeneratePartnerMessages = true,
    EnablePartnerChat = true,
    RequestTimeoutMs = 15000,
}
```

### Example (OpenAI API)

```lua
Config.AI = {
    Enabled = true,
    ApiUrl = 'https://api.openai.com/v1/chat/completions',
    ApiKey = 'sk-your-key-here',
    Model = 'gpt-4o-mini',
    GeneratePartnerMessages = true,
    EnablePartnerChat = true,
    RequestTimeoutMs = 15000,
}
```

---

## API Contract

The server sends **POST** requests with a JSON body in **OpenAI chat-completions** format:

- **Body:** `{ "model": "<Config.AI.Model>", "messages": [ { "role": "system", "content": "..." }, { "role": "user", "content": "..." } ], "max_tokens": 512, "temperature": 0.8 }`
- **Headers:** `Content-Type: application/json`, and if `ApiKey` is set: `Authorization: Bearer <ApiKey>`.
- **Response:** Expects `{ "choices": [ { "message": { "content": "..." } } ] }`. The first `content` string is used.

---

## Files Touched

- **config.lua** – Added `Config.AI` block.
- **server.lua** – `CallAI()`, `RequestAIPartnerMessages()`, `HandleSendPartnerChatMessage()`, callback `sugar_hustle:server:getAIPartnerMessages`, event `sugar_hustle:server:sendPartnerChatMessage`.
- **client.lua** – `BuildMeetRequestMessage()`, OpenNUI AI branch, events `receiveAIPartnerMessages` / `receivePartnerChatReply`, NUI callback `sendPartnerChatMessage`.
- **html/index.html** – “Text your partner” compose area (input + send button) in the Messages tab.
- **html/script.js** – `addPartnerChatReply`, `addMessageToMessagesList`, compose show/hide and send logic, handler for NUI action `addPartnerChatReply`.
- **html/style.css** – Styles for `.partner-chat-compose`, `.partner-chat-input`, `.partner-chat-send`, `.message-item--you`.

---

## Fallback When AI Is Off or Fails

- **Partner messages:** If AI is disabled or the request fails, the Messages tab still shows the meet-request (if any) that was built when the app opened. You can keep static messages by leaving `GeneratePartnerMessages = false` and using the original `Config.PartnerMessages` behavior.
- **Text partner:** If AI is disabled or the server can’t get a reply, the client still receives a short fallback line (e.g. “Something came up. Text you later?” or “AI chat is disabled.”) so the UI doesn’t hang.

---

## Quick checklist

1. Set `Config.AI.Enabled = true`.
2. Set `Config.AI.ApiUrl` to your gateway (OpenClaw or OpenAI-compatible).
3. Set `Config.AI.ApiKey` if the endpoint requires it.
4. Set `Config.AI.Model` to the model name your gateway uses.
5. Restart the `sugar_hustle` resource (or the server) after changing config.

After that, open the app with a partner and use the **Messages** tab to see AI-generated messages and the “Text your partner” chat.

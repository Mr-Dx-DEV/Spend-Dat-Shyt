---@meta

---**`Dispatch` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/dispatch/client)
---
---#### Function Creates Client Callback
---
---```lua
---Framework.CreateCallback('clientcallbackname', function(cb, value1, value2)
---    cb(value1, value2)
---end
---```
---
---@param data { weight : number, count : number, slot: number, name: string, metadata: table, label: string }
function Dispatch(data) end
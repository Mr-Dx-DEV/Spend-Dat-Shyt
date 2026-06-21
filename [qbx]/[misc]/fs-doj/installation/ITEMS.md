# FS-DOJ Item Definitions

Add the items below to your inventory system. Choose the section that matches your setup.

---

## Item Overview

| Item | Label | Used For |
|------|-------|----------|
| `doj_tablet` | DOJ Tablet | Opens the MDT (Mobile Data Terminal) |
| `warrant_document` | Warrant Document | Physical warrant issued from the MDT |
| `evidence_paper` | Printed Document | Manually typed/printed documents from the printer |
| `evidence_report` | Printed Report | Reports printed from the database via the printer |
| `printed_photo` | Printed Photo | Photo evidence printed from the MDT |
| `paper` | Paper | Optional — required only if `Config.PrinterSettings.requirePaper = true` |

> **Note:** `evidence_paper` and `evidence_report` are intentionally separate items.
> qb-inventory stacks items with the same name, which overwrites metadata.
> Keeping them separate ensures each document retains its own content.

---

## ox_inventory

Add to `ox_inventory/data/items.lua`:

```lua
-- ============================================
-- FS-DOJ Items for ox_inventory
-- ============================================

['doj_tablet'] = {
    label = 'DOJ Tablet',
    weight = 500,
    stack = false,
    close = true,
    description = 'Department of Justice Mobile Data Terminal',
    server = {
        export = 'fs-doj.doj_tablet'
    }
},

['warrant_document'] = {
    label = 'Warrant Document',
    weight = 100,
    stack = false,
    close = true,
    description = 'Official warrant document issued by the Department of Justice',
    client = {
        export = 'fs-doj.useWarrantDocument'
    }
},

['evidence_paper'] = {
    label = 'Printed Document',
    weight = 50,
    stack = false,   -- MUST be false: each document has unique metadata
    close = true,
    description = 'Manually typed document printed at the DOJ printer',
    client = {
        export = 'fs-doj.useDocument'
    }
},

['evidence_report'] = {
    label = 'Printed Report',
    weight = 50,
    stack = false,   -- MUST be false: each report has unique metadata
    close = true,
    description = 'Official report printed from the DOJ database',
    client = {
        export = 'fs-doj.useDocument'
    }
},

['printed_photo'] = {
    label = 'Printed Photo',
    weight = 50,
    stack = false,   -- MUST be false: each photo has unique metadata
    close = true,
    description = 'Printed photograph for evidence purposes',
    client = {
        export = 'fs-doj.usePhoto'
    }
},

['paper'] = {
    label = 'Paper',
    weight = 10,
    stack = true,
    close = false,
    description = 'Blank paper for printing documents'
},
```

### Images

Copy images to: `ox_inventory/web/images/`

| File | Item |
|------|------|
| `doj_tablet.png` | DOJ Tablet |
| `warrant_document.png` | Warrant Document |
| `evidence_paper.png` | Printed Document |
| `evidence_report.png` | Printed Report |
| `printed_photo.png` | Printed Photo |
| `paper.png` | Paper |

---

## QBCore / QBox

Add to `qb-core/shared/items.lua`:

```lua
-- ============================================
-- FS-DOJ Items for QBCore / QBox
-- ============================================

['doj_tablet'] = {
    name        = 'doj_tablet',
    label       = 'DOJ Tablet',
    weight      = 500,
    type        = 'item',
    image       = 'doj_tablet.png',
    unique      = true,
    useable     = true,
    shouldClose = true,
    combinable  = nil,
    description = 'Department of Justice Mobile Data Terminal'
},

['warrant_document'] = {
    name        = 'warrant_document',
    label       = 'Warrant Document',
    weight      = 100,
    type        = 'item',
    image       = 'warrant_document.png',
    unique      = true,
    useable     = true,
    shouldClose = true,
    combinable  = nil,
    description = 'Official warrant document issued by the Department of Justice'
},

['evidence_paper'] = {
    name        = 'evidence_paper',
    label       = 'Printed Document',
    weight      = 50,
    type        = 'item',
    image       = 'evidence_paper.png',
    unique      = false,
    useable     = true,
    shouldClose = true,
    combinable  = nil,
    description = 'Manually typed document printed at the DOJ printer'
},

['evidence_report'] = {
    name        = 'evidence_report',
    label       = 'Printed Report',
    weight      = 50,
    type        = 'item',
    image       = 'evidence_report.png',
    unique      = false,
    useable     = true,
    shouldClose = true,
    combinable  = nil,
    description = 'Official report printed from the DOJ database'
},

['printed_photo'] = {
    name        = 'printed_photo',
    label       = 'Printed Photo',
    weight      = 50,
    type        = 'item',
    image       = 'printed_photo.png',
    unique      = false,
    useable     = true,
    shouldClose = true,
    combinable  = nil,
    description = 'Printed photograph for evidence purposes'
},

['paper'] = {
    name        = 'paper',
    label       = 'Paper',
    weight      = 10,
    type        = 'item',
    image       = 'paper.png',
    unique      = false,
    useable     = false,
    shouldClose = false,
    combinable  = nil,
    description = 'Blank paper for printing documents'
},
```

### Images

Copy images to: `qb-core/inventories/items/` (or wherever your server loads QB item images from)

| File | Item |
|------|------|
| `doj_tablet.png` | DOJ Tablet |
| `warrant_document.png` | Warrant Document |
| `evidence_paper.png` | Printed Document |
| `evidence_report.png` | Printed Report |
| `printed_photo.png` | Printed Photo |
| `paper.png` | Paper |

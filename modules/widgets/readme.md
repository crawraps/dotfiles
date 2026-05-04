# widgets

widget/panel/shell selection — imports qs, ags, or sherlock based on preference flags.

**Preference key:** `preferences.modules.widgets`
**Default:** `{ qs = true; ags = false; sherlock = false; }`

**Files:**
- `home.nix` — imports sub-module home configs conditionally

**Sub-modules:**

| sub-module | preference key | description |
|------------|---------------|-------------|
| `qs/` | `widgets.qs` | quickshell with cwc bar |
| `ags/` | `widgets.ags` | ags config |
| `sherlock/` | `widgets.sherlock` | sherlock launcher |

**Dependencies:** `compositor` (compositor auto-starts quickshell)
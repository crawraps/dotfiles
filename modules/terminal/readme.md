# terminal

terminal emulator selection — imports foot and/or kitty based on preference flags.

**Preference key:** `preferences.modules.terminal`
**Default:** `{ foot = true; kitty = false; }`

**Files:**
- `home.nix` — imports sub-module home configs conditionally

**Sub-modules:**

| sub-module | preference key | description |
|------------|---------------|-------------|
| `foot/` | `terminal.foot` | foot terminal + foot server |
| `kitty/` | `terminal.kitty` | kitty terminal |

**Dependencies:** none (but other modules like `desktop-entries` and `compositor` read `preferences.modules.terminal` to select the terminal command)
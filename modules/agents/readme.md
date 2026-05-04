# agents

AI agents and local LLM services.

**Preference key:** `preferences.modules.agents`
**Default:** `{ claude = false; gemini = false; opencode = true; ollama = true; }`

**Files:**
- `system.nix` — ollama service (runs as system daemon with flash attention)
- `home.nix` — installs CLI agents (opencode, claude-code) based on sub-flags

**Dependencies:** none
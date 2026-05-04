# security

gpg agent and password-store with OTP support.

**Preference key:** `preferences.modules.security`
**Default:** `true`

**Files:**
- `system.nix` — enables gnupg agent with pinentry-qt
- `home.nix` — enables `programs.password-store` (pass-wayland + pass-otp) and `programs.gpg`

**Dependencies:** `user` (gnupg home dir created via user module's tmpfiles rules)
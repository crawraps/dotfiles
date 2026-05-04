# bootloader

systemd-boot with rEFInd and quiet boot.

**Preference key:** `preferences.modules.bootloader`
**Default:** `true`

**Files:**
- `system.nix` — systemd-boot, efi config, kernel params (`quiet`, `usbcore.autosuspend=-1`), installs rEFInd + efibootmgr

**Dependencies:** none
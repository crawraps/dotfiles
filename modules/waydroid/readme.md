# waydroid

Container-based approach to run Android on Linux, using a Wayland session.

**Preference key:** `preferences.modules.waydroid`
**Default:** `false`

**Files:**
- `system.nix` — enables waydroid with the nftables package for newer kernels and adds wl-clipboard for clipboard sharing

**Dependencies:** requires a Wayland session (see `compositor` module)

After rebuilding and switching, run `sudo waydroid init` to fetch the Android images and initialize the environment. Use `sudo waydroid init -s GAPPS -f` for GApps support.

**GPU adjustments (NVIDIA / RX 6800 series):**
This host has an NVIDIA RTX 3050 Mobile, so GBM and mesa-drivers must be disabled. After `waydroid init`, edit `/var/lib/waydroid/waydroid_base.prop` and set:

```
ro.hardware.gralloc=default
ro.hardware.egl=swiftshader
```

Then restart waydroid with `sudo systemctl restart waydroid-container`.
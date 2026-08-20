{ lib, preferences, ... }:

let cfg = preferences.modules.locale; in
lib.mkIf cfg {
  time = {
    timeZone = preferences.system.timezone;
    hardwareClockInLocalTime = true; # windows dual-boot recommendation
  };
  i18n.defaultLocale = preferences.system.locale;
}

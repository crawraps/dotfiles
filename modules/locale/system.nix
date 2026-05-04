{ lib, preferences, ... }:

let cfg = preferences.modules.locale; in
lib.mkIf cfg {
  time.timeZone = preferences.system.timezone;
  i18n.defaultLocale = preferences.system.locale;
}
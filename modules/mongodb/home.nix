{ preferences, lib, ... }:

let cfg = preferences.modules.mongodb; in
lib.mkIf cfg {
  xdg.desktopEntries = {
    mongodb-compass = {
      name = "MongoDB Compass";
      exec = "mongodb-compass";
      terminal = false;
      icon = ./assets/pictures/mongo.svg;
      categories = [ "Development" "Database" ];
      comment = "GUI for MongoDB";
      type = "Application";
    };
  };
}
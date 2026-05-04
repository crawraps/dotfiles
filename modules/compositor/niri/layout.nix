{
  layout = {
    gaps = 5;
    center-focused-column = "never";

    preset-column-widths = [
      { proportion = 0.5; }
      { proportion = 0.75; }
      { proportion = 1.0; }
    ];

    default-column-width = { proportion = 0.5; };

    focus-ring.enable = false;
    border.enable = false;
  };

  window-rules = [
    # Float dialogs and utility windows
    {
      matches = [
        { title = "file_progress"; }
        { title = "confirm"; }
        { title = "dialog"; }
        { title = "download"; }
        { title = "notification"; }
        { title = "error"; }
        { title = "splash"; }
        { app-id = "confirmreset"; }
        { title = "Open File"; }
        { title = "branchdialog"; }
        { app-id = "pavucontrol"; }
        { app-id = "file-roller"; }
        { title = "^Media viewer$"; }
        { title = "^Volume Control$"; }
        { title = "^Picture-in-Picture$"; }
      ];
      open-floating = true;
    }
    # Browsers and Thunderbird opaque
    {
      matches = [
        { app-id = "firefox-nightly"; }
        { app-id = "zen-twilight"; }
        { app-id = "thunderbird"; }
      ];
      opacity = 1.0;
    }
    # Thunderbird compose window float
    {
      matches = [
        { app-id = "thunderbird"; title = "^Write:"; }
      ];
      open-floating = true;
    }
  ];
}

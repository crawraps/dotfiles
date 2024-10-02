import TopBar from "windows/topbar";
import Sliders from "windows/sliders";
import NotificationPopups from "windows/notifications";
import Run from "windows/run";

// run `ags init` to symlink type definition

App.config({
  windows: [
    TopBar(),
    TopBar({ monitor: 1 }),
    Sliders(),
    NotificationPopups(),
    Run(),
  ],
  style: loadStyles(),
});

App.addIcons(`${App.configDir}/assets/icons`);

App.closeWindowDelay = {
  sliders: 200,
};

function loadStyles(): string {
  const styles = `${App.configDir}/styles/index.scss`;
  const resolvedStyles = `/home/careem/.cache/ags/styles/index.css`;

  Utils.exec(`dart-sass ${styles} ${resolvedStyles}`);

  return resolvedStyles;
}

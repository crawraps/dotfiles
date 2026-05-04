import NetworkIndicator from "widgets/network";
import Ram from "widgets/ram";
import Cpu from "widgets/cpu";
import KBLayout from "widgets/kb-layout";
import Backlight from "widgets/backlight";
import Audio from "widgets/audio";
import Battery from "widgets/battery";
import Time from "widgets/time";
import Workspaces from "widgets/workspaces";
import Player from "widgets/player";
import WorkTimer from "widgets/work-timer";

const hyprland = await Service.import("hyprland");

interface Props {
  monitor?: number;
}

const Left = (monitor: number) =>
  Widget.Box({
    children: [
      Widget.Box({
        child: Workspaces(monitor),
        classNames: ["menu", "fit"],
      }),
      Widget.Box({
        child: WorkTimer(),
        classNames: ["menu", "work-timer"],
      }),
      Widget.Box({
        child: Player(),
        classNames: ["menu", "player"],
      }),
    ],
    className: "left",
  });

const Center = () =>
  Widget.Box({
    child: Widget.Box({
      children: [Time()],
      className: "menu",
    }),
    className: "center",
    hpack: "center",
  });

const Right = () =>
  Widget.Box({
    child: Widget.Box({
      children: [
        Audio(),
        Backlight(),
        KBLayout(),
        Cpu(),
        Ram(),
        NetworkIndicator(),
        Battery(),
      ],
      spacing: 20,
      className: "menu",
    }),
    className: "right",
    hpack: "end",
  });

const Container = (monitor: number) =>
  Widget.Box({
    children: [Left(monitor), Center(), Right()],
    homogeneous: true,
    className: "container gapped",
  });

export default function Bar({ monitor = 0 }: Props = {}) {
  const visible = Variable(
    Boolean(hyprland.monitors.filter((mon) => mon.id === monitor).length),
  );
  const gapped = Variable(true);

  hyprland.connect("event", (_, name: string) => {
    switch (name) {
      case "workspace":
      case "destroyworkspace":
      case "openwindow":
      case "closewindow":
        const activeWorkspace = hyprland.monitors.find((m) => m.id === monitor)
          ?.activeWorkspace.id;

        const windows = hyprland.workspaces.find(
          (ws) => ws.id === activeWorkspace,
        )?.windows;

        gapped.value = windows !== 1;

        break;
      case "monitorAdded":
      case "monitorRemoved":
        visible.value = Boolean(
          hyprland.monitors.filter((mon) => mon.id === monitor).length,
        );
        break;
    }
  });

  const container = Container(monitor);
  gapped.connect("changed", (gapped) =>
    container.toggleClassName("gapped", gapped.value),
  );

  return Widget.Window({
    name: `top-bar_${monitor}`,
    anchor: ["top", "left", "right"],
    child: container,
    margins: gapped
      .bind()
      .as((gapped) => (gapped ? [4, 4, -4, 8] : [0, 0, 0, 0])),
    layer: "top",
    monitor,
    visible: visible.bind(),
    exclusivity: "exclusive",
    className: "top-bar",
  });
}

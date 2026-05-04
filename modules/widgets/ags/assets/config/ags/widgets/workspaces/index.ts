const hyprland = await Service.import("hyprland");

const dispatch = (ws) => hyprland.messageAsync(`dispatch workspace ${ws}`);

const Container = (monitor: number) =>
  Widget.Box({
    children: Array.from({ length: 10 }, (_, i) => i + 1).map((i) =>
      Widget.Button({
        attribute: i,
        label: `${i}`,
        onPrimaryClick: () => dispatch(i),
        className: "workspace",
      }),
    ),

    setup: (self) => {
      self.hook(hyprland, () => {
        self.children.forEach((btn) => {
          btn.visible = hyprland.workspaces.some(
            (ws) => ws.id === btn.attribute && ws.monitorID === monitor,
          );
        });
      });

      self.hook(hyprland.active.workspace, () => {
        self.children.forEach((btn) => {
          btn.toggleClassName(
            "active",
            btn.attribute === hyprland.active.workspace.id,
          );
        });
      });
    },
    className: "inner-container",
  });

export default (monitor: number) =>
  Widget.EventBox({
    onScrollUp: () => dispatch("+1"),
    onScrollDown: () => dispatch("-1"),
    child: Container(monitor),
    className: "workspaces",
  });


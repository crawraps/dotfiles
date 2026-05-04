import { Notification as NotificationType } from 'types/service/notifications'

const notifications = await Service.import('notifications')
export const animationDuration = 200

function NotificationIcon({ app_entry, app_icon, image }) {
  if (image) {
    return Widget.Box({
      css: `background-image: url("${image}");` + 'background-size: contain;' + 'background-repeat: no-repeat;' + 'background-position: center;',
    })
  }

  let icon = 'dialog-information-symbolic'
  if (Utils.lookUpIcon(app_icon)) icon = app_icon

  if (app_entry && Utils.lookUpIcon(app_entry)) icon = app_entry

  return Widget.Box({
    vpack: 'center',
    hpack: 'center',
    vexpand: true,
    hexpand: true,
    child: Widget.Icon(icon),
  })
}

function Notification(ntf: NotificationType) {
  const icon = Widget.Box({
    vpack: 'start',
    class_name: 'icon',
    child: NotificationIcon(ntf),
  })

  const title = Widget.Label({
    class_name: 'title',
    xalign: 0,
    justification: 'left',
    vexpand: true,
    max_width_chars: 24,
    truncate: 'end',
    wrap: true,
    label: ntf.summary,
    use_markup: true,
  })

  const body = Widget.Label({
    class_name: 'body',
    hexpand: true,
    use_markup: true,
    xalign: 0,
    justification: 'left',
    wrap: true,
    widthChars: 48,
    label: ntf.body,
  })

  const actions = Widget.Box({
    class_name: 'actions',
    homogeneous: true,
    spacing: 8,
    children: ntf.actions.map(({ id, label }) =>
      Widget.EventBox({
        onPrimaryClick: () => {
          ntf.invoke(id)
          ntf.dismiss()
        },
        hexpand: true,
        child: Widget.CenterBox({
          class_name: 'action-button',
          centerWidget: Widget.Label(label)
        }),
      })
    ),
  })

  return Widget.Revealer({
    attribute: { id: ntf.id },
    transition: 'slide_down',
    transitionDuration: animationDuration,
    hexpand: false,
    revealChild: false,
    child: Widget.EventBox({
      on_primary_click: ntf.dismiss,
      hexpand: true,
      vexpand: true,
      css: 'padding: 0;',
      child: Widget.Box({
        class_name: `notification ${ntf.urgency}`,
        vertical: true,
        children: [
          Widget.Box({
            children: [icon, Widget.Box({ vertical: true, children: [title, body] })],
          }),
          ...(ntf.actions.length ? [actions] : []),
        ],
      }),
    }),
  })
}

let staled: number[] = []

export default function NotificationPopups(monitor = 0, maxPopups = 4) {
  notifications.clearDelay = 100

  const list = Widget.Box({
    vertical: true,
    vpack: 'center',
    class_name: 'list',
    spacing: 6,
    children: notifications.popups.map(Notification),
  })

  function onNotified(_, id: number) {
    const ntf = notifications.getNotification(id)

    if (ntf) {
      const notification = Notification(ntf)
      list.children = [...list.children, notification]
      App.openWindow('notifications')

      if (list.children.length > maxPopups) {
        list.children = list.children.slice(1)
      }

      if (staled.length) {
        staled.splice(0, staled.length, ...list.children.map(n => n.attribute.id))
      }

      setTimeout(() => {
        notification.set_reveal_child(true)
      }, 0)
    }
  }

  function onDismissed(_, id: number, force: boolean) {
    const revealer = list.children.find(n => n.attribute.id === id)

    if (revealer && (!staled.includes(id) || force)) {
      revealer.set_reveal_child(false)

      setTimeout(() => {
        revealer.destroy()

        if (list.children.length === 0) {
          App.closeWindow('notifications')
        }
      }, animationDuration)
    }
  }

  function dismissStaled() {
    staled.forEach(id => {
      onDismissed(null, id, true)
    })

    staled = []
  }

  list.hook(notifications, onNotified, 'notified').hook(notifications, onDismissed, 'dismissed')

  return Widget.Window({
    monitor,
    name: 'notifications',
    class_name: 'notification-popups',
    visible: false,
    anchor: ['top'],
    layer: 'overlay',
    child: Widget.Box({
      class_name: 'notifications',
      vertical: true,
      child: Widget.EventBox({
        onHover: () => {
          staled = notifications.popups.map(n => n.id)
        },
        onHoverLost: () => {
          dismissStaled()
        },
        child: list
      }),
    }),
  })
}

export interface TimerState {
  state: "work" | "break";
  start: Date;
  duration: number;
  remainingTime: number;
}

const formatTime = (time) => {
  const pad = (n) => n < 10 ? `0${n}` : n;
  time /= 1000

  const h = Math.floor(time / 3600);
  const m = Math.floor(time / 60) - (h * 60);
  const s = Math.floor(time - h * 3600 - m * 60);

  let res = `${pad(m)}:${pad(s)}`

  if (h > 0) {
    res = `${pad(h)}:` + res;
  }

  return res
}

export const currentState = Variable<TimerState | null>(null, {
  poll: [
    1000,
    `cat ${Utils.CACHE_DIR}/../work-timer_state.json`,
    (out) => {
      const data = JSON.parse(out);

      if (data && data.start) {
        data.start = new Date(data.start);
      }

      if (data && data.start && data.duration) {
        data.remainingTime = data.duration - (new Date().getTime() - data.start.getTime());
      }

      return data.state ? data : null
    },
  ],
});

export default () =>
  Widget.Box({
    children: [
      Widget.Icon({
        icon: "stopwatch",
        className: "icon",
      }),
      Widget.Revealer({
        child: Widget.Label({
          label: currentState.bind().as((state) => {
            if (!state?.state) {
              return "";
            }

            return `${state.state} - ${formatTime(state.remainingTime)}`;
          }),
          maxWidthChars: 20,
          truncate: "end",
        }),
        revealChild: currentState.bind().as((state) => {
          return Boolean(state?.remainingTime) && state!.remainingTime > 0;
        }),
        transition: "slide_right",
        className: "title",
      }),
    ],
    className: "work-timer",
  });

function start(delayTime, cb) {
  timer.interval = delayTime;
  timer.repeat = false;
  timer.triggered.connect(cb);
  timer.start();
}

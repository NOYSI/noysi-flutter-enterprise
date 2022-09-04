///Logger interface used to print logs or not depending the current debug level.
abstract class Logger {
  log(Object message);
}

class LoggerEmptyImpl implements Logger {
  @override
  log(Object message) {
    //nothing
  }
}

class LoggerImpl implements Logger {
  @override
  log(Object message) {
    print(message);
  }
}

abstract class BaseBloC {
  ///Be sure to override this function and dispose all streams
  void dispose();
}
// ///Save add a value into a controller sink. It should be an Extension
// sinkAdd<T>(StreamController<T> controller, T value) {
//   if (!controller.isClosed)
//     controller.sink.add(value);
// }
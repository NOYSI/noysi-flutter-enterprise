
import 'package:code/data/api/remote/network_handler.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

class TXUriResolverBloC extends BaseBloC {
  final NetworkHandler _networkHandler;

  TXUriResolverBloC(this._networkHandler);

  BehaviorSubject<String> _uriController = new BehaviorSubject();

  Stream<String> get uriResult => _uriController.stream;

  void resolverUri(String baseUri) async {
    final res = await _networkHandler.get(path: baseUri);
    if (res.statusCode == RemoteConstants.code_success) {
      final uri = res.headers["location"];
      _uriController.sinkAddSafe(uri![0]);
    } else {
      _uriController.sinkAddSafe("");
    }
  }

  @override
  void dispose() {
    _uriController.close();
  }
}

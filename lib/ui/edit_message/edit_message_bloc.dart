import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/message/i_message_repository.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_form_validator.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

class EditMessageBloC extends BaseBloC
    with LoadingBloC, ErrorHandlerBloC, FormValidatorBloC {
  final IMessageRepository _iMessageRepository;

  EditMessageBloC(this._iMessageRepository);

  @override
  void dispose() {
    _editController.close();
    disposeErrorHandlerBloC();
    disposeLoadingBloC();
  }

  BehaviorSubject<bool> _editController = new BehaviorSubject();

  Stream<bool> get editResult => _editController.stream;

  MessageModel? model;
  bool edited = false;

  void edit(String content) async {
    isLoading = true;
    final res = await _iMessageRepository.putMessage(model!.id, content);
    if (res is ResultSuccess<bool>) {
      model?.text = content;
      model?.html = content;
      edited = true;
      _editController.sinkAddSafe(edited);
    }else
      showErrorMessage(res);
    isLoading = false;
  }
}

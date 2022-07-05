import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/message/message_model.dart';

abstract class IFileConverter {
  FileModel fromJson(Map<String, dynamic> json);

  FileWrapperModel fromJsonFileWrapper(Map<String, dynamic> json);

  FileThumbnailModel fromJsonFileThumbnail(Map<String, dynamic> json);

  FolderModel fromJsonFolder(Map<String, dynamic> json);

  Map<String, dynamic> toJsonFileCreate(FileCreateModel model);

  Map<String, dynamic> toJsonFolderCreate(FolderCreateModel model);

  Map<String, dynamic> toJsonFileCreateConfirm(FileCreateConfirmModel model);
}

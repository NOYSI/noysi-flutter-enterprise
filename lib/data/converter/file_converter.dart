import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/file/i_file_converter.dart';
import 'package:code/domain/message/message_model.dart';

class FileConverter implements IFileConverter {
  @override
  FileModel fromJson(Map<String, dynamic> json) {
    final FileModel model = FileModel(
        id: json["id"],
        type: json["type"],
        subType: json["subtype"],
        uid: json["uid"],
        tid: json["tid"],
        cid: json["cid"],
        mid: json["mid"],
        text: json["text"],
        html: json["html"],
        ts: json.containsKey("ts") && json["ts"] != null
            ? DateTime.fromMillisecondsSinceEpoch(json["ts"], isUtc: true)
                .toLocal()
            : null,
        location: json.containsKey("location") ? json["location"] : null,
        comments: json["comments"],
        path: json["path"],
        name: json["name"],
        contentType: json["content-type"],
        mimeType: json["mime"],
        size: json["size"],
        title: json["title"],
        url: json["url"],
        link: json["link"],
        folder: json["folder"],
        ref: json["ref"],
        width: json["width"],
        height: json["height"],
        thumbnail: json.containsKey('thumbnail')
            ? fromJsonFileThumbnail(json['thumbnail'])
            : null);
    return model;
  }

  @override
  FolderModel fromJsonFolder(Map<String, dynamic> json) {
    return FolderModel(
      id: json['id'],
      path: json['path'],
      tid: json['tid'],
      cid: json['cid'],
      renamed: json.containsKey('renamed')
          ? DateTime.fromMillisecondsSinceEpoch(json["renamed"], isUtc: true)
              .toLocal()
          : null,
    );
  }

  @override
  FileThumbnailModel fromJsonFileThumbnail(Map<String, dynamic> json) {
    final FileThumbnailModel model = FileThumbnailModel(
        width: double.tryParse(json["width"].toString()) ?? 0.0,
        height: double.tryParse(json["height"].toString()) ?? 0.0);
    return model;
  }

  @override
  FileWrapperModel fromJsonFileWrapper(Map<String, dynamic> json) {
    final FileWrapperModel model = FileWrapperModel(
        id: json.containsKey('id') ? json['id'] : null,
        uid: json.containsKey('uid') ? json['uid'] : null,
        path: json["path"],
        parent: json["parent"],
        cid: json["cid"],
        total: json.containsKey("total") && json["total"] != null
            ? json["total"]
            : 0,
        list: (json["list"] as List<dynamic>).map((e) => fromJson(e)).toList());
    return model;
  }

  @override
  Map<String, dynamic> toJsonFileCreate(FileCreateModel model) {
    final map = {
      "type": "file",
      "mime": model.mime,
      "path": model.path,
      "size": model.size
    };
    return map;
  }

  @override
  Map<String, dynamic> toJsonFileCreateConfirm(FileCreateConfirmModel model) {
    final map = model.pmid == null
        ? {
            "mime": model.mime,
            "path": model.path,
            "title": model.title,
            "provider": model.provider,
            "size": model.size
          }
        : {
            "mime": model.mime,
            "path": model.path,
            "title": model.title,
            "provider": model.provider,
            "size": model.size,
            "pmid": model.pmid,
            "showOnChannel": model.showOnChannel
          };
    return map;
  }

  @override
  Map<String, dynamic> toJsonFolderCreate(FolderCreateModel model) {
    final map = {"path": model.path, "type": model.type};
    return map;
  }
}

class FileWrapperModel {
  String? id;
  String parent;
  String? cid;
  String? uid;
  String path;
  int total;
  List<FileModel> list;

  FileWrapperModel({this.id, this.path = '', this.parent = '', this.cid, this.list = const [], this.total = 0, this.uid});
}

class FileModel {
  String? id;
  String? type;
  String? subType;
  String? uid;
  String? tid;
  String? cid;
  String? mid;
  String? text;
  String? html;
  int? comments;
  String path;
  String? name;
  String? contentType;
  String mimeType;
  int size;
  String? title;
  String? url;
  String? link;
  bool? folder;
  String? ref;
  int? width;
  int? height;
  DateTime? ts;
  bool isUploadingDownloading;
  String? location;
  FileThumbnailModel? thumbnail;

  String get sizeFixed => (size) <= 1024
      ? "1 kb"
      : ((size) > 1024 && (size) <= 1048576)
          ? "${((size) / 1024).toStringAsFixed(2)} kb"
          : ((size) > 1048576 && (size) <= 1073741824)
              ? "${(((size) / 1024) / 1024).toStringAsFixed(2)} mb"
              : "${((((size) / 1024) / 1024) / 1024).toStringAsFixed(2)} gb";

  String get titleFixed => name?.trim().isNotEmpty == true ? name! : title ?? "";

  bool get isImage => mimeType.contains("image");
  FileModel(
      {this.id = '',
      this.type = '',
      this.subType = '',
      this.uid = '',
      this.tid,
      this.cid,
      this.mid,
      this.text = '',
      this.isUploadingDownloading = false,
      this.html = '',
      this.comments = 0,
      this.path = '',
      this.name = '',
      this.contentType = '',
      this.mimeType = '',
      this.size = 1,
      this.title = '',
      this.url = '',
      this.link = '',
      this.folder = false,
      this.ref = '',
      this.width,
      this.height,
      this.ts,
      this.location = '',
      this.thumbnail});
}

class FileThumbnailModel {
  double width;
  double height;

  FileThumbnailModel({this.width = 0.0, this.height = 0.0});
}

class FolderCreateModel {
  String type;
  String path;

  FolderCreateModel({this.type = '', this.path = ''});
}

class FileCreateModel {
  String type;
  String mime;
  String path;
  int? size;

  FileCreateModel({this.type = '', this.mime = '', this.path = '', this.size});
}

class FileCreateConfirmModel {
  String provider;
  String title;
  String mime;
  String path;
  int? size;
  String? pmid;
  bool showOnChannel;

  FileCreateConfirmModel(
      {this.provider = '',
      this.title = '',
      this.mime = '',
      this.path = '',
      this.size,
      this.pmid,
      this.showOnChannel = false});
}

class UsageModel {
  UsageFilesModel? files;
  UsageMessageModel? messages;

  UsageModel({this.files, this.messages});
}

class UsageFilesModel {
  int count;
  int size;

  UsageFilesModel({this.count = 0, this.size = 0});
}

class UsageMessageModel {
  int count;

  UsageMessageModel({this.count = 0});
}

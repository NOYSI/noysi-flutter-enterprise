import 'package:code/domain/usage/i_usage_converter.dart';
import 'package:code/domain/usage/usage_model.dart';

class UsageConverter implements IUsageConverter{
  @override
  UsageModel fromJson(Map<String, dynamic> json) {
    final UsageModel model = UsageModel(
      files: fromJsonUsageFile(json["files"]),
      messages: fromJsonUsageMessage(json["messages"])
    );
    return model;
  }

  @override
  UsageFilesModel fromJsonUsageFile(Map<String, dynamic> json) {
    final UsageFilesModel model = UsageFilesModel(
      count: json["count"],
      size: json["size"]
    );
    return model;
  }

  @override
  UsageMessageModel fromJsonUsageMessage(Map<String, dynamic> json) {
    final UsageMessageModel model = UsageMessageModel(
      count: json["count"]
    );
    return model;
  }

}
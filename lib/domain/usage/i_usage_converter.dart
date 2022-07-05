import 'package:code/domain/usage/usage_model.dart';

abstract class IUsageConverter {
  UsageModel fromJson(Map<String, dynamic> json);

  UsageFilesModel fromJsonUsageFile(Map<String, dynamic> json);

  UsageMessageModel fromJsonUsageMessage(Map<String, dynamic> json);
}

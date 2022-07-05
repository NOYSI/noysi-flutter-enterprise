
import 'package:code/domain/activity/activity_model.dart';

abstract class IActivityConverter{

  ActivityModel fromJson(Map<String, dynamic> json);

  ActivityWrapperModel fromJsonWrapperModel(Map<String, dynamic> json);

  SessionModel fromJsonSessionModel(Map<String, dynamic> json);
}
import 'dart:math';

enum fcmMessageActions { CALL, HANG_DOWN, MESSAGE }

class FCMMessageModel {
  final int? from;
  final String sender;
  final String cid;
  final String title;
  final String image;
  final String message;
  final String sound;
  final String tid;
  final int notId;
  final String teamName;
  final String teamTitle;
  final String channelName;
  final fcmMessageActions action;

  String get teamTitleFixed =>
      teamTitle.trim().isNotEmpty ? teamTitle : teamName;

  FCMMessageModel({
    this.from,
    this.teamName = '',
    this.teamTitle = '',
    this.channelName = '',
    this.sender = '',
    this.cid = '',
    this.title = '',
    this.image = '',
    this.message = '',
    this.sound = '',
    this.tid = '',
    this.action = fcmMessageActions.MESSAGE,
    this.notId = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      "from": this.from,
      "sender": this.sender,
      "channel": this.cid,
      "title": this.title,
      "image": this.image,
      "message": this.message,
      "sound": this.sound,
      "action": this.action == fcmMessageActions.CALL
          ? "tok_call"
          : this.action == fcmMessageActions.HANG_DOWN
              ? "tok_hang_down"
              : "message",
      "team": this.tid,
      "teamName": this.teamName,
      "teamTitle": this.teamTitle,
      "channelName": this.channelName,
      "notId": this.notId
    };
  }

  factory FCMMessageModel.fromString(Map<String, dynamic> bodyJson) {
    return FCMMessageModel(
      from: bodyJson.containsKey("from") && bodyJson['from'] != null
          ? int.tryParse(bodyJson['from'].toString())
          : null,
      sender: bodyJson['sender'],
      cid: bodyJson['channel'],
      title: bodyJson['title'],
      image: bodyJson['image'],
      message: bodyJson.containsKey("message") ? bodyJson['message'] ?? "" : "",
      sound: bodyJson['sound'] ?? "",
      action: bodyJson.containsKey("action") && bodyJson["action"] != null
          ? bodyJson["action"] == "tok_call"
              ? fcmMessageActions.CALL
              : bodyJson["action"] == "message"
                  ? fcmMessageActions.MESSAGE
                  : fcmMessageActions.HANG_DOWN
          : fcmMessageActions.MESSAGE,
      tid: bodyJson['team'],
      teamName: bodyJson['teamName'],
      teamTitle:
          bodyJson.containsKey('teamTitle') && bodyJson['teamTitle'] != null
              ? bodyJson['teamTitle']
              : "",
      channelName: bodyJson['channelName'],
      notId: bodyJson.containsKey('notId') && bodyJson['notId'] != null
          ? int.tryParse(bodyJson['notId'].toString())?.abs() ??
              Random().nextInt(999999)
          : Random().nextInt(999999),
    );
  }
}

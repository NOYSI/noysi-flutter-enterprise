import 'dart:async';
import 'dart:collection';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:flutter/cupertino.dart';

import '../enums.dart';

extension SafeSink<T> on StreamController<T> {
  void sinkAddSafe(T value) {
    if (!this.isClosed) this.sink.add(value);
  }
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this?.isEmpty == true;

  String? toCapitalize() {
    if (this?.trim().isNotEmpty == true) {
      String? subString = this?.substring(0, 1);
      if (subString != null) {
        return this?.trim().replaceFirst(subString, subString.toUpperCase());
      }
      return this;
    } else {
      return this;
    }
  }

  bool isUpperCase() {
    if (this == null) {
      return false;
    }
    if (this?.isEmpty == true) {
      return false;
    }
    if (this?.trimLeft().isEmpty == true) {
      return false;
    }
    String? firstLetter = this?.trimLeft().substring(0, 1);
    if (double.tryParse(firstLetter!) != null) {
      return false;
    }
    return firstLetter.toUpperCase() == this?.substring(0, 1);
  }
}

extension MessageIndexExtension on List<MessageModel> {
  void setToSentStatus() {
    this.forEach((element) {
      element.messageStatus = MessageStatus.Sent;
    });
  }

  int messageIndexById(String id) {
    int index = -1;
    if (this.isEmpty) return index;
    for (int i = 0; i < this.length; i++) {
      final m = this[i];
      if (id == m.id) {
        index = i;
        break;
      }
    }
    return index;
  }

  MessageModel? firstMessageById(String id) {
    MessageModel? model;
    for (int i = 0; i < this.length; i++) {
      final m = this[i];
      if (id == m.id) {
        model = m;
        break;
      }
    }
    return model;
  }
}

extension ChannelListExtension on List<ChannelModel> {
  void setTeamId(String teamId) {
    this.forEach((element) {
      element.tid = teamId;
    });
  }
}

extension ColorExtension on Color {
  Color darken([double amount = .04]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten([double amount = .04]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
}

extension LinkedHashMapExtensions on LinkedHashMap {
  HashMap<String, dynamic> toMap() {
    return HashMap.from(this.map((key, value) => MapEntry(key, value)));
  }
}

import 'dart:ui';

import 'package:code/_res/R.dart';

class TagColorUIModel {
  int id;
  Color color;
  String code;
  bool isSelected;
  String textCodeColor;

  TagColorUIModel({required this.id, required this.color, required this.code, this.isSelected = false, required this.textCodeColor});

  static List<TagColorUIModel> getTagColorsList() {
    List<TagColorUIModel> list = [];
    final color1 = TagColorUIModel(
        id: 1, color: R.color.tagColor1, code: "#FF6666", isSelected: true, textCodeColor: "#FFFFFF");
    final color2 = TagColorUIModel(
        id: 2, color: R.color.tagColor2, code: "#FF9466", isSelected: false, textCodeColor: "#FFFFFF");
    final color3 = TagColorUIModel(
        id: 3, color: R.color.tagColor3, code: "#FFD166", isSelected: false, textCodeColor: "#2B3845");
    final color4 = TagColorUIModel(
        id: 4, color: R.color.tagColor4, code: "#FFFF00", isSelected: false, textCodeColor: "#2B3845");
    final color5 = TagColorUIModel(
        id: 5, color: R.color.tagColor5, code: "#218100", isSelected: false, textCodeColor: "#FFFFFF");
    final color6 = TagColorUIModel(
        id: 6, color: R.color.tagColor6, code: "#7ED321", isSelected: false, textCodeColor: "#FFFFFF");
    final color7 = TagColorUIModel(
        id: 7, color: R.color.tagColor7, code: "#17B6A7", isSelected: false, textCodeColor: "#FFFFFF");
    final color8 = TagColorUIModel(
        id: 8, color: R.color.tagColor8, code: "#00FFCE", isSelected: false, textCodeColor: "#2B3845");
    final color9 = TagColorUIModel(
        id: 9, color: R.color.tagColor9, code: "#0000EE", isSelected: false, textCodeColor: "#FFFFFF");
    final color10 = TagColorUIModel(
        id: 10, color: R.color.tagColor10, code: "#2A80B9", isSelected: false, textCodeColor: "#FFFFFF");
    final color11 = TagColorUIModel(
        id: 11, color: R.color.tagColor11, code: "#28A6EF", isSelected: false, textCodeColor: "#FFFFFF");
    final color12 = TagColorUIModel(
        id: 12, color: R.color.tagColor12, code: "#3F71FF", isSelected: false, textCodeColor: "#FFFFFF");
    final color13 = TagColorUIModel(
        id: 13, color: R.color.tagColor13, code: "#6800D3", isSelected: false, textCodeColor: "#FFFFFF");
    final color14 = TagColorUIModel(
        id: 14, color: R.color.tagColor14, code: "#A800FF", isSelected: false, textCodeColor: "#FFFFFF");
    final color15 = TagColorUIModel(
        id: 15, color: R.color.tagColor15, code: "#EB58DF", isSelected: false, textCodeColor: "#FFFFFF");
    final color16 = TagColorUIModel(
        id: 16, color: R.color.tagColor16, code: "#FF709F", isSelected: false, textCodeColor: "#FFFFFF");

    list.add(color1);
    list.add(color2);
    list.add(color3);
    list.add(color4);
    list.add(color5);
    list.add(color6);
    list.add(color7);
    list.add(color8);
    list.add(color9);
    list.add(color10);
    list.add(color11);
    list.add(color12);
    list.add(color13);
    list.add(color14);
    list.add(color15);
    list.add(color16);

    return list;
  }
}

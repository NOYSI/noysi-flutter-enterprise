import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showTXModalBottomSheet({
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  showCupertinoModalPopup(
    semanticsDismissible: false,
    context: context,
    builder: (b) => Container(
      color: Colors.white,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 100),
      child: Material(child: builder(context)),
    ),
  );
}

void showTXModalBottomSheetAutoAdjustable({
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (b) => Container(
      color: Colors.white,
      width: double.infinity,
      child: SafeArea(
        bottom: true,
        left: false,
        right: false,
        top: false,
        child: SingleChildScrollView(
          child: builder(context),
        ),
      ),
    ),
  );
}

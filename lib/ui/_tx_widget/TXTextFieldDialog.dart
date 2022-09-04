

import 'package:code/ui/_base/bloc_form_validator.dart';
import 'package:code/ui/_tx_widget/tx_blur_dialog.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:flutter/material.dart';

import '../../_res/R.dart';

class TXTextFieldDialog {
  static show(BuildContext context, {
    required String title,
    required Function(bool) action,
    required TextEditingController controller,
    String? okName,
    String? Function(dynamic)? validator,
  }) {
    final keyFormRename = GlobalKey<FormState>();
    final focusNode = FocusNode();
    return showBlurDialog(
      context: context,
      builder: (context) {
        FocusScope.of(context).requestFocus(focusNode);
        return AlertDialog(
          title: TXTextWidget(
            text: title,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.bold,
            size: 16,
          ),
          content: Form(
            key: keyFormRename,
            child: TXTextFieldWidget(
              controller: controller,
              validator: validator,
              focusNode: focusNode,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: TXTextWidget(
                text: okName?.isEmpty == true ? R.string.ok : okName!,
                fontWeight: FontWeight.bold,
              ),
              onPressed: () {
                if (validator == null || keyFormRename.currentState?.validate() == true) {
                  action(true);
                  Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
              child: TXTextWidget(
                text: R.string.cancel,
                fontWeight: FontWeight.bold,
              ),
              onPressed: () {
                action(false);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
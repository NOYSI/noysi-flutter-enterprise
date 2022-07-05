import 'package:code/_res/R.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';

class TXCheckBoxWidget extends StatelessWidget {
  final String? text;
  final bool value;
  final ValueChanged<bool>? onChange;
  final bool leading;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final bool removeCheckboxExtraPadding;
  final CrossAxisAlignment? crossAxisAlignment;

  const TXCheckBoxWidget({
    super .key,
    this.text,
    this.onChange,
    this.value = false,
    this.leading = false,
    this.removeCheckboxExtraPadding = false,
    this.textColor,
    this.crossAxisAlignment,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChange!(!value);
      },
      child: Container(
        padding: padding,
        child: leading ? leadingWidget() : trailingWidget(),
      ),
    );
  }

  Widget trailingWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: removeCheckboxExtraPadding
            ? <Widget>[
                Expanded(
                  child: TXTextWidget(
                    text: text ?? '',
                    color: textColor ?? R.color.primaryColor,
                  ),
                ),
                SizedBox.fromSize(
                  size: const Size(kRadialReactionRadius, kRadialReactionRadius),
                  child: Checkbox(
                    onChanged: (value) {
                      onChange!(value!);
                    },
                    value: value,
                  ),
                ),
              ]
            : <Widget>[
                Expanded(
                  child: TXTextWidget(
                    text: text ?? '',
                    color: textColor ?? R.color.primaryColor,
                  ),
                ),
                Checkbox(
                  onChanged: (value) {
                    onChange!(value!);
                  },
                  value: value,
                )
              ],
      );

  Widget leadingWidget() => Row(
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: removeCheckboxExtraPadding
            ? <Widget>[
                SizedBox.fromSize(
                  size: const Size(kRadialReactionRadius, kRadialReactionRadius),
                  child: Checkbox(
                    onChanged: (value) {
                      onChange!(value!);
                    },
                    value: value,
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: TXTextWidget(
                    text: text ?? '',
                    color: textColor ?? R.color.primaryColor,
                  ),
                ),
              ]
            : <Widget>[
                Checkbox(
                  onChanged: (value) {
                    onChange!(value!);
                  },
                  value: value,
                ),
                Expanded(
                  child: TXTextWidget(
                    text: text ?? '',
                    color: textColor ?? R.color.primaryColor,
                  ),
                ),
              ],
      );
}

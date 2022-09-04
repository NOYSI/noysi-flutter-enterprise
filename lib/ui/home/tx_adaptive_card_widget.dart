import 'package:code/_res/R.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';

class AdaptiveCardWidget extends StatelessWidget {
  final MessageModel messageModel;
  final ValueChanged<String>? onBtnTap;

  const AdaptiveCardWidget({Key? key, required this.messageModel, this.onBtnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ArgumentAttachment> attachments = messageModel.args?.attachments ?? [];

    return Container(
      constraints: BoxConstraints(maxHeight: 300),
      child: Card(
        margin: EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._getAttachmentsContainerForBtns(context, attachments)
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getAttachmentsContainerForBtns(
      BuildContext context, List<ArgumentAttachment> attachments) {
    List<Widget> list = [];
    if (attachments.length <= 1 && attachments[0].content?.tap == null) {
      return [_getInWrapMode(context, attachments[0])];
    } else {
      attachments.forEach((attachment) {
        Color bgColor = Color(attachment.content?.getColorCode ?? 0xFFFFFFFF);
        List<Widget> btns = [];
        final isRedBackground = attachment.content?.bgColor == "#f00";
        if(attachment.content?.tap == null) {
          attachment.content?.buttons.forEach((btn) {
            btns.add(getButtonItem(btn,
                isWrapMode: false,
                textColor: isRedBackground ? R.color.whiteColor : null));
          });
        } else {
          btns.add(getTapItem(attachment.content!.tap!, attachment.content?.text ?? ""));
        }
        Widget btnBoxGroup = Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: bgColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                child: TXTextWidget(
                  text: attachment.content?.title ?? "",
                  fontWeight: FontWeight.bold,
                  color:
                      isRedBackground ? R.color.whiteColor : R.color.blackColor,
                  size: 18,
                ),
                onTap: () {
                  if (attachment.content?.tap != null && onBtnTap != null)
                    onBtnTap!(attachment.content!.tap!.value);
                },
              ),
              ...btns
            ],
          ),
        );
        list.add(btnBoxGroup);
      });
    }
    return list;
  }

  Widget _getInWrapMode(BuildContext context, ArgumentAttachment attachment) {
    List<Widget> btns = [];
    attachment.content?.buttons.forEach((btn) {
      btns.add(Container(
          margin: EdgeInsets.only(bottom: 5, left: 10, right: 10, top: 5),
          child: getButtonItem(btn)));
    });
    return Wrap(
      children: [...btns],
    );
  }

  Widget getTapItem(ArgumentAttachmentContentButton tap, String text, {Color? textColor}) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(width: .5, color: textColor ?? R.color.grayColor),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      width: double.infinity,
      child: InkWell(
        highlightColor: R.color.grayColor,
        splashColor: R.color.grayColor,
        hoverColor: R.color.grayColor,
        onTap: () {
          if (onBtnTap != null) onBtnTap!(tap.value);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
          child: TXTextWidget(
            text: text,
            color: textColor ?? R.color.grayDarkColor,
          ),
        ),
      ),
    );
  }

  Widget getButtonItem(ArgumentAttachmentContentButton button,
      {bool isWrapMode = true, Color? textColor}) {
    return Container(
      margin: EdgeInsets.only(bottom: !isWrapMode ? 5 : 0),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(width: .5, color: textColor ?? R.color.grayColor),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      width: double.infinity,
      child: InkWell(
        highlightColor: R.color.grayColor,
        splashColor: R.color.grayColor,
        hoverColor: R.color.grayColor,
        onTap: () {
          if (onBtnTap != null) onBtnTap!(button.value);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
          child: TXTextWidget(
            text: "${isWrapMode ? "" : "-"} ${button.title}",
            color: textColor ?? R.color.grayDarkColor,
          ),
        ),
      ),
    );
  }
}

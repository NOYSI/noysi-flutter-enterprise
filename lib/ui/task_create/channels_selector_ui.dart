import 'package:code/_res/R.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:flutter/material.dart';

import '../../utils/common_utils.dart';

class ChannelsSelectorUI extends StatelessWidget {
  final List<DrawerChatModel> drawerChatList;

  const ChannelsSelectorUI({
    Key? key,
    required this.drawerChatList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TXMainAppBarWidget(
        title: R.string.selectChannel,
        body: ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ).copyWith(bottom: 30),
          physics: BouncingScrollPhysics(),
          itemBuilder: (ctx, index) {
            final model = drawerChatList[index];
            return Container(
              child: model.isChild
                  ? _getChildWidget(context, model)
                  : _getHeaderWidget(model),
            );
          },
          itemCount: drawerChatList.length,
        ));
  }

  Widget _getHeaderWidget(DrawerChatModel model) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: TXTextWidget(
        text: model.title,
        color: R.color.grayColor,
      ),
    );
  }

  Widget _getChildWidget(BuildContext context, DrawerChatModel model) {
    return InkWell(
      onTap: () {
        NavigationUtils.pop(context, result: model.channelModel?.id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.only(left: 15),
        child: TXTextWidget(
          text: model.channelModel?.isM1x1 == true
              ? "@${CommonUtils.getMemberUsername(model.memberModel) ?? ""}"
              : model.title.toLowerCase().trim(),
          color: R.color.blackColor,
        ),
      ),
    );
  }
}

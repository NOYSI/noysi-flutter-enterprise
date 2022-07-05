import 'package:code/_res/R.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:code/ui/private_group/private_group_bloc.dart';
import 'package:code/ui/private_group_create/private_group_create_page.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:flutter/material.dart';
import 'package:code/utils/extensions.dart';

class PrivateGroupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PrivateGroupState();
}

class _PrivateGroupState
    extends StateWithBloC<PrivateGroupPage, PrivateGroupBloC> {
  @override
  void initState() {
    super.initState();
    bloc.loadGroups();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        TXMainAppBarWidget(
          title: R.string.privateGroups,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add, color: R.color.whiteColor,),
            backgroundColor: R.color.secondaryColor,
            onPressed: () async {
              NavigationUtils.push(context, PrivateGroupCreatePage());
            },
          ),
          body: Container(
            child: StreamBuilder<List<ChannelModel>>(
              stream: bloc.privateGroupResult,
              initialData: [],
              builder: (ctx, snapshot) {
                if (snapshot.data!.isEmpty) return Container();
                return Stack(
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 60),
                      itemBuilder: (ctx, index) {
                        return _getPrivateGroupCell(snapshot.data![index]);
                      },
                      itemCount: snapshot.data!.length,
                    ),
                    TXLoadingWidget(
                      loadingStream: bloc.isLoadingStream,
                    )
                  ],
                );
              },
            ),
          ),
        ),
        TXLoadingWidget(
          loadingStream: bloc.isLoadingStream,
        )
      ],
    );
  }

  Widget _getPrivateGroupCell(ChannelModel channelModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            changeChannelAutoController.sinkAddSafe(
                ChannelCreatedUI(channelModel: channelModel, members: []));
            NavigationUtils.popUntilWithRouteAndMaterial(
                context, NavigationUtils.HomeRoute);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TXTextWidget(
                        text: channelModel.titleFixed.trim().toLowerCase(),
                        fontWeight: FontWeight.bold,
                        color: R.color.blackColor,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TXTextWidget(
                        size: 12,
                        text:
                            "${R.string.created} ${CalendarUtils.showInFormat(R.string.dateFormat1, channelModel.created)}",
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.group,
                      size: 10,
                      color: R.color.darkColor,
                    ),
                    TXTextWidget(
                      text: channelModel.totalMembers.toString(),
                      size: 12,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        TXDividerWidget()
      ],
    );
  }
}

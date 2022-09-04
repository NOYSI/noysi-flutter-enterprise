import 'package:code/_res/R.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_html_widget.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_pull_to_refresh_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/link/link_bloc.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:code/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:collection/collection.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../enums.dart';

class LinkPage extends StatefulWidget {
  final List<MemberModel> members;

  const LinkPage({Key? key, required this.members}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LinkState();
}

class _LinkState extends StateWithBloC<LinkPage, LinkBloC> {
  ScrollController _scrollController = new ScrollController();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc.init();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        TXMainAppBarWidget(
          title: R.string.seeLinks,
          actions: <Widget>[
            StreamBuilder<bool>(
                stream: bloc.sortResult,
                initialData: true,
                builder: (context, snapshotSort) {
                  return TXIconButtonWidget(
                    icon: Icon(
                        snapshotSort.data!
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: R.color.grayLightColor),
                    onPressed: () async {
                      if (!bloc.isLoadingLinks) {
                        bloc.currentQuery = "";
                        bloc.channelLinkWrappedModel.sort =
                            bloc.channelLinkWrappedModel.sort == CommonSort.desc
                                ? CommonSort.asc
                                : CommonSort.desc;
                        await bloc.loadLinks(isSortAction: true);
                        _scrollController
                            .jumpTo(_scrollController.position.minScrollExtent);
                      }
                    },
                  );
                }),
          ],
          body: Container(
            child: StreamBuilder<ChannelLinkWrappedModel>(
                stream: bloc.linkResult,
                initialData: bloc.channelLinkWrappedModel,
                builder: (context, snapshot) {
                  return TXPullToRefreshWidget(
                    onRefresh: (_refreshController) async {
                      await bloc.loadLinks();
                      _refreshController.refreshCompleted();
                    },
                    onLoadMore: (_refreshController) async {
                      await bloc.loadLinks(isLoadingMore: true);
                      _refreshController.loadComplete();
                    },
                    body: _getLinksListWidget(context, snapshot.data!),
                  );
                }),
          ),
        ),
        TXLoadingWidget(
          loadingStream: bloc.isLoadingStream,
        )
      ],
    );
  }

  Widget _getLinksListWidget(
      BuildContext context, ChannelLinkWrappedModel channelLinkWrappedModel) {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.only(bottom: 60),
      itemBuilder: (ctx, index) {
        final ChannelLinkModel model = channelLinkWrappedModel.list[index];
        return Container(child: _getLinkWidget(model));
      },
      itemCount: channelLinkWrappedModel.list.length,
    );
  }

  Widget _getLinkWidget(ChannelLinkModel link) {
    final member =
        widget.members.firstWhereOrNull((element) => element.id == link.uid);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: <Widget>[
                TXTextWidget(
                  text: "@${CommonUtils.getMemberUsername(member)}",
                  color: R.color.blackColor,
                  fontWeight: FontWeight.bold,
                ),
                TXTextWidget(
                  text: CalendarUtils.showInFormat(
                          R.string.dateFormat1, link.ts) ??
                      '',
                )
              ],
            ),
          ),
          Container(
            child: TXHtmlWidget(
              shrinkWrap: true,
              body:
                  "<div class =\"body_local_mobile\"><a href='${link.url}'>${link.url}</a></div>",
              style: {
                "div.body_local_mobile": Style(fontSize: FontSize(20)),
                "a": Style(
                    color: R.color.secondaryColor,
                    textDecoration: TextDecoration.none),
              },
            ),
          ),
          TXDividerWidget()
        ],
      ),
    );
  }
}

import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_base/richtext_widgets/tx_user_date_message_widget.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_gesture_hide_key_board.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_menu_option_item_widget.dart';
import 'package:code/ui/_tx_widget/tx_message_body_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_pull_to_refresh_widget.dart';
import 'package:code/ui/_tx_widget/tx_search_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:code/ui/message_comments/message_comments_page.dart';
import 'package:code/ui/search_global/search_global_bloc.dart';
import 'package:code/ui/share/share_file_page.dart';
import 'package:code/ui/task/task_page_view_widget.dart';
import 'package:code/ui/task/task_ui_model.dart';
import 'package:code/ui/task_detail/task_detail_page.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:code/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:code/utils/extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../rtc/rtc_manager.dart';
import '../_tx_widget/tx_divider_widget.dart';

class SearchGlobalPage extends StatefulWidget {
  final TeamJoinedModel joinedTeam;
  final List<DrawerChatModel> drawerChatList;

  const SearchGlobalPage(
      {required this.joinedTeam, required this.drawerChatList});

  @override
  State<StatefulWidget> createState() => _SearchGlobalState();
}

class _SearchGlobalState
    extends StateWithBloC<SearchGlobalPage, SearchGlobalBloC>
    with SingleTickerProviderStateMixin {
  PageController pageController = PageController(initialPage: 0);
  DateTime searchMarkTime = DateTime.now();

  ScrollController _scrollMessagesController = new ScrollController();
  ScrollController _scrollMembersController = new ScrollController();
  ScrollController _scrollFilesController = new ScrollController();
  ScrollController _navBarController = new ScrollController();
  late AnimationController _animationController;

  bool navIsAtEnd = false;

  @override
  void initState() {
    super.initState();
    bloc.initViewData();
    _animationController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 1, // initially visible
    );
    bloc.createChatResult.listen((event) {
      if (event) {
        NavigationUtils.pop(context);
      }
    });
    bloc.popToHome.listen((value) {
      if (value)
        NavigationUtils.popUntilWithRouteAndMaterial(
            context, NavigationUtils.HomeRoute);
    });
    _navBarController.addListener(_navBarListener);
  }

  void _navBarListener() {
    if (_navBarController.position.pixels >
        _navBarController.position.maxScrollExtent - 10) {
      if (!navIsAtEnd) {
        navIsAtEnd = true;
        _animationController.reverse();
      }
    } else if (navIsAtEnd) {
      navIsAtEnd = false;
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _navBarController.removeListener(_navBarListener);
    _animationController.dispose();
    _navBarController.dispose();
    _scrollFilesController.dispose();
    _scrollMembersController.dispose();
    _scrollMessagesController.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return TXSearchBarAppWidget(
      onTextChange: (query) {
        bloc.searchByQuery(query);
      },
      initSearching: true,
      onNavBack: () {
        NavigationUtils.pop(context);
      },
      body: TXGestureHideKeyBoard(
        child: Container(
          child: Column(
            children: [
              StreamBuilder<int>(
                  stream: bloc.pageTabResult,
                  initialData: 1,
                  builder: (context, snapshotPageIndex) {
                    return Container(
                      height: 50,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _navBarController,
                            child: Row(
                              children: [
                                StreamBuilder<SearchMessagesModel?>(
                                    stream: bloc.messagesResult,
                                    initialData: SearchMessagesModel(),
                                    builder: (context, snapshotMessages) {
                                      return _getTab(
                                          1,
                                          snapshotPageIndex.data == 1,
                                          R.string.messages,
                                          snapshotMessages.data?.total ?? 0);
                                    }),
                                StreamBuilder<SearchFilesModel?>(
                                    stream: bloc.filesResult,
                                    initialData: SearchFilesModel(),
                                    builder: (context, snapshotFiles) {
                                      return _getTab(
                                          2,
                                          snapshotPageIndex.data == 2,
                                          R.string.files,
                                          snapshotFiles.data?.total ?? 0);
                                    }),
                                StreamBuilder<SearchMembersModel?>(
                                    stream: bloc.membersResult,
                                    initialData: SearchMembersModel(),
                                    builder: (context, snapshotMembers) {
                                      return _getTab(
                                          3,
                                          snapshotPageIndex.data == 3,
                                          R.string.members,
                                          snapshotMembers.data?.total ?? 0);
                                    }),
                                StreamBuilder<SearchTasksModel>(
                                    stream: bloc.tasksResult,
                                    initialData: SearchTasksModel(),
                                    builder: (context, snapshotTasks) {
                                      return _getTab(
                                          4,
                                          snapshotPageIndex.data == 4,
                                          R.string.tasks,
                                          snapshotTasks.data?.total ?? 0);
                                    }),
                                StreamBuilder<List<ChannelModel>>(
                                    stream: bloc.channelsResult,
                                    initialData: [],
                                    builder: (context, snapshotChannels) {
                                      return _getTab(
                                          5,
                                          snapshotPageIndex.data == 5,
                                          R.string.channels,
                                          snapshotChannels.data!.length);
                                    }),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            //padding: EdgeInsets.only(top: 4),
                            child: ScaleTransition(
                              scale: _animationController,
                              child: Container(
                                child: Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  color: R.color.grayColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (ctx, pageIndex) {
                    return pageIndex == 0
                        ? _getMessagesWidget()
                        : pageIndex == 1
                            ? _getFilesWidget()
                            : pageIndex == 2
                                ? _getMembersWidget()
                                : pageIndex == 3
                                  ? _getTasksWidget()
                                  : _getChannelsWidget();
                  },
                  onPageChanged: (index) {
                    bloc.changePageTab(index + 1);
                  },
                  itemCount: 5,
                  controller: pageController,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMessagesWidget() {
    if (_scrollMessagesController.hasClients && bloc.offsetMessage == 0) {
      Future.delayed(Duration(milliseconds: 50), () {
        _scrollMessagesController.jumpTo(-100);
      });
    }
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: StreamBuilder<SearchMessagesModel?>(
        stream: bloc.messagesResult,
        initialData: SearchMessagesModel(),
        builder: (ctx, snapshot) {
          return TXGestureHideKeyBoard(
            child: TXPullToRefreshWidget(
              onRefresh: (_controller) async {
                await bloc.loadMessages(replace: true);
                _controller.refreshCompleted();
              },
              onLoadMore: (_controller) async {
                await bloc.loadMessages();
                _controller.loadComplete();
              },
              body: ListView.builder(
                controller: _scrollMessagesController,
                padding: EdgeInsets.only(bottom: 30),
                physics: BouncingScrollPhysics(),
                itemBuilder: (ctx, index) {
                  final message = snapshot.data?.list[index];
                  final member = Injector.instance.inMemoryData
                      .getMember(message?.uid ?? "");
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: member?.profile?.fullNameWithUsername
                                          .isUpperCase() ==
                                      true
                                  ? 3.5
                                  : 5.7),
                          child: TXNetworkImage(
                            imageUrl: CommonUtils.getMemberPhoto(Injector
                                .instance.inMemoryData
                                .getMember(message?.uid ?? "")),
                            boxFitImage: BoxFit.cover,
                            placeholderImage: Image.asset(
                              R.image.logo,
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              bloc.onMessageTap(message!);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: TXUserDateMessageWidget(
                                    onTap: () {
                                      if(member?.isDeletedUser == false) {
                                        bloc.onMentionClicked(
                                            member?.profile?.name ?? "");
                                      }
                                    },
                                    userText:
                                        CommonUtils.getMemberName(member) ?? "",
                                    dateText: CalendarUtils.showInFormat(
                                                R.string.dateFormat4,
                                                message?.ts)
                                            ?.toLowerCase() ??
                                        "",
                                  ),
                                  margin: EdgeInsets.only(left: 8),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 8, right: 8, top: 8),
                                  child: TXMessageBodyWidget(
                                    message: message!,
                                    onLinkTap: (link) async {
                                      if (link
                                          .startsWith("#file-comment")) {
                                        bloc
                                            .getChannelFromId(message.cid)
                                            .then((value) {
                                          if (value != null) {
                                            NavigationUtils.push(
                                                context,
                                                MessageCommentsPage(
                                                  teamJoinedModel:
                                                      widget.joinedTeam,
                                                  drawerChatList:
                                                      widget.drawerChatList,
                                                  channel: value,
                                                  parentMessageId:
                                                      message.mid ?? "",
                                                ));
                                          } else {
                                            bloc.showErrorMessageFromString(
                                                R.string.errorFetchingData);
                                          }
                                        });
                                      } else {
                                        final username =
                                            CommonUtils.getUsernameFromLink(
                                                link);
                                        bloc.onMentionClicked(username);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: snapshot.data?.list.length ?? 0,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getFilesWidget() {
    if (_scrollFilesController.hasClients && bloc.offsetFile == 0) {
      Future.delayed(Duration(milliseconds: 50), () {
        _scrollFilesController.jumpTo(-100);
      });
    }
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: StreamBuilder<SearchFilesModel?>(
        stream: bloc.filesResult,
        initialData: SearchFilesModel(),
        builder: (ctx, snapshot) {
          return Stack(
            children: [
              TXGestureHideKeyBoard(
                child: TXPullToRefreshWidget(
                  onRefresh: (_controller) async {
                    await bloc.loadFiles(replace: true);
                    _controller.refreshCompleted();
                  },
                  onLoadMore: (_controller) async {
                    await bloc.loadFiles();
                    _controller.loadComplete();
                  },
                  body: ListView.builder(
                    padding: EdgeInsets.only(bottom: 30),
                    physics: BouncingScrollPhysics(),
                    controller: _scrollFilesController,
                    itemBuilder: (ctx, index) {
                      final file = snapshot.data?.list[index];
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TXNetworkImage(
                              forceLoad: true,
                              height: 60,
                              width: 60,
                              imageUrl: file?.link ?? "",
                              placeholderImage: Image.asset(
                                R.image.logo,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TXTextWidget(
                                      text: file?.titleFixed ?? "",
                                      maxLines: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                      color: R.color.blackColor,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TXTextWidget(
                                      text: file?.mimeType ?? "",
                                      size: 12,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TXTextWidget(
                                      text: CalendarUtils.showInFormat(
                                                  R.string.dateFormat4,
                                                  file?.ts)
                                              ?.toLowerCase() ??
                                          "",
                                      size: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TXIconButtonWidget(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {
                                showTXModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return _showFileOptions(file!);
                                    });
                              },
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: snapshot.data?.list.length ?? 0,
                  ),
                ),
              ),
              TXLoadingWidget(
                loadingStream: bloc.isLoadingStream,
              )
            ],
          );
        },
      ),
    );
  }

  Widget _getChannelsWidget() {
    return Container(
      padding: EdgeInsets.only(left: 10,),
      child: StreamBuilder<List<ChannelModel>>(
        initialData: [],
        stream: bloc.channelsResult,
        builder: (context, snapshot) {
          return ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: 40),
            itemBuilder: (ctx, index) {
              return _getChannelCell(snapshot.data![index]);
            },
            itemCount: snapshot.data!.length,
          );
        },
      ),
    );
  }

  Widget _getChannelCell(ChannelModel channelModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            changeChannelAutoController.sinkAddSafe(
                ChannelCreatedUI(channelModel: channelModel, members: []));
            NavigationUtils.popUntilWithRouteAndMaterial(context, NavigationUtils.HomeRoute);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          channelModel.isPrivateGroup ? Icon(
                            Icons.https,
                            size: 15,
                            color: R.color.blackColor,
                          ) : Container(),
                          channelModel.isPrivateGroup ? const SizedBox(
                            width: 5,
                          ) : Container(),
                          TXTextWidget(
                            text: channelModel.titleFixed.trim().toLowerCase(),
                            fontWeight: FontWeight.bold,
                            color: R.color.blackColor,
                          )
                        ],
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

  Widget _getMembersWidget() {
    if (_scrollMembersController.hasClients && bloc.offsetMember == 0) {
      Future.delayed(Duration(milliseconds: 50), () {
        _scrollMembersController.jumpTo(-100);
      });
    }
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: StreamBuilder<SearchMembersModel?>(
        stream: bloc.membersResult,
        initialData: SearchMembersModel(),
        builder: (ctx, snapshot) {
          return TXGestureHideKeyBoard(
            child: TXPullToRefreshWidget(
              onRefresh: (_controller) async {
                await bloc.loadMembers(replace: true);
                _controller.refreshCompleted();
              },
              onLoadMore: (_controller) async {
                await bloc.loadMembers();
                _controller.loadComplete();
              },
              body: ListView.builder(
                padding: EdgeInsets.only(bottom: 30),
                physics: BouncingScrollPhysics(),
                controller: _scrollMembersController,
                itemBuilder: (ctx, index) {
                  final member = snapshot.data?.list[index];
                  return InkWell(
                    onTap: () {
                      bloc.create1x1Message(member!);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1, color: R.color.grayLightestColor),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TXNetworkImage(
                            forceLoad: true,
                            imageUrl: CommonUtils.getMemberPhoto(member),
                            placeholderImage: Image.asset(
                              R.image.logo,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TXTextWidget(
                                    text: member?.isDeletedUser == true ? R.string.memberDeleted : member?.active == false
                                        ? R.string.inactiveMember
                                        : CommonUtils.getMemberNameSingle(
                                                member) ??
                                            "",
                                    maxLines: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                    fontStyle: member?.active == false || member?.isDeletedUser == true
                                        ? FontStyle.italic
                                        : null,
                                    color: member?.active == false || member?.isDeletedUser == true
                                        ? Colors.redAccent
                                        : R.color.blackColor,
                                  ),
                                  TXTextWidget(
                                    text:
                                        "@${CommonUtils.getMemberUsername(member) ?? ""}",
                                    size: 12,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TXTextWidget(
                                    text: member?.active == false ? "" : member?.profile?.position ?? '',
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data?.list.length ?? 0,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getTasksWidget() {
    return Container(
      child: StreamBuilder<TaskUIModel>(
        stream: bloc.tasksUIResult,
        initialData: bloc.taskUIModel,
        builder: (ctx, snapshot) {
          return TXGestureHideKeyBoard(
            child: StreamBuilder<int>(
                stream: bloc.pageTabTaskResult,
                initialData: 1,
                builder: (context, snapshotTabTask) {
                  return TaskPageViewWidget(
                    currentPageTab: snapshotTabTask.data!,
                    taskUIModel: snapshot.data!,
                    onItemTap: (task) {
                      navigateToDetails(task);
                    },
                    onPageChange: (tab) {
                      bloc.changeTaskPageTab(tab);
                    },
                    onLoadMoreClosed: (_controller) async {
                      await bloc.loadTasks();
                      _controller.loadComplete();
                    },
                    onLoadMoreOpen: (_controller) async {
                      await bloc.loadTasks();
                      _controller.loadComplete();
                    },
                    onRefreshClosed: (_controller) async {
                      await bloc.loadTasks(replace: true);
                      _controller.refreshCompleted();
                    },
                    onRefreshOpen: (_controller) async {
                      await bloc.loadTasks(replace: true);
                      _controller.refreshCompleted();
                    },
                  );
                }),
          );
        },
      ),
    );
  }

  Widget _getTab(
    int tabNumber,
    bool isActive,
    String title,
    int count,
  ) {
    return InkWell(
      onTap: () {
        if (!isActive) bloc.changePageTab(tabNumber);
        pageController.jumpToPage(tabNumber - 1);
      },
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                width: isActive ? 5.0 : 1,
                color: isActive
                    ? R.color.secondaryColor
                    : R.color.grayLightestColor),
          ),
        ),
        padding: EdgeInsets.only(bottom: 10, left: 25, right: 25, top: 20),
        child: TXTextWidget(
          text: "${title.toUpperCase()}($count)",
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.normal,
          size: 16,
          color: isActive ? R.color.grayDarkestColor : R.color.grayColor,
        ),
      ),
    );
  }

  Widget _showFileOptions(FileModel file) {
//    final bool isOwner = file.uid == Injector.instance.inMemoryData.currentMember.id;
    return Container(
      padding: EdgeInsets.all(8),
      height: 180,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              TXNetworkImage(
                forceLoad: true,
                height: 60,
                width: 60,
                imageUrl: file.link ?? "",
                placeholderImage: Image.asset(
                  R.image.logo,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: TXTextWidget(
                  fontWeight: FontWeight.bold,
                  color: R.color.blackColor,
                  text: file.titleFixed,
                  size: 12,
                ),
              )
            ],
          ),
          Container(
            height: 45,
            child: TXMenuOptionItemWidget(
              icon: Icon(Icons.cloud_download, color: R.color.grayColor),
              text: R.string.download,
              onTap: () async {
                await NavigationUtils.pop(context);
                bloc.downloadFile(file);
              },
            ),
          ),
          Container(
            height: 45,
            child: TXMenuOptionItemWidget(
              icon: Icon(Icons.share, color: R.color.grayColor),
              text: R.string.share,
              onTap: () async {
                await NavigationUtils.pop(context);
                NavigationUtils.push(
                    context,
                    ShareFilePage(
                      fileModel: file,
                      channels: widget.joinedTeam.channels,
                      groups: widget.joinedTeam.groups,
                      messages1x1: widget.joinedTeam.messages1x1,
                      members: widget.joinedTeam.memberWrapperModel.list,
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }

  void navigateToDetails(TaskModel taskModel) async {
    await NavigationUtils.push(
        context,
        TaskDetailPage(
          taskModel: taskModel,
        ));
    bloc.loadTasks(replace: true);
  }
}

import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/TXTextFieldDialog.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_cupertino_dialog_widget.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_media_selector_widget.dart';
import 'package:code/ui/_tx_widget/tx_menu_option_item_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:code/ui/files_explorer/file_model_ui.dart';
import 'package:code/ui/files_explorer/files_explorer_bloc.dart';
import 'package:code/ui/files_explorer/tx_breadcrumb_item_widget.dart';
import 'package:code/ui/files_explorer/tx_file_widget.dart';
import 'package:code/ui/files_explorer/tx_folder_widget.dart';
import 'package:code/ui/share/share_file_page.dart';
import 'package:code/utils/file_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FilesExplorerPage extends StatefulWidget {
  final List<ChannelModel> channels;
  final List<ChannelModel> groups;
  final List<ChannelModel> messages1x1;
  final List<MemberModel> members;
  final ChannelModel? selectedChannel;
  final FolderModel? selectedFolder;

  const FilesExplorerPage({
    Key? key,
    required this.channels,
    required this.groups,
    required this.messages1x1,
    required this.members,
    this.selectedChannel,
    this.selectedFolder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FilesExplorerState();
}

class _FilesExplorerState
    extends StateWithBloC<FilesExplorerPage, FilesExplorerBloC> {
  TextEditingController inputController = TextEditingController();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(loadMoreFilesFolders);
    bloc.initView(widget.members, widget.channels, widget.groups,
        widget.messages1x1, widget.selectedChannel, widget.selectedFolder);
    onFolderDeletedController.listen((value) {
      if (value != null) {
        bloc.onFileFolderDeleted(value.id, value.cid, value.tid, value.path,
            isFolder: true);
      }
    });

    onFolderRenamedController.listen((value) {
      if (value != null) {
        bloc.onFolderRenamed(value.id, value.tid, value.cid, value.path);
      }
    });

    onFileDeletedController.listen((value) {
      if (value != null) {
        bloc.onFileFolderDeleted(
            value.id!, value.cid!, value.tid!, value.path!);
      }
    });

    onFileFolderCreatedController.listen((value) {
      if (value != null) {
        bloc.onFileFolderCreated(value);
      }
    });
  }

  void loadMoreFilesFolders() {
    if (_scrollController.hasClients &&
        _scrollController.position.pixels >
            _scrollController.position.maxScrollExtent - 100 &&
        !bloc.isLoadingMore &&
        !bloc.fileModelUI.isRootView) {
      bloc.loadMoreFilesFolders();
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        StreamBuilder<FileModelUI>(
            stream: bloc.initResult,
            initialData: null,
            builder: (context, snapshot) {
              return StreamBuilder<FileViewMode?>(
                  stream: bloc.viewModeStream,
                  initialData: FileViewMode.grid,
                  builder: (context, snapshotViewModel) {
                    return TXMainAppBarWidget(
                      title: R.string.myFiles,
                      leading: TXIconButtonWidget(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          NavigationUtils.pop(context);
                        },
                      ),
                      actions: <Widget>[
                        TXIconButtonWidget(
                          icon: Icon(
                            Icons.view_module,
                            color:
                                (snapshotViewModel.data ?? FileViewMode.grid) ==
                                        FileViewMode.grid
                                    ? Colors.white
                                    : R.color.grayLightColor,
                          ),
                          onPressed: () {
                            bloc.setViewType(FileViewMode.grid);
                          },
                        ),
                        TXIconButtonWidget(
                          icon: Icon(Icons.view_list,
                              color: (snapshotViewModel.data ??
                                          FileViewMode.grid) ==
                                      FileViewMode.list
                                  ? Colors.white
                                  : R.color.grayLightColor),
                          onPressed: () {
                            bloc.setViewType(FileViewMode.list);
                          },
                        ),
                        // (snapshot.data?.isRootView == true ||
                        //         (snapshot.data?.currentParentContainer?.files
                        //                     ?.isEmpty ==
                        //                 true &&
                        //             snapshot.data?.currentParentContainer?.folders
                        //                     ?.isEmpty ==
                        //                 true))
                        //     ? Container()
                        //     : PopupMenuButton(
                        //         child: TXIconButtonWidget(
                        //           icon: Icon(
                        //             Icons.filter_list,
                        //             color: Colors.white,
                        //           ),
                        //           onPressed: () {},
                        //         ),
                        //         itemBuilder: (ctx) {
                        //           return [..._popupActions()];
                        //         },
                        //         onSelected: (key) {},
                        //       ),
                      ],
                      body: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: R.color.grayLightestColor,
                              padding: EdgeInsets.only(left: 5, right: 5),
                              height: 50,
                              child: snapshot.data != null
                                  ? _getBreadCrumb()
                                  : Container(),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                padding: EdgeInsets.only(bottom: 30),
                                physics: BouncingScrollPhysics(),
                                controller: _scrollController,
                                child: snapshot.data == null
                                    ? Container()
                                    : snapshot.data!.isRootView
                                        ? _getRootView()
                                        : _getChanelFilesView(),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }),
        TXLoadingWidget(
          loadingStream: bloc.isLoadingStream,
        )
      ],
    );
  }

  Widget _getBreadCrumb() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(right: 20),
      scrollDirection: Axis.horizontal,
      itemCount: bloc.fileModelUI.breadCrumbList!.length,
      itemBuilder: (ctx, index) {
        final model = bloc.fileModelUI.breadCrumbList?[index];
        return Material(
          color: R.color.grayLightestColor,
          child: TXBreadCrumbItemWidget(
            singleSelectionModel: model,
            onTap: () {
              if (model!.id == bloc.fileModelUI.currentParentContainer!.id)
                return;
              else if (model.index == 0)
                bloc.initView(
                    bloc.memberList,
                    bloc.fileModelUI.channels,
                    bloc.fileModelUI.groups,
                    bloc.fileModelUI.messages1x1,
                    null,
                    null,
                    containerMap: bloc.fileModelUI.containerMap);
              else
                bloc.loadFiles(model.displayName, model.id,
                    fromBreadCrumb: model.index);
            },
          ),
        );
      },
    );
  }

  Widget _getRootView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              TXTextWidget(
                text: Injector.instance.inMemoryData.currentWhiteBrandConfig !=
                        null
                    ? Injector.instance.inMemoryData.currentTeam?.titleFixed
                            .toUpperCase() ??
                        ""
                    : R.string.appName.toUpperCase(),
                color: Colors.black,
              ),
              // SizedBox(
              //   width: 10,
              // ),
              // Icon(
              //   Icons.info_outline,
              //   size: 15,
              //   color: R.color.grayColor,
              // ),
              // SizedBox(
              //   width: 3,
              // ),
              // TXTextWidget(
              //   text: R.string.moreInfo.toUpperCase(),
              // ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: bloc.crossAxis == 1 ? 5.0 : 3,
            crossAxisCount: bloc.crossAxis,
            children: <Widget>[
              bloc.fileModelUI.noysiChannel != null
                  ? TXFolderWidget(
                      text: bloc.fileModelUI.noysiChannel?.titleFixed ?? "",
                      onTap: () {
                        bloc.currentParentAdmin =
                            bloc.fileModelUI.noysiChannel?.uid;
                        bloc.fileModelUI.currentChannelId =
                            bloc.fileModelUI.noysiChannel?.id;
                        bloc.loadFiles(
                          bloc.fileModelUI.noysiChannel?.titleFixed ?? "",
                          bloc.fileModelUI.noysiChannel?.id ?? "",
                        );
                      },
                      icon: Injector.instance.inMemoryData
                                  .currentWhiteBrandConfig !=
                              null
                          ? TXNetworkImage(
                              imageUrl: Injector.instance.inMemoryData
                                      .currentTeam?.photo ??
                                  "",
                              width: 30,
                              height: 30,
                              forceLoad: true,
                              placeholderImage: Image.asset(R.image.logo))
                          : Image.asset(
                              R.image.logo,
                              width: 30,
                              height: 30,
                            ),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          TXTextWidget(
            text: R.string.openChannels.toUpperCase(),
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: bloc.crossAxis == 1 ? 5.0 : 3.0,
            crossAxisCount: bloc.crossAxis,
            children: <Widget>[..._getOpenChannelsFolders()],
          ),
          SizedBox(
            height: 20,
          ),
          TXTextWidget(
            text: R.string.message1x1.toUpperCase(),
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: bloc.crossAxis == 1 ? 5.0 : 3.0,
            crossAxisCount: bloc.crossAxis,
            children: <Widget>[..._getMessages1x1Folders()],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.lock_outline,
                size: 15,
              ),
              TXTextWidget(
                text: R.string.privateGroups.toUpperCase(),
                color: Colors.black,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: bloc.crossAxis == 1 ? 5.0 : 3.0,
            crossAxisCount: bloc.crossAxis,
            children: <Widget>[..._getGroupsFolders()],
          )
        ],
      ),
    );
  }

  List<Widget> _getOpenChannelsFolders() {
    List<Widget> list = [];
    bloc.fileModelUI.channels.forEach((c) {
      if (c.open == true && c.joined == true) {
        final w = TXFolderWidget(
          text: c.titleFixed,
          onTap: () {
            bloc.currentParentAdmin = c.uid!;
            bloc.fileModelUI.currentChannelId = c.id;
            bloc.loadFiles(c.titleFixed, c.id);
          },
        );
        list.add(w);
      }
    });
    return list;
  }

  List<Widget> _getGroupsFolders() {
    List<Widget> list = [];
    bloc.fileModelUI.groups.forEach((c) {
      if (c.open == true && c.joined == true) {
        final w = TXFolderWidget(
          text: c.titleFixed,
          onTap: () {
            bloc.currentParentAdmin = c.uid!;
            bloc.fileModelUI.currentChannelId = c.id;
            bloc.loadFiles(c.titleFixed, c.id);
          },
        );
        list.add(w);
      }
    });
    return list;
  }

  List<Widget> _getMessages1x1Folders() {
    List<Widget> list = [];
    bloc.fileModelUI.messages1x1.forEach((c) {
      if (c.joined == true && c.open == true) {
        final w = TXFolderWidget(
          text: c.titleFixed,
          onTap: () {
            bloc.currentParentAdmin = c.uid;
            bloc.fileModelUI.currentChannelId = c.id;
            bloc.loadFiles(c.titleFixed, c.id);
          },
        );
        list.add(w);
      }
    });
    return list;
  }

  Widget _getChanelFilesView() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TXTextWidget(
                  text: R.string.folders.toUpperCase(),
                  color: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TXDividerWidget(),
                ),
                TXIconButtonWidget(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: R.color.secondaryColor,
                    size: 35,
                  ),
                  onPressed: () {
                    _showDialogInput(
                        context: context,
                        title: R.string.createFolder,
                        okName: R.string.createFolder);
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              childAspectRatio: bloc.crossAxis == 1 ? 5.0 : 3.0,
              crossAxisCount: bloc.crossAxis,
              children: <Widget>[..._getFolders()],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TXTextWidget(
                  text: R.string.files.toUpperCase(),
                  color: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TXDividerWidget(),
                ),
                TXIconButtonWidget(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: R.color.secondaryColor,
                    size: 35,
                  ),
                  onPressed: () {
                    showTXModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return _showSourceSelector(context);
                        });
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: bloc.crossAxis,
              childAspectRatio: bloc.crossAxis == 1 ? 5.0 : 1.0,
              children: <Widget>[..._getFiles()],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  List<Widget> _getFolders() {
    List<Widget> folders = [];
    bloc.fileModelUI.currentParentContainer?.folders?.forEach((element) {
      final w = TXFolderWidget(
        text: element.titleFixed,
        onTap: () {
          bloc.loadFiles(element.titleFixed, element.id ?? "");
        },
        onLongPress: () {
          showTXModalBottomSheet(
              context: context,
              builder: (context) {
                return _showFolderOptions(element);
              });
        },
      );
      folders.add(w);
    });

    if (folders.isEmpty) {
      final w = TXFolderWidget(
        text: "..(${R.string.back})",
        onTap: () {
          if (bloc.fileModelUI.breadCrumbList?.length == 2) {
            bloc.initView(
                bloc.memberList,
                bloc.fileModelUI.channels,
                bloc.fileModelUI.groups,
                bloc.fileModelUI.messages1x1,
                null,
                null,
                containerMap: bloc.fileModelUI.containerMap);
          } else {
            String id = bloc
                .fileModelUI
                .breadCrumbList![bloc.fileModelUI.breadCrumbList!.length - 2]
                .id;
            String name = bloc
                .fileModelUI
                .breadCrumbList![bloc.fileModelUI.breadCrumbList!.length - 2]
                .displayName;
            bloc.loadFiles(name, id,
                fromBreadCrumb: bloc.fileModelUI.breadCrumbList!.length - 2);
          }
        },
      );
      folders.add(w);
    }
    return folders;
  }

  List<Widget> _getFiles() {
    List<Widget> files = [];
    bloc.fileModelUI.currentParentContainer?.files?.forEach((element) {
      final w = TXFileWidget(
        file: element,
        fileViewMode:
            bloc.crossAxis == 2 ? FileViewMode.grid : FileViewMode.list,
        onTap: () {},
        onLongPress: () {
          showTXModalBottomSheet(
              context: context,
              builder: (context) {
                return _showFileOptions(element);
              });
        },
      );
      files.add(w);
    });
    return files;
  }

  // List<PopupMenuItem> _popupActions() {
  //   List<PopupMenuItem> list = [];
  //   final newwest = PopupMenuItem(
  //     value: SortFileMode.newest,
  //     child: Container(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: <Widget>[],
  //       ),
  //     ),
  //   );
  //   final oldest = PopupMenuItem(
  //     value: SortFileMode.oldest,
  //     child: Container(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: <Widget>[],
  //       ),
  //     ),
  //   );
  //   final a_z = PopupMenuItem(
  //     value: SortFileMode.oldest,
  //     child: Container(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: <Widget>[],
  //       ),
  //     ),
  //   );
  //   final z_a = PopupMenuItem(
  //     value: SortFileMode.oldest,
  //     child: Container(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: <Widget>[],
  //       ),
  //     ),
  //   );
  //
  //   list.add(newwest);
  //   list.add(oldest);
  //   list.add(a_z);
  //   list.add(z_a);
  //   return list;
  // }

  Widget _showSourceSelector(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TXTextWidget(
            text: R.string.fromLocalStorage,
            color: R.color.secondaryColor,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                TXMediaSelectorWidget(
                  icon: Icon(
                    Icons.library_add,
                    color: R.color.grayDarkColor,
                  ),
                  showVertically: false,
                  title: R.string.documents,
                  titleColor: R.color.blackColor,
                  onTap: () {
                    _launchMediaView(allFiles: true);
                  },
                ),
                TXMediaSelectorWidget(
                  icon: Icon(
                    Icons.photo_library,
                    color: R.color.grayDarkColor,
                  ),
                  showVertically: false,
                  titleColor: R.color.blackColor,
                  title: R.string.photoGallery,
                  onTap: () {
                    _launchMediaView(imageSource: ImageSource.gallery);
                  },
                ),
                TXMediaSelectorWidget(
                  icon: Icon(
                    Icons.video_library,
                    color: R.color.grayDarkColor,
                  ),
                  showVertically: false,
                  titleColor: R.color.blackColor,
                  title: R.string.videoGallery,
                  onTap: () {
                    _launchMediaView(
                        imageSource: ImageSource.gallery, lookForVideo: true);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TXDividerWidget(),
          SizedBox(
            height: 10,
          ),
          TXTextWidget(
            text: R.string.useCamera,
            color: R.color.secondaryColor,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                TXMediaSelectorWidget(
                  icon: Icon(
                    Icons.photo_camera,
                    color: R.color.grayDarkColor,
                  ),
                  showVertically: false,
                  titleColor: R.color.blackColor,
                  title: R.string.takePhoto,
                  onTap: () {
                    _launchMediaView(imageSource: ImageSource.camera);
                  },
                ),
                TXMediaSelectorWidget(
                  icon: Icon(
                    Icons.videocam,
                    color: R.color.grayDarkColor,
                  ),
                  showVertically: false,
                  titleColor: R.color.blackColor,
                  title: R.string.recordVideo,
                  onTap: () {
                    _launchMediaView(
                        imageSource: ImageSource.camera, lookForVideo: true);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchMediaView({
    ImageSource? imageSource,
    bool lookForVideo = false,
    bool allFiles = false,
    ValueChanged<int>? onFileLoading,
  }) async {
    try {
      NavigationUtils.pop(context);
      final file = await FileManager.getImageFromSource(
          source: imageSource,
          lookForVideo: lookForVideo,
          allFiles: allFiles,
          onFileLoading: onFileLoading);
      if (file != null && file.existsSync()) {
        bloc.uploadFile(file);
      }
    } catch (ex) {
      if (ex is PlatformException) {
        if (ex.code == "photo_access_denied" ||
            ex.code == "camera_access_denied") {
          _showDialogPermissions(
              context: context,
              onOkAction: () async {
                openAppSettings();
              });
        }
      }
    }
  }

  void _showDialogPermissions({
    required BuildContext context,
    required Function onOkAction,
  }) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => TXCupertinoDialogWidget(
        title: R.string.permissionDenied,
        content: R.string.enablePermissions,
        onOK: () {
          Navigator.pop(context, R.string.ok);
          onOkAction();
        },
        onCancel: () {
          Navigator.pop(context, R.string.cancel);
        },
      ),
    );
  }

  void _showDialogInput({
    required BuildContext context,
    required title,
    required okName,
    String fileId = '',
  }) {
    if (fileId.isEmpty) inputController.text = "";

    TXTextFieldDialog.show(context, title: title, action: (ok) {
      if (ok) {
        if (fileId.isEmpty) {
          bloc.createFolder(inputController.text.trim());
        } else {
          bloc.renameFolder(fileId, inputController.text.trim());
        }
      }
    },
        controller: inputController,
        okName: okName,
        validator: bloc.alphanumericRoomName());
  }

  Widget _showFileOptions(FileModel file) {
    final bool isOwner =
        file.uid == Injector.instance.inMemoryData.currentMember?.id;
    final bool isAdmin = bloc.currentParentAdmin ==
        Injector.instance.inMemoryData.currentMember?.id;
    return Container(
      padding: EdgeInsets.all(8),
      height: isOwner || isAdmin ? 225 : 185,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              TXNetworkImage(
                mimeType: file.mimeType,
                forceLoad: true,
                width: 60,
                height: 60,
                imageUrl: file.link ?? "",
                shape: BoxShape.rectangle,
                boxFitImage: BoxFit.cover,
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
                      channels: widget.channels,
                      groups: widget.groups,
                      members: widget.members,
                      messages1x1: widget.messages1x1,
                    ));
              },
            ),
          ),
          // isOwner || isAdmin
          // ? Container(
          //     height: 45,
          //     child: TXMenuOptionItemWidget(
          //       icon: Icon(Icons.edit, color: R.color.grayColor),
          //       text: R.string.changeName,
          //       onTap: () async {
          //         await NavigationUtils.pop(context);
          //         inputController.text = file.titleFixed;
          //         _showDialogInput(
          //             context: context,
          //             title: R.string.renameFile,
          //             inputName: R.string.newName,
          //             okName: R.string.rename,
          //             fileId: file.id);
          //       },
          //     ),
          //   )
          // : Container(),
          isOwner || isAdmin
              ? Container(
                  height: 45,
                  child: TXMenuOptionItemWidget(
                    icon: Icon(Icons.delete_forever, color: Colors.redAccent),
                    text: R.string.deleteFile,
                    textColor: Colors.redAccent,
                    onTap: () async {
                      await NavigationUtils.pop(context);
                      _showDialogDelete(
                          context: context, fileId: file.id ?? "");
                    },
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget _showFolderOptions(FileModel file) {
    final bool isOwner =
        file.uid == Injector.instance.inMemoryData.currentMember?.id;
    final bool isAdmin = bloc.currentParentAdmin ==
        Injector.instance.inMemoryData.currentMember?.id;
    return Container(
      padding: EdgeInsets.all(8),
      height: isOwner || isAdmin ? 270 : 185,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              TXNetworkImage(
                mimeType: file.mimeType,
                forceLoad: true,
                width: 60,
                height: 60,
                imageUrl: file.link ?? "",
                shape: BoxShape.rectangle,
                boxFitImage: BoxFit.cover,
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
                  size: 14,
                ),
              )
            ],
          ),
          Container(
            height: 45,
            child: TXMenuOptionItemWidget(
              icon: Icon(Icons.link, color: R.color.grayColor),
              text: R.string.copyPermanentLink,
              onTap: () async {
                await NavigationUtils.pop(context);
                final link = await bloc.conformFolderLink(file);
                await Clipboard.setData(new ClipboardData(text: link));
                Fluttertoast.showToast(
                    msg: link,
                    toastLength: Toast.LENGTH_LONG,
                    textColor: R.color.whiteColor,
                    backgroundColor: R.color.primaryColor);
              },
            ),
          ),
          Container(
            height: 45,
            child: TXMenuOptionItemWidget(
              icon: Icon(Icons.share, color: R.color.grayColor),
              text: R.string.cloneFolder,
              onTap: () async {
                await NavigationUtils.pop(context);
                NavigationUtils.push(
                    context,
                    ShareFilePage(
                      fileModel: file,
                      channels: widget.channels,
                      groups: widget.groups,
                      members: widget.members,
                      messages1x1: widget.messages1x1,
                    ));
              },
            ),
          ),
          isOwner || isAdmin
              ? Container(
                  height: 45,
                  child: TXMenuOptionItemWidget(
                    icon: Icon(Icons.edit, color: R.color.grayColor),
                    text: R.string.changeName,
                    onTap: () async {
                      await NavigationUtils.pop(context);
                      inputController.text = file.titleFixed;
                      _showDialogInput(
                          context: context,
                          title: R.string.renameFolder,
                          okName: R.string.rename,
                          fileId: file.id ?? "");
                    },
                  ),
                )
              : Container(),
          isOwner || isAdmin
              ? Container(
                  height: 45,
                  child: TXMenuOptionItemWidget(
                    icon: Icon(Icons.delete_forever, color: Colors.redAccent),
                    text: R.string.deleteFolder,
                    textColor: Colors.redAccent,
                    onTap: () async {
                      await NavigationUtils.pop(context);
                      _showDialogDelete(
                          context: context,
                          fileId: file.id ?? "",
                          isFolder: (file.folder ?? false));
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void _showDialogDelete({
    required BuildContext context,
    required String fileId,
    bool isFolder = false,
  }) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: TXTextWidget(
          text: isFolder ? R.string.deleteFolder : R.string.deleteFile,
          fontWeight: FontWeight.bold,
          maxLines: null,
          color: R.color.blackColor,
        ),
        content: Container(
          margin: EdgeInsets.only(top: 10),
          child: TXTextWidget(
            text: isFolder
                ? R.string.deleteFolderWarning
                : R.string.deleteFileWarning,
            color: R.color.blackColor,
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: TXTextWidget(
              text: R.string.cancel,
              color: R.color.blackColor,
            ),
            onPressed: () {
              NavigationUtils.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: TXTextWidget(
              text: R.string.delete,
              color: R.color.blackColor,
            ),
            onPressed: () async {
              await NavigationUtils.pop(context);
              bloc.deleteFile(fileId, isFolder: isFolder);
            },
          ),
        ],
      ),
    );
  }
}

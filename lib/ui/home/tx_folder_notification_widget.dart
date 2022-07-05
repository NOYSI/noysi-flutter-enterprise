
import 'package:code/domain/message/message_model.dart';
import 'package:code/ui/home/tx_folder_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TXFolderNotificationWidget extends StatelessWidget {
  final MessageModel message;
  final ValueChanged<FolderModel>? onFolderTap;
  final GestureLongPressCallback? onLongPress;
  final bool showFolderOwner;
  final String? folderOwner;

  const TXFolderNotificationWidget(
      {super .key, required this.message,
      this.onFolderTap,
      this.onLongPress,
      this.folderOwner,
      this.showFolderOwner = false});

  @override
  Widget build(BuildContext context) {
    return message.isFolderLinkMessage
        ? GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ...List.generate(
            message.folders.length,
                (index) => GestureDetector(
              onLongPress: onLongPress,
              onTap: () {
                if(onFolderTap != null) onFolderTap!(message.folders[index]);
              },
              child: TXFolderItem(
                name: _getFixedPath(message.folders[index].path)
                    .split('/')
                    .last,
                deleted: message.folders[index].deleted,
                renamed: message.folders[index].renamed != null && message.ts != null && message.folders[index].renamed!.compareTo(message.ts!) > 0,
              ),
            ))
      ],
    )
        : GestureDetector(
            onTap: () {
              if(onFolderTap != null) {
                onFolderTap!(FolderModel(
                cid: message.args?.cid ?? "",
                tid: message.args?.tid ?? "",
                path: message.args?.path ?? "",
                id: message.args?.id ?? "",
                deleted: message.args?.folderDeleted == true,
                renamed: message.args?.folderRenamed,
              ));
              }
            },
            onLongPress: onLongPress,
            child: TXFolderItem(
              showOwner: showFolderOwner,
              owner: folderOwner ?? "",
              name: _getFixedPath(message.args?.path ?? "").split('/').last,
              deleted: message.args?.folderDeleted == true,
              renamed: message.args?.folderRenamed != null && message.ts != null && message.args!.folderRenamed!.compareTo(message.ts!) > 0,
            ),
          );
    // return Container(
    //   decoration: BoxDecoration(
    //       border: Border.all(color: R.color.grayLightestColor, width: 1),
    //       borderRadius: BorderRadius.all(Radius.circular(4))),
    //   child: InkWell(
    //     onTap: onTap,
    //     child: Container(
    //       padding: EdgeInsets.all(5),
    //       child: Row(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Container(
    //             height: 30,
    //             width: 30,
    //             decoration: BoxDecoration(
    //                 shape: BoxShape.circle,
    //                 border: Border.all(color: R.color.grayColor, width: 2)),
    //             child: Center(
    //               child: Icon(
    //                 Icons.folder_open,
    //                 color: R.color.grayColor,
    //                 size: 20,
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             width: 5,
    //           ),
    //           Expanded(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 TXTextWidget(
    //                   text: message.args.path.split('/').last,
    //                   color: R.color.secondaryColor,
    //                 ),
    //                 TXTextWidget(
    //                   text: message.getFolderEventText(),
    //                   color: R.color.grayDarkestColor,
    //                 ),
    //               ],
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  String _getFixedPath(String path) => path.trim().endsWith('/')
      ? path.trim().replaceRange(path.length - 1, path.length, '')
      : path.trim();
}

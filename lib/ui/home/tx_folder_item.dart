import 'package:code/_res/R.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TXFolderItem extends StatelessWidget {
  final String name;
  final String owner;
  final bool showOwner;
  final bool deleted;
  final bool renamed;

  TXFolderItem({this.name = '', this.owner = '', this.showOwner = false, this.deleted = false, this.renamed = false});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        showOwner
            ? TXTextWidget(
          text: owner,
          color: R.color.blackColor,
          fontWeight: FontWeight.bold,
          size: 16,
        )
            : Container(),
        Row(
          children: [
            TXTextWidget(
              text: name,
              color: R.color.secondaryColor,
            ),
            deleted || renamed ? Container(
              padding: EdgeInsets.only(left: 2, top: 1),
              child: TXTextWidget(
                text: "(${deleted ? R.string.removed : R.string.edited})",
                color: R.color.grayColor,
                fontWeight: FontWeight.w300,
                size: 12,
              )
            ) : Container(),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        TXNetworkImage(
          forceLoad: true,
          boxFitImage: BoxFit.cover,
          mimeType: 'application/folder',
          width: 60,
          userBorderRadius: false,
          height: 40,
          imageUrl: '',
          placeholderImage: Image.asset(
            R.image.logo,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TXTextWidget(
          text: "application/folder",
        )
      ],
    );
  }
}
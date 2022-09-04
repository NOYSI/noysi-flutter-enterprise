import 'package:code/_res/R.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:code/ui/task_comment/task_comment_add_edit_bloc.dart';
import 'package:flutter/material.dart';

class TaskCommentAddEditPageWidget extends StatefulWidget {
  final TaskModel? taskModel;
  final TaskTimeLineModel? taskTimeLineModel;

  const TaskCommentAddEditPageWidget({
    Key? key,
    this.taskModel,
    this.taskTimeLineModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CommentPageState();
}

class _CommentPageState extends StateWithBloC<TaskCommentAddEditPageWidget,
    TaskCommentAddEditBloC> {
  TextEditingController commentController = TextEditingController();
  final _keyFormComment = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    bloc.taskModel = widget.taskModel;
    commentController.text = widget.taskTimeLineModel?.text ?? "";
    bloc.addEditActionResult.listen((event) {
      NavigationUtils.pop(context, result: true);
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    bool isEditingComment =
        widget.taskTimeLineModel?.text.trim().isNotEmpty == true;
    return Stack(
      children: [
        TXMainAppBarWidget(
          title: isEditingComment ? R.string.editComment : R.string.addComment,
          body: Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 30),
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.only(top: 20, right: 5, left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TXTextWidget(
                      text: R.string.comment,
                      color: R.color.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                    Form(
                      key: _keyFormComment,
                      child: TXTextFieldWidget(
                        controller: commentController,
                        validator: bloc.required(),
                        textInputType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        maxLines: 20,
                        minLines: 5,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: TXButtonWidget(
                        onPressed: () {
                          if (_keyFormComment.currentState!.validate()) {
                            if (isEditingComment) {
                              final timelineIndex = widget.taskModel!.timeLine
                                  .indexWhere((element) =>
                                      element.created!.millisecondsSinceEpoch ==
                                      widget.taskTimeLineModel!.created!
                                          .millisecondsSinceEpoch);

                              bloc.putTaskComment(
                                  commentController.text, timelineIndex);
                            } else
                              bloc.postTaskComment(commentController.text);
                          }
                        },
                        title: isEditingComment
                            ? R.string.editComment
                            : R.string.addComment,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        TXLoadingWidget(
          loadingStream: bloc.isLoadingStream,
        )
      ],
    );
  }
}

import 'package:code/domain/message/message_model.dart';

abstract class IMessageConverter {
  MessageWrapperModel fromJsonWrapper(Map<String, dynamic> json);

  MessageModel fromJson(Map<String, dynamic> json);

  Arguments fromJsonMessageFolderArguments(Map<String, dynamic> json);

  Arguments fromJsonMessageArguments(Map<String, dynamic> json);

  ArgumentAttachment fromJsonMessageArgumentsAttachments(Map<String, dynamic> json);

  ArgumentAttachmentContent fromJsonMessageArgumentsAttachmentsContent(
      Map<String, dynamic> json);

  ArgumentAttachmentContentButton fromJsonMessageArgumentsAttachmentsContentButton(
      Map<String, dynamic> json);

  // ArgumentAttachmentContentTap fromJsonMessageArgumentsAttachmentsContentTap(
  //     Map<String, dynamic> json);

  MessageExtraModel fromJsonExtra(Map<String, dynamic> json);

  MessageComment fromJsonComment(Map<String, dynamic> json);

  List<ReactionsModel> fromJsonReaction(Map<String, dynamic> json);

  //Map<String, dynamic> toJsonCreate(MessageCreateModel model);

  RepositoryModel fromJsonRepositoryModel(Map<String, dynamic> json);

  CommitModel fromJsonCommitModel(Map<String, dynamic> json);

  CommitMemberModel fromJsonCommitMemberModel(Map<String, dynamic> json);

  TrelloBoardModel fromJsonTrelloBoardModel(Map<String, dynamic> json);

  TrelloCardModel fromJsonTrelloCardModel(Map<String, dynamic> json);

  TrelloListModel fromJsonTrelloListModel(Map<String, dynamic> json);

  ZendeskTicketModel fromJsonZendeskTicketModel(Map<String, dynamic> json);
}

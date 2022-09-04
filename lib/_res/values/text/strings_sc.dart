import 'dart:ui';
import 'package:code/_res/values/config.dart';
import 'package:code/_res/values/text/strings_base.dart';

import '../../../data/api/remote/endpoints.dart';
import '../../R.dart';


class StringsSc implements StringsBase {
  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Noysi";

  @override
  String get yourTeams => "您的团队";

  @override
  String get channel => "渠道";

  @override
  String get channels => "频道";

  @override
  String get directMessagesAbr => "糖尿病";

  @override
  String get email => "电子邮件";

  @override
  String get home => "家";

  @override
  String get member => "会员";

  @override
  String get administrator => "管理员";

  @override
  String get guest => "来宾";

  @override
  String get guests => "来宾";

  @override
  String get members => "会员";

  @override
  String get inactiveMember => "成员已停用";

  @override
  String get message => "信息";

  @override
  String get messages => "留言内容";

  @override
  String get password => "密码";

  @override
  String get register => "注册";

  @override
  String get search => "搜索";

  @override
  String get signIn => "登入";

  @override
  String get task => "任务";

  @override
  String get tasks => "任务";

  @override
  String get createTask => "创建任务";

  @override
  String get newTask => "新任务";

  @override
  String get description => "描述";

  @override
  String get team => "球队";

  @override
  String get thread => "线";

  @override
  String get threads => "线程数";

  @override
  String get createTeam => "建立团队";

  @override
  String get confirmIsCorrectEmailAddress => "是!那是正确的电子邮件";

  @override
  String get createTeamIntro =>
      "您将要在Noysi建立新团队。";

  @override
  String get isCorrectEmailAddress => "这是正确的电子邮件地址吗？";

  @override
  String get welcome => "欢迎！";

  @override
  String get invitationSentAt => "您的邀请将发送至：";

  @override
  String get next => "下一个";

  @override
  String get startNow => "现在开始！";

  @override
  String get charsRemaining => "剩余字符：";

  @override
  String get teamNameOrgCompany =>
      "输入您的团队名称，组织或公司名称。";

  @override
  String get teamNameOrgCompanyLabel => "例如我的公司名称";

  @override
  String get yourTeam => "你的团队";

  @override
  String get noysiServiceNewsletters =>
      "可以（偶尔）收到有关NOYSI服务的电子邮件。";

  @override
  String get userNameIntro =>
      "您的用户名就是您在团队中其他人看来的样子。";

  @override
  String get userNameLabel => "例如阿克曼";

  @override
  String get addAnother => "加上另一个";

  @override
  String get byProceedingAcceptTerms =>
      "*继续进行，即表示您接受我们的<b>服务条款</ b>";

  @override
  String get invitations => "邀请函";

  @override
  String get invitePeople => "邀请人";

  @override
  String get noysiIsTeamWorkInvite =>
      "Noysi是一个团队合作工具。邀请至少一个人";

  @override
  String get userName => "用户名";

  @override
  String get fieldMax18 => "最多18个字符";

  @override
  String get fieldMax25 => "最多25个字符";

  @override
  String get fieldPassword => "要求输入密码";

  @override
  String get fieldRequired => "必填字段";

  @override
  String get missingEmailFormat => "错误的电子邮件";

  @override
  String get back => "背部";

  @override
  String get channelBrowser => "频道浏览器";

  @override
  String get help => "救命";

  @override
  String get preferences => "优先";

  @override
  String get signOutOf => "登出";

  @override
  String get closed => "关闭";

  @override
  String get closedMilestone => "关闭";

  @override
  String get close => "关";

  @override
  String get opened => "开了";

  @override
  String get chat => "聊天室";

  @override
  String get allThreads => "所有线程";

  @override
  String get inviteMorPeople => "邀请更多人";

  @override
  String get meeting => "会议";

  @override
  String get myFiles => "我的文件";

  @override
  String get myTasks => "我的任务";

  @override
  String get myTeams => "我的团队";

  @override
  String get openChannels => "公开渠道";

  @override
  String get privateGroups => "私人团体";

  @override
  String get favorites => "收藏夹";

  @override
  String get message1x1 => "讯息1到1";

  @override
  String get acceptedTitle => "公认";

  @override
  String get date => "日期";

  @override
  String get invitationLanguageTitle => "习语";

  @override
  String get invitationMessage => "邀请讯息";

  @override
  String get revokeInvitation => "撤销邀请";

  @override
  String get revoke => "撤消";

  @override
  String get revokeInvitationWarning =>
      "注意，此动作不可逆";

  @override
  String get revokeInvitationDelete => "邀请删除";

  @override
  String get resendInvitationBefore24hrs =>
      "自上次发送之日起24小时之前，不允许重新发送邀请。";

  @override
  String get resendInvitationSuccess => "邀请已成功发送。";

  @override
  String get resendInvitation => "重新发送邀请";

  @override
  String get invitationMessageDefault =>
      "嗨！在这里你有邀请加入";

  @override
  String get inviteManyAsOnce => "邀请一次";

  @override
  String get inviteMemberTitle =>
      "团队成员可以完全访问公开渠道，个人消息和小组。";

  @override
  String get inviteMemberWarningTitle =>
      "要邀请新成员，您必须是团队管理员。";

  @override
  String get inviteNewMemberWarningTitle =>
      "团队中的任何成员都可以无限添加客人。";

  @override
  String get inviteSubtitle =>
      "Noysi是与您的团队更好地合作的工具。立即邀请他们！";

  @override
  String get inviteTitle => "邀请其他人";

  @override
  String get inviteToAGroup => "邀请组（必填）";

  @override
  String get inviteToAGroupNotRequired => "邀请加入群组（可选）";

  @override
  String get inviteMemberWarning =>
      "新成员将自动加入#general频道。您也可以选择将它们立即添加到私人组中。";

  @override
  String get inviteToThisTeam => "邀请这个团队";

  @override
  String get invitationsSent => "邀请已发送";

  @override
  String get name => "名称";

  @override
  String get noPendingInvitations =>
      "没有邀请发送此团队。";

  @override
  String get pendingTitle => "待定";

  @override
  String get chooseTitle => "选择";

  @override
  String get seePendingAcceptedInvitations =>
      "查看待处理和已接受的邀请";

  @override
  String get sendInvitations => "发送邀请";

  @override
  String get typeEmail => "输入电子邮件";

  @override
  String get typeEmailComaSeparated => "以逗号分隔输入电子邮件";

  @override
  String get atNoysi => "在Noysi";

  @override
  String get inviteNewMemberTitle =>
      "客人无需付款，您可以邀请任意数量的客人，但是他们只能访问此团队中的一个小组。";

  @override
  String get invited => "受邀";

  @override
  String get thisNameAlreadyExist =>
      "好像该名称已被使用。";

  @override
  String get emptyList => "空清单";

  @override
  String get ok => "好";

  @override
  String get byNameFirst => "按名称A-Z";

  @override
  String get byNameInvertedFirst => "按名称Z-A";

  @override
  String get download => "下载";

  @override
  String get files => "档案";

  @override
  String get folders => "资料夹";

  @override
  String get newTitle => "新";

  @override
  String get newestFirst => "新的先来";

  @override
  String get oldestFirst => "最旧的优先";

  @override
  String get see => "看到";

  @override
  String get share => "分享";

  @override
  String get moreInfo => "更多信息";

  @override
  String get assigned => "已分配";

  @override
  String get author => "作者";

  @override
  String get created => "已建立";

  @override
  String get earlyDeliverDate => "提早交货日期";

  @override
  String get farDeliverDate => "交货日期远";

  @override
  String get filterAuthor => "按作者筛选";

  @override
  String get searchUsers => "搜索用户";

  @override
  String get sort => "分类";

  @override
  String get sortBy => "排序方式";

  @override
  String get cancel => "取消";

  @override
  String get exit => "出口";

  @override
  String get exitWarning => "你确定吗？";

  @override
  String get deleteChannelWarning =>
      "您确定要退出此频道吗？";

  @override
  String get typeMessage => "输入讯息...";

  @override
  String get addChannelToFavorites => "添加到收藏夹";

  @override
  String get removeFromFavorites => "从收藏夹中删除";

  @override
  String get channelInfo => "频道资讯";

  @override
  String get channelMembers => "频道会员";

  @override
  String get channelPreferences => "频道偏好";

  @override
  String get closeChatVisibility => "接近1比1";

  @override
  String get inviteToGroup => "邀请会员加入此频道";

  @override
  String get leaveChannel => "离开频道";

  @override
  String get mentions => "提及";

  @override
  String get seeFiles => "查看档案";

  @override
  String get seeLinks => "查看连结";

  @override
  String get links => "链接";

  @override
  String get taskManager => "任务管理器";

  @override
  String get videoCall => "视频电话";

  @override
  String get addReaction => "添加反应";

  @override
  String get addTag => "添加标签";

  @override
  String get addMilestone => "添加里程碑";

  @override
  String get copyMessage => "复制讯息";

  @override
  String get copyPermanentLink => "复制链接";

  @override
  String get createThread => "启动主题";

  @override
  String get edit => "编辑";

  @override
  String get favorite => "喜爱";

  @override
  String get remove => "去掉";

  @override
  String get tryAgain => "再试一次";

  @override
  String get dateFormat1 => "MMM dd, yyyy hh.mm";

  @override
  String get dateFormat2 => "H:mm";

  @override
  String get dateFormat3 => "MMMM d, yyyy";

  @override
  String get dateFormat5 => "MMMM d, yyyy H:mm";

  @override
  String get dateFormat4 => "MMM d, yyyy H:mm";

  @override
  String get dateFormat7 => "MMMM yyyy";

  @override
  String get dateFormat8 => "MMM d, yyyy";

  @override
  String get deleteMessageContent =>
      "你确定要删除这条消息吗？这不能被撤消。";

  @override
  String get deleteMessageTitle => "删除留言";

  @override
  String get edited => "已编辑";

  @override
  String get seeAll => "查看全部";

  @override
  String get copiedToClipboard => "复制到剪贴板！";

  @override
  String get underConstruction => "��正在施工🚧";

  @override
  String get reactions => "反应";

  @override
  String get all => "所有";

  @override
  String get users => "用户数";

  @override
  String get documents => "文件资料";

  @override
  String get fromLocalStorage => "从本地存储";

  @override
  String get photoGallery => "照片库";

  @override
  String get recordVideo => "录制影片";

  @override
  String get takePhoto => "拍个照";

  @override
  String get useCamera => "从相机";

  @override
  String get videoGallery => "视频库";

  @override
  String get changeName => "更换名字";

  @override
  String get createFolder => "创建文件夹";

  @override
  String get createNameWarning =>
      "名称最多可以包含18个字符，且不能带标点符号。";

  @override
  String get newName => "新名字";

  @override
  String get rename => "改名";

  @override
  String get renameFile => "重新命名文件";

  @override
  String get renameFolder => "重命名文件夹";

  @override
  String get deleteFile => "删除文件";

  @override
  String get deleteFolder => "删除资料夹";

  @override
  String get deleteFileWarning => "该文件夹将被永久删除，无法恢复。从任何链接都无法访问该文件夹。";

  @override
  String get delete => "删除";

  @override
  String get open => "打开";

  @override
  String get addCommentOptional => "添加评论（可选）";

  @override
  String get shareFile => "分享档案";

  @override
  String get groups => "团体";

  @override
  String get to1_1 => "一对一";

  @override
  String get day => "天";

  @override
  String get days => "天";

  @override
  String get hour => "小时";

  @override
  String get hours => "小时";

  @override
  String get minute => "分钟";

  @override
  String get minutes => "分钟";

  @override
  String get month => "月";

  @override
  String get months => "月";

  @override
  String get year => "年";

  @override
  String get years => "年份";

  @override
  String get by => "通过";

  @override
  String get deliveryDateIn => "截止日期";

  @override
  String get ago => "前";

  @override
  String get taskOpened => "开了";

  @override
  String get assignees => "受让人";

  @override
  String get assigneeBy => "分配者";

  @override
  String get closeTask => "关闭任务";

  @override
  String get comment => "评论";

  @override
  String get deliveryDate => "截止日期";

  @override
  String get leaveAComment => "发表评论";

  @override
  String get milestone => "里程碑";

  @override
  String get milestones => "大事记";

  @override
  String get color => "颜色";

  @override
  String get milestoneAdded => "已添加到里程碑";

  @override
  String get participants => "参加者";

  @override
  String get reopen => "重新开启";

  @override
  String get completed => "已完成";

  @override
  String get dueDateUpdated => "截止日期已更新";

  @override
  String get dueDate => "截止日期";

  @override
  String get lastDueDate => "最后截止日期";

  @override
  String get commented => "已评论";

  @override
  String get tagAdded => "标签已添加";

  @override
  String get tagRemoved => "标签已删除";

  @override
  String get tags => "标签";

  @override
  String get update => "更新资料";

  @override
  String get details => "细节";

  @override
  String get timeline => "时间线";

  @override
  String get aboutMe => "关于我";

  @override
  String get acceptNews => "接收新闻";

  @override
  String get allActive => "全部活跃";

  @override
  String get changePhoto => "更改照片";

  @override
  String get changeYourPassword => "更改您的密码";

  @override
  String get changeYourPasswordAdvice =>
      "密码必须至少包含八个字符，包括数字，大写字母和小写字母，您可以使用特殊字符（如@＃\$％^＆+ =）和十个或更多字符来提高密码的安全性";

  @override
  String get charge => "收费";

  @override
  String get country => "国家";

  @override
  String get disabled => "残障人士";

  @override
  String get emailNotification => "电子邮件通知";

  @override
  String get language => "语言";

  @override
  String get lastName => "姓";

  @override
  String get maxEveryHour => "每隔一小时";

  @override
  String get maxHalfDay => "每12小时";

  @override
  String get messages1x1AndMentions => "消息1x1和@提及";

  @override
  String get myProfile => "我的简历";

  @override
  String get never => "决不";

  @override
  String get newPassword => "新密码";

  @override
  String get newsLetters => "新闻快讯";

  @override
  String get notReceiveNews => "不接收新闻";

  @override
  String get notifications => "通知事项";

  @override
  String get passwordRequirements =>
      "定期更改密码以提高安全性和保护性";

  @override
  String get phoneNotifications => "电话通知";

  @override
  String get phoneNumber => "电话号码";

  @override
  String get photoSizeRestrictions =>
      "使用最大宽度为400px（小）的方形照片";

  @override
  String get repeatNewPassword => "重复新密码";

  @override
  String get security => "安全";

  @override
  String get skypeUserName => "Skype用户";

  @override
  String get sounds => "声音";

  @override
  String get yourUserName => "您的用户名";

  @override
  String get saveChanges => "保存更改";

  @override
  String get profileEmailUsesWarning =>
      "该电子邮件仅用于该团队的通知。";

  @override
  String get pushMobileNotifications => "推送移动通知";

  @override
  String get saveNotificationChanges => "保存通知更改";

  @override
  String get updatePassword => "更新密码";

  @override
  String get updateProfileInfo => "更新资料信息";

  @override
  String get password8CharsRequirement =>
      "密码必须至少包含8个字符。";

  @override
  String get passwordAtLeast1CapitalLetter =>
      "密码必须至少包含1个大写字母。";

  @override
  String get passwordAtLeast1LowerCaseLetter =>
      "密码必须包含至少1个小写字母。";

  @override
  String get passwordAtLeast1Number =>
      "密码必须至少包含1个数字。";

  @override
  String get passwordMustMatch => "密码必须匹配。";

  @override
  String get notificationUpdatedSuccess => "通知更改已更新。";

  @override
  String get passwordUpdatedSuccess => "密码已更新。";

  @override
  String get profileUpdatedSuccess => "个人资料已更新";

  @override
  String get enablePermissions => "启用权限";

  @override
  String get permissionDenied => "没有权限";

  @override
  String get savePreferences => "保存首选项";

  @override
  String get turnOffChannelEmails => "不接收频道电子邮件";

  @override
  String get turnOffChannelSounds => "关闭频道声音";

  @override
  String get chatMessageUnavailable =>
      "该用户无法使用聊天消息";

  @override
  String get createChannel => "建立频道";

  @override
  String get createNewChannel => "建立新频道";

  @override
  String get isTyping => "在打字...";

  @override
  String get createPrivateGroup => "建立私人群组";

  @override
  String get createPrivateGroupWarning =>
      "您将要创建一个新的GROUP，如果他们已经是您团队的成员，则可以将其添加到该组中；如果尚未加入，请先创建该组，然后再邀请他们。";

  @override
  String get createNewPrivateGroup => "创建一个新的私人组";

  @override
  String get createNewChannelAction =>
      "您将要创建一个新的开放频道。";

  @override
  String get createNewChannelForAdminsOnly => "仅管理员具有写权限。";

  @override
  String get openChannelAllMemberAccess => "所有团队成员都具有读取权限。";

  @override
  String get and => "和";

  @override
  String get userIsInactiveToChat =>
      "您无法与该用户聊天，因为它处于非活动状态。";

  @override
  String get selectChannel => "选择频道";

  @override
  String get needToSelectChannel => "您需要选择一个频道";

  @override
  String get fileAlreadyShared =>
      "该文件已经在您选择的频道中以相同的名称共享。";

  @override
  String get inChannel => "在频道中";

  @override
  String seeAnswerMessages(int count) => "看到 $count  讯息";

  @override
  String participantsAndSeparated(List<String> names, {String separator = ""}) {
    String result = "";
    for (int i = 0; i < names.length; i++) {
      if (i > 0) {
        result = "$result   $separator   ${names[i]}";
      } else {
        result = "<b>${names[i]}</b>";
      }
    }
    return result;
  }

  @override
  String userHasJoined(String name) {
    return "用户 $name  已加入频道";
  }

  @override
  String userHasLeft(String name) {
    return "用户 $name  已经离开频道";
  }

  @override
  String invitedBy(String name) {
    return "邀请者 $name";
  }

  @override
  String get answers => "答案";

  @override
  String get publishIn => "发表于";

  @override
  String get hasCommentedOnThread => "对线程发表了评论：";

  @override
  String get unReadMessages => "未读邮件";

  @override
  String get hasAddedTag => "添加了标签";

  @override
  String get hasAssignedUser => "已分配用户";

  @override
  String get hasClosedTask => "已经完成任务";

  @override
  String get hasCommentedTask => "添加了评论";

  @override
  String get hasCreatedTask => "已创建任务";

  @override
  String get hasCreatedTaskAssignedTo => "已创建分配给的新任务";

  @override
  String get hasDeleteTag => "已删除标签";

  @override
  String get hasDeletedCommentTask => "已删除评论";

  @override
  String get hasEditedCommentTask => "已编辑评论";

  @override
  String get hasEditedTask => "已编辑任务";

  @override
  String get hasRemovedEndDateTask => "已删除的结束日期";

  @override
  String get hasReopenedTask => "重新开启了任务";

  @override
  String get hasSetMilestone => "设定了里程碑";

  @override
  String get hasUnAssignedUser => "取消分配用户";

  @override
  String get hasUpdatedDateTask => "已更新的结束日期";

  @override
  String get inTheTask => "在任务中";

  @override
  String get to => "至";

  @override
  String get hasAssignedNewDueDateFor => "为分配了新的截止日期";

  @override
  String get createNewTag => "建立新标签";

  @override
  String get createNewMilestone => "创建新的里程碑";

  @override
  String get editMilestone => "编辑里程碑";

  @override
  String get editTag => "编辑标签";

  @override
  String get openTasks => "开放任务";

  @override
  String get newPersonalNote => "新的个人笔记";

  @override
  String get createNewPersonalNote => "创建个人笔记";

  @override
  String get filterBy => "过滤";

  @override
  String hereStartsYourMessagesWith(String name) =>
      "在这里以@开头您的消息$name";

  @override
  String thisChannelIsManagedBy(String name) =>
      "此频道由@管理$name，如果需要帮助，请联系管理员。";

  @override
  String newPush(String user, String repository, String repositoryUrl) {
    String part1 = "新推";
    String part2 = "在仓库中";
    String part3 = "详情";

    return "<p>$part1  <span class ='link-mention'> @$user</span> $part2  <span> <a href ='$repositoryUrl'>$repository。 $part3</a> </span> </p>";
  }

  @override
  String unassignedTask(
    String repository,
    String repositoryUrl,
  ) {
    String part1 = "存储库中未分配的任务";
    String part2 = "详情";
    return "<p>$part1  <a href ='$repositoryUrl'>$repository。 $part2</a> </p>";
  }

  @override
  String cardTrelloCreate(
      String board, String boardUrl, String card, String cardUrl, String list) {
    String part1 = "卡已创建";
    String part2 = "在列表中";
    String part3 = "董事会";
    return "<p>$part1  <a href ='$cardUrl'>$card</a> $part2   $list   $part3  <a href ='$boardUrl'>$board</a> </p>";
  }

  @override
  String cardTrelloRename(String board, String boardUrl, String oldName,
      String newName, String list) {
    String part1 = "在清单上";
    String part2 = "从董事会";
    String part3 = "卡已重命名";
    String part4 = "到";
    return "<p>$part1 '$list' $part2 <a href='$boardUrl'>$board</a> $part3 '$oldName' $part4 '$newName'</p>";
  }

  @override
  String cardTrelloDescriptionChange(String board, String boardUrl, String card,
      String cardUrl, String list, String description) {
    String part1 = "卡片";
    String part2 = "列表中的";
    String part3 = "从董事会";
    String part4 = "已将其描述更改为";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4 '$description'</p>";
  }

  @override
  String cardTrelloMoveToOtherList(String board, String boardUrl, String card,
      String cardUrl, String oldList, String newList) {
    String part1 = "卡片";
    String part2 = "已从列表中移出";
    String part3 = "到清单";
    String part4= "在板上";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$oldList' $part3 '$newList' $part4 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloArchive(String board, String boardUrl, String card,
      String cardUrl, String list) {
    String part1 = "卡片";
    String part2 = "列表中的";
    String part3 = "从董事会";
    String part4 = "已存档";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4</p>";
  }

  @override
  String get comments => "评论";

  @override
  String get addComment => "添加评论";

  @override
  String get editComment => "编辑评论";

  @override
  String get downloadAppsAndSynchronizer =>
      "<a href ='https://noysi.com/a/#/downloads'>立即下载应用程序！</a>";

  @override
  String get welcomeToNoysiFirstName => "欢迎！这是您的个人频道，其他人不会看到，您不与任何人交流，这是您的个人频道，您可以留下个人笔记并上传其他人不会看到的文件。你叫什么名字？";

  @override
  String get welcomeToNoysiTimeout =>
      "你还没有回答我！如果需要帮助，请单击<a href ='${Endpoint.helpUrl}'>这里。</a>";

  @override
  String get wrongUsernamePassword => "错误的用户名或密码";

  @override
  String get userInUse => "该用户已经在使用中";

  @override
  String get invite => "邀请";

  @override
  String get groupRequired => "需要组";

  @override
  String get uploading => "上载中";

  @override
  String get downloading => "正在下载";

  @override
  String get inviteGuestsWarning => "来宾只能加入这个团队的一个小组。";

  @override
  String get addMembers => "新增成员";

  @override
  String get enterEmailsByComma =>
      "通过用逗号分隔输入电子邮件：";

  @override
  String get firstName => "名字";

  @override
  String get inviteFewMorePersonal => "邀请一些人，变得更加个性化";

  @override
  String get inviteManyAtOnce => "一次邀请许多人";

  @override
  String get addGuests => "添加客人";

  @override
  String get followThread => "跟随这个话题";

  @override
  String get markThreadAsRead => "标记为已读";

  @override
  String get stopFollowingThread => "停止关注此主题";

  @override
  String get needToVerifyAccountToInvite =>
      "您需要验证电子邮件帐户才能邀请成员。";

  @override
  String get createANewTeam => "建立一个新团队";

  @override
  String get createNewTeam => "创建新团队！";

  @override
  String get enterIntoYourAccount => "输入您的帐户";

  @override
  String get forgotPassword => "忘记密码了吗？";

  @override
  String get goAhead => "前进！";

  @override
  String get passwordRestriction => "密码必须至少包含八个字符，包括数字，大写字母和小写字母，您可以使用特殊字符（例如@＃\$％^＆+ =）和十个或更多字符来提高密码的安全性。";

  @override
  String get recoverYorPassword => "恢复你的密码";

  @override
  String get recoverYorPasswordWarning => "要恢复密码，请输入用于登录noysi.com的电子邮件地址";

  @override
  String recoverPasswordResponse(String email) {
    return "我们已经给您发送了一封电子邮件至 $email";
  }

  @override
  String get recoverPasswordResponse1 =>
      "检查您的收件箱并按照说明操作以创建新密码";

  @override
  String get continueStr => "继续";

  @override
  String get passwordAtLeast1SpecialChar => "密码必须至少包含一个特殊字符 @#\$%^&+=";

  @override
  String welcomeToNoysiLastName(String name) => "您好$name。你姓什么";

  @override
  String get welcomeToNoysiDescription => "很好。一切都正确。我将继续更新您的个人资料。";

  @override
  String get welcomeToNoysiInvite => "<a href = '#'>立即邀请您的团队成员！</a>";

  @override
  String get activeFilter => "有源滤波器";

  @override
  String get newFileComment => "文件中的新评论";

  @override
  String get removed => "已移除";

  @override
  String get sharedOn => "分享到";

  @override
  String get notifyAllInThisChannel => "通知此频道的所有人";

  @override
  String get notifyAllMembers => "通知所有会员";

  @override
  String get keepPressingToRecord => "请持续按下按钮进行录制";

  @override
  String get slideToCancel => "滑动即可取消";

  @override
  String get chooseASecurePasswordText => "选择一个您可以记住的安全密码";

  @override
  String get confirmPassword => "重复输入密码";

  @override
  String get yourPassword => "密码";

  @override
  String get passwordDontMatch => "密码不匹配";

  @override
  String get changeCreateTeamMail => "不，我要更改电子邮件";

  @override
  String step(int number) => "第$number步";

  @override
  String get user => "用户";

  @override
  String get deleteFolderWarning => "该文件夹将被永久删除，无法恢复";

  @override
  String get calendar => "日历";

  @override
  String get week => "星期";

  @override
  String get folderIsNotInCurrentTeam => "该文件夹未与当前团队关联";

  @override
  String get folderIsNotInAvailableChannel => "引用的文件夹不在文件资源管理器中的可用通道中";

  @override
  String get folderLinked => "文件夹链接已复制到频道";

  @override
  String get folderShared => "该文件夹已在频道上共享";

  @override
  String get folderUploaded => "该文件夹已上传到频道";

  @override
  String get folderNotFound => "找不到资料夹";

  @override
  String get folderNameIncorrect => "文件夹名称无效";

  @override
  String get cloneFolder => "克隆文件夹";

  @override
  String get cloneFolderInfo => "此时，克隆文件夹会在目标通道中创建一个新文件夹，其状态和内容与所选文件夹的状态和内容相同。";

  @override
  String get folderDeleted => "无法访问已删除的文件夹";

  @override
  String get youWereInADeletedFolder => "该文件夹所在的文件夹已被删除";

  @override
  String get dateFormat6 => "MM/dd/yyyy";

  @override
  String get createdTask => "任务已创建";

  @override
  String get loggedIn => "会话启动";

  @override
  String get mention => "提到";

  @override
  String get messageSent => "讯息已发送";

  @override
  String get taskAssigned => "分配的任务";

  @override
  String get taskUnassigned => "未分配的任务";

  @override
  String get uploadedFile => "上载档案";

  @override
  String get uploadedFileFolder => "文件/文件夹上传";

  @override
  String get uploadedFolder => "上载的资料夹";

  @override
  String get downloadedFile => "下载的文件";

  @override
  String get downloadedFileFolder => "下载的文件/文件夹";

  @override
  String get downloadedFolder => "下载文件夹";

  @override
  String get messageUnavailable => "讯息不可用";

  @override
  String get activityZone => "活动区";

  @override
  String get categories => "分类目录";

  @override
  String get category => "类别";

  @override
  String get clearAll => "全部清除";

  @override
  String get errorFetchingData => "获取数据时出错";

  @override
  String get filters => "筛选器";

  @override
  String get openSessions => "公开会议";

  @override
  String activityFileFolderUploadedDownloaded(String user, String name, String channel, {bool download = false, bool isDirect = false, isFolder = false}) {
    String part1 = "${download ? "您已下载" : "您已上传"}${isFolder ? " 文件夹 " : " 文件 "}";
    String part2 = download ? "从渠道" : "在频道中";
    return "$part1 <i class=\"mention-generic\">$name</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMentioned(String user, String channel, {bool isDirect = false}) {
    String part1 = "您在频道中被提及";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMessageSent(String user, String channel, {bool isDirect = false}) {
    String part1 = "您已在频道上发送了一条消息";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activitySignedIn(String sessionInfo, String ip) {
    return "您已登录 <i class=\"mention-generic\">$sessionInfo</i> IP: <i class=\"mention-generic\">$ip</i>";
  }

  @override
  String activityTaskAssigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "您已分配给任务";
    String part2 = "在频道中";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskCreated(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "您已创建任务";
    String part2 = "在频道中";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskUnassigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "您已被分配任务";
    String part2 = "在频道中";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String get activityZoneHeader => "这是活动区开始的地方";

  @override
  String get selectEvent => "选择活动";

  @override
  String get googleCalendar => "Google";

  @override
  String get outlookCalendar => "Outlook";

  @override
  String get noysiCalendar => "Noysi";

  @override
  String get autogenerateRoomNameQuestion => "您要自动生成房间名称吗？";

  @override
  String get createMeetingEvent => "创建事件会议";

  @override
  String get externalGuests => "外部客人";

  @override
  String get internalGuests => "内部客人";

  @override
  String get newMeetingEvent => "新活动会议";

  @override
  String get roomName => "房间名称";

  @override
  String get eventMeeting => "活动会议";

  @override
  String get personalNote => "个人笔记";

  @override
  String get updateExternalGuests => "更新外部访客";

  @override
  String get nameTextWarning => "文本对应于 1-25 个字符的字母数字字符串。您还可以使用空格和字符 _ -";

  @override
  String get nameTextWarningWithoutSpaces => "文本对应于 1-18 个字符的字母数字字符串，没有空格。您还可以使用字符 _ -";

  @override
  String get today => "今天";

  @override
  String get location => "地方";


  @override
  String get sessions => "届会";

  @override
  String get appVersion => "应用程式版本";

  @override
  String get browser => "浏览器";

  @override
  String get device => "设备";

  @override
  String get logout => "登出";

  @override
  String get manufacturer => "制作者";

  @override
  String get no => "不是";

  @override
  String get operativeSystem => "操作系统";

  @override
  String get yes => "是的";

  @override
  String get allDay => "全天";

  @override
  String get endDate => "结束日期";

  @override
  String get noTitle => "无标题";

  @override
  String get currentSession => "当前会话";

  @override
  String get logOutAllExceptForThisOne => "注销除此之外的所有设备";

  @override
  String get terminateAllOtherSessions => "终止所有其他会话";

  @override
  String get closeAllSessionsConfirmation => "是否要终止所有其他会话？";

  @override
  String get closeSessionConfirmation => "您要终止会话吗？";

  @override
  String get connectionLost => "哎呀，好像没有联系";

  @override
  String get connectionEstablished => "你又上线了";

  @override
  String get connectionStatus => "连接状态";

  @override
  String get anUserIsCalling => "一个用户正在给你打电话...";

  @override
  String get answer => "回答";

  @override
  String get hangDown => "悬挂";

  @override
  String get incomingCall => "来电";

  @override
  String isCallingYou(String user) => "$user 在呼唤你...";

  @override
  String get callCouldNotBeInitialized => "呼叫无法初始化";

  @override
  String get sentMessages => "发送信息";

  @override
  String sentMessagesCount(String count) => "$count 的 10000";

  @override
  String get teamDataUsage => "团队数据使用";

  @override
  String get usedStorage => "已用存储";

  @override
  String usedStorageText(String used) => used + "GB 的 5GB";

  @override
  String get userDataUsage => "用户数据使用";

  @override
  String get audioEnabled => "音频已启用";

  @override
  String get meetingOptions => "会议选项";

  @override
  String get videoEnabled => "视频已启用";

  @override
  String get dontShowThisMessage => "不再显示";

  @override
  String get showDialogEveryTime => "每次会议开始时显示对话框";

  @override
  String get micAndCameraRequiredAlert => "需要摄像头和麦克风访问权限，请确保您已授予必要的权限。您要转到权限设置吗？";

  @override
  String get noEvents => "没有事件、任务或个人笔记";

  @override
  String get connectWith => "与连接";

  @override
  String get or => "或者";

  @override
  String get viewDetails => "查看详情";

  @override
  String zendeskTicketUpdated(String user, String status, String type, String title, String url) {
    String part1 = R.string.user;
    String part2 = "更新了票据";
    String part3 = "的类型";
    String part4 = "到状态";
    String part5 = R.string.viewDetails;
    return "<p>$part1 '$user' $part2 '$title' $part3 '$type' $part4 '$status'. <span><a href='$url'>$part5</a></span></p>";
  }


  @override
  String get accept => "接受";

  @override
  String get busy => "忙碌的";

  @override
  String get configuration => "配置";

  @override
  String get downloads => "下载";

  @override
  String get editTeam => "编辑团队";

  @override
  String get general => "一般";

  @override
  String get integrations => "整合";

  @override
  String get noRecents => "没有记录";

  @override
  String get noRecommendations => "没有建议";

  @override
  String get inAMeeting => "在一次会议上";

  @override
  String get onFire => "On Fire";

  @override
  String get plans => "计划";

  @override
  String get setAStatus => "设定一个状态";

  @override
  String get sick => "患病";

  @override
  String get signOut => "签出";

  @override
  String get suggestions => "建议";

  @override
  String get teams => "团队";

  @override
  String get traveling => "旅行";

  @override
  String get whatsYourStatus => "你的状况如何？";

  @override
  String get sendAlwaysAPush => "始终发送推送通知";

  @override
  String get robot => "机器人";

  @override
  String get deactivateUserWarning => "禁用时，团队成员将无法与成员通信。但是，已停用成员在 Noysi 中执行的所有活动将保持不变，消息（开放频道、1 对 1 消息和私人群组）、文件和任务将可以访问。";

  @override
  String get activateUserWarning => "一旦成员被重新激活，他将恢复对他在被停用之前拥有的相同频道、组、文件和任务的访问权限。";

  @override
  String get changeRole => "改变角色";

  @override
  String get userStatus => "用户状态";

  @override
  String get deactivateMyAccount => "停用我的帐户";

  @override
  String get deactivateMyAccountWarning => "如果您停用您的帐户，您将在您通过 Noysi 管理的所有团队、对话、文件、任务和任何活动中停用，直到管理员再次重新激活您。";

  @override
  String get deactivateMyUserInThisTeam => "在这个团队中停用我的用户";

  @override
  String get deactivateMyUserInThisTeamWarning => "当您在团队中停用自己时，您在该团队中拥有的一切都将保留，直到您再次激活为止。如果您是唯一的团队管理员，则该团队不会被删除。";

  @override
  String get operationConfirmation => "你确定这个操作？";

  @override
  String get formatNotSupported => "操作系统不支持此格式或扩展名";

  @override
  String get invitePrivateGroupLink => "使用此链接邀请成员加入群组";

  @override
  String get invalidPhoneNumber => "无效的电话号码";

  @override
  String get searchByCountryName => "按国家名称或拨号代码搜索";

  @override
  String get kick => "驱逐";

  @override
  String get deleteAll => "删除所有";

  @override
  String get enterKeyManually => "手动输入密钥";

  @override
  String get noysiAuthenticator => "Noysi 身份验证器";

  @override
  String get qrScanner => "QR";

  @override
  String get otpLabelWarning => "OTP标签是一个没有空格的字母数字字符串 :@.,;()\$% 也被允许";

  @override
  String get invalidBase32Chars => "无效的base32字符";

  @override
  String get label => "标签";

  @override
  String get secretCode => "秘密钥匙";

  @override
  String get labelTextWarning => "标签为空，请检查此值";

  @override
  String missedCallFrom(String user) => "未接来电 $user";

  @override
  String get activeItemBackgroundColor => "活动项目背景";

  @override
  String get activeItemTextColor => "活动项目文本";

  @override
  String get activePresenceColor => "活跃的存在";

  @override
  String get adminsCanDeleteMessage => "管理员可以删除消息s";

  @override
  String get allForAdminsOnly => "@all 仅供管理员使用";

  @override
  String get channelForAdminsOnly => "@channel 仅适用于管理员和频道创建者";

  @override
  String get chooseTheme => "为您的团队选择一个主题";

  @override
  String get enablePushAllChannels => "在所有频道上启用推送通知";

  @override
  String get inactivePresenceColor => "不活跃的存在";

  @override
  String get leaveTeam => "离开这个团队";

  @override
  String get leaveTeamWarning => "当您离开团队时，您在该团队中拥有的所有内容都将被删除。如果您是唯一的团队管理员，则该团队将被删除。";

  @override
  String get notificationBadgeBackgroundColor => "徽章背景";

  @override
  String get notificationBadgeTextColor => "徽章文字";

  @override
  String get onlyAdminInvitesAllowed => "仅由管理员授权的访客";

  @override
  String get reset => "重置";

  @override
  String get settings => "设置";

  @override
  String get sidebarColor => "侧边栏颜色";

  @override
  String get taskUpdateProtected => "为创建者和管理员保留的任务的修改";

  @override
  String get teamName => "队名";

  @override
  String get textColor => "文字颜色";

  @override
  String get theme => "主题";

  @override
  String get updateUsernameBlocked => "发送邀请时屏蔽用户名";

  @override
  String get fileNotFound => "文件未找到";

  @override
  String get messageNotFound => "未找到消息，请检查您要查找的消息是否在当前团队中可用。";

  @override
  String get taskNotFound => "未找到任务";

  @override
  String userHasPinnedMessage(String name) => "$name 已将消息固定到频道";

  @override
  String userHasUnpinnedMessage(String name) => "$name 已取消固定来自该频道的消息";

  @override
  String get pinMessage => "固定消息";

  @override
  String get unpinMessage => "取消固定消息";

  @override
  String get pinnedMessage => "固定消息";

  @override
  String get deleteMyAccount => "删除我的账户";

  @override
  String get yourDeleteRequestIsInProcess => "您的帐户删除请求正在处理中";

  @override
  String get deleteMyAccountWarning => "如果您删除您的帐户，该操作将不可撤销。如果您管理一个团队并且没有其他管理员，则该团队将被删除。";

  @override
  String get lifetimeDeal => "终身优惠";

  @override
  String get showEmails => "显示用户电子邮件";

  @override
  String get showPhoneNumbers => "显示用户电话号码";

  @override
  String get addChannel => "添加频道";

  @override
  String get addPrivateGroup => "添加私人组";

  @override
  String get selectUserFromTeam => "从此团队中选择用户";

  @override
  String get selectUsersFromChannelGroup => "从频道或群组中选择用户";

  @override
  String get memberDeleted => "会员已删除";
}


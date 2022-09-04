import 'dart:ui';
import 'package:code/_res/values/config.dart';
import 'package:code/_res/values/text/strings_base.dart';

import '../../../data/api/remote/endpoints.dart';
import '../../R.dart';


class StringsTc implements StringsBase {
  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Noysi";

  @override
  String get yourTeams => "您的團隊";

  @override
  String get channel => "渠道";

  @override
  String get channels => "頻道";

  @override
  String get directMessagesAbr => "糖尿病";

  @override
  String get email => "電子郵件";

  @override
  String get home => "家";

  @override
  String get member => "會員";

  @override
  String get administrator => "管理員";

  @override
  String get guest => "來賓";

  @override
  String get guests => "來賓";

  @override
  String get members => "會員";

  @override
  String get inactiveMember => "成員已停用";

  @override
  String get message => "信息";

  @override
  String get messages => "留言內容";

  @override
  String get password => "密碼";

  @override
  String get register => "註冊";

  @override
  String get search => "搜索";

  @override
  String get signIn => "登入";

  @override
  String get task => "任務";

  @override
  String get tasks => "任務";

  @override
  String get createTask => "創建任務";

  @override
  String get newTask => "新任務";

  @override
  String get description => "描述";

  @override
  String get team => "球隊";

  @override
  String get thread => "線";

  @override
  String get threads => "線程數";

  @override
  String get createTeam => "建立團隊";

  @override
  String get confirmIsCorrectEmailAddress => "是!那是正確的電子郵件";

  @override
  String get createTeamIntro =>
      "您將要在Noysi建立新團隊。";

  @override
  String get isCorrectEmailAddress => "這是正確的電子郵件地址嗎？";

  @override
  String get welcome => "歡迎！";

  @override
  String get invitationSentAt => "您的邀請將發送至：";

  @override
  String get next => "下一個";

  @override
  String get startNow => "現在開始！";

  @override
  String get charsRemaining => "剩餘字符：";

  @override
  String get teamNameOrgCompany =>
      "輸入您的團隊名稱，組織或公司名稱。";

  @override
  String get teamNameOrgCompanyLabel => "例如我的公司名稱";

  @override
  String get yourTeam => "你的團隊";

  @override
  String get noysiServiceNewsletters =>
      "可以（偶爾）收到有關NOYSI服務的電子郵件。";

  @override
  String get userNameIntro =>
      "您的用戶名就是您在團隊中其他人看來的樣子。";

  @override
  String get userNameLabel => "例如阿克曼";

  @override
  String get addAnother => "加上另一個";

  @override
  String get byProceedingAcceptTerms =>
      "*繼續進行，即表示您接受我們的<b>服務條款</ b>";

  @override
  String get invitations => "邀請函";

  @override
  String get invitePeople => "邀請人";

  @override
  String get noysiIsTeamWorkInvite =>
      "Noysi是一個團隊合作工具。邀請至少一個人";

  @override
  String get userName => "用戶名";

  @override
  String get fieldMax18 => "最多18個字符";

  @override
  String get fieldMax25 => "最多25個字符";

  @override
  String get fieldPassword => "要求輸入密碼";

  @override
  String get fieldRequired => "必填字段";

  @override
  String get missingEmailFormat => "錯誤的電子郵件";

  @override
  String get back => "背部";

  @override
  String get channelBrowser => "頻道瀏覽器";

  @override
  String get help => "救命";

  @override
  String get preferences => "優先";

  @override
  String get signOutOf => "登出";

  @override
  String get closed => "關閉";

  @override
  String get closedMilestone => "關閉";

  @override
  String get close => "關";

  @override
  String get opened => "開了";

  @override
  String get chat => "聊天室";

  @override
  String get allThreads => "所有線程";

  @override
  String get inviteMorPeople => "邀請更多人";

  @override
  String get meeting => "會議";

  @override
  String get myFiles => "我的文件";

  @override
  String get myTasks => "我的任務";

  @override
  String get myTeams => "我的團隊";

  @override
  String get openChannels => "公開渠道";

  @override
  String get privateGroups => "私人團體";

  @override
  String get favorites => "收藏夾";

  @override
  String get message1x1 => "訊息1到1";

  @override
  String get acceptedTitle => "公認";

  @override
  String get date => "日期";

  @override
  String get invitationLanguageTitle => "習語";

  @override
  String get invitationMessage => "邀請訊息";

  @override
  String get revokeInvitation => "撤銷邀請";

  @override
  String get revoke => "撤消";

  @override
  String get revokeInvitationWarning =>
      "注意，此動作不可逆";

  @override
  String get revokeInvitationDelete => "邀請刪除";

  @override
  String get resendInvitationBefore24hrs =>
      "自上次發送之日起24小時之前，不允許重新發送邀請。";

  @override
  String get resendInvitationSuccess => "邀請已成功發送。";

  @override
  String get resendInvitation => "重新發送邀請";

  @override
  String get invitationMessageDefault =>
      "嗨！在這裡你有邀請加入";

  @override
  String get inviteManyAsOnce => "邀請一次";

  @override
  String get inviteMemberTitle =>
      "團隊成員可以完全訪問公開渠道，個人消息和小組。";

  @override
  String get inviteMemberWarningTitle =>
      "要邀請新成員，您必須是團隊管理員。";

  @override
  String get inviteNewMemberWarningTitle =>
      "團隊中的任何成員都可以無限添加客人。";

  @override
  String get inviteSubtitle =>
      "Noysi是與您的團隊更好地合作的工具。立即邀請他們！";

  @override
  String get inviteTitle => "邀請其他人";

  @override
  String get inviteToAGroup => "邀請組（必填）";

  @override
  String get inviteToAGroupNotRequired => "邀請加入群組（可選）";

  @override
  String get inviteMemberWarning =>
      "新成員將自動加入#general頻道。您也可以選擇將它們立即添加到私人組中。";

  @override
  String get inviteToThisTeam => "邀請這個團隊";

  @override
  String get invitationsSent => "邀請已發送";

  @override
  String get name => "名稱";

  @override
  String get noPendingInvitations =>
      "沒有邀請發送此團隊。";

  @override
  String get pendingTitle => "待定";

  @override
  String get chooseTitle => "選擇";

  @override
  String get seePendingAcceptedInvitations =>
      "查看待處理和已接受的邀請";

  @override
  String get sendInvitations => "發送邀請";

  @override
  String get typeEmail => "輸入電子郵件";

  @override
  String get typeEmailComaSeparated => "以逗號分隔輸入電子郵件";

  @override
  String get atNoysi => "在Noysi";

  @override
  String get inviteNewMemberTitle =>
      "客人無需付款，您可以邀請任意數量的客人，但是他們只能訪問此團隊中的一個小組。";

  @override
  String get invited => "受邀";

  @override
  String get thisNameAlreadyExist =>
      "好像該名稱已被使用。";

  @override
  String get emptyList => "空清單";

  @override
  String get ok => "好";

  @override
  String get byNameFirst => "按名稱A-Z";

  @override
  String get byNameInvertedFirst => "按名稱Z-A";

  @override
  String get download => "下載";

  @override
  String get files => "檔案";

  @override
  String get folders => "資料夾";

  @override
  String get newTitle => "新";

  @override
  String get newestFirst => "新的先來";

  @override
  String get oldestFirst => "最舊的優先";

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
  String get earlyDeliverDate => "提早交貨日期";

  @override
  String get farDeliverDate => "交貨日期遠";

  @override
  String get filterAuthor => "按作者篩選";

  @override
  String get searchUsers => "搜索用戶";

  @override
  String get sort => "分類";

  @override
  String get sortBy => "排序方式";

  @override
  String get cancel => "取消";

  @override
  String get exit => "出口";

  @override
  String get exitWarning => "你確定嗎？";

  @override
  String get deleteChannelWarning =>
      "您確定要退出此頻道嗎？";

  @override
  String get typeMessage => "輸入訊息...";

  @override
  String get addChannelToFavorites => "添加到收藏夾";

  @override
  String get removeFromFavorites => "從收藏夾中刪除";

  @override
  String get channelInfo => "頻道資訊";

  @override
  String get channelMembers => "頻道會員";

  @override
  String get channelPreferences => "頻道偏好";

  @override
  String get closeChatVisibility => "接近1比1";

  @override
  String get inviteToGroup => "邀請會員加入此頻道";

  @override
  String get leaveChannel => "離開頻道";

  @override
  String get mentions => "提及";

  @override
  String get seeFiles => "查看檔案";

  @override
  String get seeLinks => "查看連結";

  @override
  String get links => "鏈接";

  @override
  String get taskManager => "任務管理器";

  @override
  String get videoCall => "視頻電話";

  @override
  String get addReaction => "添加反應";

  @override
  String get addTag => "添加標籤";

  @override
  String get addMilestone => "添加里程碑";

  @override
  String get copyMessage => "複製訊息";

  @override
  String get copyPermanentLink => "複製鏈接";

  @override
  String get createThread => "啟動主題";

  @override
  String get edit => "編輯";

  @override
  String get favorite => "喜愛";

  @override
  String get remove => "去掉";

  @override
  String get tryAgain => "再試一次";

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
      "你確定要刪除這條消息嗎？這不能被撤消。";

  @override
  String get deleteMessageTitle => "刪除留言";

  @override
  String get edited => "已編輯";

  @override
  String get seeAll => "查看全部";

  @override
  String get copiedToClipboard => "複製到剪貼板！";

  @override
  String get underConstruction => "��正在施工🚧";

  @override
  String get reactions => "反應";

  @override
  String get all => "所有";

  @override
  String get users => "用戶數";

  @override
  String get documents => "文件資料";

  @override
  String get fromLocalStorage => "從本地存儲";

  @override
  String get photoGallery => "照片庫";

  @override
  String get recordVideo => "錄製影片";

  @override
  String get takePhoto => "拍個照";

  @override
  String get useCamera => "從相機";

  @override
  String get videoGallery => "視頻庫";

  @override
  String get changeName => "更換名字";

  @override
  String get createFolder => "創建文件夾";

  @override
  String get createNameWarning =>
      "名稱最多可以包含18個字符，且不能帶標點符號。";

  @override
  String get newName => "新名字";

  @override
  String get rename => "改名";

  @override
  String get renameFile => "重新命名文件";

  @override
  String get renameFolder => "重命名文件夾";

  @override
  String get deleteFile => "刪除文件";

  @override
  String get deleteFolder => "刪除資料夾";

  @override
  String get deleteFileWarning => "該文件夾將被永久刪除，無法恢復。從任何鏈接都無法訪問該文件夾。";

  @override
  String get delete => "刪除";

  @override
  String get open => "打開";

  @override
  String get addCommentOptional => "添加評論（可選）";

  @override
  String get shareFile => "分享檔案";

  @override
  String get groups => "團體";

  @override
  String get to1_1 => "一對一";

  @override
  String get day => "天";

  @override
  String get days => "天";

  @override
  String get hour => "小時";

  @override
  String get hours => "小時";

  @override
  String get minute => "分鐘";

  @override
  String get minutes => "分鐘";

  @override
  String get month => "月";

  @override
  String get months => "月";

  @override
  String get year => "年";

  @override
  String get years => "年份";

  @override
  String get by => "通過";

  @override
  String get deliveryDateIn => "截止日期";

  @override
  String get ago => "前";

  @override
  String get taskOpened => "開了";

  @override
  String get assignees => "受讓人";

  @override
  String get assigneeBy => "分配者";

  @override
  String get closeTask => "關閉任務";

  @override
  String get comment => "評論";

  @override
  String get deliveryDate => "截止日期";

  @override
  String get leaveAComment => "發表評論";

  @override
  String get milestone => "里程碑";

  @override
  String get milestones => "大事記";

  @override
  String get color => "顏色";

  @override
  String get milestoneAdded => "已添加到里程碑";

  @override
  String get participants => "參加者";

  @override
  String get reopen => "重新開啟";

  @override
  String get completed => "已完成";

  @override
  String get dueDateUpdated => "截止日期已更新";

  @override
  String get dueDate => "截止日期";

  @override
  String get lastDueDate => "最後截止日期";

  @override
  String get commented => "已評論";

  @override
  String get tagAdded => "標籤已添加";

  @override
  String get tagRemoved => "標籤已刪除";

  @override
  String get tags => "標籤";

  @override
  String get update => "更新資料";

  @override
  String get details => "細節";

  @override
  String get timeline => "時間線";

  @override
  String get aboutMe => "關於我";

  @override
  String get acceptNews => "接收新聞";

  @override
  String get allActive => "全部活躍";

  @override
  String get changePhoto => "更改照片";

  @override
  String get changeYourPassword => "更改您的密碼";

  @override
  String get changeYourPasswordAdvice =>
      "密碼必須至少包含八個字符，包括數字，大寫字母和小寫字母，您可以使用特殊字符（如@＃\$％^＆+ =）和十個或更多字符來提高密碼的安全性";

  @override
  String get charge => "收費";

  @override
  String get country => "國家";

  @override
  String get disabled => "殘障人士";

  @override
  String get emailNotification => "電子郵件通知";

  @override
  String get language => "語言";

  @override
  String get lastName => "姓";

  @override
  String get maxEveryHour => "每隔一小時";

  @override
  String get maxHalfDay => "每12小時";

  @override
  String get messages1x1AndMentions => "消息1x1和@提及";

  @override
  String get myProfile => "我的簡歷";

  @override
  String get never => "決不";

  @override
  String get newPassword => "新密碼";

  @override
  String get newsLetters => "新聞快訊";

  @override
  String get notReceiveNews => "不接收新聞";

  @override
  String get notifications => "通知事項";

  @override
  String get passwordRequirements =>
      "定期更改密碼以提高安全性和保護性";

  @override
  String get phoneNotifications => "電話通知";

  @override
  String get phoneNumber => "電話號碼";

  @override
  String get photoSizeRestrictions =>
      "使用最大寬度為400px（小）的方形照片";

  @override
  String get repeatNewPassword => "重複新密碼";

  @override
  String get security => "安全";

  @override
  String get skypeUserName => "Skype用戶";

  @override
  String get sounds => "聲音";

  @override
  String get yourUserName => "您的用戶名";

  @override
  String get saveChanges => "保存更改";

  @override
  String get profileEmailUsesWarning =>
      "該電子郵件僅用於該團隊的通知。";

  @override
  String get pushMobileNotifications => "推送移動通知";

  @override
  String get saveNotificationChanges => "保存通知更改";

  @override
  String get updatePassword => "更新密碼";

  @override
  String get updateProfileInfo => "更新資料信息";

  @override
  String get password8CharsRequirement =>
      "密碼必須至少包含8個字符。";

  @override
  String get passwordAtLeast1CapitalLetter =>
      "密碼必須至少包含1個大寫字母。";

  @override
  String get passwordAtLeast1LowerCaseLetter =>
      "密碼必須包含至少1個小寫字母。";

  @override
  String get passwordAtLeast1Number =>
      "密碼必須至少包含1個數字。";

  @override
  String get passwordMustMatch => "密碼必須匹配。";

  @override
  String get notificationUpdatedSuccess => "通知更改已更新。";

  @override
  String get passwordUpdatedSuccess => "密碼已更新。";

  @override
  String get profileUpdatedSuccess => "個人資料已更新";

  @override
  String get enablePermissions => "啟用權限";

  @override
  String get permissionDenied => "沒有權限";

  @override
  String get savePreferences => "保存首選項";

  @override
  String get turnOffChannelEmails => "不接收頻道電子郵件";

  @override
  String get turnOffChannelSounds => "關閉頻道聲音";

  @override
  String get chatMessageUnavailable =>
      "該用戶無法使用聊天消息";

  @override
  String get createChannel => "建立頻道";

  @override
  String get createNewChannel => "建立新頻道";

  @override
  String get isTyping => "在打字...";

  @override
  String get createPrivateGroup => "建立私人群組";

  @override
  String get createPrivateGroupWarning =>
      "您將要創建一個新的GROUP，如果這些人已經屬於您的團隊，則可以將其添加到該組中；如果尚未加入，請先創建該組，然後再邀請他們。";

  @override
  String get createNewPrivateGroup => "創建一個新的私人組";

  @override
  String get createNewChannelAction =>
      "您將要創建一個新的開放頻道。";

  @override
  String get createNewChannelForAdminsOnly => "僅管理員具有寫權限。";

  @override
  String get openChannelAllMemberAccess => "所有團隊成員都具有讀取權限。";

  @override
  String get and => "和";

  @override
  String get userIsInactiveToChat =>
      "您無法與該用戶聊天，因為它處於非活動狀態。";

  @override
  String get selectChannel => "選擇頻道";

  @override
  String get needToSelectChannel => "您需要選擇一個頻道";

  @override
  String get fileAlreadyShared =>
      "該文件已經在您選擇的頻道中以相同的名稱共享。";

  @override
  String get inChannel => "在頻道中";

  @override
  String seeAnswerMessages(int count) => "看到 $count  訊息";

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
    return "用戶 $name  已加入頻道";
  }

  @override
  String userHasLeft(String name) {
    return "用戶 $name  已經離開頻道";
  }

  @override
  String invitedBy(String name) {
    return "邀請者 $name";
  }

  @override
  String get answers => "答案";

  @override
  String get publishIn => "發表於";

  @override
  String get hasCommentedOnThread => "對線程發表了評論：";

  @override
  String get unReadMessages => "未讀郵件";

  @override
  String get hasAddedTag => "添加了標籤";

  @override
  String get hasAssignedUser => "已分配用戶";

  @override
  String get hasClosedTask => "已經完成任務";

  @override
  String get hasCommentedTask => "添加了評論";

  @override
  String get hasCreatedTask => "已創建任務";

  @override
  String get hasCreatedTaskAssignedTo => "已創建分配給的新任務";

  @override
  String get hasDeleteTag => "已刪除標籤";

  @override
  String get hasDeletedCommentTask => "已刪除評論";

  @override
  String get hasEditedCommentTask => "已編輯評論";

  @override
  String get hasEditedTask => "已編輯任務";

  @override
  String get hasRemovedEndDateTask => "已刪除的結束日期";

  @override
  String get hasReopenedTask => "重新開啟了任務";

  @override
  String get hasSetMilestone => "設定了里程碑";

  @override
  String get hasUnAssignedUser => "取消分配用戶";

  @override
  String get hasUpdatedDateTask => "已更新的結束日期";

  @override
  String get inTheTask => "在任務中";

  @override
  String get to => "至";

  @override
  String get hasAssignedNewDueDateFor => "為分配了新的截止日期";

  @override
  String get createNewTag => "建立新標籤";

  @override
  String get createNewMilestone => "創建新的里程碑";

  @override
  String get editMilestone => "編輯里程碑";

  @override
  String get editTag => "編輯標籤";

  @override
  String get openTasks => "開放任務";

  @override
  String get newPersonalNote => "新的個人筆記";

  @override
  String get createNewPersonalNote => "創建個人筆記";

  @override
  String get filterBy => "過濾";

  @override
  String hereStartsYourMessagesWith(String name) =>
      "在這里以@開頭您的消息$name";

  @override
  String thisChannelIsManagedBy(String name) =>
      "此頻道由@管理$name，如果需要幫助，請聯繫管理員。";

  @override
  String newPush(String user, String repository, String repositoryUrl) {
    String part1 = "新推";
    String part2 = "在倉庫中";
    String part3 = "詳情";

    return "<p>$part1  <span class ='link-mention'> @$user</span> $part2  <span> <a href ='$repositoryUrl'>$repository。 $part3</a> </span> </p>";
  }

  @override
  String unassignedTask(
    String repository,
    String repositoryUrl,
  ) {
    String part1 = "存儲庫中未分配的任務";
    String part2 = "詳情";
    return "<p>$part1  <a href ='$repositoryUrl'>$repository。 $part2</a> </p>";
  }

  @override
  String cardTrelloCreate(
      String board, String boardUrl, String card, String cardUrl, String list) {
    String part1 = "卡已創建";
    String part2 = "在列表中";
    String part3 = "董事會";
    return "<p>$part1  <a href ='$cardUrl'>$card</a> $part2   $list   $part3  <a href ='$boardUrl'>$board</a> </p>";
  }

  @override
  String cardTrelloRename(String board, String boardUrl, String oldName,
      String newName, String list) {
    String part1 = "在清單上";
    String part2 = "從董事會";
    String part3 = "卡已重命名";
    String part4 = "到";
    return "<p>$part1 '$list' $part2 <a href='$boardUrl'>$board</a> $part3 '$oldName' $part4 '$newName'</p>";
  }

  @override
  String cardTrelloDescriptionChange(String board, String boardUrl, String card,
      String cardUrl, String list, String description) {
    String part1 = "卡片";
    String part2 = "列表中的";
    String part3 = "從董事會";
    String part4 = "已將其描述更改為";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4 '$description'</p>";
  }

  @override
  String cardTrelloMoveToOtherList(String board, String boardUrl, String card,
      String cardUrl, String oldList, String newList) {
    String part1 = "卡片";
    String part2 = "已從列表中移出";
    String part3 = "到清單";
    String part4= "在板上";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$oldList' $part3 '$newList' $part4 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloArchive(String board, String boardUrl, String card,
      String cardUrl, String list) {
    String part1 = "卡片";
    String part2 = "列表中的";
    String part3 = "從董事會";
    String part4 = "已存檔";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4</p>";
  }

  @override
  String get comments => "評論";

  @override
  String get addComment => "添加評論";

  @override
  String get editComment => "編輯評論";

  @override
  String get downloadAppsAndSynchronizer =>
      "<a href ='https://noysi.com/a/#/downloads'>立即下載應用程序！</a>";

  @override
  String get welcomeToNoysiFirstName => "歡迎！這是您的個人頻道，其他人不會看到，您不與任何人交流，這是您的個人頻道，您可以留下個人筆記並上傳其他人不會看到的文件。你叫什麼名字？";

  @override
  String get welcomeToNoysiTimeout =>
      "你還沒有回答我！如果需要幫助，請單擊<a href ='${Endpoint.helpUrl}'>這裡。</a>";

  @override
  String get wrongUsernamePassword => "錯誤的用戶名或密碼";

  @override
  String get userInUse => "該用戶已經在使用中";

  @override
  String get invite => "邀請";

  @override
  String get groupRequired => "需要組";

  @override
  String get uploading => "上載中";

  @override
  String get downloading => "正在下載";

  @override
  String get inviteGuestsWarning => "來賓只能加入這個團隊的一個小組。";

  @override
  String get addMembers => "新增成員";

  @override
  String get enterEmailsByComma =>
      "通過用逗號分隔輸入電子郵件：";

  @override
  String get firstName => "名字";

  @override
  String get inviteFewMorePersonal => "邀請一些人，變得更加個性化";

  @override
  String get inviteManyAtOnce => "一次邀請許多人";

  @override
  String get addGuests => "添加客人";

  @override
  String get followThread => "跟隨這個話題";

  @override
  String get markThreadAsRead => "標記為已讀";

  @override
  String get stopFollowingThread => "停止關注此主題";

  @override
  String get needToVerifyAccountToInvite =>
      "您需要驗證電子郵件帳戶才能邀請成員。";

  @override
  String get createANewTeam => "建立一個新團隊";

  @override
  String get createNewTeam => "創建新團隊！";

  @override
  String get enterIntoYourAccount => "輸入您的帳戶";

  @override
  String get forgotPassword => "忘記密碼了嗎？";

  @override
  String get goAhead => "前進！";

  @override
  String get passwordRestriction => "密碼必須至少包含八個字符，包括數字，大寫字母和小寫字母，您可以使用特殊字符（例如@＃\$％^＆+ =）和十個或更多字符來提高密碼的安全性。";

  @override
  String get recoverYorPassword => "恢復你的密碼";

  @override
  String get recoverYorPasswordWarning => "要恢復密碼，請輸入用於登錄noysi.com的電子郵件地址";

  @override
  String recoverPasswordResponse(String email) {
    return "我們已經給您發送了一封電子郵件至 $email";
  }

  @override
  String get recoverPasswordResponse1 =>
      "檢查您的收件箱並按照說明操作以創建新密碼";

  @override
  String get continueStr => "繼續";

  @override
  String get passwordAtLeast1SpecialChar => "密碼必須至少包含一個特殊字符 @#\$%^&+=";

  @override
  String welcomeToNoysiLastName(String name) => "您好$name。你姓什么";

  @override
  String get welcomeToNoysiDescription => "很好。一切都正確。我將繼續更新您的個人資料。";

  @override
  String get welcomeToNoysiInvite => "<a href = '#'>立即邀請您的團隊成員！</a>";

  @override
  String get activeFilter => "有源濾波器";

  @override
  String get newFileComment => "文件中的新評論";

  @override
  String get removed => "已移除";

  @override
  String get sharedOn => "分享到";

  @override
  String get notifyAllInThisChannel => "通知此頻道的所有人";

  @override
  String get notifyAllMembers => "通知所有會員";

  @override
  String get keepPressingToRecord => "請持續按下按鈕進行錄製";

  @override
  String get slideToCancel => "滑動即可取消";

  @override
  String get chooseASecurePasswordText => "選擇一個您可以記住的安全密碼";

  @override
  String get confirmPassword => "重複輸入密碼";

  @override
  String get yourPassword => "密碼";

  @override
  String get passwordDontMatch => "密碼不匹配";

  @override
  String get changeCreateTeamMail => "不，我要更改電子郵件";

  @override
  String step(int number) => "第$number步";

  @override
  String get user => "用戶";

  @override
  String get deleteFolderWarning => "該文件夾將被永久刪除，無法恢復";

  @override
  String get calendar => "日曆";

  @override
  String get week => "星期";

  @override
  String get folderIsNotInCurrentTeam => "該文件夾未與當前團隊關聯";

  @override
  String get folderIsNotInAvailableChannel => "引用的文件夾不在文件資源管理器中的可用通道中";

  @override
  String get folderLinked => "文件夾鏈接已復製到頻道";

  @override
  String get folderShared => "該文件夾已在頻道上共享";

  @override
  String get folderUploaded => "該文件夾已上傳到頻道";

  @override
  String get folderNotFound => "找不到資料夾";

  @override
  String get folderNameIncorrect => "文件夾名稱無效";

  @override
  String get cloneFolder => "克隆文件夾";

  @override
  String get cloneFolderInfo => "此時，克隆文件夾會在目標通道中創建一個新文件夾，其狀態和內容與所選文件夾的狀態和內容相同。";

  @override
  String get folderDeleted => "無法訪問已刪除的文件夾";

  @override
  String get youWereInADeletedFolder => "該文件夾所在的文件夾已被刪除";

  @override
  String get dateFormat6 => "MM/dd/yyyy";

  @override
  String get createdTask => "任務已創建";

  @override
  String get loggedIn => "會話啟動";

  @override
  String get mention => "提到";

  @override
  String get messageSent => "訊息已發送";

  @override
  String get taskAssigned => "分配的任務";

  @override
  String get taskUnassigned => "未分配的任務";

  @override
  String get uploadedFile => "上載檔案";

  @override
  String get uploadedFileFolder => "文件/文件夾上傳";

  @override
  String get uploadedFolder => "上載的資料夾";

  @override
  String get downloadedFile => "下載的文件";

  @override
  String get downloadedFileFolder => "下載的文件/文件夾";

  @override
  String get downloadedFolder => "下載文件夾";

  @override
  String get messageUnavailable => "訊息不可用";

  @override
  String get activityZone => "活動區";

  @override
  String get categories => "分類目錄";

  @override
  String get category => "類別";

  @override
  String get clearAll => "全部清除";

  @override
  String get errorFetchingData => "獲取數據時出錯";

  @override
  String get filters => "篩選器";

  @override
  String get openSessions => "公開會議";

  @override
  String activityFileFolderUploadedDownloaded(String user, String name, String channel, {bool download = false, bool isDirect = false, isFolder = false}) {
    String part1 = "${download ? "您已下載" : "您已上傳"}${isFolder ? " 文件夾 " : " 文件 "}";
    String part2 = download ? "從渠道" : "在頻道中";
    return "$part1 <i class=\"mention-generic\">$name</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMentioned(String user, String channel, {bool isDirect = false}) {
    String part1 = "您在頻道中被提及";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMessageSent(String user, String channel, {bool isDirect = false}) {
    String part1 = "您已在頻道上發送了一條消息";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activitySignedIn(String sessionInfo, String ip) {
    return "您已登錄 <i class=\"mention-generic\">$sessionInfo</i> IP: <i class=\"mention-generic\">$ip</i>";
  }

  @override
  String activityTaskAssigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "您已分配給任務";
    String part2 = "在頻道中";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskCreated(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "您已創建任務";
    String part2 = "在頻道中";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskUnassigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "您已被分配任務";
    String part2 = "在頻道中";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String get activityZoneHeader => "這是活動區開始的地方";

  @override
  String get selectEvent => "選擇活動";

  @override
  String get googleCalendar => "Google";

  @override
  String get outlookCalendar => "Outlook";

  @override
  String get noysiCalendar => "Noysi";

  @override
  String get autogenerateRoomNameQuestion => "您要自動生成房間名稱嗎？";

  @override
  String get createMeetingEvent => "創建事件會議";

  @override
  String get externalGuests => "外部客人";

  @override
  String get internalGuests => "內部客人";

  @override
  String get newMeetingEvent => "新活動會議";

  @override
  String get roomName => "房間名稱";

  @override
  String get eventMeeting => "活動會議";

  @override
  String get personalNote => "個人筆記";

  @override
  String get updateExternalGuests => "更新外部訪客";

  @override
  String get nameTextWarning => "文本對應於 1-25 個字符的字母數字字符串。您還可以使用空格和字符 _ -";

  @override
  String get nameTextWarningWithoutSpaces => "文本對應於 1-18 個字符的字母數字字符串，沒有空格。您還可以使用字符 _ -";

  @override
  String get today => "今天";

  @override
  String get location => "地方";


  @override
  String get sessions => "屆會";

  @override
  String get appVersion => "應用程式版本";

  @override
  String get browser => "瀏覽器";

  @override
  String get device => "設備";

  @override
  String get logout => "登出";

  @override
  String get manufacturer => "製作者";

  @override
  String get no => "不是";

  @override
  String get operativeSystem => "操作系統";

  @override
  String get yes => "是的";

  @override
  String get allDay => "一整天";

  @override
  String get endDate => "結束日期";

  @override
  String get noTitle => "無題";

  @override
  String get currentSession => "當前會話";

  @override
  String get logOutAllExceptForThisOne => "註銷除此之外的所有設備";

  @override
  String get terminateAllOtherSessions => "終止所有其他會話";

  @override
  String get closeAllSessionsConfirmation => "是否要終止所有其他會話？";

  @override
  String get closeSessionConfirmation => "您要終止會話嗎？";

  @override
  String get connectionLost => "哎呀，好像沒有聯繫";

  @override
  String get connectionEstablished => "你又上線了";

  @override
  String get connectionStatus => "連接狀態";

  @override
  String get anUserIsCalling => "一個用戶正在給你打電話...";

  @override
  String get answer => "回答";

  @override
  String get hangDown => "懸掛";

  @override
  String get incomingCall => "來電";

  @override
  String isCallingYou(String user) => "$user 在呼喚你...";

  @override
  String get callCouldNotBeInitialized => "呼叫無法初始化";

  @override
  String get sentMessages => "發送信息";

  @override
  String sentMessagesCount(String count) => "$count 的 10000";

  @override
  String get teamDataUsage => "團隊數據使用";

  @override
  String get usedStorage => "已用存儲";

  @override
  String usedStorageText(String used) => used + "GB 的 5GB";

  @override
  String get userDataUsage => "用戶數據使用";

  @override
  String get audioEnabled => "音頻已啟用";

  @override
  String get meetingOptions => "會議選項";

  @override
  String get videoEnabled => "視頻已啟用";

  @override
  String get dontShowThisMessage => "不再顯示";

  @override
  String get showDialogEveryTime => "每次會議開始時顯示對話框";

  @override
  String get micAndCameraRequiredAlert => "需要攝像頭和麥克風訪問權限，請確保您已授予必要的權限。您要轉到權限設置嗎？";

  @override
  String get noEvents => "沒有事件、任務或個人筆記";

  @override
  String get connectWith => "與連接";

  @override
  String get or => "或者";

  @override
  String get viewDetails => "查看詳情";

  @override
  String zendeskTicketUpdated(String user, String status, String type, String title, String url) {
    String part1 = R.string.user;
    String part2 = "更新了票";
    String part3 = "類型";
    String part4 = "狀態";
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
  String get downloads => "下載";

  @override
  String get editTeam => "編輯團隊";

  @override
  String get general => "一般的";

  @override
  String get integrations => "集成";

  @override
  String get noRecents => "沒有最近";

  @override
  String get noRecommendations => "沒有建議";

  @override
  String get inAMeeting => "在開會";

  @override
  String get onFire => "On Fire";

  @override
  String get plans => "計劃";

  @override
  String get setAStatus => "設置狀態";

  @override
  String get sick => "生病的";

  @override
  String get signOut => "登出";

  @override
  String get suggestions => "建議";

  @override
  String get teams => "團隊";

  @override
  String get traveling => "旅行";

  @override
  String get whatsYourStatus => "你是什麼狀態？";

  @override
  String get sendAlwaysAPush => "始終發送推送通知";

  @override
  String get robot => "機器人";

  @override
  String get deactivateUserWarning => "禁用時，團隊成員將無法與成員通信。但是，已停用成員在 Noysi 中執行的所有活動將保持不變，消息（開放頻道、1 對 1 消息和私人群組）、文件和任務將可以訪問。";

  @override
  String get activateUserWarning => "一旦成員被重新激活，他將恢復對他在被停用之前擁有的相同頻道、組、文件和任務的訪問權限。";

  @override
  String get changeRole => "改變角色";

  @override
  String get userStatus => "用戶狀態";

  @override
  String get deactivateMyAccount => "停用我的帳戶";

  @override
  String get deactivateMyAccountWarning => "如果您停用您的帳戶，您將在您通過 Noysi 管理的所有團隊、對話、文件、任務和任何活動中停用，直到管理員再次重新激活您。";

  @override
  String get deactivateMyUserInThisTeam => "在這個團隊中停用我的用戶";

  @override
  String get deactivateMyUserInThisTeamWarning => "當您在團隊中停用自己時，您在該團隊中擁有的一切都將保留，直到您再次激活為止。如果您是唯一的團隊管理員，則該團隊不會被刪除。";

  @override
  String get operationConfirmation => "你確定這個操作？";

  @override
  String get formatNotSupported => "操作系統不支持此格式或擴展名";

  @override
  String get invitePrivateGroupLink => "使用此鏈接邀請成員加入群組";

  @override
  String get invalidPhoneNumber => "無效的電話號碼";

  @override
  String get searchByCountryName => "按國家名稱或撥號代碼搜索";

  @override
  String get kick => "驅逐";

  @override
  String get deleteAll => "刪除所有";

  @override
  String get enterKeyManually => "手動輸入密鑰";

  @override
  String get noysiAuthenticator => "Noysi 身份驗證器";

  @override
  String get qrScanner => "QR";

  @override
  String get otpLabelWarning => "OTP 標籤是不帶空格的字母數字字符串 :@.,;()\$% 也被允許";

  @override
  String get invalidBase32Chars => "無效的 base32 字符";

  @override
  String get label => "標籤";

  @override
  String get secretCode => "密鑰";

  @override
  String get labelTextWarning => "標籤為空，請檢查此值";

  @override
  String missedCallFrom(String user) => "未接來電 $user";

  @override
  String get activeItemBackgroundColor => "活動項目背景";

  @override
  String get activeItemTextColor => "活動項目文本";

  @override
  String get activePresenceColor => "活躍的存在";

  @override
  String get adminsCanDeleteMessage => "管理員可以刪除消息";

  @override
  String get allForAdminsOnly => "@all 僅供管理員使用";

  @override
  String get channelForAdminsOnly => "@channel 僅適用於管理員和頻道創建者";

  @override
  String get chooseTheme => "為您的團隊選擇一個主題";

  @override
  String get enablePushAllChannels => "在所有頻道上啟用推送通知";

  @override
  String get inactivePresenceColor => "不活躍的存在";

  @override
  String get leaveTeam => "離開這個團隊";

  @override
  String get leaveTeamWarning => "當您離開團隊時，您在該團隊中擁有的所有內容都將被刪除。如果您是唯一的團隊管理員，則該團隊將被刪除。";

  @override
  String get notificationBadgeBackgroundColor => "徽章背景";

  @override
  String get notificationBadgeTextColor => "徽章文字";

  @override
  String get onlyAdminInvitesAllowed => "僅由管理員授權的訪客";

  @override
  String get reset => "重置";

  @override
  String get settings => "設置";

  @override
  String get sidebarColor => "側邊欄顏色";

  @override
  String get taskUpdateProtected => "為創建者和管理員保留的任務的修改";

  @override
  String get teamName => "隊名";

  @override
  String get textColor => "文字顏色";

  @override
  String get theme => "主題";

  @override
  String get updateUsernameBlocked => "發送邀請時屏蔽用戶名";

  @override
  String get fileNotFound => "文件未找到";

  @override
  String get messageNotFound => "未找到消息，請檢查您要查找的消息是否在當前團隊中可用。";

  @override
  String get taskNotFound => "未找到任務";

  @override
  String userHasPinnedMessage(String name) => "$name 已將消息固定到頻道";

  @override
  String userHasUnpinnedMessage(String name) => "$name 已取消固定來自該頻道的消息";

  @override
  String get pinMessage => "固定消息";

  @override
  String get unpinMessage => "取消固定消息";

  @override
  String get pinnedMessage => "固定消息";

  @override
  String get deleteMyAccount => "刪除我的賬戶";

  @override
  String get yourDeleteRequestIsInProcess => "您的帳戶刪除請求正在處理中";

  @override
  String get deleteMyAccountWarning => "如果您刪除您的帳戶，該操作將不可撤銷。如果您管理一個團隊並且沒有其他管理員，則該團隊將被刪除。";

  @override
  String get lifetimeDeal => "終身優惠";

  @override
  String get showEmails => "顯示用戶電子郵件";

  @override
  String get showPhoneNumbers => "顯示用戶電話號碼";

  @override
  String get addChannel => "添加频道";

  @override
  String get addPrivateGroup => "添加私人组";

  @override
  String get selectUserFromTeam => "從此團隊中選擇用戶";

  @override
  String get selectUsersFromChannelGroup => "從頻道或群組中選擇用戶";

  @override
  String get memberDeleted => "會員已刪除";
}


import 'dart:ui';
import 'package:code/_res/values/config.dart';
import 'package:code/_res/values/text/strings_base.dart';

import '../../../data/api/remote/endpoints.dart';
import '../../R.dart';


class StringsJa implements StringsBase {
  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Noysi";

  @override
  String get yourTeams => "あなたのチーム";

  @override
  String get channel => "チャネル";

  @override
  String get channels => "チャンネル";

  @override
  String get directMessagesAbr => "DM";

  @override
  String get email => "Eメール";

  @override
  String get home => "ホーム";

  @override
  String get member => "メンバー";

  @override
  String get administrator => "管理者";

  @override
  String get guest => "ゲスト";

  @override
  String get guests => "ゲスト";

  @override
  String get members => "メンバー";

  @override
  String get inactiveMember => "メンバーが非アクティブ化されました";

  @override
  String get message => "メッセージ";

  @override
  String get messages => "メッセージ";

  @override
  String get password => "パスワード";

  @override
  String get register => "サインアップ";

  @override
  String get search => "探す";

  @override
  String get signIn => "サインイン";

  @override
  String get task => "仕事";

  @override
  String get tasks => "タスク";

  @override
  String get createTask => "タスクの作成";

  @override
  String get newTask => "新しい仕事";

  @override
  String get description => "説明";

  @override
  String get team => "チーム";

  @override
  String get thread => "糸";

  @override
  String get threads => "スレッド";

  @override
  String get createTeam => "チームを作成する";

  @override
  String get confirmIsCorrectEmailAddress => "はい！それは正しいメールです";

  @override
  String get createTeamIntro =>
      "Noysiに新しいチームを設立しようとしています。";

  @override
  String get isCorrectEmailAddress => "これは正しいメールアドレスですか？";

  @override
  String get welcome => "ようこそ！";

  @override
  String get invitationSentAt => "招待状は次の宛先に送信されます。";

  @override
  String get next => "次";

  @override
  String get startNow => "今すぐ始めましょう！";

  @override
  String get charsRemaining => "残りの文字：";

  @override
  String get teamNameOrgCompany =>
      "チーム名、組織、または会社名を入力します。";

  @override
  String get teamNameOrgCompanyLabel => "例私の会社名";

  @override
  String get yourTeam => "あなたのチーム";

  @override
  String get noysiServiceNewsletters =>
      "NOYSIサービスに関する電子メールを（非常にまれに）受信しても問題ありません。";

  @override
  String get userNameIntro =>
      "ユーザー名は、チームの他のメンバーにどのように表示されるかを示します。";

  @override
  String get userNameLabel => "例アッカーマン";

  @override
  String get addAnother => "別の追加";

  @override
  String get byProceedingAcceptTerms =>
      "*続行すると、<b>利用規約</ b>に同意したことになります";

  @override
  String get invitations => "招待状";

  @override
  String get invitePeople => "人を招待する";

  @override
  String get noysiIsTeamWorkInvite =>
      "Noysiはチームワークツールです。少なくとも1人を招待する";

  @override
  String get userName => "ユーザー名";

  @override
  String get fieldMax18 => "最大18文字";

  @override
  String get fieldMax25 => "最大25文字";

  @override
  String get fieldPassword => "パスワードが必要";

  @override
  String get fieldRequired => "必要なフィールド";

  @override
  String get missingEmailFormat => "間違ったメール";

  @override
  String get back => "バック";

  @override
  String get channelBrowser => "チャネルブラウザ";

  @override
  String get help => "助けて";

  @override
  String get preferences => "環境設定";

  @override
  String get signOutOf => "サインアウト";

  @override
  String get closed => "閉まっている";

  @override
  String get closedMilestone => "閉まっている";

  @override
  String get close => "閉じる";

  @override
  String get opened => "オープン";

  @override
  String get chat => "チャット";

  @override
  String get allThreads => "すべてのスレッド";

  @override
  String get inviteMorPeople => "より多くの人を招待する";

  @override
  String get meeting => "会議";

  @override
  String get myFiles => "私のファイル";

  @override
  String get myTasks => "私のタスク";

  @override
  String get myTeams => "私のチーム";

  @override
  String get openChannels => "開水路";

  @override
  String get privateGroups => "プライベートグループ";

  @override
  String get favorites => "お気に入り";

  @override
  String get message1x1 => "メッセージ1対1";

  @override
  String get acceptedTitle => "承認済み";

  @override
  String get date => "日付";

  @override
  String get invitationLanguageTitle => "イディオム言語";

  @override
  String get invitationMessage => "招待メッセージ";

  @override
  String get revokeInvitation => "招待を取り消す";

  @override
  String get revoke => "取り消す";

  @override
  String get revokeInvitationWarning =>
      "注意してください、このアクションは元に戻せません";

  @override
  String get revokeInvitationDelete => "招待削除";

  @override
  String get resendInvitationBefore24hrs =>
      "招待状の再送信は、最後の送信から24時間経過するまで許可されません。";

  @override
  String get resendInvitationSuccess => "招待状は正常に送信されました。";

  @override
  String get resendInvitation => "招待状を再送する";

  @override
  String get invitationMessageDefault =>
      "こんにちは！ここに参加への招待状があります";

  @override
  String get inviteManyAsOnce => "一度だけ招待する";

  @override
  String get inviteMemberTitle =>
      "チームメンバーは、オープンチャネル、個人間メッセージ、およびグループに完全にアクセスできます。";

  @override
  String get inviteMemberWarningTitle =>
      "新しいメンバーを招待するには、チーム管理者である必要があります。";

  @override
  String get inviteNewMemberWarningTitle =>
      "チームのメンバーは誰でも無制限にゲストを追加できます。";

  @override
  String get inviteSubtitle =>
      "Noysiは、チームとの連携を強化するためのツールです。今すぐ招待してください！";

  @override
  String get inviteTitle => "他の人を招待する";

  @override
  String get inviteToAGroup => "グループに招待する（必須）";

  @override
  String get inviteToAGroupNotRequired => "グループに招待する（オプション）";

  @override
  String get inviteMemberWarning =>
      "新しいメンバーは自動的に#generalチャンネルに参加します。オプションで、今すぐプライベートグループに追加することもできます。";

  @override
  String get inviteToThisTeam => "このチームに招待する";

  @override
  String get invitationsSent => "送信された招待状";

  @override
  String get name => "名前";

  @override
  String get noPendingInvitations =>
      "このチームに送信する招待状はありません。";

  @override
  String get pendingTitle => "保留中";

  @override
  String get chooseTitle => "選択";

  @override
  String get seePendingAcceptedInvitations =>
      "保留中および承認済みの招待状を表示";

  @override
  String get sendInvitations => "招待状を送信する";

  @override
  String get typeEmail => "メールを入力してください";

  @override
  String get typeEmailComaSeparated => "コマで区切られたメールを入力";

  @override
  String get atNoysi => "ノイシで";

  @override
  String get inviteNewMemberTitle =>
      "ゲストは料金を支払わず、好きなだけ招待できますが、このチーム内の1つのグループにしかアクセスできません。";

  @override
  String get invited => "招待";

  @override
  String get thisNameAlreadyExist =>
      "この名前がすでに使用されているようです。";

  @override
  String get emptyList => "空のリスト";

  @override
  String get ok => "OK";

  @override
  String get byNameFirst => "名前でA-Z";

  @override
  String get byNameInvertedFirst => "名前でZ-A";

  @override
  String get download => "ダウンロード";

  @override
  String get files => "ファイル";

  @override
  String get folders => "フォルダー";

  @override
  String get newTitle => "新着";

  @override
  String get newestFirst => "最新のものが最初";

  @override
  String get oldestFirst => "最も古いものから";

  @override
  String get see => "見る";

  @override
  String get share => "シェア";

  @override
  String get moreInfo => "詳しくは";

  @override
  String get assigned => "割り当て済み";

  @override
  String get author => "著者";

  @override
  String get created => "作成した";

  @override
  String get earlyDeliverDate => "早期納期";

  @override
  String get farDeliverDate => "遠い納期";

  @override
  String get filterAuthor => "著者によるフィルタリング";

  @override
  String get searchUsers => "ユーザーを検索";

  @override
  String get sort => "ソート";

  @override
  String get sortBy => "並び替え";

  @override
  String get cancel => "キャンセル";

  @override
  String get exit => "出口";

  @override
  String get exitWarning => "本気ですか？";

  @override
  String get deleteChannelWarning =>
      "このチャンネルを離れてもよろしいですか？";

  @override
  String get typeMessage => "メッセージを入力してください...";

  @override
  String get addChannelToFavorites => "お気に入りに追加";

  @override
  String get removeFromFavorites => "お気に入りから削除";

  @override
  String get channelInfo => "チャンネル情報";

  @override
  String get channelMembers => "チャネルメンバー";

  @override
  String get channelPreferences => "チャネル設定";

  @override
  String get closeChatVisibility => "1対1で閉じる";

  @override
  String get inviteToGroup => "このチャンネルにメンバーを招待する";

  @override
  String get leaveChannel => "チャネルを離れる";

  @override
  String get mentions => "言及";

  @override
  String get seeFiles => "ファイルを見る";

  @override
  String get seeLinks => "リンクを見る";

  @override
  String get links => "リンク";

  @override
  String get taskManager => "タスクマネージャー";

  @override
  String get videoCall => "ビデオ通話";

  @override
  String get addReaction => "反応を追加";

  @override
  String get addTag => "タグ付けする";

  @override
  String get addMilestone => "マイルストーンを追加";

  @override
  String get copyMessage => "メッセージをコピーする";

  @override
  String get copyPermanentLink => "リンクをコピーする";

  @override
  String get createThread => "スレッドを開始します";

  @override
  String get edit => "編集";

  @override
  String get favorite => "お気に入り";

  @override
  String get remove => "削除する";

  @override
  String get tryAgain => "再試行";

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
      "このメッセージを削除してもよろしいですか？これは、元に戻すことはできません。";

  @override
  String get deleteMessageTitle => "メッセージを削除する";

  @override
  String get edited => "編集済み";

  @override
  String get seeAll => "すべてを見る";

  @override
  String get copiedToClipboard => "クリップボードにコピー！";

  @override
  String get underConstruction => "工事中";

  @override
  String get reactions => "反応";

  @override
  String get all => "すべて";

  @override
  String get users => "ユーザー";

  @override
  String get documents => "ドキュメント";

  @override
  String get fromLocalStorage => "ローカルストレージから";

  @override
  String get photoGallery => "フォトギャラリー";

  @override
  String get recordVideo => "ビデオを録画する";

  @override
  String get takePhoto => "写真を撮る";

  @override
  String get useCamera => "カメラから";

  @override
  String get videoGallery => "ビデオギャラリー";

  @override
  String get changeName => "名前を変更する";

  @override
  String get createFolder => "フォルダーを作る";

  @override
  String get createNameWarning =>
      "名前は、句読点なしで最大18文字にする必要があります。";

  @override
  String get newName => "新しい名前";

  @override
  String get rename => "名前を変更する";

  @override
  String get renameFile => "ファイル名を変更する";

  @override
  String get renameFolder => "フォルダの名前を変更する";

  @override
  String get deleteFile => "ファイルを削除する";

  @override
  String get deleteFolder => "フォルダを削除する";

  @override
  String get deleteFileWarning => "フォルダは完全に削除され、復元できません。このフォルダには、どのリンクからもアクセスできなくなります。";

  @override
  String get delete => "削除";

  @override
  String get open => "開いた";

  @override
  String get addCommentOptional => "コメントを追加（オプション）";

  @override
  String get shareFile => "ファイルを共有する";

  @override
  String get groups => "グループ";

  @override
  String get to1_1 => "1対1";

  @override
  String get day => "日";

  @override
  String get days => "日々";

  @override
  String get hour => "時間";

  @override
  String get hours => "時間";

  @override
  String get minute => "分";

  @override
  String get minutes => "分";

  @override
  String get month => "月";

  @override
  String get months => "月";

  @override
  String get year => "年";

  @override
  String get years => "年";

  @override
  String get by => "沿って";

  @override
  String get deliveryDateIn => "期日";

  @override
  String get ago => "前";

  @override
  String get taskOpened => "オープン";

  @override
  String get assignees => "譲受人";

  @override
  String get assigneeBy => "によって割り当てられた";

  @override
  String get closeTask => "タスクを閉じる";

  @override
  String get comment => "コメント";

  @override
  String get deliveryDate => "期日";

  @override
  String get leaveAComment => "コメントを残す";

  @override
  String get milestone => "マイルストーン";

  @override
  String get milestones => "マイルストーン";

  @override
  String get color => "色";

  @override
  String get milestoneAdded => "マイルストーンに追加";

  @override
  String get participants => "参加者";

  @override
  String get reopen => "再開する";

  @override
  String get completed => "完了";

  @override
  String get dueDateUpdated => "期日が更新されました";

  @override
  String get dueDate => "期日";

  @override
  String get lastDueDate => "最終期日";

  @override
  String get commented => "コメント";

  @override
  String get tagAdded => "タグが追加されました";

  @override
  String get tagRemoved => "タグが削除されました";

  @override
  String get tags => "タグ";

  @override
  String get update => "更新";

  @override
  String get details => "詳細";

  @override
  String get timeline => "タイムライン";

  @override
  String get aboutMe => "私について";

  @override
  String get acceptNews => "ニュースを受け取る";

  @override
  String get allActive => "すべてアクティブ";

  @override
  String get changePhoto => "写真を変更する";

  @override
  String get changeYourPassword => "パスワードを変更してください";

  @override
  String get changeYourPasswordAdvice =>
      "パスワードには、数字、大文字、小文字を含む8文字以上が必要です。@＃\$％^＆+ =などの特殊文字と10文字以上を使用して、パスワードのセキュリティを向上させることができます。";

  @override
  String get charge => "充電";

  @override
  String get country => "国";

  @override
  String get disabled => "無効";

  @override
  String get emailNotification => "電子メール通知";

  @override
  String get language => "言語";

  @override
  String get lastName => "苗字";

  @override
  String get maxEveryHour => "毎時";

  @override
  String get maxHalfDay => "12時間ごと";

  @override
  String get messages1x1AndMentions => "メッセージ1x1と@メンション";

  @override
  String get myProfile => "私のプロフィール";

  @override
  String get never => "決して";

  @override
  String get newPassword => "新しいパスワード";

  @override
  String get newsLetters => "ニュースレター";

  @override
  String get notReceiveNews => "ニュースを受け取らない";

  @override
  String get notifications => "通知";

  @override
  String get passwordRequirements =>
      "セキュリティと保護を強化するために、定期的にパスワードを変更してください";

  @override
  String get phoneNotifications => "電話通知";

  @override
  String get phoneNumber => "電話番号";

  @override
  String get photoSizeRestrictions =>
      "最大幅400px（小）の正方形の写真を使用してください";

  @override
  String get repeatNewPassword => "新しいパスワードを繰り返す";

  @override
  String get security => "セキュリティ";

  @override
  String get skypeUserName => "Skypeユーザー";

  @override
  String get sounds => "音";

  @override
  String get yourUserName => "ユーザー名";

  @override
  String get saveChanges => "変更内容を保存";

  @override
  String get profileEmailUsesWarning =>
      "このメールは、このチームの通知にのみ使用されます。";

  @override
  String get pushMobileNotifications => "モバイル通知をプッシュ";

  @override
  String get saveNotificationChanges => "通知の変更を保存する";

  @override
  String get updatePassword => "パスワードを更新する";

  @override
  String get updateProfileInfo => "プロファイル情報を更新する";

  @override
  String get password8CharsRequirement =>
      "パスワードは8文字以上である必要があります。";

  @override
  String get passwordAtLeast1CapitalLetter =>
      "パスワードには少なくとも1つの大文字が含まれている必要があります。";

  @override
  String get passwordAtLeast1LowerCaseLetter =>
      "パスワードには少なくとも1つの小文字が含まれている必要があります。";

  @override
  String get passwordAtLeast1Number =>
      "パスワードには少なくとも1つの数字が含まれている必要があります。";

  @override
  String get passwordMustMatch => "パスワードが一致している必要があります。";

  @override
  String get notificationUpdatedSuccess => "通知の変更が更新されました。";

  @override
  String get passwordUpdatedSuccess => "パスワードが更新されました。";

  @override
  String get profileUpdatedSuccess => "プロフィール更新";

  @override
  String get enablePermissions => "権限を有効にする";

  @override
  String get permissionDenied => "アクセス拒否";

  @override
  String get savePreferences => "設定を保存する";

  @override
  String get turnOffChannelEmails => "チャネルの電子メールを受信しない";

  @override
  String get turnOffChannelSounds => "チャンネルサウンドをオフにする";

  @override
  String get chatMessageUnavailable =>
      "このユーザーはチャットメッセージを使用できません";

  @override
  String get createChannel => "チャネルを作成する";

  @override
  String get createNewChannel => "新しいチャネルを作成する";

  @override
  String get isTyping => "打ち込んでいる...";

  @override
  String get createPrivateGroup => "プライベートグループを作成する";

  @override
  String get createPrivateGroupWarning =>
      "新しいグループを作成します。既にチームに参加している場合は、このグループにユーザーを追加できます。参加していない場合は、最初にグループを作成し、後で招待します。";

  @override
  String get createNewPrivateGroup => "新しいプライベートグループを作成する";

  @override
  String get createNewChannelAction =>
      "新しいオープンチャネルを作成しようとしています。";

  @override
  String get createNewChannelForAdminsOnly => "管理者のみが書き込みにアクセスできます。";

  @override
  String get openChannelAllMemberAccess => "すべてのチームメンバーは読み取りアクセス権を持っています。";

  @override
  String get and => "そして";

  @override
  String get userIsInactiveToChat =>
      "このユーザーは非アクティブであるため、チャットできません。";

  @override
  String get selectChannel => "チャネルを選択";

  @override
  String get needToSelectChannel => "チャンネルを選択する必要があります";

  @override
  String get fileAlreadyShared =>
      "このファイルは、選択したチャネルで同じ名前ですでに共有されています。";

  @override
  String get inChannel => "チャネル内";

  @override
  String seeAnswerMessages(int count) => "見る $count  メッセージ";

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
    return "ユーザー $name  チャンネルに参加しました";
  }

  @override
  String userHasLeft(String name) {
    return "ユーザー $name  チャネルを離れました";
  }

  @override
  String invitedBy(String name) {
    return "招待者 $name";
  }

  @override
  String get answers => "回答";

  @override
  String get publishIn => "で公開";

  @override
  String get hasCommentedOnThread => "スレッドにコメントしました：";

  @override
  String get unReadMessages => "未読メッセージ";

  @override
  String get hasAddedTag => "タグを追加しました";

  @override
  String get hasAssignedUser => "ユーザーを割り当てました";

  @override
  String get hasClosedTask => "タスクを閉じました";

  @override
  String get hasCommentedTask => "コメントを追加しました";

  @override
  String get hasCreatedTask => "タスクを作成しました";

  @override
  String get hasCreatedTaskAssignedTo => "に割り当てられた新しいタスクを作成しました";

  @override
  String get hasDeleteTag => "タグを削除しました";

  @override
  String get hasDeletedCommentTask => "コメントを削除しました";

  @override
  String get hasEditedCommentTask => "コメントを編集しました";

  @override
  String get hasEditedTask => "タスクを編集しました";

  @override
  String get hasRemovedEndDateTask => "の終了日を削除しました";

  @override
  String get hasReopenedTask => "タスクを再開しました";

  @override
  String get hasSetMilestone => "マイルストーンを設定しました";

  @override
  String get hasUnAssignedUser => "ユーザーの割り当てを解除しました";

  @override
  String get hasUpdatedDateTask => "の終了日を更新しました";

  @override
  String get inTheTask => "タスクで";

  @override
  String get to => "に";

  @override
  String get hasAssignedNewDueDateFor => "の新しい期日を割り当てました";

  @override
  String get createNewTag => "新しいタグを作成する";

  @override
  String get createNewMilestone => "新しいマイルストーンを作成する";

  @override
  String get editMilestone => "マイルストーンの編集";

  @override
  String get editTag => "タグを編集する";

  @override
  String get openTasks => "開いているタスク";

  @override
  String get newPersonalNote => "新しい個人的なメモ";

  @override
  String get createNewPersonalNote => "個人的なメモを作成する";

  @override
  String get filterBy => "フィルタリング";

  @override
  String hereStartsYourMessagesWith(String name) =>
      "ここでメッセージを@で始めます$name";

  @override
  String thisChannelIsManagedBy(String name) =>
      "このチャネルは@によって管理されています$name、ヘルプが必要な場合は管理者に連絡してください。";

  @override
  String newPush(String user, String repository, String repositoryUrl) {
    String part1 = "の新しいプッシュ";
    String part2 = "リポジトリ内";
    String part3 = "詳細";

    return "<p>$part1  <span class = 'link-mention'> @$user</span> $part2  <span> <a href = '$repositoryUrl'>$repository。 $part3</a> </span> </p>";
  }

  @override
  String unassignedTask(
    String repository,
    String repositoryUrl,
  ) {
    String part1 = "リポジトリ内の割り当てられていないタスク";
    String part2 = "詳細";
    return "<p>$part1  <a href = '$repositoryUrl'>$repository。 $part2</a> </p>";
  }

  @override
  String cardTrelloCreate(
      String board, String boardUrl, String card, String cardUrl, String list) {
    String part1 = "カードを作成しました";
    String part2 = "リスト内";
    String part3 = "ボードの";
    return "<p>$part1  <a href = '$cardUrl'>$card</a> $part2   $list   $part3  <a href = '$boardUrl'>$board</a> </p>";
  }

  @override
  String cardTrelloRename(String board, String boardUrl, String oldName,
      String newName, String list) {
    String part1 = "リストに";
    String part2 = "ボードから";
    String part3 = "カードの名前が変更されました";
    String part4 = "に";
    return "<p>$part1 '$list' $part2 <a href='$boardUrl'>$board</a> $part3 '$oldName' $part4 '$newName'</p>";
  }

  @override
  String cardTrelloDescriptionChange(String board, String boardUrl, String card,
      String cardUrl, String list, String description) {
    String part1 = "カード";
    String part2 = "リストの";
    String part3 = "ボードから";
    String part4 = "説明をに変更しました";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4 '$description'</p>";
  }

  @override
  String cardTrelloMoveToOtherList(String board, String boardUrl, String card,
      String cardUrl, String oldList, String newList) {
    String part1 = "カード";
    String part2 = "リストから移動されました";
    String part3 = "リストへ";
    String part4 = "ボード上の";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$oldList' $part3 '$newList' $part4 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloArchive(String board, String boardUrl, String card,
      String cardUrl, String list) {
    String part1 = "カード";
    String part2 = "リストの";
    String part3 = "ボードから";
    String part4 = "アーカイブされました";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4</p>";
  }

  @override
  String get comments => "コメント";

  @override
  String get addComment => "コメントを追加する";

  @override
  String get editComment => "コメントの編集";

  @override
  String get downloadAppsAndSynchronizer =>
      "<a href ='https://noysi.com/a/#/downloads'>今すぐアプリをダウンロードしてください！</a>";

  @override
  String get welcomeToNoysiFirstName => "いらっしゃいませ！これはあなたの個人的なチャンネルであり、他の誰にも見られません。あなたは誰ともコミュニケーションをとっていません。あなたが個人的なメモを残し、他の誰にも見られないファイルをアップロードするためのあなたの個人的なチャンネルです。名前は何？";

  @override
  String get welcomeToNoysiTimeout =>
      "あなたは私に答えていません！ヘルプが必要な場合はクリックしてください <a href='${Endpoint.helpUrl}'>ここ.</a>";

  @override
  String get wrongUsernamePassword => "間違ったユーザー名またはパスワード";

  @override
  String get userInUse => "このユーザーはすでに使用されています";

  @override
  String get invite => "招待する";

  @override
  String get groupRequired => "必要なグループ";

  @override
  String get uploading => "アップロード";

  @override
  String get downloading => "ダウンロード";

  @override
  String get inviteGuestsWarning => "ゲストはこのチームの1つのグループにのみ参加します。";

  @override
  String get addMembers => "メンバーを追加する";

  @override
  String get enterEmailsByComma =>
      "メールをカンマで区切って入力します。";

  @override
  String get firstName => "ファーストネーム";

  @override
  String get inviteFewMorePersonal => "数人を招待して、もっと個人的になる";

  @override
  String get inviteManyAtOnce => "一度に多くの人を招待する";

  @override
  String get addGuests => "ゲストを追加";

  @override
  String get followThread => "このスレッドに従ってください";

  @override
  String get markThreadAsRead => "既読にする";

  @override
  String get stopFollowingThread => "このスレッドのフォローをやめる";

  @override
  String get needToVerifyAccountToInvite =>
      "メンバーを招待するには、メールアカウントを確認する必要があります。";

  @override
  String get createANewTeam => "新しいチームを作成する";

  @override
  String get createNewTeam => "新しいチームを作ろう！";

  @override
  String get enterIntoYourAccount => "アカウントに入力してください";

  @override
  String get forgotPassword => "パスワードをお忘れですか？";

  @override
  String get goAhead => "どうぞ！";

  @override
  String get passwordRestriction => "パスワードには、数字、大文字、小文字を含む8文字以上が必要です。パスワードのセキュリティを向上させるために、@＃\$％^＆+ =などの特殊文字と10文字以上を使用できます。";

  @override
  String get recoverYorPassword => "パスワードを回復する";

  @override
  String get recoverYorPasswordWarning => "パスワードを復元するには、noysi.comへのサインインに使用するメールアドレスを入力してください";

  @override
  String recoverPasswordResponse(String email) {
    return "にメールを送信しました $email";
  }

  @override
  String get recoverPasswordResponse1 =>
      "受信トレイを確認し、そこにある指示に従って新しいパスワードを作成します";

  @override
  String get continueStr => "継続する";

  @override
  String get passwordAtLeast1SpecialChar => "パスワードには少なくとも1つの特殊文字が必要です @#\$%^&+=";

  @override
  String welcomeToNoysiLastName(String name) => "こんにちは$name。あなたの名字は何ですか";

  @override
  String get welcomeToNoysiDescription => "結構。すべてが正しいです。プロフィールの更新に進みます。";

  @override
  String get welcomeToNoysiInvite => "<a href = '#'>今すぐチームメンバーを招待してください！</a>";

  @override
  String get activeFilter => "アクティブフィルター";

  @override
  String get newFileComment => "ファイル内の新しいコメント";

  @override
  String get removed => "削除されました";

  @override
  String get sharedOn => "共有";

  @override
  String get notifyAllInThisChannel => "このチャンネルの全員に通知する";

  @override
  String get notifyAllMembers => "すべてのメンバーに通知する";

  @override
  String get keepPressingToRecord => "録音するにはボタンを押し続けてください";

  @override
  String get slideToCancel => "スワイプしてキャンセル";

  @override
  String get chooseASecurePasswordText => "覚えておくことができる安全なパスワードを選択する";

  @override
  String get confirmPassword => "パスワードを再度入力してください。";

  @override
  String get yourPassword => "パスワード";

  @override
  String get passwordDontMatch => "パスワードが一致していません";

  @override
  String get changeCreateTeamMail => "いいえ、メールを変更したい";

  @override
  String step(int number) => "ステップ$number";

  @override
  String get user => "ユーザー";

  @override
  String get deleteFolderWarning => "フォルダは完全に削除され、復元できません";

  @override
  String get calendar => "カレンダー";

  @override
  String get week => "週間";

  @override
  String get folderIsNotInCurrentTeam => "フォルダは現在のチームに関連付けられていません";

  @override
  String get folderIsNotInAvailableChannel => "参照されたフォルダーは、ファイルエクスプローラーで使用可能なチャネルにありません";

  @override
  String get folderLinked => "チャネルにコピーされたフォルダリンク";

  @override
  String get folderShared => "フォルダはチャネルで共有されています";

  @override
  String get folderUploaded => "フォルダがチャンネルにアップロードされました";

  @override
  String get folderNotFound => "フォルダが見つかりません";

  @override
  String get folderNameIncorrect => "フォルダの名前が無効です";

  @override
  String get cloneFolder => "クローンフォルダ";

  @override
  String get cloneFolderInfo => "フォルダのクローンを作成すると、その時点で選択したフォルダと同じステータスとコンテンツを持つ新しいフォルダが宛先チャネルに作成されます。";

  @override
  String get folderDeleted => "削除したフォルダにアクセスできません";

  @override
  String get youWereInADeletedFolder => "それがあったフォルダが削除されました";

  @override
  String get dateFormat6 => "MM/dd/yyyy";

  @override
  String get createdTask => "作成されたタスク";

  @override
  String get loggedIn => "セッション開始";

  @override
  String get mention => "言及する";

  @override
  String get messageSent => "送信されたメッセージ";

  @override
  String get taskAssigned => "割り当てられたタスク";

  @override
  String get taskUnassigned => "割り当てられていないタスク";

  @override
  String get uploadedFile => "アップロードされたファイル";

  @override
  String get uploadedFileFolder => "アップロードされたファイル/フォルダ";

  @override
  String get uploadedFolder => "アップロードされたフォルダ";

  @override
  String get downloadedFile => "ダウンロードしたファイル";

  @override
  String get downloadedFileFolder => "ダウンロードしたファイル/フォルダ";

  @override
  String get downloadedFolder => "ダウンロードしたフォルダ";

  @override
  String get messageUnavailable => "メッセージは利用できません";

  @override
  String get activityZone => "アクティビティゾーン";

  @override
  String get categories => "カテゴリ";

  @override
  String get category => "カテゴリー";

  @override
  String get clearAll => "すべてクリア";

  @override
  String get errorFetchingData => "データの取得中にエラーが発生しました";

  @override
  String get filters => "フィルタ";

  @override
  String get openSessions => "オープンセッション";

  @override
  String activityFileFolderUploadedDownloaded(String user, String name, String channel, {bool download = false, bool isDirect = false, isFolder = false}) {
    String part1 = "${download ? "ダウンロードしました" : "アップロードしました"}${isFolder ? " フォルダ " : " ファイル "}";
    String part2 = download ? "チャネルから" : "チャネル内";
    return "$part1 <i class=\"mention-generic\">$name</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMentioned(String user, String channel, {bool isDirect = false}) {
    String part1 = "あなたはチャンネルで言及されました";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMessageSent(String user, String channel, {bool isDirect = false}) {
    String part1 = "チャンネルでメッセージを送信しました";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activitySignedIn(String sessionInfo, String ip) {
    return "ログインしています <i class=\"mention-generic\">$sessionInfo</i> IP: <i class=\"mention-generic\">$ip</i>";
  }

  @override
  String activityTaskAssigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "タスクに割り当てられました";
    String part2 = "チャネル内";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskCreated(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "タスクを作成しました";
    String part2 = "チャネル内";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskUnassigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "タスクから割り当てが解除されました";
    String part2 = "チャネル内";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String get activityZoneHeader => "ここからアクティビティゾーンが始まります";

  @override
  String get selectEvent => "イベントを選択";

  @override
  String get googleCalendar => "Google";

  @override
  String get outlookCalendar => "Outlook";

  @override
  String get noysiCalendar => "Noysi";

  @override
  String get autogenerateRoomNameQuestion => "部屋名を自動的に生成しますか？";

  @override
  String get createMeetingEvent => "イベントミーティングの作成";

  @override
  String get externalGuests => "外部ゲスト";

  @override
  String get internalGuests => "内部ゲスト";

  @override
  String get newMeetingEvent => "新しいイベント-会議";

  @override
  String get roomName => "部屋の名前";

  @override
  String get eventMeeting => "イベントミーティング";

  @override
  String get personalNote => "個人的なメモ";

  @override
  String get updateExternalGuests => "外部ゲストを更新する";

  @override
  String get nameTextWarning => "このテキストは、1〜25文字の英数字の文字列に対応しています。スペースと文字を使用することもできます_-";

  @override
  String get nameTextWarningWithoutSpaces => "テキストは、スペースを含まない1〜18文字の英数字の文字列に対応します。文字を使用することもできます_-";

  @override
  String get today => "今日";

  @override
  String get location => "場所";


  @override
  String get sessions => "セッション";

  @override
  String get appVersion => "アプリ版";

  @override
  String get browser => "ブラウザ";

  @override
  String get device => "端末";

  @override
  String get logout => "サインオフ";

  @override
  String get manufacturer => "メーカー";

  @override
  String get no => "ない";

  @override
  String get operativeSystem => "オペレーティング・システム";

  @override
  String get yes => "はい";

  @override
  String get allDay => "一日中";

  @override
  String get endDate => "終了日";

  @override
  String get noTitle => "タイトルなし";

  @override
  String get currentSession => "現在のセッション";

  @override
  String get logOutAllExceptForThisOne => "これを除くすべてのデバイスをログアウトします";

  @override
  String get terminateAllOtherSessions => "他のすべてのセッションを終了します";

  @override
  String get closeAllSessionsConfirmation => "他のすべてのセッションを終了しますか？";

  @override
  String get closeSessionConfirmation => "セッションを終了しますか？";

  @override
  String get connectionLost => "おっと、接続がないようです";

  @override
  String get connectionEstablished => "オンラインに戻りました";

  @override
  String get connectionStatus => "接続ステータス";

  @override
  String get anUserIsCalling => "ユーザーから電話があります...";

  @override
  String get answer => "回答";

  @override
  String get hangDown => "ハング";

  @override
  String get incomingCall => "電話の着信";

  @override
  String isCallingYou(String user) => "$user あなたを呼んでいます...";

  @override
  String get callCouldNotBeInitialized => "呼び出しを初期化できませんでした";

  @override
  String get sentMessages => "メッセージを送った";

  @override
  String sentMessagesCount(String count) => "$count の 10000";

  @override
  String get teamDataUsage => "チームデータの使用";

  @override
  String get usedStorage => "使用済みストレージ";

  @override
  String usedStorageText(String used) => used + "GB の 5GB";

  @override
  String get userDataUsage => "ユーザーデータの使用";

  @override
  String get audioEnabled => "オーディオ対応";

  @override
  String get meetingOptions => "ミーティングオプション";

  @override
  String get videoEnabled => "ビデオ対応";

  @override
  String get dontShowThisMessage => "二度と表示しない";

  @override
  String get showDialogEveryTime => "会議が始まるたびにダイアログを表示する";

  @override
  String get micAndCameraRequiredAlert => "カメラとマイクのアクセス許可が必要です。必要な許可が付与されていることを確認してください。権限設定に移動しますか？";

  @override
  String get noEvents => "イベント、タスク、個人的なメモはありません";

  @override
  String get connectWith => "と接続する";

  @override
  String get or => "また";

  @override
  String get viewDetails => "詳細を見る";

  @override
  String zendeskTicketUpdated(String user, String status, String type, String title, String url) {
    String part1 = R.string.user;
    String part2 = "チケットの更新";
    String part3 = "タイプの";
    String part4 = "ステータスへ";
    String part5 = R.string.viewDetails;
    return "<p>$part1 '$user' $part2 '$title' $part3 '$type' $part4 '$status'. <span><a href='$url'>$part5</a></span></p>";
  }


  @override
  String get accept => "受け入れ";

  @override
  String get busy => "ビジー";

  @override
  String get configuration => "構成";

  @override
  String get downloads => "ダウンロード";

  @override
  String get editTeam => "編集チーム";

  @override
  String get general => "一般";

  @override
  String get integrations => "インテグレーション";

  @override
  String get noRecents => "過去の実績なし";

  @override
  String get noRecommendations => "推奨しない";

  @override
  String get inAMeeting => "打ち合わせ中";

  @override
  String get onFire => "On Fire";

  @override
  String get plans => "プラン";

  @override
  String get setAStatus => "ステータスの設定";

  @override
  String get sick => "病気";

  @override
  String get signOut => "サインアウト";

  @override
  String get suggestions => "提案";

  @override
  String get teams => "チーム";

  @override
  String get traveling => "旅行";

  @override
  String get whatsYourStatus => "あなたの状況は？";

  @override
  String get sendAlwaysAPush => "常にプッシュ通知を送信する";

  @override
  String get robot => "ロボット";

  @override
  String get deactivateUserWarning => "チームメンバーは、無効になっている間はメンバーと通信できなくなります。ただし、Noysiで非アクティブ化されたメンバーによって実行されたすべてのアクティビティはそのまま残り、メッセージ（オープンチャネル、1対1のメッセージ、およびプライベートグループ）、ファイル、およびタスクにアクセスできます。";

  @override
  String get activateUserWarning => "メンバーが再アクティブ化されると、非アクティブ化される前と同じチャネル、グループ、ファイル、およびタスクへのアクセスが回復します。";

  @override
  String get changeRole => "役割を変更する";

  @override
  String get userStatus => "ユーザーステータス";

  @override
  String get deactivateMyAccount => "アカウントを無効にします";

  @override
  String get deactivateMyAccountWarning => "アカウントを非アクティブ化すると、管理者が再びアクティブ化するまで、すべてのチーム、会話、ファイル、タスク、およびNoysiを介して管理したすべてのアクティビティが非アクティブ化されます。";

  @override
  String get deactivateMyUserInThisTeam => "このチームのユーザーを非アクティブ化する";

  @override
  String get deactivateMyUserInThisTeamWarning => "チームで自分自身を非アクティブ化すると、そのチームで所有しているものはすべて、再びアクティブ化されるまで残ります。あなたが唯一のチーム管理者である場合、チームは削除されません。";

  @override
  String get operationConfirmation => "この操作を確認しますか？";

  @override
  String get formatNotSupported => "この形式または拡張機能は、オペレーティングシステムではサポートされていません";

  @override
  String get invitePrivateGroupLink => "このリンクを使用してグループにメンバーを招待します";

  @override
  String get invalidPhoneNumber => "無効な電話番号";

  @override
  String get searchByCountryName => "国名またはダイヤルコードで検索";

  @override
  String get kick => "追放";

  @override
  String get deleteAll => "すべて削除";

  @override
  String get enterKeyManually => "キーを手動で入力";

  @override
  String get noysiAuthenticator => "Noysi オーセンティケーター";

  @override
  String get qrScanner => "QR";

  @override
  String get otpLabelWarning => "OTPラベルはスペースを含まない英数字の文字列です :@.,;()\$% もOK";

  @override
  String get invalidBase32Chars => "無効なbase32文字";

  @override
  String get label => "ラベル";

  @override
  String get secretCode => "秘密鍵";

  @override
  String get labelTextWarning => "ラベルが空です、この値を確認してください";

  @override
  String missedCallFrom(String user) => "からの不在着信 $user";

  @override
  String get activeItemBackgroundColor => "アクティブアイテムの背景";

  @override
  String get activeItemTextColor => "アクティブなアイテムのテキスト";

  @override
  String get activePresenceColor => "アクティブプレゼンス";

  @override
  String get adminsCanDeleteMessage => "管理者はメッセージを削除できます";

  @override
  String get allForAdminsOnly => "@allは管理者のみ";

  @override
  String get channelForAdminsOnly => "@channelは、管理者とチャネル作成者のみが対象です";

  @override
  String get chooseTheme => "チームのテーマを選択してください";

  @override
  String get enablePushAllChannels => "すべてのチャネルでプッシュ通知を有効にする";

  @override
  String get inactivePresenceColor => "非アクティブなプレゼンス";

  @override
  String get leaveTeam => "このチームを離れる";

  @override
  String get leaveTeamWarning => "チームを離れると、そのチームで所有しているものはすべて削除されます。あなたが唯一のチーム管理者である場合、チームは削除されます。";

  @override
  String get notificationBadgeBackgroundColor => "バッジの背景";

  @override
  String get notificationBadgeTextColor => "バッジテキスト";

  @override
  String get onlyAdminInvitesAllowed => "管理者によってのみ承認されたゲスト";

  @override
  String get reset => "リセット";

  @override
  String get settings => "設定";

  @override
  String get sidebarColor => "サイドバーの色";

  @override
  String get taskUpdateProtected => "作成者と管理者のために予約されているタスクの変更";

  @override
  String get teamName => "チームの名前";

  @override
  String get textColor => "テキストの色";

  @override
  String get theme => "テーマ";

  @override
  String get updateUsernameBlocked => "招待状を送信するときにユーザー名をブロックする";

  @override
  String get fileNotFound => "ファイルが見つかりません";

  @override
  String get messageNotFound => "メッセージが見つかりません。探しているメッセージが現在のチームで利用可能かどうかを確認してください。";

  @override
  String get taskNotFound => "タスクが見つかりません";

  @override
  String userHasPinnedMessage(String name) => "$name チャンネルにメッセージを固定しました";

  @override
  String userHasUnpinnedMessage(String name) => "$name このチャンネルからのメッセージの固定を解除しました";

  @override
  String get pinMessage => "ピンメッセージ";

  @override
  String get unpinMessage => "メッセージの固定を解除する";

  @override
  String get pinnedMessage => "固定されたメッセージ";

  @override
  String get deleteMyAccount => "アカウントを削除します";

  @override
  String get yourDeleteRequestIsInProcess => "アカウントの削除リクエストは処理中です";

  @override
  String get deleteMyAccountWarning => "アカウントを削除すると、アクションは元に戻せなくなります。チームを管理していて、他に管理者がいない場合、チームは削除されます。";

  @override
  String get lifetimeDeal => "生涯のお得な情報";

  @override
  String get showEmails => "ユーザーのメールを表示する";

  @override
  String get showPhoneNumbers => "ユーザーの電話番号を表示する";

  @override
  String get addChannel => "チャンネルを追加";

  @override
  String get addPrivateGroup => "プライベート グループを追加";

  @override
  String get selectUserFromTeam => "このチームからユーザーを選択";

  @override
  String get selectUsersFromChannelGroup => "チャンネルまたはグループからユーザーを選択";

  @override
  String get memberDeleted => "メンバーが削除されました";
}


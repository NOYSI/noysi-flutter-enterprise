import 'dart:ui';

import 'package:code/_res/values/config.dart';
import 'package:code/_res/values/text/strings_base.dart';

import '../../../data/api/remote/endpoints.dart';
import '../../R.dart';

class StringsVi implements StringsBase {
  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Noysi";

  @override
  String get yourTeams => "Đội của bạn";

  @override
  String get channel => "Kênh";

  @override
  String get channels => "Kênh truyền hình";

  @override
  String get directMessagesAbr => "MDs";

  @override
  String get email => "Thư";

  @override
  String get home => "Bắt đầu";

  @override
  String get member => "Thành viên";

  @override
  String get administrator => "Người quản lý";

  @override
  String get guest => "Được mời";

  @override
  String get guests => "Khách";

  @override
  String get members => "Các thành viên";

  @override
  String get inactiveMember => "Thành viên đã bị vô hiệu hóa";

  @override
  String get message => "Nhắn";

  @override
  String get messages => "Bài viết";

  @override
  String get password => "Mật khẩu";

  @override
  String get register => "Đăng ký";

  @override
  String get search => "Tìm kiếm";

  @override
  String get signIn => "Đăng nhập";

  @override
  String get task => "Bài tập về nhà";

  @override
  String get tasks => "Nhiệm vụ";

  @override
  String get createTask => "Tạo công việc";

  @override
  String get newTask => "Bài tập về nhà mới";

  @override
  String get description => "Sự miêu tả";

  @override
  String get team => "Đội";

  @override
  String get thread => "Chủ đề";

  @override
  String get threads => "Chủ đề";

  @override
  String get createTeam => "Tạo nhóm";

  @override
  String get confirmIsCorrectEmailAddress => "Đúng! Đó là email chính xác";

  @override
  String get createTeamIntro =>
      "Bạn sắp định cấu hình thiết bị mới của mình trong Noysi.";

  @override
  String get isCorrectEmailAddress => "Email có chính xác không?";

  @override
  String get welcome => "Chào mừng!";

  @override
  String get invitationSentAt => "Lời mời của bạn sẽ được gửi đến:";

  @override
  String get next => "Tiếp theo";

  @override
  String get startNow => "Bắt đầu bây giờ!";

  @override
  String get charsRemaining => "Ký tự còn lại:";

  @override
  String get teamNameOrgCompany =>
      "Viết tên của Nhóm, Tổ chức hoặc Công ty của bạn.";

  @override
  String get teamNameOrgCompanyLabel => "Trong. Công ty của tôi";

  @override
  String get yourTeam => "Đội bạn";

  @override
  String get noysiServiceNewsletters =>
      "Tôi đồng ý nhận (thỉnh thoảng) email về các dịch vụ của Noysi.";

  @override
  String get userNameIntro =>
      "Tên người dùng của bạn là cách những người còn lại trong nhóm nhìn thấy bạn.";

  @override
  String get userNameLabel => "Vd: ackerman";

  @override
  String get addAnother => "Thêm cái khác";

  @override
  String get byProceedingAcceptTerms =>
      "* Bằng cách tiếp tục, bạn chấp nhận của chúng tôi <b>Điều khoản dịch vụ</b>";

  @override
  String get invitations => "Lời mời";

  @override
  String get invitePeople => "Mời mọi người";

  @override
  String get noysiIsTeamWorkInvite =>
      "Noysi là một công cụ làm việc theo nhóm. Mời ít nhất một người";

  @override
  String get userName => "tên tài khoản";

  @override
  String get fieldMax18 => "Tối đa 18 ký tự";

  @override
  String get fieldMax25 => "Tối đa 25 ký tự";

  @override
  String get fieldPassword => "mật khẩu được yêu câu";

  @override
  String get fieldRequired => "phần bắt buộc";

  @override
  String get missingEmailFormat => "Email sai";

  @override
  String get back => "Phía sau";

  @override
  String get channelBrowser => "Công cụ tìm kênh";

  @override
  String get help => "Cứu giúp";

  @override
  String get preferences => "sở thích";

  @override
  String get signOutOf => "Đăng xuất khỏi";

  @override
  String get closed => "Đã đóng cửa";

  @override
  String get closedMilestone => "Đã đóng cửa";

  @override
  String get close => "Đóng";

  @override
  String get opened => "Mở ra";

  @override
  String get chat => "Trò chuyện";

  @override
  String get allThreads => "Tất cả các chủ đề";

  @override
  String get inviteMorPeople => "Mời nhiều người hơn";

  @override
  String get meeting => "Gặp gỡ";

  @override
  String get myFiles => "Tệp của tôi";

  @override
  String get myTasks => "Nhiệm vụ của tôi";

  @override
  String get myTeams => "Đội của tôi";

  @override
  String get openChannels => "Mở các kênh";

  @override
  String get privateGroups => "Nhóm riêng";

  @override
  String get favorites => "Yêu thích";

  @override
  String get message1x1 => "Nhắn 1 đến 1";

  @override
  String get acceptedTitle => "Đã được chấp nhận";

  @override
  String get date => "Ngày";

  @override
  String get invitationLanguageTitle => "Cách diễn đạt";

  @override
  String get invitationMessage => "Tin nhắn mời";

  @override
  String get revokeInvitation => "Thu hồi lời mời";

  @override
  String get revoke => "Thu hồi";

  @override
  String get revokeInvitationWarning =>
      "Hãy cẩn thận, hành động này không thể hoàn nguyên";

  @override
  String get revokeInvitationDelete => "Xóa lời mời";

  @override
  String get resendInvitationBefore24hrs =>
      "Gửi lại lời mời không được phép cho đến 24 giờ sau lần gửi cuối cùng.";

  @override
  String get resendInvitationSuccess =>
      "Lời mời đã được gửi thành công.";

  @override
  String get resendInvitation => "Gửi lại lời mời";

  @override
  String get invitationMessageDefault =>
      "Xin chào! Đây là lời mời tham gia";

  @override
  String get inviteManyAsOnce => "Mời nhiều người cùng một lúc";

  @override
  String get inviteMemberTitle =>
      "Các thành viên trong nhóm có toàn quyền truy cập vào các kênh mở, tin nhắn giữa người với người và nhóm.";

  @override
  String get inviteMemberWarningTitle =>
      "Để mời thành viên mới, bạn phải là quản trị viên nhóm.";

  @override
  String get inviteNewMemberWarningTitle =>
      "Bất kỳ thành viên nào trong nhóm đều có thể thêm khách không giới hạn.";

  @override
  String get inviteSubtitle =>
      "Noysi là một công cụ để làm việc tốt hơn với nhóm của bạn. Mời họ ngay bây giờ!";

  @override
  String get inviteTitle => "Mời người khác";

  @override
  String get inviteToAGroup => "Mời một nhóm (bắt buộc)";

  @override
  String get inviteToAGroupNotRequired => "Mời một nhóm (tùy chọn)";

  @override
  String get inviteMemberWarning =>
      "Các thành viên mới sẽ tự động tham gia kênh #general. Theo tùy chọn, bạn cũng có thể thêm họ vào một nhóm riêng tư ngay bây giờ.";

  @override
  String get inviteToThisTeam => "Mời đội này";

  @override
  String get invitationsSent => "Lời mời đã được gửi";

  @override
  String get name => "Tên";

  @override
  String get noPendingInvitations =>
      "Không có lời mời nào để gửi trong nhóm này.";

  @override
  String get pendingTitle => "Bông tai";

  @override
  String get chooseTitle => "Lựa chọn";

  @override
  String get seePendingAcceptedInvitations =>
      "Xem lời mời đang chờ xử lý và được chấp nhận";

  @override
  String get sendInvitations => "Gửi những lời mời";

  @override
  String get typeEmail => "Viết email";

  @override
  String get typeEmailComaSeparated => "Viết các email được phân tách bằng dấu phẩy";

  @override
  String get atNoysi => "ở Noysi";

  @override
  String get inviteNewMemberTitle =>
      "Khách không trả tiền và bạn có thể mời bao nhiêu tùy thích, nhưng họ sẽ chỉ có quyền truy cập vào một nhóm trong nhóm này.";

  @override
  String get invited => "Mời)";

  @override
  String get thisNameAlreadyExist => "Có vẻ như tên này đã được sử dụng.";

  @override
  String get emptyList => "Danh sách trống";

  @override
  String get ok => "Được chứ";

  @override
  String get byNameFirst => "Bằng tên A-Z";

  @override
  String get byNameInvertedFirst => "Bằng tên Z-A";

  @override
  String get download => "Tải xuống";

  @override
  String get files => "Các tập tin";

  @override
  String get folders => "Thư mục";

  @override
  String get newTitle => "Mới";

  @override
  String get newestFirst => "Mới nhất đầu tiên";

  @override
  String get oldestFirst => "Cũ nhất đầu tiên";

  @override
  String get see => "Nhìn thấy";

  @override
  String get share => "Chia sẻ";

  @override
  String get moreInfo => "Thêm thông tin";

  @override
  String get assigned => "Giao";

  @override
  String get author => "Tác giả";

  @override
  String get created => "Tạo";

  @override
  String get earlyDeliverDate => "Ngày giao hàng dự kiến";

  @override
  String get farDeliverDate => "Ngày giao hàng xa";

  @override
  String get filterAuthor => "Ngày giao hàng muộn";

  @override
  String get searchUsers => "Tìm kiếm người dùng";

  @override
  String get sort => "Ngăn nắp";

  @override
  String get sortBy => "Sắp xếp theo";

  @override
  String get dateFormat1 => "MMM dd, yyyy hh.mm";

  @override
  String get cancel => "Hủy bỏ";

  @override
  String get exit => "Ra khỏi";

  @override
  String get exitWarning => "Bạn chắc chắn?";

  @override
  String get deleteChannelWarning =>
      "Bạn có chắc chắn muốn rời khỏi kênh này không?";

  @override
  String get typeMessage => "Viết tin nhắn ...";

  @override
  String get addChannelToFavorites => "Thêm vào mục yêu thích";

  @override
  String get removeFromFavorites => "Loại bỏ khỏi mục ưa thích";

  @override
  String get channelInfo => "Thông tin kênh";

  @override
  String get channelMembers => "Thành viên kênh";

  @override
  String get channelPreferences => "Tùy chọn kênh";

  @override
  String get closeChatVisibility => "Đóng 1 đến 1";

  @override
  String get inviteToGroup => "Mời thành viên vào kênh này";

  @override
  String get leaveChannel => "Rời khỏi kênh";

  @override
  String get mentions => "Đề cập";

  @override
  String get seeFiles => "Xem các tập tin";

  @override
  String get seeLinks => "Xem các liên kết";

  @override
  String get links => "Liên kết (sửa)";

  @override
  String get taskManager => "Quản lý công việc";

  @override
  String get videoCall => "Cuộc gọi video";

  @override
  String get addReaction => "Thêm phản ứng";

  @override
  String get addTag => "Thêm thẻ";

  @override
  String get addMilestone => "Thêm cột mốc";

  @override
  String get copyMessage => "Sao chép tin nhắn";

  @override
  String get copyPermanentLink => "Sao chép đường dẫn";

  @override
  String get createThread => "Bắt đầu một chuỗi";

  @override
  String get edit => "Biên tập";

  @override
  String get favorite => "Yêu thích";

  @override
  String get remove => "Tẩy";

  @override
  String get dateFormat2 => "H:mm";

  @override
  String get dateFormat3 => "MMM d, yyyy";

  @override
  String get tryAgain => "Thử lại";

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
      "Bạn có chắc chắn muốn xóa tin nhắn này? Điều này không thể được hoàn tác.";

  @override
  String get deleteMessageTitle => "Xóa tin nhắn";

  @override
  String get edited => "Đã chỉnh sửa";

  @override
  String get seeAll => "Nhìn thấy mọi thứ";

  @override
  String get copiedToClipboard => "Sao chép vào clipboard!";

  @override
  String get underConstruction => "Đang xây dựng";

  @override
  String get reactions => "Phản ứng";

  @override
  String get all => "Tất cả mọi người";

  @override
  String get users => "Người dùng";

  @override
  String get documents => "Các tài liệu";

  @override
  String get fromLocalStorage => "Từ bộ nhớ cục bộ";

  @override
  String get photoGallery => "triển lãm ảnh";

  @override
  String get recordVideo => "Quay một đoạn phim";

  @override
  String get takePhoto => "Chụp ảnh";

  @override
  String get useCamera => "Từ máy ảnh";

  @override
  String get videoGallery => "Thư viện Video";

  @override
  String get changeName => "Đổi tên";

  @override
  String get createFolder => "Tạo thư mục";

  @override
  String get createNameWarning =>
      "Tên phải có tối đa 18 ký tự, không có dấu chấm câu.";

  @override
  String get newName => "Tên mới";

  @override
  String get rename => "Đổi tên";

  @override
  String get renameFile => "Đổi tên tập tin";

  @override
  String get renameFolder => "Đổi tên thư mục";

  @override
  String get deleteFile => "Xóa tài liệu";

  @override
  String get deleteFolder => "Xóa thư mục";

  @override
  String get deleteFileWarning => "Tệp sẽ bị xóa vĩnh viễn và không thể khôi phục được";

  @override
  String get delete => "Tẩy";

  @override
  String get open => "Mở";

  @override
  String get addCommentOptional => "Thêm nhận xét (tùy chọn)";

  @override
  String get shareFile => "Chia sẻ thư mục";

  @override
  String get groups => "Các nhóm";

  @override
  String get to1_1 => "1 đến 1";

  @override
  String get day => "ngày";

  @override
  String get days => "Ngày";

  @override
  String get hour => "giờ";

  @override
  String get hours => "giờ";

  @override
  String get minute => "phút";

  @override
  String get minutes => "phút";

  @override
  String get month => "Tháng";

  @override
  String get months => "Tháng";

  @override
  String get year => "năm";

  @override
  String get years => "năm";

  @override
  String get by => "vì";

  @override
  String get deliveryDateIn => "Ngày giao hàng trong";

  @override
  String get ago => "Làm";

  @override
  String get taskOpened => "Mở ra";

  @override
  String get assignees => "Bài tập";

  @override
  String get assigneeBy => "Được chỉ định bởi";

  @override
  String get closeTask => "Đóng tác vụ";

  @override
  String get comment => "Nhận xét";

  @override
  String get deliveryDate => "Đường giới hạn";

  @override
  String get leaveAComment => "Để lại bình luận";

  @override
  String get milestone => "Cột mốc";

  @override
  String get milestones => "Các mốc quan trọng";

  @override
  String get color => "Màu sắc";

  @override
  String get milestoneAdded => "Đã thêm vào cột mốc";

  @override
  String get participants => "Những người tham gia";

  @override
  String get reopen => "Mở lại";

  @override
  String get completed => "Hoàn thành";

  @override
  String get dueDateUpdated => "Cập nhật ngày hết hạn";

  @override
  String get dueDate => "Ngày hết hạn";

  @override
  String get lastDueDate => "Ngày hết hạn cuối cùng";

  @override
  String get commented => "Đã nhận xét";

  @override
  String get tagAdded => "Đã thêm thẻ";

  @override
  String get tagRemoved => "Đã xóa thẻ";

  @override
  String get tags => "Nhãn";

  @override
  String get update => "Cập nhật";

  @override
  String get details => "Thông tin chi tiết";

  @override
  String get timeline => "Mốc thời gian";

  @override
  String get aboutMe => "Về tôi";

  @override
  String get acceptNews => "Nhận tin tức";

  @override
  String get allActive => "Tất cả đang hoạt động";

  @override
  String get changePhoto => "Thay đổi hình ảnh";

  @override
  String get changeYourPassword => "Thay đổi mật khẩu của bạn";

  @override
  String get changeYourPasswordAdvice =>
      "Mật khẩu phải có ít nhất tám ký tự, bao gồm một số, một ký tự viết hoa và một ký tự viết thường, bạn có thể sử dụng các ký tự đặc biệt như @#\$%^&+= và mười ký tự trở lên để cải thiện tính bảo mật của mật khẩu của bạn";

  @override
  String get charge => "Chức vụ";

  @override
  String get country => "Quốc gia";

  @override
  String get disabled => "Tàn tật";

  @override
  String get emailNotification => "những thông báo thư điện tử";

  @override
  String get language => "Cách diễn đạt";

  @override
  String get lastName => "Họ";

  @override
  String get maxEveryHour => "Hàng giờ";

  @override
  String get maxHalfDay => "12 giờ một lần";

  @override
  String get messages1x1AndMentions => "Tin nhắn 1x1 và @ chú thích";

  @override
  String get myProfile => "Thông tin của tôi";

  @override
  String get never => "Nunca";

  @override
  String get newPassword => "mật khẩu mới";

  @override
  String get newsLetters => "Bản tin";

  @override
  String get notReceiveNews => "Không nhận được tin tức";

  @override
  String get notifications => "Thông báo";

  @override
  String get passwordRequirements =>
      "Thay đổi mật khẩu của bạn định kỳ để tăng cường bảo mật và an toàn cho bạn";

  @override
  String get phoneNotifications => "Thông báo qua điện thoại";

  @override
  String get phoneNumber => "Số điện thoại";

  @override
  String get photoSizeRestrictions =>
      "Sử dụng ảnh vuông có chiều rộng tối đa là 400 px (nhỏ)";

  @override
  String get repeatNewPassword => "Lặp lại mật khẩu mới";

  @override
  String get security => "Bảo vệ";

  @override
  String get skypeUserName => "Người dùng Skype";

  @override
  String get sounds => "Âm thanh";

  @override
  String get yourUserName => "Tên người dùng của bạn";

  @override
  String get saveChanges => "Lưu thay đổi";

  @override
  String get profileEmailUsesWarning =>
      "Email này chỉ được sử dụng cho các thông báo trên máy tính này.";

  @override
  String get pushMobileNotifications => "Thông báo đẩy trên thiết bị di động";

  @override
  String get saveNotificationChanges => "Lưu các thay đổi thông báo";

  @override
  String get updatePassword => "Cập nhật mật khẩu";

  @override
  String get updateProfileInfo => "Cập nhật thông tin hồ sơ";

  @override
  String get password8CharsRequirement =>
      "Mật khẩu phải dài ít nhất 8 ký tự.";

  @override
  String get passwordAtLeast1CapitalLetter =>
      "Mật khẩu phải có ít nhất 1 chữ cái viết hoa.";

  @override
  String get passwordAtLeast1LowerCaseLetter =>
      "Mật khẩu phải chứa ít nhất 1 chữ thường.";

  @override
  String get passwordAtLeast1Number =>
      "Mật khẩu phải chứa ít nhất 1 số.";

  @override
  String get passwordMustMatch => "Mật khẩu phải phù hợp với.";

  @override
  String get notificationUpdatedSuccess =>
      "Các thay đổi thông báo đã được cập nhật.";

  @override
  String get passwordUpdatedSuccess => "Cập nhật mật khẩu.";

  @override
  String get profileUpdatedSuccess => "Đã cập nhật hồ sơ";

  @override
  String get enablePermissions => "Bật quyền";

  @override
  String get permissionDenied => "Quyền bị từ chối";

  @override
  String get savePreferences => "Lưu tùy chọn";

  @override
  String get turnOffChannelEmails =>
      "Không nhận được email từ kênh";

  @override
  String get turnOffChannelSounds => "Tắt âm thanh kênh";

  @override
  String get chatMessageUnavailable =>
      "Tin nhắn trò chuyện không khả dụng cho người dùng này";

  @override
  String get createChannel => "Tạo kênh";

  @override
  String get createNewChannel => "Tạo một kênh mới";

  @override
  String get isTyping => "đang viết...";

  @override
  String get createPrivateGroup => "Tạo nhóm riêng";

  @override
  String get createPrivateGroupWarning =>
      "Bạn sẽ tạo một NHÓM mới, bạn có thể thêm mọi người vào nhóm này nếu họ đã là thành viên trong nhóm của bạn, nếu chưa, hãy tạo nhóm trước và mời họ sau.";

  @override
  String get createNewPrivateGroup => "Tạo một nhóm riêng tư mới";

  @override
  String get createNewChannelAction =>
      "Bạn sắp tạo một kênh mở mới.";

  @override
  String get createNewChannelForAdminsOnly =>
      "Chỉ quản trị viên mới có quyền ghi.";

  @override
  String get openChannelAllMemberAccess =>
      "Tất cả các thành viên trong nhóm đều có quyền đọc.";

  @override
  String get and => "Y";

  @override
  String get userIsInactiveToChat =>
      "Bạn không thể trò chuyện với người dùng này vì anh ta không hoạt động.";

  @override
  String get selectChannel => "Chọn kênh";

  @override
  String get needToSelectChannel => "Bạn cần chọn một kênh";

  @override
  String get fileAlreadyShared =>
      "Tệp này đã được chia sẻ với cùng tên trên kênh bạn đã chọn.";

  @override
  String get inChannel => "kênh";

  @override
  String seeAnswerMessages(int count) => "Nhìn thấy $count bài viết";

  @override
  String participantsAndSeparated(List<String> names, {String separator = ""}) {
    String result = "";
    for (int i = 0; i < names.length; i++) {
      if (i > 0) {
        result = "$result $separator ${names[i]}";
      } else {
        result = "<b>${names[i]}</b>";
      }
    }
    return result;
  }

  @override
  String userHasJoined(String name) {
    return "Người dùng $name đã tham gia kênh";
  }

  @override
  String userHasLeft(String name) {
    return "Người dùng $name đã rời khỏi kênh";
  }

  @override
  String invitedBy(String name) {
    return "Được mời bởi $name";
  }

  @override
  String get answers => "Câu trả lời";

  @override
  String get publishIn => "xuất bản trong";

  @override
  String get hasCommentedOnThread => "Anh ấy nhận xét về chủ đề:";

  @override
  String get unReadMessages => "Tin nhắn chưa đọc";

  @override
  String get hasAddedTag => "Bạn đã thêm thẻ";

  @override
  String get hasAssignedUser => "Bạn đã chỉ định người dùng";

  @override
  String get hasClosedTask => "Bạn đã hoàn thành nhiệm vụ";

  @override
  String get hasCommentedTask => "Bạn đã thêm một bình luận";

  @override
  String get hasCreatedTask => "Bạn đã tạo một nhiệm vụ";

  @override
  String get hasCreatedTaskAssignedTo => "Bạn đã tạo một nhiệm vụ mới được giao cho";

  @override
  String get hasDeleteTag => "Đã xóa thẻ";

  @override
  String get hasDeletedCommentTask => "Bạn đã xóa một bình luận";

  @override
  String get hasEditedCommentTask => "Bạn đã chỉnh sửa một bình luận";

  @override
  String get hasEditedTask => "Bạn đã chỉnh sửa nhiệm vụ";

  @override
  String get hasRemovedEndDateTask =>
      "Bạn đã xóa ngày kết thúc khỏi";

  @override
  String get hasReopenedTask => "Bạn đã mở lại nhiệm vụ";

  @override
  String get hasSetMilestone => "Đã đánh dấu cột mốc quan trọng";

  @override
  String get hasUnAssignedUser => "Bạn đã thỏa thuận phân bổ người dùng";

  @override
  String get hasUpdatedDateTask => "Bạn đã cập nhật ngày kết thúc của";

  @override
  String get inTheTask => "Trong bài tập về nhà";

  @override
  String get to => "đến";

  @override
  String get hasAssignedNewDueDateFor =>
      "Bạn đã chỉ định một ngày đến hạn mới cho";

  @override
  String get createNewTag => "Tạo thẻ mới";

  @override
  String get createNewMilestone => "Tạo cột mốc mới";

  @override
  String get editMilestone => "Chỉnh sửa cột mốc";

  @override
  String get editTag => "Thẻ chỉnh sửa";

  @override
  String get openTasks => "Mở nhiệm vụ";

  @override
  String get newPersonalNote => "Ghi chú cá nhân mới";

  @override
  String get createNewPersonalNote => "Tạo ghi chú cá nhân";

  @override
  String get filterBy => "Lọc bởi";

  @override
  String hereStartsYourMessagesWith(String name) =>
      "Tại đây, hãy bắt đầu tin nhắn của bạn với @$name";

  @override
  String thisChannelIsManagedBy(String name) =>
      "Kênh này được quản lý bởi @$name, nếu bạn cần trợ giúp, hãy liên hệ với quản trị viên.";

  @override
  String newPush(String user, String repository, String repositoryUrl) {
    String part1 = "Cú hích mới của";
    String part2 = "trong kho";
    String part3 = "Chi tiết";

    return "<p>$part1 <span class='link-mention'>@$user</span> $part2 <span><a href='$repositoryUrl'>$repository. $part3</a></span></p>";
  }

  @override
  String unassignedTask(
      String repository,
      String repositoryUrl,
      ) {
    String part1 = "Nhiệm vụ chưa được giao trong kho lưu trữ";
    String part2 = "Chi tiết";
    return "<p>$part1 <a href='$repositoryUrl'>$repository. $part2</a></p>";
  }

  @override
  String cardTrelloCreate(
      String board, String boardUrl, String card, String cardUrl, String list) {
    String part1 = "Thẻ đã được tạo";
    String part2 = "trong danh sách";
    String part3 = "từ hội đồng quản trị";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 $list $part3 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloRename(String board, String boardUrl, String oldName,
      String newName, String list) {
    String part1 = "Trên danh sách";
    String part2 = "từ hội đồng quản trị";
    String part3 = "thẻ đã được đổi tên";
    String part4 = "đến";
    return "<p>$part1 '$list' $part2 <a href='$boardUrl'>$board</a> $part3 '$oldName' $part4 '$newName'</p>";
  }

  @override
  String cardTrelloDescriptionChange(String board, String boardUrl, String card,
      String cardUrl, String list, String description) {
    String part1 = "Lá bài";
    String part2 = "trong danh sách";
    String part3 = "từ hội đồng quản trị";
    String part4 = "đã thay đổi mô tả của nó thành";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4 '$description'</p>";
  }

  @override
  String cardTrelloMoveToOtherList(String board, String boardUrl, String card,
      String cardUrl, String oldList, String newList) {
    String part1 = "Lá bài";
    String part2 = "đã được chuyển khỏi danh sách";
    String part3 = "vào danh sách";
    String part4= "trên bảng";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$oldList' $part3 '$newList' $part4 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloArchive(String board, String boardUrl, String card,
      String cardUrl, String list) {
    String part1 = "Lá bài";
    String part2 = "trong danh sách";
    String part3 = "từ hội đồng quản trị";
    String part4 = "đã được lưu trữ";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4</p>";
  }

  @override
  String get comments => "Bình luận";

  @override
  String get addComment => "Thêm bình luận";

  @override
  String get editComment => "Cập nhật bình luận";

  @override
  String get downloadAppsAndSynchronizer =>
      "<a href = 'https://noysi.com/a/#/downloads'>TẢI ỨNG DỤNG NGAY BÂY GIỜ!</a>";

  @override
  String get welcomeToNoysiFirstName =>
      "Xin chào! Chào mừng đến với Noysi. Tên của bạn là gì?";

  @override
  String get welcomeToNoysiTimeout =>
      "Bạn chưa trả lời tôi! Nếu bạn cần trợ giúp, hãy nhấp vào <a href='${Endpoint.helpUrl}'>nơi đây.</a>";

  @override
  String get wrongUsernamePassword =>
      "Tên đăng nhập hoặc tài khoản của bạn không chính xác";

  @override
  String get userInUse => "Người dùng này đã được sử dụng";

  @override
  String get invite => "Mời";

  @override
  String get groupRequired => "Nhóm bắt buộc";

  @override
  String get uploading => "Đi lên";

  @override
  String get downloading => "Đang tải xuống";

  @override
  String get inviteGuestsWarning =>
      "Khách sẽ chỉ tham gia một nhóm trong nhóm này";

  @override
  String get addMembers => "Thêm thành viên";

  @override
  String get enterEmailsByComma => "Nhập các email được phân tách bằng dấu phẩy.";

  @override
  String get firstName => "Họ";

  @override
  String get inviteFewMorePersonal => "Mời một người và trở nên cá nhân hơn";

  @override
  String get inviteManyAtOnce => "Mời nhiều người cùng một lúc";

  @override
  String get addGuests => "Thêm khách";

  @override
  String get followThread => "Theo dõi chủ đề này";

  @override
  String get markThreadAsRead => "đánh dấu là đã đọc";

  @override
  String get stopFollowingThread => "Dừng theo dõi chuỗi này";

  @override
  String get needToVerifyAccountToInvite =>
      "Bạn cần xác minh tài khoản để mời thành viên hoặc khách mới.";

  @override
  String get createANewTeam => "Tạo một nhóm mới";

  @override
  String get createNewTeam => "Tạo nhóm mới!";

  @override
  String get enterIntoYourAccount => "đăng nhập vào tài khoản của bạn";

  @override
  String get forgotPassword => "Bạn đã quên mật khẩu của bạn?";

  @override
  String get goAhead => "Đi nào!";

  @override
  String get passwordRestriction =>
      "Mật khẩu phải có ít nhất tám ký tự bao gồm một số, một chữ hoa và một chữ thường, bạn có thể sử dụng các ký tự đặc biệt như @#\$%^&+= và mười ký tự trở lên để cải thiện tính bảo mật cho mật khẩu của bạn.";

  @override
  String get recoverYorPassword => "Khôi phục mật khẩu";

  @override
  String get recoverYorPasswordWarning =>
      "Để đặt lại mật khẩu, hãy nhập email bạn sử dụng cho noysi.com";

  @override
  String recoverPasswordResponse(String email) {
    return "Chúng tôi đã gửi cho bạn một email tới $email";
  }

  @override
  String get recoverPasswordResponse1 =>
      "Vui lòng kiểm tra hộp thư đến của bạn và làm theo hướng dẫn để thay đổi mật khẩu";

  @override
  String get continueStr => "Theo dõi";

  @override
  String get passwordAtLeast1SpecialChar =>
      "Mật khẩu phải bao gồm ít nhất 1 ký tự đặc biệt @#\$%^&+=";

  @override
  String welcomeToNoysiLastName(String name) =>
      "xin chào $name. Họ của bạn là gì?";

  @override
  String get welcomeToNoysiDescription =>
      "Rất tốt. Tất cả mọi thứ là chính xác. Tôi sẽ tiến hành cập nhật hồ sơ của bạn.";

  @override
  String get welcomeToNoysiInvite =>
      "<a href = '#'>Mời các thành viên trong nhóm của bạn ngay bây giờ!</a>";

  @override
  String get activeFilter => "Bộ lọc hoạt động";

  @override
  String get newFileComment => "Nhận xét mới trong tệp";

  @override
  String get removed => "Loại bỏ";

  @override
  String get sharedOn => "Được chia sẻ trên";

  @override
  String get notifyAllInThisChannel => "thông báo cho mọi người trên kênh này";

  @override
  String get notifyAllMembers => "thông báo cho tất cả các thành viên";

  @override
  String get keepPressingToRecord => "Tiếp tục nhấn nút để ghi";

  @override
  String get slideToCancel => "Vuốt để hủy";

  @override
  String get chooseASecurePasswordText => "Chọn một mật khẩu đủ mạnh và bạn có thể nhớ được";

  @override
  String get confirmPassword => "Xác nhận mật khẩu";

  @override
  String get yourPassword => "Mật khẩu của bạn";

  @override
  String get passwordDontMatch => "Mật khẩu không phù hợp";

  @override
  String get changeCreateTeamMail => "Không, tôi muốn thay đổi email";

  @override
  String step(int number) => "Anh ấy đã qua $number";

  @override
  String get user => "Người dùng";

  @override
  String get calendar => "Lịch";

  @override
  String get week => "Tuần";

  String get deleteFolderWarning => "Thư mục sẽ bị xóa vĩnh viễn và không thể khôi phục được. Thư mục sẽ không thể truy cập được từ bất kỳ liên kết nào.";

  @override
  String get folderIsNotInCurrentTeam => "Thư mục không được liên kết với Nhóm hiện tại";

  @override
  String get folderIsNotInAvailableChannel => "Thư mục được tham chiếu không nằm trong kênh khả dụng trong trình khám phá tệp";

  @override
  String get folderLinked => "Đã sao chép liên kết thư mục vào kênh";

  @override
  String get folderShared => "Thư mục đã được chia sẻ trên kênh";

  @override
  String get folderUploaded => "Thư mục đã được tải lên kênh";

  @override
  String get folderNotFound => "Không tìm thấy thư mục";

  @override
  String get folderNameIncorrect => "Tên thư mục không hợp lệ";

  @override
  String get cloneFolder => "Thư mục sao chép";

  @override
  String get cloneFolderInfo => "Sao chép một thư mục sẽ tạo ra một thư mục mới trong kênh đích có cùng trạng thái và nội dung với thư mục đã chọn tại thời điểm này.";

  @override
  String get folderDeleted => "Không thể truy cập thư mục đã xóa";

  @override
  String get youWereInADeletedFolder => "Thư mục nó ở trong đã bị xóa";

  @override
  String get dateFormat6 => "MM/dd/yyyy";

  @override
  String get createdTask => "Tác vụ đã tạo";

  @override
  String get loggedIn => "Phiên bắt đầu";

  @override
  String get mention => "Đề cập đến";

  @override
  String get messageSent => "Đã gửi tin nhắn";

  @override
  String get taskAssigned => "Nhiệm vụ được giao";

  @override
  String get taskUnassigned => "Nhiệm vụ chưa được giao";

  @override
  String get uploadedFile => "Tệp đã tải lên";

  @override
  String get uploadedFileFolder => "Tệp / Thư mục đã được Tải lên";

  @override
  String get uploadedFolder => "Thư mục đã tải lên";

  @override
  String get downloadedFile => "Tập tin tải về";

  @override
  String get downloadedFileFolder => "Tệp / Thư mục đã Tải xuống";

  @override
  String get downloadedFolder => "Thư mục đã tải xuống";

  @override
  String get messageUnavailable => "Không có tin nhắn";

  @override
  String get activityZone => "Khu hoạt động";

  @override
  String get categories => "Thể loại";

  @override
  String get category => "Loại";

  @override
  String get clearAll => "Làm sạch tất cả";

  @override
  String get errorFetchingData => "Lỗi khi lấy dữ liệu";

  @override
  String get filters => "Bộ lọc";

  @override
  String get openSessions => "Phiên mở";

  @override
  String activityFileFolderUploadedDownloaded(String user, String name, String channel, {bool download = false, bool isDirect = false, isFolder = false}) {
    String part1 = "Có bạn ${download ? "Đã xả" : "đã tải lên"}${isFolder ? " Thư mục " : " tập tin "}";
    String part2 = download ? "của Chanel" : "Trong kênh";
    return "$part1 <i class=\"mention-generic\">$name</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMentioned(String user, String channel, {bool isDirect = false}) {
    String part1 = "Bạn đã được đề cập trên kênh";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMessageSent(String user, String channel, {bool isDirect = false}) {
    String part1 = "Bạn đã gửi một tin nhắn trên kênh";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activitySignedIn(String sessionInfo, String ip) {
    return "Bạn đã đăng nhập vào <i class=\"mention-generic\">$sessionInfo</i> IP: <i class=\"mention-generic\">$ip</i>";
  }

  @override
  String activityTaskAssigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Bạn đã được giao nhiệm vụ";
    String part2 = "Trong kênh";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskCreated(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Bạn đã tạo nhiệm vụ";
    String part2 = "Trong kênh";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskUnassigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Bạn đã được phân bổ khỏi nhiệm vụ";
    String part2 = "Trong kênh";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String get activityZoneHeader => "Đây là nơi Khu hoạt động bắt đầu.";

  @override
  String get selectEvent => "Chọn sự kiện";

  @override
  String get googleCalendar => "Google";

  @override
  String get outlookCalendar => "Quan điểm";

  @override
  String get noysiCalendar => "Noysi";

  @override
  String get autogenerateRoomNameQuestion => "Bạn có muốn tạo tên phòng tự động không?";

  @override
  String get createMeetingEvent => "Tạo sự kiện-cuộc họp";

  @override
  String get externalGuests => "Khách bên ngoài";

  @override
  String get internalGuests => "Khách nội bộ";

  @override
  String get newMeetingEvent => "Sự kiện-Cuộc họp mới";

  @override
  String get roomName => "Tên phòng";

  @override
  String get eventMeeting => "Sự kiện-Họp mặt";

  @override
  String get personalNote => "Ghi chú cá nhân";

  @override
  String get updateExternalGuests => "Cập nhật khách bên ngoài";

  @override
  String get nameTextWarning => "Văn bản tương ứng với một chuỗi chữ và số gồm 1-25 ký tự. Bạn cũng có thể sử dụng dấu cách và các ký tự _ -";

  @override
  String get nameTextWarningWithoutSpaces => "Văn bản tương ứng với một chuỗi chữ và số từ 1-18 ký tự không có dấu cách. Bạn cũng có thể sử dụng các ký tự _ -";

  @override
  String get today => "Hôm nay";

  @override
  String get location => "Địa điểm";

  @override
  String get sessions => "Phiên";

  @override
  String get appVersion => "Phiên bản ứng dụng";

  @override
  String get browser => "Trình duyệt";

  @override
  String get device => "Thiết bị";

  @override
  String get logout => "Đăng xuất";

  @override
  String get manufacturer => "Nhà sản xuất";

  @override
  String get no => "Không";

  @override
  String get operativeSystem => "Hệ điều hành";

  @override
  String get yes => "Đúng";

  @override
  String get allDay => "Cả ngày";

  @override
  String get endDate => "Ngày kết thúc";

  @override
  String get noTitle => "Không tiêu đề";

  @override
  String get currentSession => "Phiên hiện tại";

  @override
  String get logOutAllExceptForThisOne => "Đăng xuất khỏi tất cả các thiết bị ngoại trừ thiết bị này.";

  @override
  String get terminateAllOtherSessions => "Đóng tất cả các phiên khác";

  @override
  String get closeAllSessionsConfirmation => "Bạn có muốn đóng tất cả các phiên khác không?";

  @override
  String get closeSessionConfirmation => "Bạn có muốn đóng phiên không?";

  @override
  String get connectionLost => "Chà, dường như không có kết nối";

  @override
  String get connectionEstablished => "Bạn đã trực tuyến trở lại";

  @override
  String get connectionStatus => "Tình trạng kết nối";

  @override
  String get anUserIsCalling => "Một người dùng đang gọi cho bạn ...";

  @override
  String get answer => "Hồi đáp";

  @override
  String get hangDown => "Treo lên";

  @override
  String get incomingCall => "Cuộc gọi đến";

  @override
  String isCallingYou(String user) => "$user đang gọi bạn ...";

  @override
  String get callCouldNotBeInitialized => "Không thể bắt đầu cuộc gọi";

  @override
  String get sentMessages => "Gửi tin nhắn";

  @override
  String sentMessagesCount(String count) => "$count 10000";

  @override
  String get teamDataUsage => "Sử dụng dữ liệu nhóm";

  @override
  String get usedStorage => "Bộ nhớ đã sử dụng";

  @override
  String usedStorageText(String used) => used + "5 GB GB";

  @override
  String get userDataUsage => "Sử dụng dữ liệu của tôi";

  @override
  String get audioEnabled => "Bật âm thanh";

  @override
  String get meetingOptions => "Tùy chọn cuộc họp";

  @override
  String get videoEnabled => "Bật video";

  @override
  String get dontShowThisMessage => "Không hiển thị trở lại";

  @override
  String get showDialogEveryTime => "Hiển thị đối thoại mỗi khi cuộc họp bắt đầu";

  @override
  String get micAndCameraRequiredAlert => "Quyền truy cập máy ảnh và micrô là bắt buộc, hãy đảm bảo rằng bạn đã cấp các quyền cần thiết. Bạn có muốn đi tới cài đặt quyền không?";

  @override
  String get connectWith => "Đăng nhập với";

  @override
  String get or => "hoặc là";

  @override
  String get viewDetails => "Xem chi tiết";

  @override
  String zendeskTicketUpdated(String user, String status, String type, String title, String url) {
    String part1 = R.string.user;
    String part2 = "đã cập nhật vé";
    String part3 = "thuộc loại";
    String part4 = "đến tiểu bang";
    String part5 = R.string.viewDetails;
    return "<p>$part1 '$user' $part2 '$title' $part3 '$type' $part4 '$status'. <span><a href='$url'>$part5</a></span></p>";
  }


  @override
  String get accept => "Chấp nhận";

  @override
  String get busy => "Chiếm lĩnh";

  @override
  String get configuration => "Thiết lập";

  @override
  String get downloads => "tải xuống";

  @override
  String get editTeam => "Chỉnh sửa nhóm";

  @override
  String get general => "chung";

  @override
  String get integrations => "Tích hợp";

  @override
  String get noRecents => "Không có gần đây";

  @override
  String get noRecommendations => "Không có khuyến nghị";

  @override
  String get inAMeeting => "Đã thu thập";

  @override
  String get onFire => "Cháy";

  @override
  String get plans => "Các kế hoạch";

  @override
  String get setAStatus => "Đặt trạng thái";

  @override
  String get sick => "Tôi sẽ";

  @override
  String get signOut => "Đăng xuất";

  @override
  String get suggestions => "Gợi ý";

  @override
  String get teams => "Thiết bị";

  @override
  String get traveling => "Đi du lịch";

  @override
  String get whatsYourStatus => "Trạng thái của bạn là gì?";

  @override
  String get sendAlwaysAPush => "Luôn gửi thông báo đẩy";

  @override
  String get robot => "Người máy";

  @override
  String get deactivateUserWarning => "Các thành viên trong nhóm sẽ không thể giao tiếp với một thành viên khi nó bị vô hiệu hóa. Tuy nhiên, tất cả hoạt động được thực hiện bởi thành viên đã hủy kích hoạt trong Noysi sẽ vẫn nguyên vẹn và các tin nhắn (kênh mở, tin nhắn 1 đến 1 và nhóm riêng tư), tệp và tác vụ sẽ có thể truy cập được.";

  @override
  String get activateUserWarning => "Sau khi thành viên được kích hoạt lại, họ sẽ lấy lại quyền truy cập vào cùng các kênh, nhóm, tệp và tác vụ mà họ đã có trước khi bị vô hiệu hóa.";

  @override
  String get changeRole => "Thay đổi vai trò";

  @override
  String get userStatus => "Tâm trạng người dùng";

  @override
  String get deactivateMyAccount => "Vô hiệu hóa tài khoản của tôi";

  @override
  String get deactivateMyAccountWarning => "Khi bạn tự hủy kích hoạt trên máy tính, mọi thứ bạn có trên máy tính sẽ vẫn còn cho đến khi bạn được kích hoạt lại. Nếu bạn là quản trị viên duy nhất của nhóm, nó sẽ không bị loại.";

  @override
  String get deactivateMyUserInThisTeam => "Hủy kích hoạt tên người dùng của tôi trên máy tính này";

  @override
  String get deactivateMyUserInThisTeamWarning => "Nếu bạn hủy kích hoạt tài khoản của mình, điều này sẽ xảy ra trên tất cả các máy tính, cuộc trò chuyện, tệp, tác vụ và bất kỳ hoạt động nào khác mà bạn đã thực hiện trong Noysi cho đến khi quản trị viên kích hoạt lại bạn.";

  @override
  String get operationConfirmation => "Bạn có chắc chắn về hoạt động này?";

  @override
  String get formatNotSupported => "Định dạng hoặc tiện ích mở rộng này không được Hệ điều hành hỗ trợ";

  @override
  String get invitePrivateGroupLink => "Mời một thành viên vào nhóm bằng liên kết này";

  @override
  String get invalidPhoneNumber => "Số điện thoại không hợp lệ";

  @override
  String get searchByCountryName => "Tìm kiếm theo tên quốc gia hoặc mã quay số";

  @override
  String get kick => "Trục xuất";

  @override
  String get noEvents => "Không có sự kiện, nhiệm vụ hoặc ghi chú cá nhân";

  @override
  String get deleteAll => "Xóa hết";

  @override
  String get enterKeyManually => "Nhập khóa thủ công";

  @override
  String get noysiAuthenticator => "Noysi Trình xác thực";

  @override
  String get qrScanner => "QR";

  @override
  String get otpLabelWarning => "ป้าย OTP เป็นสตริงตัวอักษรและตัวเลขที่ไม่มีช่องว่าง :@.,;()\$% ได้รับอนุญาตด้วย";

  @override
  String get invalidBase32Chars => "อักขระฐาน32 ไม่ถูกต้อง";

  @override
  String get label => "ฉลาก";

  @override
  String get secretCode => "รหัสลับ";

  @override
  String get labelTextWarning => "ได้รับอนุญาตด้วย";

  @override
  String missedCallFrom(String user) => "Cuộc gọi nhỡ từ $user";

  @override
  String get activeItemBackgroundColor => "Nền mục đang hoạt động";

  @override
  String get activeItemTextColor => "Văn bản mục hiện hoạt";

  @override
  String get activePresenceColor => "Hiện diện tích cực";

  @override
  String get adminsCanDeleteMessage => "Quản trị viên có thể xóa tin nhắn";

  @override
  String get allForAdminsOnly => "@all chỉ dành cho Quản trị viên";

  @override
  String get channelForAdminsOnly => "@channel chỉ dành cho Quản trị viên và Người tạo Kênh";

  @override
  String get chooseTheme => "Chọn một chủ đề cho nhóm của bạn";

  @override
  String get enablePushAllChannels => "Bật thông báo đẩy trên tất cả các kênh";

  @override
  String get inactivePresenceColor => "Sự hiện diện không hoạt động";

  @override
  String get leaveTeam => "Rời khỏi đội này";

  @override
  String get leaveTeamWarning => "Khi bạn rời khỏi một đội, mọi thứ bạn sở hữu trong đội đó sẽ bị xóa. Nếu bạn là quản trị viên nhóm duy nhất, nhóm sẽ bị xóa.";

  @override
  String get notificationBadgeBackgroundColor => "Nền huy hiệu";

  @override
  String get notificationBadgeTextColor => "Văn bản huy hiệu";

  @override
  String get onlyAdminInvitesAllowed => "Khách chỉ được ủy quyền bởi Quản trị viên";

  @override
  String get reset => "Cài lại";

  @override
  String get settings => "Cài đặt";

  @override
  String get sidebarColor => "Màu thanh bên";

  @override
  String get taskUpdateProtected => "Sửa đổi Công việc dành riêng cho Người sáng tạo và Quản trị viên";

  @override
  String get teamName => "Tên nhóm";

  @override
    String get textColor => "Văn bản màu";

  @override
  String get theme => "Chủ đề";

  @override
  String get updateUsernameBlocked => "Chặn tên người dùng khi gửi lời mời";

  @override
  String get fileNotFound => "Không tìm thấy tệp";

  @override
  String get messageNotFound => "Không tìm thấy tin nhắn, vui lòng kiểm tra xem tin nhắn bạn đang tìm có khả dụng trong nhóm hiện tại hay không.";

  @override
  String get taskNotFound => "Không tìm thấy tác vụ";

  @override
  String userHasPinnedMessage(String name) => "$name đã ghim một tin nhắn vào kênh";

  @override
  String userHasUnpinnedMessage(String name) => "$name đã bỏ ghim tin nhắn khỏi kênh này";

  @override
  String get pinMessage => "Ghim tin nhắn";

  @override
  String get unpinMessage => "Bỏ ghim tin nhắn";

  @override
  String get pinnedMessage => "Tin nhắn đã ghim";

  @override
  String get deleteMyAccount => "Xóa tài khoản của tôi đi";

  @override
  String get yourDeleteRequestIsInProcess => "Yêu cầu xóa tài khoản của bạn đang được xử lý";

  @override
  String get deleteMyAccountWarning => "Nếu bạn xóa tài khoản của mình, hành động này sẽ không thể thay đổi được. Nếu bạn quản lý một nhóm và không có quản trị viên nào khác, nhóm sẽ bị xóa.";

  @override
  String get lifetimeDeal => "Ưu đãi trọn đời";
  @override
  String get showEmails => "Hiển thị email của người dùng";

  @override
  String get showPhoneNumbers => "Hiển thị số điện thoại của người dùng";

  @override
  String get addChannel => "Thêm kênh";

  @override
  String get addPrivateGroup => "Thêm nhóm riêng";

  @override
  String get selectUserFromTeam => "Chọn người dùng từ nhóm này";

  @override
  String get selectUsersFromChannelGroup => "Chọn người dùng từ kênh hoặc nhóm";

  @override
  String get memberDeleted => "Thành viên đã bị xóa";
}

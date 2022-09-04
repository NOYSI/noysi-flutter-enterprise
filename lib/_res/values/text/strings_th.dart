import 'dart:ui';

import 'package:code/_res/values/config.dart';
import 'package:code/_res/values/text/strings_base.dart';

import '../../../data/api/remote/endpoints.dart';
import '../../R.dart';

class StringsTh implements StringsBase {
  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Noysi";

  @override
  String get yourTeams => "ทีมงานของคุณ";

  @override
  String get channel => "ช่อง";

  @override
  String get channels => "ช่อง";

  @override
  String get directMessagesAbr => "DM";

  @override
  String get email => "อีเมล";

  @override
  String get home => "บ้าน";

  @override
  String get member => "สมาชิก";

  @override
  String get administrator => "ผู้ดูแลระบบ";

  @override
  String get guest => "แขก";

  @override
  String get guests => "แขก";

  @override
  String get members => "สมาชิก";

  @override
  String get inactiveMember => "สมาชิกปิดการใช้งาน";

  @override
  String get message => "ข้อความ";

  @override
  String get messages => "ข้อความ";

  @override
  String get password => "รหัสผ่าน";

  @override
  String get register => "ลงชื่อ";

  @override
  String get search => "ค้นหา";

  @override
  String get signIn => "เข้าสู่ระบบ";

  @override
  String get task => "งาน";

  @override
  String get tasks => "งาน";

  @override
  String get createTask => "สร้างงาน";

  @override
  String get newTask => "งานใหม่";

  @override
  String get description => "คำอธิบาย";

  @override
  String get team => "ทีม";

  @override
  String get thread => "เกลียว";

  @override
  String get threads => "กระทู้";

  @override
  String get createTeam => "สร้างทีม";

  @override
  String get confirmIsCorrectEmailAddress => "ใช่! นั่นคืออีเมลที่ถูกต้อง";

  @override
  String get createTeamIntro =>
      "คุณกำลังจะตั้งทีมใหม่ที่ Noysi";

  @override
  String get isCorrectEmailAddress => "นี่เป็นที่อยู่อีเมลที่ถูกต้องหรือไม่";

  @override
  String get welcome => "ยินดีต้อนรับ!";

  @override
  String get invitationSentAt => "คำเชิญของคุณจะถูกส่งไปที่:";

  @override
  String get next => "ถัดไป";

  @override
  String get startNow => "เริ่มเลย!";

  @override
  String get charsRemaining => "ตัวละครที่เหลืออยู่:";

  @override
  String get teamNameOrgCompany =>
      "ป้อนชื่อทีม องค์กร หรือชื่อบริษัทของคุณ";

  @override
  String get teamNameOrgCompanyLabel => "อดีต. ชื่อบริษัทของฉัน";

  @override
  String get yourTeam => "ทีมของคุณ";

  @override
  String get noysiServiceNewsletters =>
      "การรับอีเมล (เป็นครั้งคราว) เกี่ยวกับบริการ NOYSI เป็นเรื่องปกติ";

  @override
  String get userNameIntro =>
      "ชื่อผู้ใช้ของคุณคือลักษณะที่คุณปรากฏต่อผู้อื่นในทีมของคุณ";

  @override
  String get userNameLabel => "อดีต. แอคเคอร์แมน";

  @override
  String get addAnother => "เพิ่มอีกหนึ่ง";

  @override
  String get byProceedingAcceptTerms =>
      "* การดำเนินการต่อแสดงว่าคุณยอมรับ <b>ข้อกำหนดในการให้บริการ</b>";

  @override
  String get invitations => "คำเชิญ";

  @override
  String get invitePeople => "เชิญคน";

  @override
  String get noysiIsTeamWorkInvite =>
      "Noysi เป็นเครื่องมือในการทำงานเป็นทีม เชิญอย่างน้อยหนึ่งคน";

  @override
  String get userName => "ชื่อผู้ใช้";

  @override
  String get fieldMax18 => "สูงสุด 18 ตัวอักษร";

  @override
  String get fieldMax25 => "สูงสุด 25 ตัวอักษร";

  @override
  String get fieldPassword => "ต้องใช้รหัสผ่าน";

  @override
  String get fieldRequired => "ต้องระบุข้อมูล";

  @override
  String get missingEmailFormat => "ผิดอีเมล";

  @override
  String get back => "กลับ";

  @override
  String get channelBrowser => "ช่องเบราว์เซอร์";

  @override
  String get help => "ช่วย";

  @override
  String get preferences => "การตั้งค่า";

  @override
  String get signOutOf => "ออกจากระบบ";

  @override
  String get closed => "ปิด";

  @override
  String get closedMilestone => "ปิด";

  @override
  String get close => "ปิด";

  @override
  String get opened => "เปิดแล้ว";

  @override
  String get chat => "แชท";

  @override
  String get allThreads => "กระทู้ทั้งหมด";

  @override
  String get inviteMorPeople => "เชิญคนเพิ่ม";

  @override
  String get meeting => "การประชุม";

  @override
  String get myFiles => "ไฟล์ของฉัน";

  @override
  String get myTasks => "งานของฉัน";

  @override
  String get myTeams => "ทีมของฉัน";

  @override
  String get openChannels => "เปิดช่อง";

  @override
  String get privateGroups => "กลุ่มส่วนตัว";

  @override
  String get favorites => "รายการโปรด";

  @override
  String get message1x1 => "ข้อความ 1 ถึง 1";

  @override
  String get acceptedTitle => "รับแล้ว";

  @override
  String get date => "วันที่";

  @override
  String get invitationLanguageTitle => "ภาษา";

  @override
  String get invitationMessage => "ข้อความเชิญ";

  @override
  String get revokeInvitation => "เพิกถอนคำเชิญ";

  @override
  String get revoke => "ถอน";

  @override
  String get revokeInvitationWarning =>
      "ระวัง การกระทำนี้ไม่สามารถย้อนกลับได้";

  @override
  String get revokeInvitationDelete => "คำเชิญ ลบ";

  @override
  String get resendInvitationBefore24hrs =>
      "ไม่อนุญาตให้ส่งคำเชิญซ้ำจนกว่าจะผ่านไป 24 ชั่วโมงนับตั้งแต่ส่งครั้งล่าสุด";

  @override
  String get resendInvitationSuccess => "ส่งคำเชิญเรียบร้อยแล้ว";

  @override
  String get resendInvitation => "ส่งคำเชิญอีกครั้ง";

  @override
  String get invitationMessageDefault =>
      "สวัสดี! ที่นี่คุณมีคำเชิญให้เข้าร่วม";

  @override
  String get inviteManyAsOnce => "เชิญมากันเยอะๆนะครับ";

  @override
  String get inviteMemberTitle =>
      "สมาชิกในทีมสามารถเข้าถึงแชนเนลที่เปิด ข้อความแบบตัวต่อตัว และกลุ่มได้อย่างเต็มที่";

  @override
  String get inviteMemberWarningTitle =>
      "ในการเชิญสมาชิกใหม่ คุณต้องเป็นผู้ดูแลทีม";

  @override
  String get inviteNewMemberWarningTitle =>
      "สมาชิกคนใดในทีมสามารถเพิ่มแขกได้ไม่จำกัด";

  @override
  String get inviteSubtitle =>
      "Noysi เป็นเครื่องมือในการทำงานที่ดีขึ้นกับทีมของคุณ เชิญพวกเขาตอนนี้!";

  @override
  String get inviteTitle => "เชิญคนอื่น";

  @override
  String get inviteToAGroup => "เชิญเข้ากลุ่ม (จำเป็น)";

  @override
  String get inviteToAGroupNotRequired => "เชิญเข้าร่วมกลุ่ม (ไม่บังคับ)";

  @override
  String get inviteMemberWarning =>
      "สมาชิกใหม่จะเข้าร่วมช่อง #ทั่วไป โดยอัตโนมัติ คุณยังสามารถเพิ่มพวกเขาในกลุ่มส่วนตัวได้ในขณะนี้";

  @override
  String get inviteToThisTeam => "เชิญเข้าทีมนี้";

  @override
  String get invitationsSent => "ส่งคำเชิญแล้ว";

  @override
  String get name => "ชื่อ";

  @override
  String get noPendingInvitations =>
      "ไม่มีคำเชิญให้ส่งในทีมนี้";

  @override
  String get pendingTitle => "รอดำเนินการ";

  @override
  String get chooseTitle => "เลือก";

  @override
  String get seePendingAcceptedInvitations =>
      "ดูคำเชิญที่รอดำเนินการและตอบรับแล้ว";

  @override
  String get sendInvitations => "ส่งคำเชิญ";

  @override
  String get typeEmail => "พิมพ์อีเมล";

  @override
  String get typeEmailComaSeparated => "พิมพ์อีเมลโดยคั่นด้วยอาการโคม่า";

  @override
  String get atNoysi => "ที่ นอยซี่";

  @override
  String get inviteNewMemberTitle =>
      "แขกไม่ต้องจ่ายเงิน และคุณสามารถเชิญได้มากเท่าที่คุณต้องการ แต่พวกเขาจะสามารถเข้าถึงกลุ่มเดียวภายในทีมนี้";

  @override
  String get invited => "เชิญ";

  @override
  String get thisNameAlreadyExist =>
      "ดูเหมือนว่าชื่อนี้ถูกใช้ไปแล้ว";

  @override
  String get emptyList => "รายการว่าง";

  @override
  String get ok => "ตกลง";

  @override
  String get byNameFirst => "โดยชื่อ A-Z";

  @override
  String get byNameInvertedFirst => "โดยชื่อ Z-A";

  @override
  String get download => "ดาวน์โหลด";

  @override
  String get files => "ไฟล์";

  @override
  String get folders => "โฟลเดอร์";

  @override
  String get newTitle => "ใหม่";

  @override
  String get newestFirst => "ใหม่ล่าสุดก่อน";

  @override
  String get oldestFirst => "เก่าสุดก่อน";

  @override
  String get see => "ดู";

  @override
  String get share => "แบ่งปัน";

  @override
  String get moreInfo => "ข้อมูลมากกว่านี้";

  @override
  String get assigned => "ที่ได้รับมอบหมาย";

  @override
  String get author => "ได้รับ";

  @override
  String get created => "สร้าง";

  @override
  String get earlyDeliverDate => "วันที่จัดส่งก่อนกำหนด";

  @override
  String get farDeliverDate => "วันที่จัดส่งไกล";

  @override
  String get filterAuthor => "กรองตามผู้เขียน";

  @override
  String get searchUsers => "ค้นหาผู้ใช้";

  @override
  String get sort => "เรียงลำดับ";

  @override
  String get sortBy => "เรียงโดย";

  @override
  String get cancel => "ยกเลิก";

  @override
  String get exit => "ทางออก";

  @override
  String get exitWarning => "คุณแน่ใจไหม?";

  @override
  String get deleteChannelWarning =>
      "คุณแน่ใจหรือไม่ว่าต้องการออกจากช่องนี้";

  @override
  String get typeMessage => "พิมพ์ข้อความ...";

  @override
  String get addChannelToFavorites => "เพิ่มในรายการโปรด";

  @override
  String get removeFromFavorites => "ลบออกจากรายการโปรด";

  @override
  String get channelInfo => "ข้อมูลช่อง";

  @override
  String get channelMembers => "สมาชิกช่อง";

  @override
  String get channelPreferences => "การตั้งค่าช่อง";

  @override
  String get closeChatVisibility => "ปิด 1 ถึง 1";

  @override
  String get inviteToGroup => "เชิญสมาชิกมาที่ช่องนี้";

  @override
  String get leaveChannel => "ออกจากช่อง";

  @override
  String get mentions => "กล่าวถึง";

  @override
  String get seeFiles => "ดูไฟล์";

  @override
  String get seeLinks => "ดูลิงค์";

  @override
  String get links => "ลิงค์";

  @override
  String get taskManager => "ผู้จัดการงาน";

  @override
  String get videoCall => "การสนทนาทางวิดีโอ";

  @override
  String get addReaction => "เพิ่มปฏิกิริยา";

  @override
  String get addTag => "เพิ่มแท็ก";

  @override
  String get addMilestone => "เพิ่มเหตุการณ์สำคัญ";

  @override
  String get copyMessage => "คัดลอกข้อความ";

  @override
  String get copyPermanentLink => "คัดลอกลิงค์";

  @override
  String get createThread => "เริ่มกระทู้";

  @override
  String get edit => "แก้ไข";

  @override
  String get favorite => "ที่ชื่นชอบ";

  @override
  String get remove => "ลบ";

  @override
  String get tryAgain => "ลองอีกครั้ง";

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
      "คุณแน่ใจหรือไม่ว่าต้องการลบข้อความนี้ การดำเนินการนี้ไม่สามารถยกเลิกได้";

  @override
  String get deleteMessageTitle => "ลบข้อความ";

  @override
  String get edited => "แก้ไขแล้ว";

  @override
  String get seeAll => "ดูทั้งหมด";

  @override
  String get copiedToClipboard => "คัดลอกไปยังคลิปบอร์ดแล้ว!";

  @override
  String get underConstruction => "อยู่ระหว่างการก่อสร้าง";

  @override
  String get reactions => "ปฏิกิริยา";

  @override
  String get all => "ทั้งหมด";

  @override
  String get users => "ผู้ใช้";

  @override
  String get documents => "เอกสาร";

  @override
  String get fromLocalStorage => "จากที่จัดเก็บในตัวเครื่อง";

  @override
  String get photoGallery => "แกลเลอรี่ภาพ";

  @override
  String get recordVideo => "บันทึกวิดีโอ";

  @override
  String get takePhoto => "ถ่ายรูป";

  @override
  String get useCamera => "จากกล้อง";

  @override
  String get videoGallery => "แกลเลอรี่วิดีโอ";

  @override
  String get changeName => "เปลี่ยนชื่อ";

  @override
  String get createFolder => "สร้างโฟลเดอร์";

  @override
  String get createNameWarning =>
      "ชื่อควรมีอักขระสูงสุด 18 ตัว โดยไม่มีเครื่องหมายวรรคตอน";

  @override
  String get newName => "ชื่อใหม่";

  @override
  String get rename => "เปลี่ยนชื่อ";

  @override
  String get renameFile => "เปลี่ยนชื่อไฟล์";

  @override
  String get renameFolder => "เปลี่ยนชื่อโฟลเดอร์";

  @override
  String get deleteFile => "ลบไฟล์";

  @override
  String get deleteFolder => "ลบโฟลเดอร์";

  @override
  String get deleteFileWarning => "โฟลเดอร์จะถูกลบอย่างถาวรและไม่สามารถกู้คืนได้ โฟลเดอร์นี้จะไม่สามารถเข้าถึงได้จากลิงก์ใดๆ";

  @override
  String get delete => "ลบ";

  @override
  String get open => "เปิด";

  @override
  String get addCommentOptional => "เพิ่มความคิดเห็น (ไม่บังคับ)";

  @override
  String get shareFile => "แชร์ไฟล์";

  @override
  String get groups => "กลุ่ม";

  @override
  String get to1_1 => "1 ถึง 1";

  @override
  String get day => "วัน";

  @override
  String get days => "วัน";

  @override
  String get hour => "ชั่วโมง";

  @override
  String get hours => "ชั่วโมง";

  @override
  String get minute => "นาที";

  @override
  String get minutes => "นาที";

  @override
  String get month => "เดือน";

  @override
  String get months => "เดือน";

  @override
  String get year => "ปี";

  @override
  String get years => "ปีที่";

  @override
  String get by => "โดย";

  @override
  String get deliveryDateIn => "วันครบกำหนดใน";

  @override
  String get ago => "ที่ผ่านมา";

  @override
  String get taskOpened => "เปิดแล้ว";

  @override
  String get assignees => "ผู้ได้รับมอบหมาย";

  @override
  String get assigneeBy => "ได้รับมอบหมายโดย";

  @override
  String get closeTask => "ปิดงาน";

  @override
  String get comment => "ความคิดเห็น";

  @override
  String get deliveryDate => "วันครบกำหนด";

  @override
  String get leaveAComment => "ทิ้งข้อความไว้";

  @override
  String get milestone => "เหตุการณ์สำคัญ";

  @override
  String get milestones => "เหตุการณ์สำคัญ";

  @override
  String get color => "สี";

  @override
  String get milestoneAdded => "เพิ่มไปยังเหตุการณ์สำคัญ";

  @override
  String get participants => "ผู้เข้าร่วม";

  @override
  String get reopen => "เปิดใหม่";

  @override
  String get completed => "สมบูรณ์";

  @override
  String get dueDateUpdated => "วันที่ครบกำหนดอัพเดท";

  @override
  String get dueDate => "วันครบกำหนด";

  @override
  String get lastDueDate => "วันที่ครบกำหนดล่าสุด";

  @override
  String get commented => "แสดงความคิดเห็น";

  @override
  String get tagAdded => "เพิ่มแท็กแล้ว";

  @override
  String get tagRemoved => "แท็กถูกลบ";

  @override
  String get tags => "แท็ก";

  @override
  String get update => "อัปเดต";

  @override
  String get details => "รายละเอียด";

  @override
  String get timeline => "เส้นเวลา";

  @override
  String get aboutMe => "เกี่ยวกับฉัน";

  @override
  String get acceptNews => "รับข่าวสาร";

  @override
  String get allActive => "ใช้งานอยู่ทั้งหมด";

  @override
  String get changePhoto => "เปลี่ยนรูป";

  @override
  String get changeYourPassword => "เปลี่ยนรหัสผ่านของคุณ";

  @override
  String get changeYourPasswordAdvice =>
      "รหัสผ่านต้องมีอักขระอย่างน้อยแปดตัวรวมทั้งตัวเลข, ตัวพิมพ์ใหญ่และตัวพิมพ์เล็ก คุณสามารถใช้อักขระพิเศษเช่น @#\$%^&+= และอักขระสิบตัวขึ้นไปเพื่อเพิ่มความปลอดภัยให้กับรหัสผ่านของคุณ";

  @override
  String get charge => "ค่าใช้จ่าย";

  @override
  String get country => "ประเทศ";

  @override
  String get disabled => "พิการ";

  @override
  String get emailNotification => "การแจ้งเตือนทางอีเมล";

  @override
  String get language => "ภาษา";

  @override
  String get lastName => "นามสกุล";

  @override
  String get maxEveryHour => "ทุกชั่วโมง";

  @override
  String get maxHalfDay => "ทุก 12 ชั่วโมง";

  @override
  String get messages1x1AndMentions => "ข้อความ 1x1 และ @พูดถึง";

  @override
  String get myProfile => "ประวัติของฉัน";

  @override
  String get never => "ไม่เคย";

  @override
  String get newPassword => "รหัสผ่านใหม่";

  @override
  String get newsLetters => "จดหมายข่าว";

  @override
  String get notReceiveNews => "ไม่ได้รับข่าวสาร";

  @override
  String get notifications => "การแจ้งเตือน";

  @override
  String get passwordRequirements =>
      "เปลี่ยนรหัสผ่านของคุณเป็นระยะเพื่อเพิ่มความปลอดภัยและการป้องกันของคุณ";

  @override
  String get phoneNotifications => "การแจ้งเตือนทางโทรศัพท์";

  @override
  String get phoneNumber => "หมายเลขโทรศัพท์";

  @override
  String get photoSizeRestrictions =>
      "ใช้รูปภาพสี่เหลี่ยมจัตุรัสที่มีความกว้างสูงสุด 400px(เล็ก)";

  @override
  String get repeatNewPassword => "รหัสผ่านใหม่ซ้ำ";

  @override
  String get security => "ความปลอดภัย";

  @override
  String get skypeUserName => "ผู้ใช้สไกป์";

  @override
  String get sounds => "เสียง";

  @override
  String get yourUserName => "ชื่อผู้ใช้ของคุณ";

  @override
  String get saveChanges => "บันทึกการเปลี่ยนแปลง";

  @override
  String get profileEmailUsesWarning =>
      "อีเมลนี้ใช้สำหรับการแจ้งเตือนในทีมนี้เท่านั้น";

  @override
  String get pushMobileNotifications => "ผลักดันการแจ้งเตือนมือถือ";

  @override
  String get saveNotificationChanges => "บันทึกการเปลี่ยนแปลงการแจ้งเตือน";

  @override
  String get updatePassword => "อัพเดทรหัสผ่าน";

  @override
  String get updateProfileInfo => "อัปเดตข้อมูลโปรไฟล์";

  @override
  String get password8CharsRequirement =>
      "รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร";

  @override
  String get passwordAtLeast1CapitalLetter =>
      "รหัสผ่านต้องมีตัวพิมพ์ใหญ่อย่างน้อย 1 ตัว";

  @override
  String get passwordAtLeast1LowerCaseLetter =>
      "รหัสผ่านต้องมีตัวพิมพ์เล็กอย่างน้อย 1 ตัว";

  @override
  String get passwordAtLeast1Number =>
      "รหัสผ่านต้องมีอย่างน้อย 1 หมายเลข";

  @override
  String get passwordMustMatch => "รหัสผ่านจะต้องตรงกับ.";

  @override
  String get notificationUpdatedSuccess => "อัปเดตการเปลี่ยนแปลงการแจ้งเตือนแล้ว";

  @override
  String get passwordUpdatedSuccess => "อัปเดตรหัสผ่านแล้ว";

  @override
  String get profileUpdatedSuccess => "อัพเดทโปรไฟล์แล้ว";

  @override
  String get enablePermissions => "เปิดใช้งานการอนุญาต";

  @override
  String get permissionDenied => "เปิดใช้งานการอนุญาต";

  @override
  String get savePreferences => "บันทึกการตั้งค่า";

  @override
  String get turnOffChannelEmails => "ไม่ได้รับอีเมลช่อง";

  @override
  String get turnOffChannelSounds => "ไม่ได้รับอีเมลช่อง";

  @override
  String get chatMessageUnavailable =>
      "ข้อความแชทไม่พร้อมใช้งานสำหรับผู้ใช้รายนี้";

  @override
  String get createChannel => "สร้างช่อง";

  @override
  String get createNewChannel => "สร้างช่องใหม่";

  @override
  String get isTyping => "กำลังพิมพ์...";

  @override
  String get createPrivateGroup => "สร้างกลุ่มส่วนตัว";

  @override
  String get createPrivateGroupWarning =>
      "คุณกำลังจะสร้าง GROUP ใหม่ คุณสามารถเพิ่มคนในกลุ่มนี้หากพวกเขาเป็นส่วนหนึ่งของทีมของคุณอยู่แล้ว ถ้าไม่ ให้สร้างกลุ่มก่อนแล้วเชิญพวกเขาในภายหลัง";

  @override
  String get createNewPrivateGroup => "สร้างกลุ่มส่วนตัวใหม่";

  @override
  String get createNewChannelAction =>
      "คุณกำลังจะสร้างช่องเปิดใหม่";

  @override
  String get createNewChannelForAdminsOnly => "เฉพาะผู้ดูแลระบบเท่านั้นที่เข้าถึงการเขียน";

  @override
  String get openChannelAllMemberAccess => "สมาชิกในทีมทุกคนมีสิทธิ์อ่าน";

  @override
  String get and => "และ";

  @override
  String get userIsInactiveToChat =>
      "คุณไม่สามารถแชทกับผู้ใช้รายนี้เนื่องจากไม่ได้ใช้งาน";

  @override
  String get selectChannel => "เลือกช่อง";

  @override
  String get needToSelectChannel => "คุณต้องเลือกช่อง";

  @override
  String get fileAlreadyShared =>
      "มีการแชร์ไฟล์นี้โดยใช้ชื่อเดียวกันในช่องที่คุณเลือก";

  @override
  String get inChannel => "ในช่อง";

  @override
  String seeAnswerMessages(int count) => "ดู $count ข้อความ";

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
    return "ผู้ใช้ $name ได้เข้าร่วมช่อง";
  }

  @override
  String userHasLeft(String name) {
    return "ผู้ใช้ $name ได้ออกจากช่อง";
  }

  @override
  String invitedBy(String name) {
    return "ได้รับเชิญจาก $name";
  }

  @override
  String get answers => "คำตอบ";

  @override
  String get publishIn => "เผยแพร่ใน";

  @override
  String get hasCommentedOnThread => "ได้แสดงความคิดเห็นในกระทู้:";

  @override
  String get unReadMessages => "ข้อความที่ยังไม่ได้อ่าน";

  @override
  String get hasAddedTag => "ได้เพิ่มแท็ก";

  @override
  String get hasAssignedUser => "ได้มอบหมายให้ผู้ใช้";

  @override
  String get hasClosedTask => "ได้ปิดงาน";

  @override
  String get hasCommentedTask => "ได้เพิ่มความคิดเห็น";

  @override
  String get hasCreatedTask => "ได้สร้างงาน";

  @override
  String get hasCreatedTaskAssignedTo => "ได้สร้างงานใหม่ที่ได้รับมอบหมายให้";

  @override
  String get hasDeleteTag => "ได้ลบแท็ก";

  @override
  String get hasDeletedCommentTask => "ได้ลบความคิดเห็น";

  @override
  String get hasEditedCommentTask => "ได้แก้ไขความคิดเห็น";

  @override
  String get hasEditedTask => "ได้แก้ไขงาน";

  @override
  String get hasRemovedEndDateTask => "ได้ลบวันที่สิ้นสุดของ";

  @override
  String get hasReopenedTask => "ได้เปิดงานอีกครั้ง";

  @override
  String get hasSetMilestone => "ได้กำหนดหลักชัย";

  @override
  String get hasUnAssignedUser => "ได้ยกเลิกการมอบหมายผู้ใช้แล้ว";

  @override
  String get hasUpdatedDateTask => "ได้อัปเดตวันที่สิ้นสุดของ";

  @override
  String get inTheTask => "ในงาน";

  @override
  String get to => "ถึง";

  @override
  String get hasAssignedNewDueDateFor => "ได้กำหนดวันครบกำหนดใหม่สำหรับ";

  @override
  String get createNewTag => "สร้างแท็กใหม่";

  @override
  String get createNewMilestone => "สร้างก้าวใหม่";

  @override
  String get editMilestone => "แก้ไขเหตุการณ์สำคัญ";

  @override
  String get editTag => "แก้ไขแท็ก";

  @override
  String get openTasks => "งานเปิด";

  @override
  String get newPersonalNote => "บันทึกส่วนตัวใหม่";

  @override
  String get createNewPersonalNote => "สร้างบันทึกส่วนตัว";

  @override
  String get filterBy => "กรองโดย";

  @override
  String hereStartsYourMessagesWith(String name) =>
      "Here start your messages with @$name";

  @override
  String thisChannelIsManagedBy(String name) =>
      "ช่องนี้บริหารจัดการโดย @$name, หากต้องการความช่วยเหลือติดต่อผู้ดูแลระบบ.";

  @override
  String newPush(String user, String repository, String repositoryUrl) {
    String part1 = "ดันใหม่ของ";
    String part2 = "ในที่เก็บ";
    String part3 = R.string.viewDetails;

    return "<p>$part1 <span class='link-mention'>@$user</span> $part2 <span><a href='$repositoryUrl'>$repository. $part3</a></span></p>";
  }

  @override
  String unassignedTask(
      String repository,
      String repositoryUrl,
      ) {
    String part1 = "งานที่ไม่ได้มอบหมายในที่เก็บ";
    String part2 = R.string.viewDetails;
    return "<p>$part1 <a href='$repositoryUrl'>$repository. $part2</a></p>";
  }

  @override
  String cardTrelloCreate(
      String board, String boardUrl, String card, String cardUrl, String list) {
    String part1 = "การ์ดที่สร้าง";
    String part2 = "ในรายการ";
    String part3 = "ของกระดาน";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 $list $part3 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloRename(String board, String boardUrl, String oldName,
      String newName, String list) {
    String part1 = "ในรายการ";
    String part2 = "ของกระดาน";
    String part3 = "บัตรถูกเปลี่ยนชื่อ";
    String part4 = "ถึง";
    return "<p>$part1 '$list' $part2 <a href='$boardUrl'>$board</a> $part3 '$oldName' $part4 '$newName'</p>";
  }

  @override
  String cardTrelloDescriptionChange(String board, String boardUrl, String card,
      String cardUrl, String list, String description) {
    String part1 = "การ์ด";
    String part2 = "ของรายการ";
    String part3 = "ของกระดาน";
    String part4 = "ได้เปลี่ยนคำอธิบายเป็น";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4 '$description'</p>";
  }

  @override
  String cardTrelloMoveToOtherList(String board, String boardUrl, String card,
      String cardUrl, String oldList, String newList) {
    String part1 = "การ์ด";
    String part2 = "ถูกย้ายออกจากรายการ";
    String part3 = "ไปที่รายการ";
    String part4= "ในกระดาน";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$oldList' $part3 '$newList' $part4 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloArchive(String board, String boardUrl, String card,
      String cardUrl, String list) {
    String part1 = "การ์ด";
    String part2 = "ของรายการ";
    String part3 = "ของกระดาน";
    String part4 = "ถูกเก็บถาวรแล้ว";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4</p>";
  }

  @override
  String get comments => "ความคิดเห็น";

  @override
  String get addComment => "เพิ่มความเห็น";

  @override
  String get editComment => "แก้ไขความคิดเห็น";

  @override
  String get downloadAppsAndSynchronizer =>
      "<a href = 'https://noysi.com/a/#/downloads'>ดาวน์โหลดแอปทันที!</a>";

  @override
  String get welcomeToNoysiFirstName => "สวัสดี! ยินดีต้อนรับสู่ นอยซี่ คุณชื่ออะไร?";

  @override
  String get welcomeToNoysiTimeout =>
      "คุณยังไม่ได้ตอบฉัน! ต้องการความช่วยเหลือ คลิก <a href='${Endpoint.helpUrl}'>ที่นี่.</a>";

  @override
  String get wrongUsernamePassword => "ชื่อผู้ใช้หรือรหัสผ่านผิด";

  @override
  String get userInUse => "ผู้ใช้รายนี้ถูกใช้งานแล้ว";

  @override
  String get invite => "เชิญชวน";

  @override
  String get groupRequired => "ต้องการกลุ่ม";

  @override
  String get uploading => "กำลังอัพโหลด";

  @override
  String get downloading => "Downloading";

  @override
  String get inviteGuestsWarning => "แขกเข้าร่วมกลุ่มเดียวเท่านั้นในทีมนี้";

  @override
  String get addMembers => "เพิ่มสมาชิก";

  @override
  String get enterEmailsByComma =>
      "ป้อนอีเมลโดยคั่นด้วยเครื่องหมายจุลภาค:";

  @override
  String get firstName => "ชื่อจริง";

  @override
  String get inviteFewMorePersonal => "เชิญสักสองสามคนและเป็นส่วนตัวมากขึ้น";

  @override
  String get inviteManyAtOnce => "เชิญหลายคนพร้อมกัน";

  @override
  String get addGuests => "เพิ่มแขก";

  @override
  String get followThread => "ติดตามกระทู้นี้ครับ";

  @override
  String get markThreadAsRead => "ทำเครื่องหมายว่าอ่านแล้ว";

  @override
  String get stopFollowingThread => "เลิกติดตามกระทู้นี้";

  @override
  String get needToVerifyAccountToInvite =>
      "คุณต้องยืนยันบัญชีอีเมลเพื่อเชิญสมาชิก";

  @override
  String get createANewTeam => "สร้างทีมใหม่";

  @override
  String get createNewTeam => "สร้างทีมใหม่!";

  @override
  String get enterIntoYourAccount => "เข้าสู่บัญชีของคุณ";

  @override
  String get forgotPassword => "ลืมรหัสผ่านหรือไม่?";

  @override
  String get goAhead => "ไปข้างหน้า!";

  @override
  String get passwordRestriction => "รหัสผ่านต้องมีอักขระอย่างน้อยแปดตัวรวมทั้งตัวเลข ตัวพิมพ์ใหญ่ และตัวพิมพ์เล็ก คุณสามารถใช้อักขระพิเศษเช่น @ # \$% ^ & + = และอักขระสิบตัวขึ้นไปเพื่อปรับปรุงความปลอดภัยของรหัสผ่านของคุณ";

  @override
  String get recoverYorPassword => "กู้คืนรหัสผ่านของคุณ";

  @override
  String get recoverYorPasswordWarning => "หากต้องการกู้คืนรหัสผ่าน ให้ป้อนที่อยู่อีเมลที่คุณใช้ลงชื่อเข้าใช้ noysi.com";

  @override
  String recoverPasswordResponse(String email) {
    return "เราได้ส่งอีเมลถึงคุณที่ $email";
  }

  @override
  String get recoverPasswordResponse1 =>
      "ตรวจสอบกล่องจดหมายของคุณและทำตามคำแนะนำเพื่อสร้างรหัสผ่านใหม่ของคุณ";

  @override
  String get continueStr => "ดำเนินการต่อ";

  @override
  String get passwordAtLeast1SpecialChar => "รหัสผ่านต้องมีอักขระพิเศษอย่างน้อย 1 ตัว @#\$%^&+=";

  @override
  String welcomeToNoysiLastName(String name) => "สวัสดี $name. คุณนามสกุลอะไร?";

  @override
  String get welcomeToNoysiDescription => "ดีมาก. ทุกอย่างถูกต้อง ฉันจะดำเนินการอัปเดตโปรไฟล์ของคุณ";

  @override
  String get welcomeToNoysiInvite => "<a href = '#'>เชิญสมาชิกในทีมของคุณตอนนี้!</a>";

  @override
  String get activeFilter => "ตัวกรองที่ใช้งาน";

  @override
  String get newFileComment => "ความคิดเห็นใหม่ในไฟล์";

  @override
  String get removed => "ลบออก";

  @override
  String get sharedOn => "แบ่งปันบน";

  @override
  String get notifyAllInThisChannel => "แจ้งทุกท่านในช่องนี้นะครับ";

  @override
  String get notifyAllMembers => "แจ้งสมาชิกทุกท่าน";

  @override
  String get keepPressingToRecord => "กรุณากดปุ่มค้างไว้เพื่อบันทึก";

  @override
  String get slideToCancel => "เลื่อนเพื่อยกเลิก";

  @override
  String get chooseASecurePasswordText => "เลือกรหัสผ่านที่ปลอดภัยที่คุณจำได้";

  @override
  String get confirmPassword => "รหัสผ่านซ้ำ";

  @override
  String get yourPassword => "รหัสผ่าน";

  @override
  String get passwordDontMatch => "รหัสผ่านไม่ตรงกัน";

  @override
  String get changeCreateTeamMail => "ไม่ ฉันต้องการเปลี่ยนอีเมล";

  @override
  String step(int number) => "ขั้นตอน $number";

  @override
  String get user => "ผู้ใช้";

  @override
  String get deleteFolderWarning => "โฟลเดอร์จะถูกลบอย่างถาวรและไม่สามารถกู้คืนได้";

  @override
  String get calendar => "ปฏิทิน";

  @override
  String get week => "สัปดาห์";

  @override
  String get folderIsNotInCurrentTeam => "โฟลเดอร์ไม่เกี่ยวข้องกับทีมปัจจุบัน";

  @override
  String get folderIsNotInAvailableChannel => "โฟลเดอร์ที่อ้างอิงไม่อยู่ในช่องที่มีอยู่ใน file explorer";

  @override
  String get folderLinked => "ลิงก์โฟลเดอร์ในช่อง";

  @override
  String get folderShared => "โฟลเดอร์ถูกแชร์ไปยังช่อง";

  @override
  String get folderUploaded => "อัปโหลดโฟลเดอร์ไปยังช่องแล้ว";

  @override
  String get folderNotFound => "ไม่พบโฟลเดอร์";

  @override
  String get folderNameIncorrect => "ชื่อโฟลเดอร์ไม่ถูกต้อง";

  @override
  String get cloneFolder => "โคลนโฟลเดอร์";

  @override
  String get cloneFolderInfo => "การโคลนโฟลเดอร์จะสร้างโฟลเดอร์ใหม่ในช่องปลายทางที่มีสถานะและเนื้อหาเดียวกันกับโฟลเดอร์ที่เลือกในขณะนี้";

  @override
  String get folderDeleted => "คุณไม่สามารถเข้าถึงโฟลเดอร์ที่ถูกลบ";

  @override
  String get youWereInADeletedFolder => "คุณอยู่ในโฟลเดอร์ที่ถูกลบ";

  @override
  String get dateFormat6 => "MM/dd/yyyy";

  @override
  String get activityZone => "โซนกิจกรรม";

  @override
  String get categories => "หมวดหมู่";

  @override
  String get category => "หมวดหมู่";

  @override
  String get clearAll => "ลบทั้งหมด";

  @override
  String get createdTask => "สร้างงานแล้ว";

  @override
  String get errorFetchingData => "เกิดข้อผิดพลาดในการดึงข้อมูล";

  @override
  String get filters => "ตัวกรอง";

  @override
  String get loggedIn => "เข้าสู่ระบบ";

  @override
  String get mention => "กล่าวถึง";

  @override
  String get messageSent => "ส่งข้อความ";

  @override
  String get messageUnavailable => "ข้อความไม่พร้อมใช้งาน";

  @override
  String get openSessions => "เปิดเซสชั่น";

  @override
  String get taskAssigned => "งานที่มอบหมาย";

  @override
  String get taskUnassigned => "งานที่ยังไม่ได้มอบหมาย";

  @override
  String get uploadedFile => "ไฟล์ที่อัปโหลด";

  @override
  String get uploadedFileFolder => "ไฟล์/โฟลเดอร์ที่อัปโหลด";

  @override
  String get uploadedFolder => "โฟลเดอร์ที่อัปโหลด";

  @override
  String get downloadedFile => "ไฟล์ที่ดาวน์โหลด";

  @override
  String get downloadedFileFolder => "ไฟล์/โฟลเดอร์ที่ดาวน์โหลด";

  @override
  String get downloadedFolder => "โฟลเดอร์ที่ดาวน์โหลด";

  @override
  String activityFileFolderUploadedDownloaded(String user, String name, String channel, {bool download = false, bool isDirect = false, isFolder = false}) {
    String part1 = "คุณมี ${download ? "ดาวน์โหลด" : "อัพโหลดแล้ว"}${isFolder ? " แฟ้ม " : " ไฟล์ "}";
    String part2 = download ? "จากช่อง" : "ทางช่อง";
    return "$part1 <i class=\"mention-generic\">$name</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMentioned(String user, String channel, {bool isDirect = false}) {
    String part1 = "มีคนพูดถึงคุณในช่อง";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMessageSent(String user, String channel, {bool isDirect = false}) {
    String part1 = "คุณได้ส่งข้อความในช่อง";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activitySignedIn(String sessionInfo, String ip) {
    return "คุณได้เข้าสู่ระบบ <i class=\"mention-generic\">$sessionInfo</i> IP: <i class=\"mention-generic\">$ip</i>";
  }

  @override
  String activityTaskAssigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "คุณได้รับมอบหมายให้ทำงาน";
    String part2 = "ทางช่อง";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskCreated(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "คุณได้สร้างงาน";
    String part2 = "ทางช่อง";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskUnassigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "คุณได้รับการจัดสรรคืนจากภารกิจ";
    String part2 = "ทางช่อง";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String get activityZoneHeader => "ที่นี่เริ่มโซนกิจกรรม";

  @override
  String get selectEvent => "เลือกกิจกรรม";

  @override
  String get googleCalendar => "Google";

  @override
  String get outlookCalendar => "Outlook";

  @override
  String get noysiCalendar => "Noysi";

  @override
  String get autogenerateRoomNameQuestion => "คุณต้องการสร้างชื่อห้องโดยอัตโนมัติหรือไม่?";

  @override
  String get createMeetingEvent => "สร้างงานประชุม";

  @override
  String get externalGuests => "แขกภายนอก";

  @override
  String get internalGuests => "แขกภายใน";

  @override
  String get newMeetingEvent => "งานประชุมใหม่";

  @override
  String get roomName => "ชื่อห้อง";

  @override
  String get eventMeeting => "งานประชุม";

  @override
  String get personalNote => "บันทึกส่วนตัว";

  @override
  String get updateExternalGuests => "อัพเดทแขกภายนอก";

  @override
  String get nameTextWarning => "ข้อความแบบสตริงตัวอักษรและตัวเลข 1-25 อักขระ คุณยังสามารถใช้ช่องว่างและอักขระ _ -";

  @override
  String get nameTextWarningWithoutSpaces => "ข้อความสอดคล้องกับสตริงตัวอักษรและตัวเลข 1-18 อักขระโดยไม่มีช่องว่าง คุณยังสามารถใช้ตัวอักษร _ -";

  @override
  String get today => "วันนี้";

  @override
  String get location => "วันนี้";

  @override
  String get sessions => "เซสชั่น";

  @override
  String get appVersion => "เวอร์ชันแอป";

  @override
  String get browser => "เบราว์เซอร์";

  @override
  String get device => "อุปกรณ์";

  @override
  String get logout => "ออกจากระบบ";

  @override
  String get manufacturer => "ผู้ผลิต";

  @override
  String get no => "ไม่";

  @override
  String get operativeSystem => "ระบบปฏิบัติการ";

  @override
  String get yes => "ใช่";

  @override
  String get allDay => "ทั้งวัน";

  @override
  String get endDate => "วันที่สิ้นสุด";

  @override
  String get noTitle => "ที่ดิน";

  @override
  String get currentSession => "เซสชั่นปัจจุบัน";

  @override
  String get logOutAllExceptForThisOne => "ออกจากระบบอุปกรณ์ทั้งหมดยกเว้นเครื่องนี้";

  @override
  String get terminateAllOtherSessions => "ยุติเซสชันอื่นๆ ทั้งหมด";

  @override
  String get closeAllSessionsConfirmation => "คุณต้องการยุติเซสชันอื่นๆ ทั้งหมดหรือไม่";

  @override
  String get closeSessionConfirmation => "คุณต้องการยุติเซสชั่นหรือไม่?";

  @override
  String get connectionLost => "อ๊ะ ดูเหมือนว่าจะไม่มีการเชื่อมต่อ";

  @override
  String get connectionEstablished => "คุณกลับมาออนไลน์อีกครั้ง";

  @override
  String get connectionStatus => "สถานะการเชื่อมต่อ";

  @override
  String get anUserIsCalling => "มีผู้ใช้โทรหาคุณ...";

  @override
  String get answer => "ตอบ";

  @override
  String get hangDown => "วางสาย";

  @override
  String get incomingCall => "สายเรียกเข้า";

  @override
  String isCallingYou(String user) => "$user กำลังโทรหาคุณ...";

  @override
  String get callCouldNotBeInitialized => "ไม่สามารถเริ่มต้นการโทรได้";

  @override
  String get sentMessages => "ส่งข้อความ";

  @override
  String sentMessagesCount(String count) => "$count จาก 10000";

  @override
  String get teamDataUsage => "การใช้ข้อมูลทีม";

  @override
  String get usedStorage => "ที่เก็บข้อมูลที่ใช้แล้วe";

  @override
  String usedStorageText(String used) => used + "GB 5GB";

  @override
  String get userDataUsage => "การใช้ข้อมูลผู้ใช้";

  @override
  String get audioEnabled => "เปิดใช้งานเสียง";

  @override
  String get meetingOptions => "ตัวเลือกการประชุม";

  @override
  String get videoEnabled => "เปิดใช้งานวิดีโอ";

  @override
  String get dontShowThisMessage => "ไม่ต้องแสดงอีก";

  @override
  String get showDialogEveryTime => "แสดงกล่องโต้ตอบทุกครั้งที่เริ่มการประชุม";

  @override
  String get micAndCameraRequiredAlert => "ต้องมีการอนุญาตการเข้าถึงกล้องและไมโครโฟน โปรดตรวจสอบให้แน่ใจว่าคุณได้ให้สิทธิ์ที่จำเป็นแล้ว คุณต้องการไปที่การตั้งค่าการอนุญาตหรือไม่?";

  @override
  String get connectWith => "เข้าสู่ระบบด้วย";

  @override
  String get or => "หรือ";

  @override
  String get viewDetails => "ดูรายละเอียด";

  @override
  String zendeskTicketUpdated(String user, String status, String type, String title, String url) {
    String part1 = R.string.user;
    String part2 = "อัพเดทตั๋ว";
    String part3 = "ประเภท";
    String part4 = "สู่สถานะ";
    String part5 = R.string.viewDetails;
    return "<p>$part1 '$user' $part2 '$title' $part3 '$type' $part4 '$status'. <span><a href='$url'>$part5</a></span></p>";
  }

  @override
  String get accept => "ยอมรับ";

  @override
  String get busy => "ยุ่ง";

  @override
  String get configuration => "การกำหนดค่า";

  @override
  String get downloads => "ดาวน์โหลด";

  @override
  String get editTeam => "แก้ไขทีม";

  @override
  String get general => "ทั่วไป";

  @override
  String get integrations => "บูรณาการ";

  @override
  String get noRecents => "ไม่มีล่าสุด";

  @override
  String get noRecommendations => "ไม่มีคำแนะนำ";

  @override
  String get inAMeeting => "อยู่ระหว่างประชุม";

  @override
  String get onFire => "ไฟไหม้";

  @override
  String get plans => "แผน";

  @override
  String get setAStatus => "ตั้งสถานะ";

  @override
  String get sick => "ป่วย";

  @override
  String get signOut => "ออกจากระบบ";

  @override
  String get suggestions => "ข้อเสนอแนะ";

  @override
  String get teams => "ทีม";

  @override
  String get traveling => "การเดินทาง";

  @override
  String get whatsYourStatus => "สถานะของคุณคืออะไร?";

  @override
  String get sendAlwaysAPush => "ส่งการแจ้งเตือนแบบพุชเสมอ";

  @override
  String get robot => "หุ่นยนต์";

  @override
  String get deactivateUserWarning => "สมาชิกในทีมจะไม่สามารถสื่อสารกับสมาชิกในขณะที่ปิดการใช้งาน อย่างไรก็ตาม กิจกรรมทั้งหมดที่ดำเนินการโดยสมาชิกที่ปิดใช้งานใน Noysi จะยังคงเหมือนเดิมและข้อความ (ช่องเปิด, ข้อความ 1 ต่อ 1 และกลุ่มส่วนตัว) ไฟล์และงานต่างๆ จะสามารถเข้าถึงได้";

  @override
  String get activateUserWarning => "เมื่อสมาชิกถูกเปิดใช้งานอีกครั้ง เขาจะกู้คืนการเข้าถึงช่องทาง กลุ่ม ไฟล์ และงานเดิมที่เขามีก่อนที่จะถูกปิดใช้งาน";

  @override
  String get changeRole => "เปลี่ยนบทบาท";

  @override
  String get userStatus => "สถานะผู้ใช้";

  @override
  String get deactivateMyAccount => "ปิดการใช้งานบัญชีของฉัน";

  @override
  String get deactivateMyAccountWarning => "หากคุณปิดใช้งานบัญชี คุณจะปิดการใช้งานในทีม การสนทนา ไฟล์ งาน และกิจกรรมทั้งหมดที่คุณจัดการผ่าน Noysi จนกว่าผู้ดูแลระบบจะเปิดใช้งานคุณอีกครั้ง";

  @override
  String get deactivateMyUserInThisTeam => "ปิดการใช้งานผู้ใช้ของฉันในทีมนี้";

  @override
  String get deactivateMyUserInThisTeamWarning => "เมื่อคุณปิดการใช้งานตัวเองในทีม ทุกสิ่งที่คุณเป็นเจ้าของในทีมนั้นจะยังคงอยู่จนกว่าคุณจะเปิดใช้งานอีกครั้ง หากคุณเป็นผู้ดูแลทีมเพียงคนเดียว ทีมจะไม่ถูกลบ";

  @override
  String get operationConfirmation => "คุณแน่ใจในการดำเนินการนี้หรือไม่?";

  @override
  String get formatNotSupported => "รูปแบบหรือส่วนขยายนี้ไม่ได้รับการสนับสนุนโดยระบบปฏิบัติการ";

  @override
  String get invitePrivateGroupLink => "เชิญสมาชิกเข้ากลุ่มโดยใช้ลิงค์นี้";

  @override
  String get invalidPhoneNumber => "หมายเลขโทรศัพท์ไม่ถูกต้อง";

  @override
  String get searchByCountryName => "ค้นหาตามชื่อประเทศหรือรหัสโทรศัพท์";

  @override
  String get kick => "เตะ";

  @override
  String get noEvents => "ไม่มีกิจกรรม งาน หรือบันทึกส่วนตัว";

  @override
  String get deleteAll => "ลบทั้งหมด";

  @override
  String get enterKeyManually => "ป้อนคีย์ด้วยตนเอง";

  @override
  String get noysiAuthenticator => "Noysi ตัวตรวจสอบสิทธิ์";

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
  String get labelTextWarning => "ป้ายกำกับว่างเปล่า โปรดตรวจสอบค่านี้";

  @override
  String missedCallFrom(String user) => "สายที่ไม่ได้รับจาก $user";

  @override
  String get activeItemBackgroundColor => "พื้นหลังรายการที่ใช้งานอยู่";

  @override
  String get activeItemTextColor => "ข้อความรายการที่ใช้งานอยู่";

  @override
  String get activePresenceColor => "การแสดงตนที่ใช้งานอยู่";

  @override
  String get adminsCanDeleteMessage => "แอดมินสามารถลบข้อความได้";

  @override
  String get allForAdminsOnly => "@all สำหรับผู้ดูแลระบบเท่านั้น";

  @override
  String get channelForAdminsOnly => "@channel สำหรับผู้ดูแลระบบและผู้สร้างช่องเท่านั้น";

  @override
  String get chooseTheme => "เลือกธีมสำหรับทีมของคุณ";

  @override
  String get enablePushAllChannels => "เปิดใช้งานการแจ้งเตือนแบบพุชในทุกช่อง";

  @override
  String get inactivePresenceColor => "การแสดงตนที่ไม่ใช้งาน";

  @override
  String get leaveTeam => "ออกจากทีมนี้";

  @override
  String get leaveTeamWarning => "เมื่อคุณออกจากทีม ทุกสิ่งที่คุณเป็นเจ้าของในทีมนั้นจะถูกลบออก หากคุณเป็นผู้ดูแลทีมเพียงคนเดียว ทีมจะถูกลบ";

  @override
  String get notificationBadgeBackgroundColor => "พื้นหลังป้าย";

  @override
  String get notificationBadgeTextColor => "ป้ายข้อความ";

  @override
  String get onlyAdminInvitesAllowed => "แขกที่ได้รับอนุญาตจากผู้ดูแลระบบเท่านั้น";

  @override
  String get reset => "รีเซ็ต";

  @override
  String get settings => "การตั้งค่า";

  @override
  String get sidebarColor => "สีแถบด้านข้าง";

  @override
  String get taskUpdateProtected => "การปรับเปลี่ยนงานที่สงวนไว้สำหรับผู้สร้างและผู้ดูแลระบบ";

  @override
  String get teamName => "ชื่อทีม";

  @override
  String get textColor => "สีข้อความ";

  @override
  String get theme => "ธีม";

  @override
  String get updateUsernameBlocked => "บล็อกชื่อผู้ใช้เมื่อส่งคำเชิญ";

  @override
  String get fileNotFound => "ไม่พบไฟล์";

  @override
  String get messageNotFound => "ไม่พบข้อความ โปรดตรวจสอบว่าข้อความที่คุณกำลังมองหามีอยู่ในทีมปัจจุบันหรือไม่";

  @override
  String get taskNotFound => "ไม่พบงาน";

  @override
  String userHasPinnedMessage(String name) => "$name ได้ปักข้อความไว้ที่ช่อง";

  @override
  String userHasUnpinnedMessage(String name) => "$name ได้เลิกตรึงข้อความจากช่องนี้แล้ว";

  @override
  String get pinMessage => "ปักหมุดข้อความ";

  @override
  String get unpinMessage => "เลิกตรึงข้อความ";

  @override
  String get pinnedMessage => "ปักหมุดข้อความ";

  @override
  String get deleteMyAccount => "คำขอลบบัญชีของคุณอยู่ในระหว่างดำเนินการ";

  @override
  String get yourDeleteRequestIsInProcess => "คำขอลบบัญชีของคุณอยู่ในระหว่างดำเนินการ";

  @override
  String get deleteMyAccountWarning => "หากคุณลบบัญชีของคุณ การดำเนินการจะไม่สามารถย้อนกลับได้ หากคุณจัดการทีมและไม่มีผู้ดูแลระบบอื่น ทีมจะถูกลบ";

  @override
  String get lifetimeDeal => "ข้อเสนอตลอดชีพ";

  @override
  String get showEmails => "แสดงอีเมลผู้ใช้";

  @override
  String get showPhoneNumbers => "แสดงหมายเลขโทรศัพท์ของผู้ใช้";

  @override
  String get addChannel => "เพิ่มช่อง";

  @override
  String get addPrivateGroup => "เพิ่มกลุ่มส่วนตัว";

  @override
  String get selectUserFromTeam => "เลือกผู้ใช้จากทีมนี้";

  @override
  String get selectUsersFromChannelGroup => "เลือกผู้ใช้จากช่องหรือกลุ่ม";

  @override
  String get memberDeleted => "สมาชิกถูกลบ";
}
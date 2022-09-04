import 'dart:ui';
import 'package:code/_res/values/config.dart';
import 'package:code/_res/values/text/strings_base.dart';

import '../../../data/api/remote/endpoints.dart';
import '../../R.dart';

class StringsAr implements StringsBase {
  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Noysi";

  @override
  String get yourTeams => "فرقك";

  @override
  String get channel => "قناة";

  @override
  String get channels => "القنوات";

  @override
  String get directMessagesAbr => "DMs";

  @override
  String get email => "البريد الإلكتروني";

  @override
  String get home => "الصفحة الرئيسية";

  @override
  String get member => "عضو";

  @override
  String get administrator => "مدير";

  @override
  String get guest => "زائر";

  @override
  String get guests => "ضيوف";

  @override
  String get members => "أفراد";

  @override
  String get inactiveMember => "تم إلغاء تنشيط العضو";

  @override
  String get message => "رسالة";

  @override
  String get messages => "الرسائل";

  @override
  String get password => "كلمه السر";

  @override
  String get register => "سجل";

  @override
  String get search => "بحث";

  @override
  String get signIn => "تسجيل الدخول";

  @override
  String get task => "مهمة";

  @override
  String get tasks => "مهام";

  @override
  String get createTask => "إنشاء مهمة";

  @override
  String get newTask => "مهمة جديدة";

  @override
  String get description => "وصف";

  @override
  String get team => "الفريق";

  @override
  String get thread => "مسلك";

  @override
  String get threads => "الخيوط";

  @override
  String get createTeam => "إنشاء فريق";

  @override
  String get confirmIsCorrectEmailAddress =>
      "نعم! هذا هو البريد الإلكتروني الصحيح";

  @override
  String get createTeamIntro => "أنت على وشك تشكيل فريقك الجديد في Noysi.";

  @override
  String get isCorrectEmailAddress =>
      "هل هذا هو عنوان البريد الإلكتروني الصحيح؟";

  @override
  String get welcome => "أهلا بك!";

  @override
  String get invitationSentAt => "سيتم إرسال دعوتك إلى:";

  @override
  String get next => "التالى";

  @override
  String get startNow => "ابدأ الآن!";

  @override
  String get charsRemaining => "الأحرف المتبقية:";

  @override
  String get teamNameOrgCompany => "أدخل اسم الفريق أو المنظمة أو اسم الشركة.";

  @override
  String get teamNameOrgCompanyLabel => "مثال اسم شركتي";

  @override
  String get yourTeam => "فريقك";

  @override
  String get noysiServiceNewsletters =>
      "لا بأس في تلقي رسائل بريد إلكتروني (في بعض الأحيان) حول خدمة NOYSI.";

  @override
  String get userNameIntro =>
      "اسم المستخدم الخاص بك هو كيف تظهر للآخرين في فريقك.";

  @override
  String get userNameLabel => "مثال اكرمان";

  @override
  String get addAnother => "أضف آخر";

  @override
  String get byProceedingAcceptTerms =>
      "* من خلال المتابعة ، فإنك تقبل <b> شروط الخدمات </ b> الخاصة بنا";

  @override
  String get invitations => "الدعوات";

  @override
  String get invitePeople => "ادعو الناس";

  @override
  String get noysiIsTeamWorkInvite =>
      "Noysi هي أداة العمل الجماعي. قم بدعوة شخص واحد على الأقل";

  @override
  String get userName => "اسم المستخدم";

  @override
  String get fieldMax18 => "18 حرفًا كحد أقصى";

  @override
  String get fieldMax25 => "25 حرفًا كحد أقصى";

  @override
  String get fieldPassword => "كلمة المرور مطلوبة";

  @override
  String get fieldRequired => "حقل مطلوب";

  @override
  String get missingEmailFormat => "بريد إلكتروني خاطئ";

  @override
  String get back => "عودة";

  @override
  String get channelBrowser => "متصفح القناة";

  @override
  String get help => "مساعدة";

  @override
  String get preferences => "التفضيلات";

  @override
  String get signOutOf => "الخروج من";

  @override
  String get closed => "مغلق";

  @override
  String get closedMilestone => "مغلق";

  @override
  String get close => "أغلق";

  @override
  String get opened => "افتتح";

  @override
  String get chat => "دردشة";

  @override
  String get allThreads => "كل المواضيع";

  @override
  String get inviteMorPeople => "ادعُ المزيد من الأشخاص";

  @override
  String get meeting => "لقاء";

  @override
  String get myFiles => "ملفاتي";

  @override
  String get myTasks => "مهامي";

  @override
  String get myTeams => "فريقي";

  @override
  String get openChannels => "فتح القنوات";

  @override
  String get privateGroups => "مجموعات خاصة";

  @override
  String get favorites => "المفضلة";

  @override
  String get message1x1 => "الرسائل من 1 إلى 1";

  @override
  String get acceptedTitle => "قبلت";

  @override
  String get date => "تاريخ";

  @override
  String get invitationLanguageTitle => "لغة المصطلح";

  @override
  String get invitationMessage => "رسالة دعوة";

  @override
  String get revokeInvitation => "إبطال الدعوة";

  @override
  String get revoke => "سحب او إبطال";

  @override
  String get revokeInvitationWarning =>
      "توخ الحذر ، هذا الإجراء لا يمكن التراجع عنه";

  @override
  String get revokeInvitationDelete => "حذف الدعوة";

  @override
  String get resendInvitationBefore24hrs =>
      "دعوة إعادة إرسالها غير مسموح بها إلا بعد مرور 24 ساعة على آخر إرسال.";

  @override
  String get resendInvitationSuccess => "تم إرسال الدعوات بنجاح.";

  @override
  String get resendInvitation => "اعادة ارسال الدعوة";

  @override
  String get invitationMessageDefault => "مرحبا! هنا لديك دعوة للانضمام";

  @override
  String get inviteManyAsOnce => "قم بدعوة الكثير مرة واحدة";

  @override
  String get inviteMemberTitle =>
      "يتمتع أعضاء الفريق بحق الوصول الكامل إلى القنوات المفتوحة والرسائل الشخصية والمجموعات.";

  @override
  String get inviteMemberWarningTitle =>
      "لدعوة أعضاء جدد ، يجب أن تكون مسؤول الفريق.";

  @override
  String get inviteNewMemberWarningTitle =>
      "يمكن لأي عضو في الفريق إضافة ضيوف بشكل غير محدود.";

  @override
  String get inviteSubtitle =>
      "Noysi هي أداة للعمل بشكل أفضل مع فريقك. قم بدعوتهم الآن!";

  @override
  String get inviteTitle => "ادعُ أشخاصًا آخرين";

  @override
  String get inviteToAGroup => "دعوة إلى مجموعة (مطلوب)";

  @override
  String get inviteToAGroupNotRequired => "دعوة إلى مجموعة (اختياري)";

  @override
  String get inviteMemberWarning =>
      "سينضم الأعضاء الجدد إلى قناة #general تلقائيًا. اختياريًا ، يمكنك أيضًا إضافتهم إلى مجموعة خاصة الآن.";

  @override
  String get inviteToThisTeam => "قم بدعوة هذا الفريق";

  @override
  String get invitationsSent => "تم إرسال الدعوات";

  @override
  String get name => "اسم";

  @override
  String get noPendingInvitations => "لا توجد دعوات لإرسالها في هذا الفريق.";

  @override
  String get pendingTitle => "قيد الانتظار";

  @override
  String get chooseTitle => "أختر";

  @override
  String get seePendingAcceptedInvitations => "انظر الدعوات المعلقة والمقبولة";

  @override
  String get sendInvitations => "يرسل دعوات";

  @override
  String get typeEmail => "اكتب بريدًا إلكترونيًا";

  @override
  String get typeEmailComaSeparated =>
      "اكتب رسائل البريد الإلكتروني بغيبوبة مفصولة";

  @override
  String get atNoysi => "في Noysi";

  @override
  String get inviteNewMemberTitle =>
      "لا يقوم الضيوف بالدفع ويمكنك دعوة أي عدد تريده ، لكن سيكون لهم حق الوصول إلى مجموعة واحدة فقط داخل هذا الفريق.";

  @override
  String get invited => "مدعو";

  @override
  String get thisNameAlreadyExist => "يبدو أن هذا الاسم قيد الاستخدام بالفعل.";

  @override
  String get emptyList => "قائمة فارغة";

  @override
  String get ok => "حسنا";

  @override
  String get byNameFirst => "بالاسم أ-ي";

  @override
  String get byNameInvertedFirst => "بالاسم Z-A";

  @override
  String get download => "تحميل";

  @override
  String get files => "الملفات";

  @override
  String get folders => "المجلدات";

  @override
  String get newTitle => "جديد";

  @override
  String get newestFirst => "الأحدث أولاً";

  @override
  String get oldestFirst => "الأقدم أولا";

  @override
  String get see => "نرى";

  @override
  String get share => "شارك";

  @override
  String get moreInfo => "معلومات اكثر";

  @override
  String get assigned => "تعيين";

  @override
  String get author => "مؤلف";

  @override
  String get created => "خلقت";

  @override
  String get earlyDeliverDate => "تاريخ التسليم المبكر";

  @override
  String get farDeliverDate => "تاريخ التسليم البعيد";

  @override
  String get filterAuthor => "تصفية حسب المؤلف";

  @override
  String get searchUsers => "بحث المستخدمين";

  @override
  String get sort => "فرز";

  @override
  String get sortBy => "ترتيب حسب";

  @override
  String get cancel => "إلغاء";

  @override
  String get exit => "خروج";

  @override
  String get exitWarning => "هل أنت واثق؟";

  @override
  String get deleteChannelWarning => "هل أنت متأكد أنك تريد مغادرة هذه القناة؟";

  @override
  String get typeMessage => "اكتب رسالة ...";

  @override
  String get addChannelToFavorites => "اضافة الى المفضلة";

  @override
  String get removeFromFavorites => "إزالة من المفضلة";

  @override
  String get channelInfo => "معلومات القناة";

  @override
  String get channelMembers => "أعضاء القناة";

  @override
  String get channelPreferences => "تفضيلات القناة";

  @override
  String get closeChatVisibility => "أغلق 1 إلى 1";

  @override
  String get inviteToGroup => "دعوة عضو لهذه القناة";

  @override
  String get leaveChannel => "اترك القناة";

  @override
  String get mentions => "يذكر";

  @override
  String get seeFiles => "انظر الملفات";

  @override
  String get seeLinks => "انظر الروابط";

  @override
  String get links => "الروابط";

  @override
  String get taskManager => "مدير المهام";

  @override
  String get videoCall => "مكالمة فيديو";

  @override
  String get addReaction => "أضف رد فعل";

  @override
  String get addTag => "إضافة علامة";

  @override
  String get addMilestone => "أضف معلمًا";

  @override
  String get copyMessage => "نسخ الرسالة";

  @override
  String get copyPermanentLink => "انسخ الرابط";

  @override
  String get createThread => "ابدأ موضوع";

  @override
  String get edit => "تعديل";

  @override
  String get favorite => "مفضل";

  @override
  String get remove => "إزالة";

  @override
  String get tryAgain => "حاول مرة أخري";

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
  String get deleteMessageContent =>
      "هل أنت متأكد أنك تريد حذف هذه الرسالة؟ هذا لا يمكن التراجع عنها.";

  @override
  String get deleteMessageTitle => "حذف رسالة";

  @override
  String get edited => "تم تحريره";

  @override
  String get seeAll => "اظهار الكل";

  @override
  String get copiedToClipboard => "نسخ إلى الحافظة!";

  @override
  String get underConstruction => "تحت التشيد";

  @override
  String get reactions => "تفاعلات";

  @override
  String get all => "الكل";

  @override
  String get users => "المستخدمون";

  @override
  String get documents => "مستندات";

  @override
  String get fromLocalStorage => "من التخزين المحلي";

  @override
  String get photoGallery => "معرض الصور";

  @override
  String get recordVideo => "سجل فيديو";

  @override
  String get takePhoto => "التقاط صورة";

  @override
  String get useCamera => "من الكاميرا";

  @override
  String get videoGallery => "معرض الفيديو";

  @override
  String get changeName => "تغيير الإسم";

  @override
  String get createFolder => "أنشئ مجلد";

  @override
  String get createNameWarning =>
      "يجب ألا يزيد عدد أحرف الأسماء عن 18 حرفًا بدون علامات الترقيم.";

  @override
  String get newName => "اسم جديد";

  @override
  String get rename => "إعادة تسمية";

  @override
  String get renameFile => "إعادة تسمية الملف";

  @override
  String get renameFolder => "إعادة تسمية المجلد";

  @override
  String get deleteFile => "حذف ملف";

  @override
  String get deleteFolder => "احذف المجلد";

  @override
  String get deleteFileWarning => "سيتم حذف المجلد نهائيًا ولا يمكن استعادته. لن يمكن الوصول إلى المجلد من أي رابط.";

  @override
  String get delete => "حذف";

  @override
  String get open => "افتح";

  @override
  String get addCommentOptional => "أضف تعليق (اختياري)";

  @override
  String get shareFile => "مشاركة الملفات";

  @override
  String get groups => "مجموعات";

  @override
  String get to1_1 => "1 إلى 1";

  @override
  String get day => "يوم";

  @override
  String get days => "أيام";

  @override
  String get hour => "ساعة";

  @override
  String get hours => "ساعات";

  @override
  String get minute => "دقيقة";

  @override
  String get minutes => "الدقائق";

  @override
  String get month => "شهر";

  @override
  String get months => "الشهور";

  @override
  String get year => "عام";

  @override
  String get years => "سنوات";

  @override
  String get by => "بواسطة";

  @override
  String get deliveryDateIn => "تاريخ الاستحقاق في";

  @override
  String get ago => "منذ";

  @override
  String get taskOpened => "افتتح";

  @override
  String get assignees => "المعينون";

  @override
  String get assigneeBy => "عين من";

  @override
  String get closeTask => "وثيقة مهمة";

  @override
  String get comment => "تعليق";

  @override
  String get deliveryDate => "تاريخ الاستحقاق";

  @override
  String get leaveAComment => "اترك تعليقا";

  @override
  String get milestone => "معلما";

  @override
  String get milestones => "معالم";

  @override
  String get color => "اللون";

  @override
  String get milestoneAdded => "يضاف إلى الإنجاز";

  @override
  String get participants => "المشاركين";

  @override
  String get reopen => "أعد فتح";

  @override
  String get completed => "منجز";

  @override
  String get dueDateUpdated => "تم تحديث تاريخ الاستحقاق";

  @override
  String get dueDate => "تاريخ الاستحقاق";

  @override
  String get lastDueDate => "تاريخ آخر استحقاق";

  @override
  String get commented => "علق";

  @override
  String get tagAdded => "تمت إضافة العلامة";

  @override
  String get tagRemoved => "تمت إزالة العلامة";

  @override
  String get tags => "العلامات";

  @override
  String get update => "تحديث";

  @override
  String get details => "تفاصيل";

  @override
  String get timeline => "الجدول الزمني";

  @override
  String get aboutMe => "عني";

  @override
  String get acceptNews => "تلقي الأخبار";

  @override
  String get allActive => "كل نشط";

  @override
  String get changePhoto => "غير الصوره";

  @override
  String get changeYourPassword => "غير كلمة المرور الخاصة بك";

  @override
  String get changeYourPasswordAdvice =>
      "يجب أن تحتوي كلمة المرور على ثمانية أحرف على الأقل بما في ذلك رقم وحرف كبير وحرف صغير ، ويمكنك استخدام أحرف خاصة مثل @ # \$٪ ^ & + = وعشرة أحرف أو أكثر لتحسين أمان كلمة المرور الخاصة بك";

  @override
  String get charge => "الشحنة";

  @override
  String get country => "بلد";

  @override
  String get disabled => "معاق";

  @override
  String get emailNotification => "اشعارات البريد الالكتروني";

  @override
  String get language => "لغة";

  @override
  String get lastName => "الكنية";

  @override
  String get maxEveryHour => "كل ساعة";

  @override
  String get maxHalfDay => "كل 12 ساعة";

  @override
  String get messages1x1AndMentions => "الرسائل 1x1 و @ الإشارات";

  @override
  String get myProfile => "ملفي";

  @override
  String get never => "أبدا";

  @override
  String get newPassword => "كلمة سر جديدة";

  @override
  String get newsLetters => "رسائل الأخبار";

  @override
  String get notReceiveNews => "لا تتلقى أخبار";

  @override
  String get notifications => "إشعارات";

  @override
  String get passwordRequirements =>
      "قم بتغيير كلمة المرور الخاصة بك بشكل دوري لزيادة الأمان والحماية";

  @override
  String get phoneNotifications => "إشعارات الهاتف";

  @override
  String get phoneNumber => "رقم الهاتف";

  @override
  String get photoSizeRestrictions =>
      "استخدم صورة مربعة بعرض أقصى 400 بكسل (صغيرة)";

  @override
  String get repeatNewPassword => "كرر كلمة المرور الجديدة";

  @override
  String get security => "الأمان";

  @override
  String get skypeUserName => "مستخدم سكايب";

  @override
  String get sounds => "اصوات";

  @override
  String get yourUserName => "اسم المستخدم الخاص بك";

  @override
  String get saveChanges => "احفظ التغييرات";

  @override
  String get profileEmailUsesWarning =>
      "يتم استخدام هذا البريد الإلكتروني فقط للإشعارات في هذا الفريق.";

  @override
  String get pushMobileNotifications => "دفع إشعارات الهاتف المحمول";

  @override
  String get saveNotificationChanges => "حفظ التغييرات الإخطار";

  @override
  String get updatePassword => "تطوير كلمة السر";

  @override
  String get updateProfileInfo => "تحديث معلومات الملف الشخصي";

  @override
  String get password8CharsRequirement =>
      "يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل.";

  @override
  String get passwordAtLeast1CapitalLetter =>
      "يجب أن تحتوي كلمة المرور على حرف واحد كبير على الأقل.";

  @override
  String get passwordAtLeast1LowerCaseLetter =>
      "يجب أن تحتوي كلمة المرور على حرف صغير واحد على الأقل.";

  @override
  String get passwordAtLeast1Number =>
      "يجب أن تحتوي كلمة المرور على رقم واحد على الأقل.";

  @override
  String get passwordMustMatch => "كلمة المرور يجب ان تتطابق.";

  @override
  String get notificationUpdatedSuccess => "تم تحديث تغييرات الإعلام.";

  @override
  String get passwordUpdatedSuccess => "تم تحديث كلمة السر.";

  @override
  String get profileUpdatedSuccess => "تحديث الملف الشخصي";

  @override
  String get enablePermissions => "تمكين الأذونات";

  @override
  String get permissionDenied => "طلب الاذن مرفوض";

  @override
  String get savePreferences => "حفظ التفضيلات";

  @override
  String get turnOffChannelEmails => "لا تتلقى رسائل البريد الإلكتروني القناة";

  @override
  String get turnOffChannelSounds => "قم بإيقاف تشغيل أصوات القناة";

  @override
  String get chatMessageUnavailable =>
      "رسائل الدردشة غير متاحة مع هذا المستخدم";

  @override
  String get createChannel => "إنشاء قناة";

  @override
  String get createNewChannel => "أنشئ قناة جديدة";

  @override
  String get isTyping => "يكتب...";

  @override
  String get createPrivateGroup => "إنشاء مجموعة خاصة";

  @override
  String get createPrivateGroupWarning =>
      "ستنشئ مجموعة جديدة ، يمكنك إضافة أشخاص إلى هذه المجموعة إذا كانوا بالفعل جزءًا من فريقك ، وإذا لم يكن الأمر كذلك ، فقم بإنشاء المجموعة أولاً ودعوتهم لاحقًا.";

  @override
  String get createNewPrivateGroup => "إنشاء مجموعة خاصة جديدة";

  @override
  String get createNewChannelAction => "أنت على وشك إنشاء قناة مفتوحة جديدة.";

  @override
  String get createNewChannelForAdminsOnly => "فقط مدراء الوصول للكتابة.";

  @override
  String get openChannelAllMemberAccess =>
      "جميع أعضاء الفريق لديهم حق الوصول للقراءة.";

  @override
  String get and => "و";

  @override
  String get userIsInactiveToChat =>
      "لا يمكنك الدردشة مع هذا المستخدم لأنه غير نشط.";

  @override
  String get selectChannel => "حدد القناة";

  @override
  String get needToSelectChannel => "تحتاج إلى تحديد قناة";

  @override
  String get fileAlreadyShared =>
      "تمت مشاركة هذا الملف بالفعل بنفس الاسم في القناة التي حددتها.";

  @override
  String get inChannel => "في القناة";

  @override
  String seeAnswerMessages(int count) => "نرى $count  الرسائل";

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
    return "المستعمل $name  انضم إلى القناة";
  }

  @override
  String userHasLeft(String name) {
    return "المستعمل $name  غادر القناة";
  }

  @override
  String invitedBy(String name) {
    return "بدعوة من $name";
  }

  @override
  String get answers => "الإجابات";

  @override
  String get publishIn => "نشر في";

  @override
  String get hasCommentedOnThread => "علق على الموضوع:";

  @override
  String get unReadMessages => "رسائل غير مقروءة";

  @override
  String get hasAddedTag => "تمت إضافة العلامة";

  @override
  String get hasAssignedUser => "قام بتعيين المستخدم";

  @override
  String get hasClosedTask => "أنهى المهمة";

  @override
  String get hasCommentedTask => "أضاف تعليق";

  @override
  String get hasCreatedTask => "أنشأت المهمة";

  @override
  String get hasCreatedTaskAssignedTo => "قام بإنشاء مهمة جديدة تم تعيينها إلى";

  @override
  String get hasDeleteTag => "تم حذف العلامة";

  @override
  String get hasDeletedCommentTask => "قام بحذف تعليق";

  @override
  String get hasEditedCommentTask => "قام بتحرير تعليق";

  @override
  String get hasEditedTask => "قام بتحرير المهمة";

  @override
  String get hasRemovedEndDateTask => "تم حذف تاريخ الانتهاء لـ";

  @override
  String get hasReopenedTask => "أعاد فتح المهمة";

  @override
  String get hasSetMilestone => "لقد حددت الإنجاز";

  @override
  String get hasUnAssignedUser => "قام بإلغاء تعيين المستخدم";

  @override
  String get hasUpdatedDateTask => "تم تحديث تاريخ الانتهاء لـ";

  @override
  String get inTheTask => "في المهمة";

  @override
  String get to => "إلى";

  @override
  String get hasAssignedNewDueDateFor => "قام بتعيين تاريخ استحقاق جديد لـ";

  @override
  String get createNewTag => "إنشاء علامة جديدة";

  @override
  String get createNewMilestone => "إنشاء معلم جديد";

  @override
  String get editMilestone => "تحرير حدث رئيسي";

  @override
  String get editTag => "تحرير العلامة";

  @override
  String get openTasks => "افتح المهام";

  @override
  String get newPersonalNote => "ملاحظة شخصية جديدة";

  @override
  String get createNewPersonalNote => "إنشاء ملاحظة شخصية";

  @override
  String get filterBy => "مصنف بواسطة";

  @override
  String hereStartsYourMessagesWith(String name) => "هنا تبدأ رسائلك مع @$name";

  @override
  String thisChannelIsManagedBy(String name) =>
      "هذه القنوات يديرها @$name، إذا احتجت إلى مساعدة اتصل بالمسؤول.";

  @override
  String newPush(String user, String repository, String repositoryUrl) {
    String part1 = "دفعة جديدة من";
    String part2 = "في المستودع";
    String part3 = "التفاصيل";

    return "<p>$part1  <span class = 'link-mention'> @$user</span> $part2  <span> <a href = '$repositoryUrl'>$repository. $part3</a> </span> </p>";
  }

  @override
  String unassignedTask(
    String repository,
    String repositoryUrl,
  ) {
    String part1 = "مهمة غير مخصصة في المستودع";
    String part2 = "التفاصيل";
    return "<p>$part1  <a href = '$repositoryUrl'>$repository. $part2</a> </p>";
  }

  @override
  String cardTrelloCreate(
      String board, String boardUrl, String card, String cardUrl, String list) {
    String part1 = "تم إنشاء البطاقة";
    String part2 = "في القائمة";
    String part3 = "من المجلس";
    return "<p>$part1  <a href = '$cardUrl'>$card</a> $part2   $list   $part3  <a href = '$boardUrl'>$board</a> </p>";
  }

  @override
  String cardTrelloRename(String board, String boardUrl, String oldName,
      String newName, String list) {
    String part1 = "في القائمة";
    String part2 = "من اللوح";
    String part3 = "تمت إعادة تسمية البطاقة";
    String part4 = "إلى";
    return "<p>$part1 '$list' $part2 <a href='$boardUrl'>$board</a> $part3 '$oldName' $part4 '$newName'</p>";
  }

  @override
  String cardTrelloDescriptionChange(String board, String boardUrl, String card,
      String cardUrl, String list, String description) {
    String part1 = "البطاقة";
    String part2 = "من القائمة";
    String part3 = "من اللوح";
    String part4 = "قام بتغيير وصفه إلى";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4 '$description'</p>";
  }

  @override
  String cardTrelloMoveToOtherList(String board, String boardUrl, String card,
      String cardUrl, String oldList, String newList) {
    String part1 = "البطاقة";
    String part2 = "تم نقله من القائمة";
    String part3 = "إلى القائمة";
    String part4= "على اللوحة";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$oldList' $part3 '$newList' $part4 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloArchive(String board, String boardUrl, String card,
      String cardUrl, String list) {
    String part1 = "البطاقة";
    String part2 = "من القائمة";
    String part3 = "من اللوح";
    String part4 = "تم أرشفته";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4</p>";
  }

  @override
  String get comments => "تعليقات";

  @override
  String get addComment => "أضف تعليق";

  @override
  String get editComment => "تعديل التعليق";

  @override
  String get downloadAppsAndSynchronizer =>
      "<a href ='https://noysi.com/a/#/downloads'>قم بتنزيل التطبيقات الآن!</a>";

  @override
  String get welcomeToNoysiFirstName =>
      "مرحبا! هذه قناتك الشخصية ، ولن يراها أي شخص آخر ، وليس لديك اتصال مع أي شخص ، إنها قناتك الشخصية لترك ملاحظات شخصية وتحميل ملفات لن يراها أي شخص آخر. ما هو اسمك؟";

  @override
  String get welcomeToNoysiTimeout =>
      " <a href='${Endpoint.helpUrl}'> هنا </a> أنت لم تجبني! إذا كنت بحاجة إلى مساعدة انقر فوق";

  @override
  String get wrongUsernamePassword => "اسم المستخدم أو كلمة المرور خاطئة";

  @override
  String get userInUse => "هذا المستخدم قيد الاستخدام بالفعل";

  @override
  String get invite => "يدعو";

  @override
  String get groupRequired => "المجموعة المطلوبة";

  @override
  String get uploading => "تحميل";

  @override
  String get downloading => "جارى التحميل";

  @override
  String get inviteGuestsWarning =>
      "ينضم الضيوف إلى مجموعة واحدة فقط في هذا الفريق.";

  @override
  String get addMembers => "إضافة أعضاء";

  @override
  String get enterEmailsByComma =>
      "أدخل رسائل البريد الإلكتروني عن طريق فصلها بفواصل:";

  @override
  String get firstName => "الاسم الاول";

  @override
  String get inviteFewMorePersonal => "ادعُ القليل وكن أكثر خصوصية";

  @override
  String get inviteManyAtOnce => "ادعُ كثيرين في آنٍ واحد";

  @override
  String get addGuests => "أضف الضيوف";

  @override
  String get followThread => "اتبع هذا الموضوع";

  @override
  String get markThreadAsRead => "ضع إشارة مقروء";

  @override
  String get stopFollowingThread => "توقف عن متابعة هذا الموضوع";

  @override
  String get needToVerifyAccountToInvite =>
      "تحتاج إلى التحقق من حساب البريد الإلكتروني لدعوة الأعضاء.";

  @override
  String get createANewTeam => "أنشئ فريقًا جديدًا";

  @override
  String get createNewTeam => "إنشاء فريق جديد!";

  @override
  String get enterIntoYourAccount => "أدخل إلى حسابك";

  @override
  String get forgotPassword => "نسيت رقمك السري؟";

  @override
  String get goAhead => "إنطلق!";

  @override
  String get passwordRestriction =>
      "يجب أن تحتوي كلمة المرور على ثمانية أحرف على الأقل بما في ذلك رقم وحرف كبير وحرف صغير ، ويمكنك استخدام أحرف خاصة مثل @ # \$٪ ^ & + = وعشرة أحرف أو أكثر لتحسين أمان كلمة المرور الخاصة بك.";

  @override
  String get recoverYorPassword => "استعادة كلمة المرور الخاصة بك";

  @override
  String get recoverYorPasswordWarning =>
      "لاستعادة كلمة المرور الخاصة بك ، أدخل عنوان البريد الإلكتروني الذي تستخدمه لتسجيل الدخول إلى noysi.com";

  @override
  String recoverPasswordResponse(String email) {
    return "لقد أرسلنا لك بريدًا إلكترونيًا إلى $email";
  }

  @override
  String get recoverPasswordResponse1 =>
      "تحقق من بريدك الوارد واتبع التعليمات هناك لإنشاء كلمة المرور الجديدة";

  @override
  String get continueStr => "استمر";

  @override
  String get passwordAtLeast1SpecialChar =>
      "يجب أن تحتوي كلمة المرور على حرف خاص واحد على الأقل @#\$%^&+=";

  @override
  String welcomeToNoysiLastName(String name) =>
      "مرحبًا $name. ما هو اللقب الخاص بك";

  @override
  String get welcomeToNoysiDescription =>
      "جيد جدا. كل شيء صحيح. سأشرع في تحديث ملف التعريف الخاص بك.";

  @override
  String get welcomeToNoysiInvite =>
      "<a href = '#'>قم بدعوة أعضاء فريقك الآن!</a>";

  @override
  String get activeFilter => "مرشح نشط";

  @override
  String get newFileComment => "تعليق جديد في الملف";

  @override
  String get removed => "إزالة";

  @override
  String get sharedOn => "مشترك على";

  @override
  String get notifyAllInThisChannel => "بإخطار الجميع في هذه القناة";

  @override
  String get notifyAllMembers => "بإخطار جميع الأعضاء";

  @override
  String get keepPressingToRecord => "يرجى الاستمرار في الضغط على الزر للتسجيل";

  @override
  String get slideToCancel => "حرك للإلغاء";

  @override
  String get chooseASecurePasswordText => "اختر كلمة مرور قوية بما يكفي ويمكنك تذكرها";

  @override
  String get confirmPassword => "تأكيد كلمة المرور";

  @override
  String get yourPassword => "كلمة المرور الخاصة بك";

  @override
  String get passwordDontMatch => "كلمة المرور غير مطابقة";

  @override
  String get changeCreateTeamMail => "لا ، أريد تغيير البريد الإلكتروني";

  @override
  String step(int number) => "$number الخطوة ";

  @override
  String get user => "مستخدم";

  @override
  String get deleteFolderWarning => "سيتم حذف المجلد نهائيًا ولا يمكن استعادته";

  @override
  String get calendar => "تقويم";

  @override
  String get week => "أسبوع";

  @override
  String get folderIsNotInCurrentTeam => "المجلد غير مقترن بالفريق الحالي";

  @override
  String get folderIsNotInAvailableChannel => "المجلد المشار إليه ليس في قناة متاحة في مستكشف الملفات";

  @override
  String get folderLinked => "تم نسخ ارتباط المجلد إلى القناة";

  @override
  String get folderShared => "تمت مشاركة المجلد على القناة";

  @override
  String get folderUploaded => "تم تحميل المجلد إلى القناة";

  @override
  String get folderNotFound => "المجلد غير موجود";

  @override
  String get folderNameIncorrect => "اسم المجلد غير صالح";

  @override
  String get cloneFolder => "مجلد استنساخ";

  @override
  String get cloneFolderInfo => "يؤدي استنساخ مجلد إلى إنشاء مجلد جديد في القناة الوجهة بنفس الحالة والمحتوى مثل المجلد المحدد في هذه المرحلة الزمنية.";

  @override
  String get folderDeleted => "لا يمكن الوصول إلى مجلد محذوف";

  @override
  String get youWereInADeletedFolder => "تم حذف المجلد الذي كان فيه";

  @override
  String get dateFormat6 => "MM/dd/yyyy";

  @override
  String get dateFormat8 => "MMM d, yyyy";

  @override
  String get createdTask => "تم إنشاء المهمة";

  @override
  String get loggedIn => "بدأت الجلسة";

  @override
  String get mention => "يذكر";

  @override
  String get messageSent => "تم الارسال";

  @override
  String get taskAssigned => "المهمة الموكلة";

  @override
  String get taskUnassigned => "مهمة غير مخصصة";

  @override
  String get uploadedFile => "تحميل الملف";

  @override
  String get uploadedFileFolder => "تم تحميل الملف / المجلد";

  @override
  String get uploadedFolder => "المجلد الذي تم تحميله";

  @override
  String get downloadedFile => "الملف الذي تم تنزيله";

  @override
  String get downloadedFileFolder => "الملف / المجلد الذي تم تنزيله";

  @override
  String get downloadedFolder => "المجلد الذي تم تنزيله";

  @override
  String get messageUnavailable => "الرسالة غير متوفرة";

  @override
  String get activityZone => "منطقة النشاط";

  @override
  String get categories => "فئات";

  @override
  String get category => "فئة";

  @override
  String get clearAll => "امسح الكل";

  @override
  String get errorFetchingData => "خطأ في الحصول على البيانات";

  @override
  String get filters => "المرشحات";

  @override
  String get openSessions => "الجلسات المفتوحة";

  @override
  String activityFileFolderUploadedDownloaded(String user, String name, String channel, {bool download = false, bool isDirect = false, isFolder = false}) {
    String part1 = "${download ? "لقد قمت بتنزيل ملفات" : "لقد قمت بتحميل"}${isFolder ? " مجلد " : " الملف "}";
    String part2 = download ? "من القناة" : "في القناة";
    return "$part1 <i class=\"mention-generic\">$name</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMentioned(String user, String channel, {bool isDirect = false}) {
    String part1 = "لقد تم ذكرك على القناة";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMessageSent(String user, String channel, {bool isDirect = false}) {
    String part1 = "لقد قمت بإرسال رسالة على القناة";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activitySignedIn(String sessionInfo, String ip) {
    return "لقد قمت بتسجيل الدخول <i class=\"mention-generic\">$sessionInfo</i> IP: <i class=\"mention-generic\">$ip</i>";
  }

  @override
  String activityTaskAssigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "لقد تم تكليفك بالمهمة";
    String part2 = "في القناة";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskCreated(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "لقد قمت بإنشاء المهمة";
    String part2 = "في القناة";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskUnassigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "لقد تم إلغاء تخصيصك من المهمة";
    String part2 = "في القناة";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String get activityZoneHeader => "هذا هو المكان الذي تبدأ منه منطقة النشاط";

  @override
  String get sessions => "الجلسات";


  @override
  String get selectEvent => "حدد الحدث";

  @override
  String get googleCalendar => "Google";

  @override
  String get outlookCalendar => "Outlook";

  @override
  String get noysiCalendar => "Noysi";

  @override
  String get autogenerateRoomNameQuestion => "هل تريد إنشاء اسم الغرفة تلقائيًا؟";

  @override
  String get createMeetingEvent => "إنشاء حدث-اجتماع";

  @override
  String get externalGuests => "الضيوف الخارجيون";

  @override
  String get internalGuests => "الضيوف الداخليون";

  @override
  String get newMeetingEvent => "حدث جديد-اجتماع";

  @override
  String get roomName => "اسم الغرفة";

  @override
  String get eventMeeting => "الحدث الاجتماع";

  @override
  String get personalNote => "ملاحظة شخصية";

  @override
  String get updateExternalGuests => "تحديث الضيوف الخارجيين";

  @override
  String get nameTextWarning => "يتوافق النص مع سلسلة أبجدية رقمية من 1 إلى 25 حرفًا. يمكنك أيضًا استخدام المسافات والأحرف _ -";

  @override
  String get nameTextWarningWithoutSpaces => "يتوافق النص مع سلسلة أبجدية رقمية من 1 إلى 18 حرفًا بدون مسافات. يمكنك أيضًا استخدام الأحرف _ -";

  @override
  String get today => "اليوم";

  @override
  String get location => "مكان";

  @override
  String get appVersion => "نسخة التطبيق";

  @override
  String get browser => "المستعرض";

  @override
  String get device => "جهاز";

  @override
  String get logout => "تسجيل خروج";

  @override
  String get manufacturer => "صانع";

  @override
  String get no => "لا";

  @override
  String get operativeSystem => "نظام التشغيل";

  @override
  String get yes => "نعم";

  @override
  String get allDay => "طوال اليوم";

  @override
  String get endDate => "تاريخ الانتهاء";

  @override
  String get noTitle => "بلا عنوان";

  @override
  String get currentSession => "الجلسة الحالية";

  @override
  String get logOutAllExceptForThisOne => "قم بتسجيل الخروج من جميع الأجهزة باستثناء هذا الجهاز";

  @override
  String get terminateAllOtherSessions => "إنهاء جميع الجلسات الأخرى";

  @override
  String get closeAllSessionsConfirmation => "هل تريد إنهاء جميع الجلسات الأخرى؟";

  @override
  String get closeSessionConfirmation => "هل تريد إنهاء الجلسة؟";

  @override
  String get connectionLost => "عفوًا ، يبدو أنه لا يوجد اتصال";

  @override
  String get connectionEstablished => "أنت متصل بالإنترنت مرة أخرى";

  @override
  String get connectionStatus => "حالة الإتصال";

  @override
  String get anUserIsCalling => "مستخدم يتصل بك ...";

  @override
  String get answer => "إجابه";

  @override
  String get hangDown => "يشنق";

  @override
  String get incomingCall => "مكالمة واردة";

  @override
  String isCallingYou(String user) => "$user يتصل بك ...";

  @override
  String get callCouldNotBeInitialized => "تعذر تهيئة المكالمة";

  @override
  String get sentMessages => "الرسائل المرسلة";

  @override
  String sentMessagesCount(String count) => "$count من 10000";

  @override
  String get teamDataUsage => "استخدام بيانات الفريق";

  @override
  String get usedStorage => "التخزين المستخدم";

  @override
  String usedStorageText(String used) => used + "GB من 5GB";

  @override
  String get userDataUsage => "استخدام بيانات المستخدم";

  @override
  String get audioEnabled => "تمكين الصوت";

  @override
  String get meetingOptions => "خيارات الاجتماع";

  @override
  String get videoEnabled => "تمكين الفيديو";

  @override
  String get dontShowThisMessage => "لا تظهر مرة أخرى";

  @override
  String get showDialogEveryTime => "إظهار الحوار في كل مرة يبدأ فيها الاجتماع";

  @override
  String get micAndCameraRequiredAlert => "أذونات الوصول إلى الكاميرا والميكروفون مطلوبة ، يرجى التأكد من منحك الأذونات اللازمة. هل تريد الانتقال إلى إعدادات الأذونات؟";

  @override
  String get noEvents => "لا توجد أحداث أو مهام أو ملاحظات شخصية";

  @override
  String get connectWith => "متصل مع";

  @override
  String get or => "أو";

  @override
  String get viewDetails => "عرض التفاصيل";

  @override
  String zendeskTicketUpdated(String user, String status, String type, String title, String url) {
    String part1 = R.string.user;
    String part2 = "تحديث التذكرة";
    String part3 = "من النوع";
    String part4 = "إلى الوضع";
    String part5 = R.string.viewDetails;
    return "<p>$part1 '$user' $part2 '$title' $part3 '$type' $part4 '$status'. <span><a href='$url'>$part5</a></span></p>";
  }


  @override
  String get accept => "قبول";

  @override
  String get busy => "مشغول";

  @override
  String get configuration => "إعدادات";

  @override
  String get downloads => "التحميلات";

  @override
  String get editTeam => "تحرير الفريق";

  @override
  String get general => "عام";

  @override
  String get integrations => "تكاملات";

  @override
  String get noRecents => "لا يوجد حديث";

  @override
  String get noRecommendations => "لا توجد توصيات";

  @override
  String get inAMeeting => "في اجتماع";

  @override
  String get onFire => "On Fire";

  @override
  String get plans => "الخطط";

  @override
  String get setAStatus => "عيِّن حالة";

  @override
  String get sick => "مرض";

  @override
  String get signOut => "خروج";

  @override
  String get suggestions => "اقتراحات";

  @override
  String get teams => "فرق";

  @override
  String get traveling => "سفر";

  @override
  String get whatsYourStatus => "ما هي حالتك؟";

  @override
  String get sendAlwaysAPush => "إرسال إشعار دفع دائما";

  @override
  String get robot => "إنسان آلي";

  @override
  String get deactivateUserWarning => "لن يتمكن أعضاء الفريق من الاتصال بالعضو أثناء تعطيله. ومع ذلك ، ستبقى جميع الأنشطة التي يقوم بها العضو المعطل في Noysi كما هي وستكون الرسائل (القنوات المفتوحة ، والرسائل 1 إلى 1 والمجموعات الخاصة) والملفات والمهام متاحة.";

  @override
  String get activateUserWarning => "بمجرد إعادة تنشيط العضو ، سيستعيد الوصول إلى نفس القنوات والمجموعات والملفات والمهام التي كان يمتلكها قبل إلغاء تنشيطه.";

  @override
  String get changeRole => "تغيير الدور";

  @override
  String get userStatus => "حالة المستخدم";

  @override
  String get deactivateMyAccount => "إلغاء تفعيل حسابي";

  @override
  String get deactivateMyAccountWarning => "إذا قمت بإلغاء تنشيط حسابك ، فسيتم إلغاء تنشيطك في جميع فرقك ومحادثاتك وملفاتك ومهامك وأي أنشطة قمت بإدارتها من خلال Noysi حتى يقوم المسؤول بإعادة تنشيطك مرة أخرى.";

  @override
  String get deactivateMyUserInThisTeam => "قم بإلغاء تنشيط المستخدم الخاص بي في هذا الفريق";

  @override
  String get deactivateMyUserInThisTeamWarning => "عندما تقوم بإلغاء تنشيط نفسك في فريق ، فسيظل كل شيء تملكه في هذا الفريق حتى يتم تنشيطه مرة أخرى. إذا كنت مسؤول الفريق الوحيد ، فلن يتم حذف الفريق.";

  @override
  String get operationConfirmation => "هل أنت متأكد من هذه العملية؟";

  @override
  String get formatNotSupported => "هذا التنسيق أو الامتداد غير مدعوم من قبل نظام التشغيل";

  @override
  String get invitePrivateGroupLink => "قم بدعوة عضو إلى المجموعة باستخدام هذا الارتباط";

  @override
  String get invalidPhoneNumber => "البحث عن طريق اسم الدولة أو رمز الاتصال الهاتفي";

  @override
  String get searchByCountryName => "البحث عن طريق اسم الدولة أو رمز الاتصال الهاتفي";

  @override
  String get kick => "يطرد";

  @override
  String get deleteAll => "حذف الكل";

  @override
  String get enterKeyManually => "أدخل المفتاح يدويًا";

  @override
  String get noysiAuthenticator => "Noysi المصادقة";

  @override
  String get qrScanner => "QR";

  @override
  String get otpLabelWarning => "تسمية OTP هي سلسلة أبجدية رقمية بدون مسافات :@.,;()\$% مسموح بها أيضًا";

  @override
  String get invalidBase32Chars => "base32 حرفًا غير صالح";

  @override
  String get label => "ملصق";

  @override
  String get secretCode => "المفتاح السري";

  @override
  String get labelTextWarning => "التسمية فارغة ، يرجى التحقق من هذه القيمة";

  @override
  String missedCallFrom(String user) => "مكالمة فائتة من $user";

  @override
  String get activeItemBackgroundColor => "خلفية العنصر النشط";

  @override
  String get activeItemTextColor => "نص العنصر النشط";

  @override
  String get activePresenceColor => "الحضور النشط";

  @override
  String get adminsCanDeleteMessage => "يمكن للمسؤولين حذف الرسائل";

  @override
  String get allForAdminsOnly => "all للمسؤولين فقط";

  @override
  String get channelForAdminsOnly => "channel فقط للمسؤولين ومنشئي القنوات";

  @override
  String get chooseTheme => "اختر موضوعًا لفريقك";

  @override
  String get enablePushAllChannels => "تفعيل دفع الإخطارات على جميع القنوات";

  @override
  String get inactivePresenceColor => "حضور غير نشط";

  @override
  String get leaveTeam => "اترك هذا الفريق";

  @override
  String get leaveTeamWarning => "عندما تترك فريقًا ، فسيتم حذف كل شيء تملكه في هذا الفريق. إذا كنت مسؤول الفريق الوحيد ، فسيتم حذف الفريق.";

  @override
  String get notificationBadgeBackgroundColor => "خلفية الشارة";

  @override
  String get notificationBadgeTextColor => "نص الشارة";

  @override
  String get onlyAdminInvitesAllowed => "الضيوف المصرح لهم فقط من قبل المسؤولين";

  @override
  String get reset => "إعادة ضبط";

  @override
  String get settings => "إعدادات";

  @override
  String get sidebarColor => "لون الشريط الجانبي";

  @override
  String get taskUpdateProtected => "تعديل المهام المخصصة للمبدعين والمسؤولين";

  @override
  String get teamName => "اسم الفريق";

  @override
  String get textColor => "لون الخط";

  @override
  String get theme => "سمة";

  @override
  String get updateUsernameBlocked => "حظر اسم المستخدم عند إرسال الدعوة";

  @override
  String get fileNotFound => "لم يتم العثور على الملف";

  @override
  String get messageNotFound => "لم يتم العثور على الرسالة ، يرجى التحقق مما إذا كانت الرسالة التي تبحث عنها متوفرة في الفريق الحالي.";

  @override
  String get taskNotFound => "لم يتم العثور على المهمة";

  @override
  String userHasPinnedMessage(String name) => "$name قام بتثبيت رسالة في القناة";

  @override
  String userHasUnpinnedMessage(String name) => "$name قام بإلغاء تثبيت الرسالة من هذه القناة";

  @override
  String get pinMessage => "رسالة دبوس";

  @override
  String get unpinMessage => "قم بإلغاء تثبيت الرسالة";

  @override
  String get pinnedMessage => "رسالة مثبتة";

  @override
  String get deleteMyAccount => "احذف حسابي";

  @override
  String get yourDeleteRequestIsInProcess => "طلب حذف حسابك قيد المعالجة";

  @override
  String get deleteMyAccountWarning => "إذا قمت بحذف حسابك ، فسيكون الإجراء لا رجوع فيه. إذا كنت تدير فريقًا ولا يوجد مسؤول آخر ، فسيتم حذف الفريق.";

  @override
  String get lifetimeDeal => "Ofertas de por vida";

  @override
  String get showEmails => "إظهار رسائل البريد الإلكتروني للمستخدم";

  @override
  String get showPhoneNumbers => "إظهار أرقام هواتف المستخدمين";

  @override
  String get addChannel => "أضف قناة";

  @override
  String get addPrivateGroup => "إضافة مجموعة خاصة";

  @override
  String get selectUserFromTeam => "حدد المستخدم من هذا الفريق";

  @override
  String get selectUsersFromChannelGroup => "حدد المستخدمين من قناة أو مجموعة";

  @override
  String get memberDeleted => "تم حذف العضو";
}

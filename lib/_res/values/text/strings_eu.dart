import 'dart:ui';
import 'package:code/_res/values/config.dart';
import 'package:code/_res/values/text/strings_base.dart';

import '../../../data/api/remote/endpoints.dart';
import '../../R.dart';


class StringsEu implements StringsBase {
  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Noysi";

  @override
  String get yourTeams => "Zure taldeak";

  @override
  String get channel => "Kanala";

  @override
  String get channels => "Kanalak";

  @override
  String get directMessagesAbr => "DMak";

  @override
  String get email => "Posta elektronikoa";

  @override
  String get home => "Etxea";

  @override
  String get member => "Kidea";

  @override
  String get administrator => "Administratzailea";

  @override
  String get guest => "Gonbidatua";

  @override
  String get guests => "Gonbidatuak";

  @override
  String get members => "Kideak";

  @override
  String get inactiveMember => "Kidea desaktibatuta";

  @override
  String get message => "Mezua";

  @override
  String get messages => "Mezuak";

  @override
  String get password => "Pasahitza";

  @override
  String get register => "Izena eman";

  @override
  String get search => "Bilatu";

  @override
  String get signIn => "Hasi saioa";

  @override
  String get task => "Egitekoa";

  @override
  String get tasks => "Zereginak";

  @override
  String get createTask => "Sortu ataza";

  @override
  String get newTask => "Zeregin berria";

  @override
  String get description => "Deskribapena";

  @override
  String get team => "Taldea";

  @override
  String get thread => "Haria";

  @override
  String get threads => "Hariak";

  @override
  String get createTeam => "Sortu taldea";

  @override
  String get confirmIsCorrectEmailAddress => "Bai! Hori da posta elektroniko zuzena";

  @override
  String get createTeamIntro =>
      "Noysin talde berria eratzera zoaz.";

  @override
  String get isCorrectEmailAddress => "Hau al da helbide elektroniko zuzena?";

  @override
  String get welcome => "Ongi etorri!";

  @override
  String get invitationSentAt => "Zure gonbidapena helbide honetara bidaliko da:";

  @override
  String get next => "Hurrengoa";

  @override
  String get startNow => "Hasi orain!";

  @override
  String get charsRemaining => "Geratzen diren karaktereak:";

  @override
  String get teamNameOrgCompany =>
      "Idatzi zure taldearen izena, erakundea edo enpresaren izena.";

  @override
  String get teamNameOrgCompanyLabel => "Adib. Nire enpresaren izena";

  @override
  String get yourTeam => "Zure taldea";

  @override
  String get noysiServiceNewsletters =>
      "Ongi da NOYSI zerbitzuaren inguruko mezu elektronikoak jasotzea (noizean behin).";

  @override
  String get userNameIntro =>
      "Zure erabiltzaile izena zure taldeko besteei nola agertzen zaren da.";

  @override
  String get userNameLabel => "Adib. ackerman";

  @override
  String get addAnother => "Gehitu beste bat";

  @override
  String get byProceedingAcceptTerms =>
      "* Aurrera eginez gero gure <b> Zerbitzuen baldintzak </b> onartzen dituzu";

  @override
  String get invitations => "Gonbidapenak";

  @override
  String get invitePeople => "Gonbidatu jendea";

  @override
  String get noysiIsTeamWorkInvite =>
      "Noysi talde-lanerako tresna da. Gonbidatu gutxienez pertsona bat";

  @override
  String get userName => "Erabiltzaile izena";

  @override
  String get fieldMax18 => "18 karaktere gehienez";

  @override
  String get fieldMax25 => "25 karaktere gehienez";

  @override
  String get fieldPassword => "Pasahitza behar da";

  @override
  String get fieldRequired => "Eremua beharrezkoa da";

  @override
  String get missingEmailFormat => "Posta elektroniko okerra";

  @override
  String get back => "Itzuli";

  @override
  String get channelBrowser => "Kanal arakatzailea";

  @override
  String get help => "Laguntza";

  @override
  String get preferences => "Lehentasunak";

  @override
  String get signOutOf => "Amaitu saioa";

  @override
  String get closed => "Itxita";

  @override
  String get closedMilestone => "Itxita";

  @override
  String get close => "Itxi";

  @override
  String get opened => "Irekita";

  @override
  String get chat => "Txateatu";

  @override
  String get allThreads => "Hari guztiak";

  @override
  String get inviteMorPeople => "Gonbidatu jende gehiago";

  @override
  String get meeting => "Bilera";

  @override
  String get myFiles => "Nire fitxategiak";

  @override
  String get myTasks => "Nire zereginak";

  @override
  String get myTeams => "Nire taldeak";

  @override
  String get openChannels => "Ireki kanalak";

  @override
  String get privateGroups => "Talde pribatuak";

  @override
  String get favorites => "Gogokoak";

  @override
  String get message1x1 => "1etik 1erako mezuak";

  @override
  String get acceptedTitle => "Onartua";

  @override
  String get date => "Data";

  @override
  String get invitationLanguageTitle => "Idiom hizkuntza";

  @override
  String get invitationMessage => "Gonbidapen mezua";

  @override
  String get revokeInvitation => "Ezeztatu gonbidapena";

  @override
  String get revoke => "Ezeztatu";

  @override
  String get revokeInvitationWarning =>
      "Kontuz, ekintza hau ez da itzulgarria";

  @override
  String get revokeInvitationDelete => "Gonbidapena ezabatu";

  @override
  String get resendInvitationBefore24hrs =>
      "Gonbidapena berriro bidaltzea ez da onartzen azken bidali zenetik 24 ordura arte.";

  @override
  String get resendInvitationSuccess => "Gonbidapenak ongi bidali dira.";

  @override
  String get resendInvitation => "Bidali berriro gonbidapena";

  @override
  String get invitationMessageDefault =>
      "Kaixo! Hemen duzu bat egiteko gonbidapena";

  @override
  String get inviteManyAsOnce => "Gonbidatu asko behin bezala";

  @override
  String get inviteMemberTitle =>
      "Taldekideek sarbide osoa dute irekitako kanaletarako, pertsonako mezuetarako eta taldeetarako.";

  @override
  String get inviteMemberWarningTitle =>
      "Kide berriak gonbidatzeko taldeko administratzailea izan behar duzu.";

  @override
  String get inviteNewMemberWarningTitle =>
      "Taldeko edozein kidek gonbidatuak gehi ditzake mugagabe.";

  @override
  String get inviteSubtitle =>
      "Noysi zure taldearekin hobeto lan egiteko tresna da. Gonbidatu orain!";

  @override
  String get inviteTitle => "Gonbidatu beste pertsona batzuk";

  @override
  String get inviteToAGroup => "Gonbidatu talde batera (beharrezkoa)";

  @override
  String get inviteToAGroupNotRequired => "Gonbidatu talde batera (aukerakoa)";

  @override
  String get inviteMemberWarning =>
      "Kide berriak # kanal orokorrean sartuko dira automatikoki. Aukeran, orain talde pribatu batera ere gehi ditzakezu.";

  @override
  String get inviteToThisTeam => "Gonbidatu talde honetara";

  @override
  String get invitationsSent => "Gonbidapenak bidali dira";

  @override
  String get name => "Izena";

  @override
  String get noPendingInvitations =>
      "Ez dago talde honetan gonbidapenik bidaltzeko.";

  @override
  String get pendingTitle => "Zain";

  @override
  String get chooseTitle => "Aukeratu";

  @override
  String get seePendingAcceptedInvitations =>
      "Ikusi zain dauden eta onartutako gonbidapenak";

  @override
  String get sendInvitations => "Gonbidapenak bidali";

  @override
  String get typeEmail => "Idatzi mezu elektronikoa";

  @override
  String get typeEmailComaSeparated => "Idatzi mezu elektronikoak komaz bereizita";

  @override
  String get atNoysi => "Noysi-n";

  @override
  String get inviteNewMemberTitle =>
      "Gonbidatuek ez dute ordaintzen eta nahi adina gonbidatu ditzakezu, baina talde horretako talde bakarra izango dute sarbidea.";

  @override
  String get invited => "Gonbidatuta";

  @override
  String get thisNameAlreadyExist =>
      "Badirudi izen hau jadanik erabiltzen ari dela.";

  @override
  String get emptyList => "Zerrenda hutsa";

  @override
  String get ok => "Ados";

  @override
  String get byNameFirst => "A-Z izenarekin";

  @override
  String get byNameInvertedFirst => "Z-A izenarekin";

  @override
  String get download => "Deskargatu";

  @override
  String get files => "Fitxategiak";

  @override
  String get folders => "Karpetak";

  @override
  String get newTitle => "Berria";

  @override
  String get newestFirst => "Berria berriena";

  @override
  String get oldestFirst => "Zaharrena lehen";

  @override
  String get see => "Ikusi";

  @override
  String get share => "Partekatu";

  @override
  String get moreInfo => "Informazio gehiago";

  @override
  String get assigned => "Esleitua";

  @override
  String get author => "Egilea";

  @override
  String get created => "Sortu";

  @override
  String get earlyDeliverDate => "Entrega-data aurreratua";

  @override
  String get farDeliverDate => "Urruneko entrega data";

  @override
  String get filterAuthor => "Iragazi egilearen arabera";

  @override
  String get searchUsers => "Bilatu erabiltzaileak";

  @override
  String get sort => "Ordenatu";

  @override
  String get sortBy => "Ordenatu";

  @override
  String get cancel => "Utzi";

  @override
  String get exit => "Irten";

  @override
  String get exitWarning => "Ziur zaude?";

  @override
  String get deleteChannelWarning =>
      "Ziur kanal honetatik irten nahi duzula?";

  @override
  String get typeMessage => "Idatzi mezu bat ...";

  @override
  String get addChannelToFavorites => "Gehitu gogokoetara";

  @override
  String get removeFromFavorites => "Kendu gogokoetatik";

  @override
  String get channelInfo => "Kanalaren informazioa";

  @override
  String get channelMembers => "Kanaleko kideak";

  @override
  String get channelPreferences => "Kanalaren hobespenak";

  @override
  String get closeChatVisibility => "Itxi 1etik 1era";

  @override
  String get inviteToGroup => "Gonbidatu kidea kanal honetara";

  @override
  String get leaveChannel => "Irten kanaletik";

  @override
  String get mentions => "Aipamenak";

  @override
  String get seeFiles => "Ikusi fitxategiak";

  @override
  String get seeLinks => "Ikusi estekak";

  @override
  String get links => "Estekak";

  @override
  String get taskManager => "Zereginen kudeatzailea";

  @override
  String get videoCall => "Bideo deia";

  @override
  String get addReaction => "Gehitu erreakzioa";

  @override
  String get addTag => "Gehitu etiketa";

  @override
  String get addMilestone => "Gehitu mugarria";

  @override
  String get copyMessage => "Kopiatu mezua";

  @override
  String get copyPermanentLink => "Kopiatu esteka";

  @override
  String get createThread => "Haria hasi";

  @override
  String get edit => "Editatu";

  @override
  String get favorite => "Gogokoena";

  @override
  String get remove => "Kendu";

  @override
  String get tryAgain => "Saiatu berriro";

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
      "Ziur zaude mezu hau ezabatu nahi duzula? Hau ezin da desegin.";

  @override
  String get deleteMessageTitle => "Ezabatu mezua";

  @override
  String get edited => "Editatua";

  @override
  String get seeAll => "Dena ikusi";

  @override
  String get copiedToClipboard => "Arbelera kopiatu da!";

  @override
  String get underConstruction => "Eraikitzen";

  @override
  String get reactions => "Erreakzioak";

  @override
  String get all => "Guztiak";

  @override
  String get users => "Erabiltzaileak";

  @override
  String get documents => "Dokumentuak";

  @override
  String get fromLocalStorage => "Tokiko biltegitik";

  @override
  String get photoGallery => "Argazki galeria";

  @override
  String get recordVideo => "Grabatu bideo bat";

  @override
  String get takePhoto => "Argazkia atera";

  @override
  String get useCamera => "Kameratik";

  @override
  String get videoGallery => "Bideo galeria";

  @override
  String get changeName => "Izena aldatu";

  @override
  String get createFolder => "Karpeta sortu";

  @override
  String get createNameWarning =>
      "Izenek gehienez 18 karaktere izan behar dituzte, puntuazio markarik gabe.";

  @override
  String get newName => "Izen berria";

  @override
  String get rename => "Aldatu izena";

  @override
  String get renameFile => "Aldatu fitxategia";

  @override
  String get renameFolder => "Karpeta izena aldatu";

  @override
  String get deleteFile => "Ezabatu fitxategia";

  @override
  String get deleteFolder => "Ezabatu karpeta";

  @override
  String get deleteFileWarning => "Karpeta behin betiko ezabatuko da eta ezin da berreskuratu. Karpeta edozein esteketatik ezin izango da sartu.";

  @override
  String get delete => "Ezabatu";

  @override
  String get open => "Irekia";

  @override
  String get addCommentOptional => "Gehitu iruzkina (aukerakoa)";

  @override
  String get shareFile => "Partekatu fitxategia";

  @override
  String get groups => "Taldeak";

  @override
  String get to1_1 => "1etik 1era";

  @override
  String get day => "eguna";

  @override
  String get days => "Egunak";

  @override
  String get hour => "ordu";

  @override
  String get hours => "ordu";

  @override
  String get minute => "minutua";

  @override
  String get minutes => "minutu";

  @override
  String get month => "Hilabetea";

  @override
  String get months => "Hilabeteak";

  @override
  String get year => "urtea";

  @override
  String get years => "urteak";

  @override
  String get by => "arabera";

  @override
  String get deliveryDateIn => "Epemuga urtean";

  @override
  String get ago => "Ago";

  @override
  String get taskOpened => "Irekita";

  @override
  String get assignees => "Esleipendunak";

  @override
  String get assigneeBy => "Egileak esleituta";

  @override
  String get closeTask => "Itxi zeregina";

  @override
  String get comment => "Iruzkina";

  @override
  String get deliveryDate => "Epemuga";

  @override
  String get leaveAComment => "Utzi iruzkin bat";

  @override
  String get milestone => "Mugarria";

  @override
  String get milestones => "Mugarriak";

  @override
  String get color => "Kolore";

  @override
  String get milestoneAdded => "Mugarrian gehitu da";

  @override
  String get participants => "Parte-hartzaileak";

  @override
  String get reopen => "Ireki berriro";

  @override
  String get completed => "Osatuta";

  @override
  String get dueDateUpdated => "Epemuga eguneratu da";

  @override
  String get dueDate => "Epemuga";

  @override
  String get lastDueDate => "Azken mugaeguna";

  @override
  String get commented => "Komentatu da";

  @override
  String get tagAdded => "Etiketa gehitu da";

  @override
  String get tagRemoved => "Etiketa kendu da";

  @override
  String get tags => "Etiketak";

  @override
  String get update => "Eguneratu";

  @override
  String get details => "Xehetasunak";

  @override
  String get timeline => "Denbora-lerroa";

  @override
  String get aboutMe => "Niri buruz";

  @override
  String get acceptNews => "Jaso berriak";

  @override
  String get allActive => "Guztiak aktibo";

  @override
  String get changePhoto => "Aldatu argazkia";

  @override
  String get changeYourPassword => "Aldatu pasahitza";

  @override
  String get changeYourPasswordAdvice =>
      "Pasahitzak gutxienez zortzi karaktere izan behar ditu zenbaki bat, maiuskulak eta minuskulak barne. @ # \$% ^ & + = Bezalako karaktere bereziak eta hamar karaktere edo gehiago erabil ditzakezu zure pasahitzaren segurtasuna hobetzeko.";

  @override
  String get charge => "Karga";

  @override
  String get country => "Herrialdea";

  @override
  String get disabled => "Desgaituta";

  @override
  String get emailNotification => "Posta elektroniko bidezko jakinarazpenak";

  @override
  String get language => "Hizkuntza";

  @override
  String get lastName => "Abizena";

  @override
  String get maxEveryHour => "Orduro";

  @override
  String get maxHalfDay => "12 orduro";

  @override
  String get messages1x1AndMentions => "1x1 mezuak eta @ aipamenak";

  @override
  String get myProfile => "Nire profila";

  @override
  String get never => "Inoiz ez";

  @override
  String get newPassword => "Pasahitz berria";

  @override
  String get newsLetters => "Albiste gutunak";

  @override
  String get notReceiveNews => "Ez jaso berririk";

  @override
  String get notifications => "Jakinarazpenak";

  @override
  String get passwordRequirements =>
      "Aldatu pasahitza aldian behin zure segurtasuna eta babesa handitzeko";

  @override
  String get phoneNotifications => "Telefono bidezko jakinarazpenak";

  @override
  String get phoneNumber => "Telefono zenbakia";

  @override
  String get photoSizeRestrictions =>
      "Erabili gehienez 400 px-ko zabalera duen argazki karratua (txikia)";

  @override
  String get repeatNewPassword => "Pasahitz berria errepikatu";

  @override
  String get security => "Segurtasuna";

  @override
  String get skypeUserName => "Skype erabiltzailea";

  @override
  String get sounds => "Soinuak";

  @override
  String get yourUserName => "Zure erabiltzaile izena";

  @override
  String get saveChanges => "Aldaketak gorde";

  @override
  String get profileEmailUsesWarning =>
      "Mezu elektronikoa talde honetako jakinarazpenetarako bakarrik erabiltzen da.";

  @override
  String get pushMobileNotifications => "Push mugikorreko jakinarazpenak";

  @override
  String get saveNotificationChanges => "Gorde jakinarazpen aldaketak";

  @override
  String get updatePassword => "Eguneratu pasahitza";

  @override
  String get updateProfileInfo => "Eguneratu profilaren informazioa";

  @override
  String get password8CharsRequirement =>
      "Pasahitzak gutxienez 8 karaktere izan behar ditu.";

  @override
  String get passwordAtLeast1CapitalLetter =>
      "Pasahitzak gutxienez maiuskula bat izan behar du.";

  @override
  String get passwordAtLeast1LowerCaseLetter =>
      "Pasahitzak gutxienez letra minuskula bat izan behar du.";

  @override
  String get passwordAtLeast1Number =>
      "Pasahitzak gutxienez zenbaki bat eduki behar du.";

  @override
  String get passwordMustMatch => "Pasahitzak bat etorri behar du.";

  @override
  String get notificationUpdatedSuccess => "Jakinarazpen aldaketak eguneratu dira.";

  @override
  String get passwordUpdatedSuccess => "Pasahitza eguneratu da.";

  @override
  String get profileUpdatedSuccess => "Profila eguneratu da";

  @override
  String get enablePermissions => "Gaitu baimenak";

  @override
  String get permissionDenied => "Baimena ukatua";

  @override
  String get savePreferences => "Gorde lehentasunak";

  @override
  String get turnOffChannelEmails => "Ez jaso kanal mezu elektronikorik";

  @override
  String get turnOffChannelSounds => "Desaktibatu kanalaren soinuak";

  @override
  String get chatMessageUnavailable =>
      "Txat mezuak ez daude erabilgarri erabiltzaile honekin";

  @override
  String get createChannel => "Sortu kanala";

  @override
  String get createNewChannel => "Sortu kanal berria";

  @override
  String get isTyping => "idazten ari da ...";

  @override
  String get createPrivateGroup => "Sortu talde pribatua";

  @override
  String get createPrivateGroupWarning =>
      "TALDE berri bat sortuko duzu. Jendea gehitu dezakezu talde honetan dagoeneko zure taldeko kide badira, hala ez bada, sortu taldea lehenbailehen eta gonbidatu gero.";

  @override
  String get createNewPrivateGroup => "Sortu talde pribatu berria";

  @override
  String get createNewChannelAction =>
      "Open Channel berria sortzear zaude.";

  @override
  String get createNewChannelForAdminsOnly => "Administratzaileek bakarrik dute sarbidea idazteko.";

  @override
  String get openChannelAllMemberAccess => "Taldekide guztiek irakurtzeko sarbidea dute.";

  @override
  String get and => "Eta";

  @override
  String get userIsInactiveToChat =>
      "Ezin duzu erabiltzaile honekin txateatu inaktiboa delako.";

  @override
  String get selectChannel => "Aukeratu kanala";

  @override
  String get needToSelectChannel => "Kanal bat hautatu behar duzu";

  @override
  String get fileAlreadyShared =>
      "Fitxategi hau dagoeneko hautatu duzu kanalean izen berekoarekin.";

  @override
  String get inChannel => "kanalean";

  @override
  String seeAnswerMessages(int count) => "Ikusi $count  mezuak";

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
    return "Erabiltzailea $name  kanalean sartu da";
  }

  @override
  String userHasLeft(String name) {
    return "Erabiltzailea $name  kanala utzi du";
  }

  @override
  String invitedBy(String name) {
    return "Gonbidatuta $name";
  }

  @override
  String get answers => "Erantzunak";

  @override
  String get publishIn => "urtean argitaratu";

  @override
  String get hasCommentedOnThread => "Haria iruzkindu du:";

  @override
  String get unReadMessages => "Irakurri gabeko mezuak";

  @override
  String get hasAddedTag => "Etiketa gehitu du";

  @override
  String get hasAssignedUser => "Erabiltzailea esleitu du";

  @override
  String get hasClosedTask => "Zeregina itxi du";

  @override
  String get hasCommentedTask => "Iruzkin bat gehitu du";

  @override
  String get hasCreatedTask => "Zeregina sortu du";

  @override
  String get hasCreatedTaskAssignedTo => "Esleitutako ataza berria sortu du";

  @override
  String get hasDeleteTag => "Etiketa ezabatu du";

  @override
  String get hasDeletedCommentTask => "Iruzkin bat ezabatu du";

  @override
  String get hasEditedCommentTask => "Iruzkin bat editatu du";

  @override
  String get hasEditedTask => "Zeregina editatu du";

  @override
  String get hasRemovedEndDateTask => "Egunkariaren amaiera data ezabatu du";

  @override
  String get hasReopenedTask => "Zeregina berriro ireki du";

  @override
  String get hasSetMilestone => "Mugarria ezarri du";

  @override
  String get hasUnAssignedUser => "Erabiltzailea esleitu gabe du";

  @override
  String get hasUpdatedDateTask => "Egunkariaren amaiera data eguneratu du";

  @override
  String get inTheTask => "Zereginean";

  @override
  String get to => "ra";

  @override
  String get hasAssignedNewDueDateFor => "Epemuga berria esleitu du";

  @override
  String get createNewTag => "Sortu etiketa berria";

  @override
  String get createNewMilestone => "Mugarri berria sortu";

  @override
  String get editMilestone => "Editatu mugarria";

  @override
  String get editTag => "Editatu etiketa";

  @override
  String get openTasks => "Zeregin irekiak";

  @override
  String get newPersonalNote => "Ohar pertsonal berria";

  @override
  String get createNewPersonalNote => "Sortu ohar pertsonala";

  @override
  String get filterBy => "Iragazi arabera";

  @override
  String hereStartsYourMessagesWith(String name) =>
      "Hemen hasi zure mezuak @ bidez$name";

  @override
  String thisChannelIsManagedBy(String name) =>
      "Kanal hau @-k kudeatzen du $name Laguntza behar baduzu, jarri administratzailearekin harremanetan.";

  @override
  String newPush(String user, String repository, String repositoryUrl) {
    String part1 = "Ren bultzada berria";
    String part2 = "biltegian";
    String part3 = "Xehetasuna";

    return "<p>$part1  <span class = 'link-mention'> @$user</span> $part2  <span> <a href = '$repositoryUrl'>$repository. $part3</a> </span> </p>";
  }

  @override
  String unassignedTask(
    String repository,
    String repositoryUrl,
  ) {
    String part1 = "Esleitu gabeko zeregina biltegian";
    String part2 = "Xehetasuna";
    return "<p>$part1  <a href = '$repositoryUrl'>$repository. $part2</a> </p>";
  }

  @override
  String cardTrelloCreate(
      String board, String boardUrl, String card, String cardUrl, String list) {
    String part1 = "Sortutako txartela";
    String part2 = "zerrendan";
    String part3 = "taula";
    return "<p>$part1  <a href = '$cardUrl'>$card</a> $part2   $list   $part3  <a href = '$boardUrl'>$board</a> </p>";
  }

  @override
  String cardTrelloRename(String board, String boardUrl, String oldName,
      String newName, String list) {
    String part1 = "Zerrendan";
    String part2 = "batzordetik";
    String part3 = "txartelaren izena aldatu da";
    String part4 = "ra";
    return "<p>$part1 '$list' $part2 <a href='$boardUrl'>$board</a> $part3 '$oldName' $part4 '$newName'</p>";
  }

  @override
  String cardTrelloDescriptionChange(String board, String boardUrl, String card,
      String cardUrl, String list, String description) {
    String part1 = "Txartela";
    String part2 = "zerrendako";
    String part3 = "batzordetik";
    String part4 = "deskribapena aldatu du";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4 '$description'</p>";
  }

  @override
  String cardTrelloMoveToOtherList(String board, String boardUrl, String card,
      String cardUrl, String oldList, String newList) {
    String part1 = "Txartela";
    String part2 = "zerrendatik mugitu da";
    String part3 = "zerrendara";
    String part4= "taula gainean";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$oldList' $part3 '$newList' $part4 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloArchive(String board, String boardUrl, String card,
      String cardUrl, String list) {
    String part1 = "Txartela";
    String part2 = "zerrendako";
    String part3 = "batzordetik";
    String part4 = "artxibatu egin da";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4</p>";
  }

  @override
  String get comments => "Iruzkinak";

  @override
  String get addComment => "Gehitu iruzkina";

  @override
  String get editComment => "Editatu iruzkina";

  @override
  String get downloadAppsAndSynchronizer =>
      "<a href ='https://noysi.com/a/#/downloads'>DESKARGATU APLIKAZIOAK ORAIN!</a>";

  @override
  String get welcomeToNoysiFirstName => "Ongi etorri! Hau zure kanal pertsonala da, beste inork ez du ikusiko, ez duzu inorekin komunikaziorik, zure kanal pertsonala da ohar pertsonalak uzteko eta inork ikusiko ez dituen fitxategiak igotzeko. Zein da zure izena?";

  @override
  String get welcomeToNoysiTimeout =>
      "Ez didazu erantzun! Laguntza behar baduzu, egin klik <a href = '${Endpoint.helpUrl}'> hemen. </a>";

  @override
  String get wrongUsernamePassword => "Erabiltzaile edo pasahitz okerra";

  @override
  String get userInUse => "Erabiltzaile hau dagoeneko erabiltzen ari da";

  @override
  String get invite => "Gonbidatu";

  @override
  String get groupRequired => "Taldea beharrezkoa da";

  @override
  String get uploading => "Kargatzen";

  @override
  String get downloading => "Deskargatzen";

  @override
  String get inviteGuestsWarning => "Gonbidatuak talde honetako talde bakarrean sartzen dira.";

  @override
  String get addMembers => "Gehitu kideak";

  @override
  String get enterEmailsByComma =>
      "Idatzi mezu elektronikoak komaz bereiziz:";

  @override
  String get firstName => "Izena";

  @override
  String get inviteFewMorePersonal => "Batzuk gonbidatu eta pertsonalagoak izan";

  @override
  String get inviteManyAtOnce => "Gonbidatu asko aldi berean";

  @override
  String get addGuests => "Gehitu gonbidatuak";

  @override
  String get followThread => "Jarraitu hari honi";

  @override
  String get markThreadAsRead => "Markatu irakurrita";

  @override
  String get stopFollowingThread => "Hari honi jarraitzeari utzi";

  @override
  String get needToVerifyAccountToInvite =>
      "Posta elektronikoko kontua egiaztatu behar duzu kideak gonbidatzeko.";

  @override
  String get createANewTeam => "Sortu talde berria";

  @override
  String get createNewTeam => "Sortu talde berria!";

  @override
  String get enterIntoYourAccount => "Sartu zure kontuan";

  @override
  String get forgotPassword => "Zure pasahitza ahaztu duzu?";

  @override
  String get goAhead => "Segi aurrera!";

  @override
  String get passwordRestriction => "Pasahitzak gutxienez zortzi karaktere izan behar ditu zenbaki bat, maiuskula bat eta minuskula bat; karaktere bereziak erabil ditzakezu @ # \$% ^ & + = eta hamar karaktere edo gehiago zure pasahitzaren segurtasuna hobetzeko.";

  @override
  String get recoverYorPassword => "Berreskuratu zure pasahitza";

  @override
  String get recoverYorPasswordWarning => "Pasahitza berreskuratzeko, idatzi noysi.com-en saioa hasteko erabiltzen duzun helbide elektronikoa";

  @override
  String recoverPasswordResponse(String email) {
    return "Mezu elektroniko bat bidali dizugu $email";
  }

  @override
  String get recoverPasswordResponse1 =>
      "Begiratu sarrera ontzia eta jarraitu argibideak bertan pasahitz berria sortzeko";

  @override
  String get continueStr => "Jarraitu";

  @override
  String get passwordAtLeast1SpecialChar => "Pasahitzak gutxienez karaktere berezi bat izan behar du @#\$%^&+=";

  @override
  String welcomeToNoysiLastName(String name) => "Kaixo $name. Zein da zure abizena?";

  @override
  String get welcomeToNoysiDescription => "Oso ondo. Dena zuzena da. Zure profila eguneratzen jarraituko dut.";

  @override
  String get welcomeToNoysiInvite => "<a href = '#'>Gonbidatu taldekideak orain!</a>";

  @override
  String get activeFilter => "Iragazki aktiboa";

  @override
  String get newFileComment => "Iruzkin berria fitxategian";

  @override
  String get removed => "Kendu";

  @override
  String get sharedOn => "Noiz partekatua";

  @override
  String get notifyAllInThisChannel => "jakinarazi kanal honetako guztiei";

  @override
  String get notifyAllMembers => "jakinarazi kide guztiei";

  @override
  String get keepPressingToRecord => "Jarrai ezazu botoia sakatzen grabatzeko";

  @override
  String get slideToCancel => "Pasatu hatza bertan behera uzteko";

  @override
  String get chooseASecurePasswordText => "Erraz gogoratu dezakezun pasahitza aukeratu";

  @override
  String get confirmPassword => "Pasahitza errepikatu";

  @override
  String get yourPassword => "Pasahitza";

  @override
  String get passwordDontMatch => "Pasahitzak ez datoz bat";

  @override
  String get changeCreateTeamMail => "Ez, mezu elektronikoa aldatu nahi dut";

  @override
  String step(int number) => "$number. urratsa";

  @override
  String get user => "Erabiltzailea";

  @override
  String get deleteFolderWarning => "Karpeta behin betiko ezabatuko da eta ezin da berreskuratu";

  @override
  String get calendar => "Egutegia";

  @override
  String get week => "Astea";

  @override
  String get folderIsNotInCurrentTeam => "Karpeta ez dago uneko taldearekin lotuta";

  @override
  String get folderIsNotInAvailableChannel => "Aipatutako karpeta ez dago fitxategi esploratzailean eskuragarri dagoen kanal batean";

  @override
  String get folderLinked => "Karpetarako esteka kanalean kopiatu da";

  @override
  String get folderShared => "Karpeta kanalean partekatu da";

  @override
  String get folderUploaded => "Karpeta kanalera igo da";

  @override
  String get folderNotFound => "Karpeta ez da aurkitu";

  @override
  String get folderNameIncorrect => "Karpetaren izenak ez du balio";

  @override
  String get cloneFolder => "Klonatu karpeta";

  @override
  String get cloneFolderInfo => "Karpeta bat klonatzeak karpeta berri bat sortzen du helmuga kanalean hautatutako karpetaren egoera eta eduki berdina une honetan.";

  @override
  String get folderDeleted => "Ezin da ezabatutako karpeta batera sartu";

  @override
  String get youWereInADeletedFolder => "Bertan zegoen karpeta ezabatu egin da";

  @override
  String get dateFormat6 => "MM/dd/yyyy";

  @override
  String get createdTask => "Zeregina sortu da";

  @override
  String get loggedIn => "Saioa hasita";

  @override
  String get mention => "Aipatu";

  @override
  String get messageSent => "Mezua bidali da";

  @override
  String get taskAssigned => "Esleitutako zeregina";

  @override
  String get taskUnassigned => "Esleitu gabeko zeregina";

  @override
  String get uploadedFile => "Kargatutako fitxategia";

  @override
  String get uploadedFileFolder => "Fitxategia / karpeta kargatua";

  @override
  String get uploadedFolder => "Kargatutako karpeta";

  @override
  String get downloadedFile => "Deskargatutako fitxategia";

  @override
  String get downloadedFileFolder => "Deskargatutako fitxategia / karpeta";

  @override
  String get downloadedFolder => "Deskargatutako karpeta";

  @override
  String get messageUnavailable => "Mezua ez dago erabilgarri";

  @override
  String get activityZone => "Jarduera gunea";

  @override
  String get categories => "Kategoriak";

  @override
  String get category => "Kategoria";

  @override
  String get clearAll => "Garbitu dena";

  @override
  String get errorFetchingData => "Errorea datuak eskuratzean";

  @override
  String get filters => "Iragazkiak";

  @override
  String get openSessions => "Saio Irekiak";

  @override
  String activityFileFolderUploadedDownloaded(String user, String name, String channel, {bool download = false, bool isDirect = false, isFolder = false}) {
    String part1 = "${download ? "Deskargatu duzu" : "Kargatu duzu"}${isFolder ? " Karpeta " : " fitxategia "}";
    String part2 = download ? "kanaletik" : "Kanalean";
    return "$part1 <i class=\"mention-generic\">$name</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMentioned(String user, String channel, {bool isDirect = false}) {
    String part1 = "Kanalean aipatu zaituzte";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMessageSent(String user, String channel, {bool isDirect = false}) {
    String part1 = "Kanalean mezu bat bidali duzu";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activitySignedIn(String sessionInfo, String ip) {
    return "Saioa hasi zara <i class=\"mention-generic\">$sessionInfo</i> IP: <i class=\"mention-generic\">$ip</i>";
  }

  @override
  String activityTaskAssigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Zeregin horretara esleitu zaituzte";
    String part2 = "Kanalean";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskCreated(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Zeregina sortu duzu";
    String part2 = "Kanalean";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskUnassigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Zereginetik banatu zaituzte";
    String part2 = "Kanalean";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String get activityZoneHeader => "Hortik hasten da Activity Zone";

  @override
  String get selectEvent => "Aukeratu gertaera";

  @override
  String get googleCalendar => "Google";

  @override
  String get outlookCalendar => "Outlook";

  @override
  String get noysiCalendar => "Noysi";

  @override
  String get autogenerateRoomNameQuestion => "Gelaren izena automatikoki sortu nahi duzu?";

  @override
  String get createMeetingEvent => "Sortu Gertaera-Bilera";

  @override
  String get externalGuests => "Kanpoko gonbidatuak";

  @override
  String get internalGuests => "Barruko gonbidatuak";

  @override
  String get newMeetingEvent => "Ekitaldi-Topaketa berria";

  @override
  String get roomName => "Gelaren izena";

  @override
  String get eventMeeting => "Ekitaldi-Topaketa";

  @override
  String get personalNote => "Ohar pertsonala";

  @override
  String get updateExternalGuests => "Eguneratu kanpoko gonbidatuak";

  @override
  String get nameTextWarning => "Testua 1-25 karaktereko kate alfanumeriko bati dagokio. Zuriuneak eta _ - karaktereak ere erabil ditzakezu";

  @override
  String get nameTextWarningWithoutSpaces => "Testua zuriunerik gabeko 1-18 karaktereko kate alfanumeriko bati dagokio. _ - karaktereak ere erabil ditzakezu";

  @override
  String get today => "Gaur";

  @override
  String get location => "Lekua";


  @override
  String get sessions => "Saioak";

  @override
  String get appVersion => "Aplikazioaren bertsioa";

  @override
  String get browser => "Arakatzailea";

  @override
  String get device => "Gailua";

  @override
  String get logout => "Saioa itxi";

  @override
  String get manufacturer => "Sortzailea";

  @override
  String get no => "Ez";

  @override
  String get operativeSystem => "Sistema eragilea";

  @override
  String get yes => "Bai";

  @override
  String get allDay => "Egun osoan";

  @override
  String get endDate => "Amaiera Data";

  @override
  String get noTitle => "Izenbururik gabe";

  @override
  String get currentSession => "Oraingo Saioa";

  @override
  String get logOutAllExceptForThisOne => "Amaitu saioa gailu guztietan, hau izan ezik";

  @override
  String get terminateAllOtherSessions => "Amaitu gainerako saio guztiak";

  @override
  String get closeAllSessionsConfirmation => "Beste saio guztiak amaitu nahi dituzu?";

  @override
  String get closeSessionConfirmation => "Saioa amaitu nahi duzu?";

  @override
  String get connectionLost => "Badirudi ez dagoela loturarik";

  @override
  String get connectionEstablished => "Sarera itzuli zara";

  @override
  String get connectionStatus => "Konexioaren egoera";

  @override
  String get anUserIsCalling => "Erabiltzaile bat deitzen ari zaizu ...";

  @override
  String get answer => "Erantzun";

  @override
  String get hangDown => "Zintzilikatu";

  @override
  String get incomingCall => "Sarrerako deia";

  @override
  String isCallingYou(String user) => "$user deitzen ari zaizu ...";

  @override

  String get callCouldNotBeInitialized => "Ezin izan da deia hasieratu";

  @override
  String get sentMessages => "Bidalitako mezuak";

  @override
  String sentMessagesCount(String count) => "$count de 10000";

  @override
  String get teamDataUsage => "Taldeko datuen erabilera";

  @override
  String get usedStorage => "Erabilitako biltegia";

  @override
  String usedStorageText(String used) => used + "GB de 5GB";

  @override
  String get userDataUsage => "Erabiltzaileen datuen erabilera";

  @override
  String get audioEnabled => "Audio gaituta";

  @override
  String get meetingOptions => "Bileraren aukerak";

  @override
  String get videoEnabled => "Bideoa gaituta";

  @override
  String get dontShowThisMessage => "Ez erakutsi berriro";

  @override
  String get showDialogEveryTime => "Erakutsi elkarrizketa bilera bat hasten den bakoitzean";

  @override
  String get micAndCameraRequiredAlert => "Kamera eta mikrofonoa atzitzeko baimenak behar dira. Ziurtatu beharrezko baimenak eman dituzula. Baimenen ezarpenetara joan nahi duzu?";

  @override
  String get connectWith => "Konektatu honekin";

  @override
  String get or => "edo";

  @override
  String get noEvents => "Ez dago gertaerarik, zereginik edo ohar pertsonalik";

  @override
  String get viewDetails => "Ikusi xehetasunak";

  @override
  String zendeskTicketUpdated(String user, String status, String type, String title, String url) {
    String part1 = R.string.user;
    String part2 = "txartela eguneratu du";
    String part3 = "motakoak";
    String part4 = "egoerara";
    String part5 = R.string.viewDetails;
    return "<p>$part1 '$user' $part2 '$title' $part3 '$type' $part4 '$status'. <span><a href='$url'>$part5</a></span></p>";
  }


  @override
  String get accept => "Onartu";

  @override
  String get busy => "Lanpetuta";

  @override
  String get configuration => "Konfigurazioa";

  @override
  String get downloads => "Deskargak";

  @override
  String get editTeam => "Editatu taldea";

  @override
  String get general => "Orokorra";

  @override
  String get integrations => "Integrazioak";

  @override
  String get noRecents => "Ez dago berririk";

  @override
  String get noRecommendations => "Gomendiorik ez";

  @override
  String get inAMeeting => "Bilera batean";

  @override
  String get onFire => "On Fire";

  @override
  String get plans => "Planoak";

  @override
  String get setAStatus => "Ezarri Egoera";

  @override
  String get sick => "Gaixo";

  @override
  String get signOut => "Amaitu saioa";

  @override
  String get suggestions => "Iradokizunak";

  @override
  String get teams => "Taldeak";

  @override
  String get traveling => "Bidaiatzea";

  @override
  String get whatsYourStatus => "Zein da zure egoera?";

  @override
  String get sendAlwaysAPush => "Bidali beti push jakinarazpena";

  @override
  String get robot => "Robota";

  @override
  String get deactivateUserWarning => "Taldekideek ezin izango dute kide batekin komunikatu desgaituta dagoen bitartean. Hala ere, desaktibatuta dagoen kideak Noysi-n egiten duen jarduera guztiak bere horretan jarraituko du eta mezuak (kanal irekiak, 1etik 1erako mezuak eta talde pribatuak), fitxategiak eta zereginak eskuragarri egongo dira.";

  @override
  String get activateUserWarning => "Kideak berriro aktibatu ondoren, desaktibatu aurretik zeukan kanal, talde, fitxategi eta zeregin berberetarako sarbidea berreskuratuko du.";

  @override
  String get changeRole => "Rola aldatu";

  @override
  String get userStatus => "Erabiltzaile egoera";

  @override
  String get deactivateMyAccount => "Desaktibatu nire kontua";

  @override
  String get deactivateMyAccountWarning => "Zure kontua desaktibatzen baduzu, zure talde, elkarrizketa, fitxategi, zeregin eta Noysiren bidez kudeatu dituzun jarduera guztietan desaktibatu egingo zara administratzaile batek berriro aktibatu arte.";

  @override
  String get deactivateMyUserInThisTeam => "Desaktibatu nire erabiltzailea talde honetan";

  @override
  String get deactivateMyUserInThisTeamWarning => "Talde batean zure burua desaktibatzen duzunean talde horretan duzun guztia mantenduko da berriro aktibatu arte. Taldeko administratzaile bakarra bazara, taldea ez da ezabatuko.";

  @override
  String get operationConfirmation => "AZiur al zaude operazio honetaz?";

  @override
  String get formatNotSupported => "Formatu edo luzapen hau ez du sistema eragileak onartzen";

  @override
  String get invitePrivateGroupLink => "Gonbidatu kide bat taldera esteka hau erabiliz";

  @override
  String get invalidPhoneNumber => "Invalid phone number";

  @override
  String get searchByCountryName => "Bilatu herrialdearen izenaren edo markatze-kodearen arabera";

  @override
  String get kick => "kanporatu";

  @override
  String get deleteAll => "Ezabatu guztiak";

  @override
  String get enterKeyManually => "Sartu tekla eskuz";

  @override
  String get noysiAuthenticator => "Noysi Autentifikatzailea";

  @override
  String get qrScanner => "QR";

  @override
  String get otpLabelWarning => "OTP etiketa zuriunerik gabeko kate alfanumeriko bat da :@.,;()\$% ere onartzen dira";

  @override
  String get invalidBase32Chars => "Oinarrizko 32 karaktere baliogabeak";

  @override
  String get label => "Etiketa";

  @override
  String get secretCode => "Giltza sekretua";

  @override
  String get labelTextWarning => "Etiketa hutsik dago, egiaztatu balio hau";

  @override
  String missedCallFrom(String user) => "Dei galdua $user";

  @override
  String get activeItemBackgroundColor => "Elementu aktiboaren atzeko planoa";

  @override
  String get activeItemTextColor => "Elementu aktiboaren testua";

  @override
  String get activePresenceColor => "Presentzia aktiboa";

  @override
  String get adminsCanDeleteMessage => "Administratzaileek mezuak ezabatu ditzakete";

  @override
  String get allForAdminsOnly => "@guztia Administratzaileentzat soilik";

  @override
  String get channelForAdminsOnly => "@channel Administratzaileentzat eta Kanalen Sortzaileentzat soilik";

  @override
  String get chooseTheme => "Aukeratu zure talderako gai bat";

  @override
  String get enablePushAllChannels => "Gaitu push jakinarazpenak kanal guztietan";

  @override
  String get inactivePresenceColor => "Presentzia inaktiboa";

  @override
  String get leaveTeam => "Utzi talde hau";

  @override
  String get leaveTeamWarning => "Talde bat uzten duzunean talde horretan duzun guztia ezabatuko da. Taldeko administratzaile bakarra bazara, taldea ezabatu egingo da.";

  @override
  String get notificationBadgeBackgroundColor => "Txapa atzeko planoa";

  @override
  String get notificationBadgeTextColor => "Txapa Testua";

  @override
  String get onlyAdminInvitesAllowed => "Administratzaileek soilik baimendutako gonbidatuak";

  @override
  String get reset => "Berrezarri";

  @override
  String get settings => "Ezarpenak";

  @override
  String get sidebarColor => "Alboko barraren kolorea";

  @override
  String get taskUpdateProtected => "Sortzaileentzako eta Administratzaileentzako gordetako Zereginen aldaketa";

  @override
  String get teamName => "Taldearen izena";

  @override
  String get textColor => "Testuaren kolorea";

  @override
  String get theme => "Gaia";

  @override
  String get updateUsernameBlocked => "Blokeatu erabiltzaile-izena gonbidapena bidaltzean";

  @override
  String get fileNotFound => "Fitxategia ez da aurkitu";

  @override
  String get messageNotFound => "Ez da mezua aurkitu. Mesedez, egiaztatu bilatzen ari zaren mezua uneko taldean eskuragarri dagoen.";

  @override
  String get taskNotFound => "Ez da aurkitu zeregina";

  @override
  String userHasPinnedMessage(String name) => "$name mezu bat ainguratu du kanalean";

  @override
  String userHasUnpinnedMessage(String name) => "$name kanal honetako mezuari aingura kendu dio";

  @override
  String get pinMessage => "Ainguratu mezua";

  @override
  String get unpinMessage => "Kendu mezua";

  @override
  String get pinnedMessage => "Ainguratutako mezua";

  @override
  String get deleteMyAccount => "Ezabatu nire kontua";

  @override
  String get yourDeleteRequestIsInProcess => "Zure kontua ezabatzeko eskaera prozesuan dago";

  @override
  String get deleteMyAccountWarning => "Zure kontua ezabatzen baduzu ekintza atzeraezina izango da. Talde bat kudeatzen baduzu eta beste administratzailerik ez badago, taldea ezabatu egingo da.";

  @override
  String get lifetimeDeal => "Bizi osorako eskaintzak";

  @override
  String get showEmails => "Erakutsi erabiltzailearen mezu elektronikoak";

  @override
  String get showPhoneNumbers => "Erakutsi erabiltzailearen telefono zenbakiak";

  @override
  String get addChannel => "Gehitu kanala";

  @override
  String get addPrivateGroup => "Gehitu talde pribatua";

  @override
  String get selectUserFromTeam => "Hautatu talde honetako erabiltzailea";

  @override
  String get selectUsersFromChannelGroup => "Hautatu erabiltzaileak kanal edo taldetik";

  @override
  String get memberDeleted => "Ezabatu da kidea";
}


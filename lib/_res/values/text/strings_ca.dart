import 'dart:ui';
import 'package:code/_res/values/config.dart';
import 'package:code/_res/values/text/strings_base.dart';

import '../../../data/api/remote/endpoints.dart';
import '../../R.dart';


class StringsCa implements StringsBase {
  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Noysi";

  @override
  String get yourTeams => "Els vostres equips";

  @override
  String get channel => "Canal";

  @override
  String get channels => "Canals";

  @override
  String get directMessagesAbr => "DM";

  @override
  String get email => "Correu electrònic";

  @override
  String get home => "Inici";

  @override
  String get member => "Membre";

  @override
  String get administrator => "Administrador";

  @override
  String get guest => "Convidat";

  @override
  String get guests => "Convidats";

  @override
  String get members => "Membres";

  @override
  String get inactiveMember => "Membre desactivat";

  @override
  String get message => "Missatge";

  @override
  String get messages => "Missatges";

  @override
  String get password => "Contrasenya";

  @override
  String get register => "Registra't";

  @override
  String get search => "Cerca";

  @override
  String get signIn => "Inicieu la sessió";

  @override
  String get task => "Tasca";

  @override
  String get tasks => "Tasques";

  @override
  String get createTask => "Crea una tasca";

  @override
  String get newTask => "Nova tasca";

  @override
  String get description => "Descripció";

  @override
  String get team => "Equip";

  @override
  String get thread => "Fil";

  @override
  String get threads => "Fils";

  @override
  String get createTeam => "Crea equip";

  @override
  String get confirmIsCorrectEmailAddress => "Sí! Aquest és el correu electrònic correcte";

  @override
  String get createTeamIntro =>
      "Esteu a punt de configurar el vostre nou equip a Noysi.";

  @override
  String get isCorrectEmailAddress => "Aquesta és l'adreça electrònica correcta?";

  @override
  String get welcome => "Benvingut!";

  @override
  String get invitationSentAt => "La vostra invitació s’enviarà a:";

  @override
  String get next => "Pròxim";

  @override
  String get startNow => "Comença ara!";

  @override
  String get charsRemaining => "Caràcters restants:";

  @override
  String get teamNameOrgCompany =>
      "Introduïu el nom de l’equip, l’organització o el nom de l’empresa.";

  @override
  String get teamNameOrgCompanyLabel => "Ex. Nom de la meva empresa";

  @override
  String get yourTeam => "El vostre equip";

  @override
  String get noysiServiceNewsletters =>
      "Està bé rebre correus electrònics (molt de tant en tant) sobre el servei NOYSI.";

  @override
  String get userNameIntro =>
      "El vostre nom d’usuari és la forma en què apareix a la resta d’equips.";

  @override
  String get userNameLabel => "Ex. ackerman";

  @override
  String get addAnother => "Afegiu-ne un altre";

  @override
  String get byProceedingAcceptTerms =>
      "* En continuar, accepteu les nostres <b> Condicions del servei </b>";

  @override
  String get invitations => "Invitacions";

  @override
  String get invitePeople => "Convida gent";

  @override
  String get noysiIsTeamWorkInvite =>
      "Noysi és una eina de treball en equip. Convida almenys una persona";

  @override
  String get userName => "Nom d'usuari";

  @override
  String get fieldMax18 => "18 caràcters com a màxim";

  @override
  String get fieldMax25 => "25 caràcters com a màxim";

  @override
  String get fieldPassword => "Cal una contrasenya";

  @override
  String get fieldRequired => "Camp obligatori";

  @override
  String get missingEmailFormat => "Correu electrònic incorrecte";

  @override
  String get back => "esquena";

  @override
  String get channelBrowser => "Navegador de canals";

  @override
  String get help => "Ajuda";

  @override
  String get preferences => "Preferències";

  @override
  String get signOutOf => "Tanqueu la sessió";

  @override
  String get closed => "Tancat";

  @override
  String get closedMilestone => "Tancat";

  @override
  String get close => "Tanca";

  @override
  String get opened => "Obert";

  @override
  String get chat => "Xatejar";

  @override
  String get allThreads => "Tots els fils";

  @override
  String get inviteMorPeople => "Convida més persones";

  @override
  String get meeting => "Reunió";

  @override
  String get myFiles => "Els meus fitxers";

  @override
  String get myTasks => "Les meves tasques";

  @override
  String get myTeams => "Els meus equips";

  @override
  String get openChannels => "Canals oberts";

  @override
  String get privateGroups => "Grups privats";

  @override
  String get favorites => "Preferits";

  @override
  String get message1x1 => "Missatges 1 a 1";

  @override
  String get acceptedTitle => "Acceptat";

  @override
  String get date => "Data";

  @override
  String get invitationLanguageTitle => "Llenguatge idiomàtic";

  @override
  String get invitationMessage => "Missatge d’invitació";

  @override
  String get revokeInvitation => "Revoca la invitació";

  @override
  String get revoke => "Revocar";

  @override
  String get revokeInvitationWarning =>
      "Vés amb compte, aquesta acció no és reversible";

  @override
  String get revokeInvitationDelete => "Eliminació de la invitació";

  @override
  String get resendInvitationBefore24hrs =>
      "No es permet tornar a enviar invitacions fins a les 24 hores posteriors a l’últim enviament.";

  @override
  String get resendInvitationSuccess => "Les invitacions s’han enviat correctament.";

  @override
  String get resendInvitation => "Torna a enviar la invitació";

  @override
  String get invitationMessageDefault =>
      "Hola! Aquí teniu una invitació per unir-vos";

  @override
  String get inviteManyAsOnce => "Convida molts com una vegada";

  @override
  String get inviteMemberTitle =>
      "Els membres de l’equip tenen accés complet a canals oberts, missatges de persona a persona i grups.";

  @override
  String get inviteMemberWarningTitle =>
      "Per convidar nous membres, heu de ser l’administrador de l’equip.";

  @override
  String get inviteNewMemberWarningTitle =>
      "Qualsevol membre de l'equip pot afegir convidats de forma il·limitada.";

  @override
  String get inviteSubtitle =>
      "Noysi és una eina per treballar millor amb el vostre equip. Convideu-los ara.";

  @override
  String get inviteTitle => "Convida altres persones";

  @override
  String get inviteToAGroup => "Convida a un grup (obligatori)";

  @override
  String get inviteToAGroupNotRequired => "Convida a un grup (opcional)";

  @override
  String get inviteMemberWarning =>
      "Els nous membres s’incorporaran automàticament al canal #general. Opcionalment, també podeu afegir-los a un grup privat ara.";

  @override
  String get inviteToThisTeam => "Convida a aquest equip";

  @override
  String get invitationsSent => "Invitacions enviades";

  @override
  String get name => "Nom";

  @override
  String get noPendingInvitations =>
      "No hi ha invitacions per enviar a aquest equip.";

  @override
  String get pendingTitle => "Pendents";

  @override
  String get chooseTitle => "Trieu";

  @override
  String get seePendingAcceptedInvitations =>
      "Veure invitacions pendents i acceptades";

  @override
  String get sendInvitations => "Enviar invitacions";

  @override
  String get typeEmail => "Escriviu un correu electrònic";

  @override
  String get typeEmailComaSeparated => "Escriviu els correus electrònics separats per coma";

  @override
  String get atNoysi => "a Noysi";

  @override
  String get inviteNewMemberTitle =>
      "Els convidats no paguen i podeu convidar-ne tants com vulgueu, però només tindran accés a un grup d’aquest equip.";

  @override
  String get invited => "Convidat";

  @override
  String get thisNameAlreadyExist =>
      "Sembla que aquest nom ja està en ús.";

  @override
  String get emptyList => "Llista buida";

  @override
  String get ok => "D'acord";

  @override
  String get byNameFirst => "Per nom A-Z";

  @override
  String get byNameInvertedFirst => "Per nom Z-A";

  @override
  String get download => "descarregar";

  @override
  String get files => "Fitxers";

  @override
  String get folders => "Carpetes";

  @override
  String get newTitle => "Novetat";

  @override
  String get newestFirst => "El més nou primer";

  @override
  String get oldestFirst => "El més antic primer";

  @override
  String get see => "Veure";

  @override
  String get share => "Compartir";

  @override
  String get moreInfo => "Més informació";

  @override
  String get assigned => "Assignat";

  @override
  String get author => "Autor";

  @override
  String get created => "Creat";

  @override
  String get earlyDeliverDate => "Data d’entrega anticipada";

  @override
  String get farDeliverDate => "Data de lliurament llunyana";

  @override
  String get filterAuthor => "Filtra per autor";

  @override
  String get searchUsers => "Cerca usuaris";

  @override
  String get sort => "Ordena";

  @override
  String get sortBy => "Ordenar per";

  @override
  String get cancel => "Cancel · lar";

  @override
  String get exit => "Surt";

  @override
  String get exitWarning => "Estàs segur?";

  @override
  String get deleteChannelWarning =>
      "Esteu segur que voleu deixar aquest canal?";

  @override
  String get typeMessage => "Escriviu un missatge ...";

  @override
  String get addChannelToFavorites => "Afegir a preferits";

  @override
  String get removeFromFavorites => "Elimina dels preferits";

  @override
  String get channelInfo => "Informació del canal";

  @override
  String get channelMembers => "Membres del canal";

  @override
  String get channelPreferences => "Preferències del canal";

  @override
  String get closeChatVisibility => "Tanca l’1 a l’1";

  @override
  String get inviteToGroup => "Convida un membre a aquest canal";

  @override
  String get leaveChannel => "Surt del canal";

  @override
  String get mentions => "Mencions";

  @override
  String get seeFiles => "Veure fitxers";

  @override
  String get seeLinks => "Veure enllaços";

  @override
  String get links => "Enllaços";

  @override
  String get taskManager => "Cap de tasques";

  @override
  String get videoCall => "Videotrucada";

  @override
  String get addReaction => "Afegiu la reacció";

  @override
  String get addTag => "Afegeix una etiqueta";

  @override
  String get addMilestone => "Afegiu una fita";

  @override
  String get copyMessage => "Copia el missatge";

  @override
  String get copyPermanentLink => "Copia l'enllaç";

  @override
  String get createThread => "Inicieu un fil";

  @override
  String get edit => "Edita";

  @override
  String get favorite => "Preferit";

  @override
  String get remove => "Elimina";

  @override
  String get tryAgain => "Torna-ho a provar";

  @override
  String get dateFormat1 => "MMM dd, yyyy h:mm";

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
      "Esteu segur que voleu suprimir aquest missatge? Això no es pot desfer.";

  @override
  String get deleteMessageTitle => "Suprimeix el missatge";

  @override
  String get edited => "Editat";

  @override
  String get seeAll => "Veure tot";

  @override
  String get copiedToClipboard => "S'ha copiat al porta-retalls.";

  @override
  String get underConstruction => "En construcció";

  @override
  String get reactions => "Reaccions";

  @override
  String get all => "Tots";

  @override
  String get users => "Usuaris";

  @override
  String get documents => "Documents";

  @override
  String get fromLocalStorage => "Des de l’emmagatzematge local";

  @override
  String get photoGallery => "galeria de fotos";

  @override
  String get recordVideo => "Grava un vídeo";

  @override
  String get takePhoto => "Fer una foto";

  @override
  String get useCamera => "Des de la càmera";

  @override
  String get videoGallery => "Galeria de vídeos";

  @override
  String get changeName => "Canvia el nom";

  @override
  String get createFolder => "Crea una carpeta";

  @override
  String get createNameWarning =>
      "Els noms han de tenir un màxim de 18 caràcters, sense signes de puntuació.";

  @override
  String get newName => "Nom nou";

  @override
  String get rename => "Canvia el nom";

  @override
  String get renameFile => "Canvia el nom del fitxer";

  @override
  String get renameFolder => "Canvia el nom de la carpeta";

  @override
  String get deleteFile => "Esborrar Arxiu";

  @override
  String get deleteFolder => "Suprimeix la carpeta";

  @override
  String get deleteFileWarning => "La carpeta s'eliminarà permanentment i no podrà ser recuperada. La carpeta serà inaccessible des de qualsevol enllaç.";

  @override
  String get delete => "Suprimeix";

  @override
  String get open => "Obert";

  @override
  String get addCommentOptional => "Afegeix un comentari (opcional)";

  @override
  String get shareFile => "Compartir fitxer";

  @override
  String get groups => "Grups";

  @override
  String get to1_1 => "1 a 1";

  @override
  String get day => "dia";

  @override
  String get days => "Dies";

  @override
  String get hour => "hores";

  @override
  String get hours => "hores";

  @override
  String get minute => "minut";

  @override
  String get minutes => "minuts";

  @override
  String get month => "Mes";

  @override
  String get months => "Mesos";

  @override
  String get year => "curs";

  @override
  String get years => "anys";

  @override
  String get by => "per";

  @override
  String get deliveryDateIn => "Data de venciment en";

  @override
  String get ago => "Fa";

  @override
  String get taskOpened => "Obert";

  @override
  String get assignees => "Cessionaris";

  @override
  String get assigneeBy => "Assignat per";

  @override
  String get closeTask => "Tanca la tasca";

  @override
  String get comment => "Comenta";

  @override
  String get deliveryDate => "Data de venciment";

  @override
  String get leaveAComment => "Deixa un comentari";

  @override
  String get milestone => "Fita";

  @override
  String get milestones => "Fites";

  @override
  String get color => "Color";

  @override
  String get milestoneAdded => "Afegit a la fita";

  @override
  String get participants => "Participants";

  @override
  String get reopen => "Torna a obrir";

  @override
  String get completed => "Completat";

  @override
  String get dueDateUpdated => "Data de venciment actualitzada";

  @override
  String get dueDate => "Data de venciment";

  @override
  String get lastDueDate => "Darrera data de venciment";

  @override
  String get commented => "Comentat";

  @override
  String get tagAdded => "S'ha afegit l'etiqueta";

  @override
  String get tagRemoved => "S'ha suprimit l'etiqueta";

  @override
  String get tags => "Etiquetes";

  @override
  String get update => "Actualització";

  @override
  String get details => "Detalls";

  @override
  String get timeline => "Cronologia";

  @override
  String get aboutMe => "Sobre mi";

  @override
  String get acceptNews => "Rep novetats";

  @override
  String get allActive => "Tot actiu";

  @override
  String get changePhoto => "Canvia la foto";

  @override
  String get changeYourPassword => "Canvia la teva contrasenya";

  @override
  String get changeYourPasswordAdvice =>
      "La contrasenya ha de tenir com a mínim vuit caràcters, inclosos un número, una majúscula i una minúscula. Podeu utilitzar caràcters especials com @ # \$% ^ & + = i deu o més caràcters per millorar la seguretat de la vostra contrasenya.";

  @override
  String get charge => "Càrrec";

  @override
  String get country => "País";

  @override
  String get disabled => "Desactivat";

  @override
  String get emailNotification => "Notificacions per correu electrònic";

  @override
  String get language => "Llenguatge";

  @override
  String get lastName => "Cognom";

  @override
  String get maxEveryHour => "Cada hora";

  @override
  String get maxHalfDay => "Cada 12 hores";

  @override
  String get messages1x1AndMentions => "Missatges 1x1 i @mentions";

  @override
  String get myProfile => "El meu perfil";

  @override
  String get never => "Mai";

  @override
  String get newPassword => "Nova contrasenya";

  @override
  String get newsLetters => "Cartes de notícies";

  @override
  String get notReceiveNews => "No rebeu novetats";

  @override
  String get notifications => "Notificacions";

  @override
  String get passwordRequirements =>
      "Canvieu la contrasenya periòdicament per augmentar la vostra seguretat i protecció";

  @override
  String get phoneNotifications => "Notificacions per telèfon";

  @override
  String get phoneNumber => "Número de telèfon";

  @override
  String get photoSizeRestrictions =>
      "Utilitzeu una foto quadrada amb una amplada màxima de 400 px (petita)";

  @override
  String get repeatNewPassword => "Repetiu la contrasenya nova";

  @override
  String get security => "Seguretat";

  @override
  String get skypeUserName => "Usuari d’Skype";

  @override
  String get sounds => "Sons";

  @override
  String get yourUserName => "El teu nom d'usuari";

  @override
  String get saveChanges => "Guardar canvis";

  @override
  String get profileEmailUsesWarning =>
      "Aquest correu electrònic només s’utilitza per a notificacions d’aquest equip.";

  @override
  String get pushMobileNotifications => "Notificacions push per a mòbils";

  @override
  String get saveNotificationChanges => "Desa els canvis de notificació";

  @override
  String get updatePassword => "Actualitzeu la contrasenya";

  @override
  String get updateProfileInfo => "Actualitza la informació del perfil";

  @override
  String get password8CharsRequirement =>
      "La contrasenya ha de tenir com a mínim 8 caràcters.";

  @override
  String get passwordAtLeast1CapitalLetter =>
      "La contrasenya ha de contenir com a mínim 1 lletra majúscula.";

  @override
  String get passwordAtLeast1LowerCaseLetter =>
      "La contrasenya ha de contenir com a mínim 1 lletra minúscula.";

  @override
  String get passwordAtLeast1Number =>
      "La contrasenya ha de contenir com a mínim un número.";

  @override
  String get passwordMustMatch => "La contrasenya ha de coincidir.";

  @override
  String get notificationUpdatedSuccess => "S'han actualitzat els canvis de notificació.";

  @override
  String get passwordUpdatedSuccess => "S'ha actualitzat la contrasenya.";

  @override
  String get profileUpdatedSuccess => "Perfil actualitzat";

  @override
  String get enablePermissions => "Activeu els permisos";

  @override
  String get permissionDenied => "Permís denegat";

  @override
  String get savePreferences => "Desa les preferències";

  @override
  String get turnOffChannelEmails => "No rebeu correus electrònics del canal";

  @override
  String get turnOffChannelSounds => "Desactiva els sons del canal";

  @override
  String get chatMessageUnavailable =>
      "Els missatges de xat no estan disponibles per a aquest usuari";

  @override
  String get createChannel => "Crea un canal";

  @override
  String get createNewChannel => "Crea un canal nou";

  @override
  String get isTyping => "està escrivint...";

  @override
  String get createPrivateGroup => "Crea un grup privat";

  @override
  String get createPrivateGroupWarning =>
      "Crearàs un GRUP nou, pots afegir persones a aquest grup si ja formen part del teu equip; si no, crea el grup primer i convida-les més tard.";

  @override
  String get createNewPrivateGroup => "Creeu un grup privat nou";

  @override
  String get createNewChannelAction =>
      "Esteu a punt de crear un nou canal obert.";

  @override
  String get createNewChannelForAdminsOnly => "Només els administradors tenen accés a escriure.";

  @override
  String get openChannelAllMemberAccess => "Tots els membres de l’equip tenen accés de lectura.";

  @override
  String get and => "I";

  @override
  String get userIsInactiveToChat =>
      "No podeu xatejar amb aquest usuari perquè està inactiu.";

  @override
  String get selectChannel => "Selecciona el canal";

  @override
  String get needToSelectChannel => "Heu de seleccionar un canal";

  @override
  String get fileAlreadyShared =>
      "Aquest fitxer ja es comparteix amb el mateix nom al canal que heu seleccionat.";

  @override
  String get inChannel => "al canal";

  @override
  String seeAnswerMessages(int count) => "Veure $count  missatges";

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
    return "Usuari $name  s'ha unit al canal";
  }

  @override
  String userHasLeft(String name) {
    return "Usuari $name  ha sortit del canal";
  }

  @override
  String invitedBy(String name) {
    return "Convidat per $name";
  }

  @override
  String get answers => "Respostes";

  @override
  String get publishIn => "publica a";

  @override
  String get hasCommentedOnThread => "Ha comentat el fil:";

  @override
  String get unReadMessages => "Missatges no llegits";

  @override
  String get hasAddedTag => "S'ha afegit l'etiqueta";

  @override
  String get hasAssignedUser => "Ha assignat l'usuari";

  @override
  String get hasClosedTask => "Ha tancat la tasca";

  @override
  String get hasCommentedTask => "Ha afegit un comentari";

  @override
  String get hasCreatedTask => "Ha creat la tasca";

  @override
  String get hasCreatedTaskAssignedTo => "Ha creat una nova tasca assignada a";

  @override
  String get hasDeleteTag => "S'ha suprimit l'etiqueta";

  @override
  String get hasDeletedCommentTask => "Ha suprimit un comentari";

  @override
  String get hasEditedCommentTask => "Ha editat un comentari";

  @override
  String get hasEditedTask => "Ha editat la tasca";

  @override
  String get hasRemovedEndDateTask => "S'ha suprimit la data de finalització de";

  @override
  String get hasReopenedTask => "Ha tornat a obrir la tasca";

  @override
  String get hasSetMilestone => "Ha marcat la fita";

  @override
  String get hasUnAssignedUser => "Ha desassignat l'usuari";

  @override
  String get hasUpdatedDateTask => "S'ha actualitzat la data de finalització de";

  @override
  String get inTheTask => "A la tasca";

  @override
  String get to => "a";

  @override
  String get hasAssignedNewDueDateFor => "Ha assignat una nova data de venciment per a";

  @override
  String get createNewTag => "Crea una etiqueta nova";

  @override
  String get createNewMilestone => "Creeu una nova fita";

  @override
  String get editMilestone => "Edita la fita";

  @override
  String get editTag => "Edita l'etiqueta";

  @override
  String get openTasks => "Tasques obertes";

  @override
  String get newPersonalNote => "Nova nota personal";

  @override
  String get createNewPersonalNote => "Crea una nota personal";

  @override
  String get filterBy => "Filtra per";

  @override
  String hereStartsYourMessagesWith(String name) =>
      "Comenceu aquí els vostres missatges amb @$name";

  @override
  String thisChannelIsManagedBy(String name) =>
      "Aquest canal està gestionat per @$name, si necessiteu ajuda, poseu-vos en contacte amb l'administrador.";

  @override
  String newPush(String user, String repository, String repositoryUrl) {
    String part1 = "Nova empenta de";
    String part2 = "al dipòsit";
    String part3 = "Detall";

    return "<p>$part1  <span class = 'link-mention'> @$user</span> $part2  <span> <a href = '$repositoryUrl'>$repository. $part3</a> </span> </p>";
  }

  @override
  String unassignedTask(
    String repository,
    String repositoryUrl,
  ) {
    String part1 = "Tasca sense assignar al repositori";
    String part2 = "Detall";
    return "<p>$part1  <a href = '$repositoryUrl'>$repository. $part2</a> </p>";
  }

  @override
  String cardTrelloCreate(
      String board, String boardUrl, String card, String cardUrl, String list) {
    String part1 = "Targeta creada";
    String part2 = "a la llista";
    String part3 = "de tauler";
    return "<p>$part1  <a href = '$cardUrl'>$card</a> $part2   $list   $part3  <a href = '$boardUrl'>$board</a> </p>";
  }

  @override
  String cardTrelloRename(String board, String boardUrl, String oldName,
      String newName, String list) {
    String part1 = "A la llista";
    String part2 = "de l'tauler";
    String part3 = "s'ha canviat el nom la targeta";
    String part4 = "a";
    return "<p>$part1 '$list' $part2 <a href='$boardUrl'>$board</a> $part3 '$oldName' $part4 '$newName'</p>";
  }

  @override
  String cardTrelloDescriptionChange(String board, String boardUrl, String card,
      String cardUrl, String list, String description) {
    String part1 = "la targeta";
    String part2 = "de la llista";
    String part3 = "de l'tauler";
    String part4 = "ha canviat la seva descripció a";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4 '$description'</p>";
  }

  @override
  String cardTrelloMoveToOtherList(String board, String boardUrl, String card,
      String cardUrl, String oldList, String newList) {
    String part1 = "la targeta";
    String part2 = "s'ha mogut de la llista";
    String part3 = "a la llista";
    String part4= "al tauler";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$oldList' $part3 '$newList' $part4 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloArchive(String board, String boardUrl, String card,
      String cardUrl, String list) {
    String part1 = "la targeta";
    String part2 = "de la llista";
    String part3 = "de l'tauler";
    String part4 = "ha estat arxivada";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4</p>";
  }

  @override
  String get comments => "Comentaris";

  @override
  String get addComment => "Afegeix un comentari";

  @override
  String get editComment => "Edita el comentari";

  @override
  String get downloadAppsAndSynchronizer =>
      "<a href ='https://noysi.com/a/#/downloads'>¡DESCÀRREGA IA les APPS!</a>";

  @override
  String get welcomeToNoysiFirstName => "Et donem la benvinguda! Aquest és el teu canal personal, no ho veurà ningú més que tu, no té comunicació amb ningú, és el teu canal personal perquè deixis notes personals i pugis fitxers que ningú més veurà. Quin és el teu nom?";

  @override
  String get welcomeToNoysiTimeout =>
      "No m'has respost! Si necessiteu ajuda, feu clic a <a href = '${Endpoint.helpUrl}'> aquí. </a>";

  @override
  String get wrongUsernamePassword => "Nom d'usuari o contrasenya incorrectes";

  @override
  String get userInUse => "Aquest usuari ja està en ús";

  @override
  String get invite => "Convidar";

  @override
  String get groupRequired => "Es requereix grup";

  @override
  String get uploading => "S'està penjant";

  @override
  String get downloading => "S'està descarregant";

  @override
  String get inviteGuestsWarning => "Els convidats només s’uneixen a un grup d’aquest equip.";

  @override
  String get addMembers => "Afegeix membres";

  @override
  String get enterEmailsByComma =>
      "Introduïu correus electrònics separant-los amb comes:";

  @override
  String get firstName => "Nom";

  @override
  String get inviteFewMorePersonal => "Convideu-ne uns quants i sigueu més personals";

  @override
  String get inviteManyAtOnce => "Convida molts a la vegada";

  @override
  String get addGuests => "Afegiu convidats";

  @override
  String get followThread => "Seguiu aquest fil";

  @override
  String get markThreadAsRead => "Marcar com llegit";

  @override
  String get stopFollowingThread => "Deixeu de seguir aquest fil";

  @override
  String get needToVerifyAccountToInvite =>
      "Cal que verifiqueu el compte de correu electrònic per convidar membres.";

  @override
  String get createANewTeam => "Crea un equip nou";

  @override
  String get createNewTeam => "Crea un equip nou";

  @override
  String get enterIntoYourAccount => "Entreu al vostre compte";

  @override
  String get forgotPassword => "Has oblidat la teva contrasenya?";

  @override
  String get goAhead => "Endavant!";

  @override
  String get passwordRestriction => "La contrasenya ha de tenir com a mínim vuit caràcters, inclosos un número, una lletra majúscula i una lletra minúscula. Podeu utilitzar caràcters especials com @ # \$% ^ & + = i deu o més caràcters per millorar la seguretat de la vostra contrasenya.";

  @override
  String get recoverYorPassword => "Recupereu la vostra contrasenya";

  @override
  String get recoverYorPasswordWarning => "Per restaurar la contrasenya, introduïu l'adreça electrònica que utilitzeu per iniciar la sessió a noysi.com";

  @override
  String recoverPasswordResponse(String email) {
    return "Us hem enviat un correu electrònic a $email";
  }

  @override
  String get recoverPasswordResponse1 =>
      "Consulteu la safata d'entrada i seguiu les instruccions per crear la vostra nova contrasenya";

  @override
  String get continueStr => "Continua";

  @override
  String get passwordAtLeast1SpecialChar => "La contrasenya ha d'incloure a l'mínim 1 caràcter especial @#\$%^&+=";

  @override
  String welcomeToNoysiLastName(String name) => "Hola $name. Quin és el teu cognom?";

  @override
  String get welcomeToNoysiDescription => "Molt bé. Tot està correcte. Vaig a procedir a actualitzar el teu perfil.";

  @override
  String get welcomeToNoysiInvite => "<a href = '#'>Convida ja als membres del teu equip!</a>";

  @override
  String get activeFilter => "Filtre actiu";

  @override
  String get newFileComment => "Nou comentari en el fitxer";

  @override
  String get removed => "Eliminat";

  @override
  String get sharedOn => "Compartit en";

  @override
  String get notifyAllInThisChannel => "notificar a tots en aquest canal";

  @override
  String get notifyAllMembers => "notificar a tots els membres";

  @override
  String get keepPressingToRecord => "Seguiu prement el botó per gravar";

  @override
  String get slideToCancel => "Llisca per cancel·lar";

  @override
  String get chooseASecurePasswordText => "Escull una contrasenya suficientment segura i que puguis recordar";

  @override
  String get confirmPassword => "Repetir contrasenya";

  @override
  String get yourPassword => "Contrasenya";

  @override
  String get passwordDontMatch => "Les contrasenyes no coincideixen";

  @override
  String get changeCreateTeamMail => "No, vull canviar l'email";

  @override
  String step(int number) => "Pas $number";

  @override
  String get user => "Usuari";

  @override
  String get deleteFolderWarning => "La carpeta s'eliminarà permanentment i no podrà ser recuperada";

  @override
  String get calendar => "Calendari";

  @override
  String get week => "Setmana";

  @override
  String get folderIsNotInCurrentTeam => "La carpeta no està associada a l'Equip actual";

  @override
  String get folderIsNotInAvailableChannel => "La carpeta a la qual es fa referència no es troba en un canal disponible al navegador de fitxers";

  @override
  String get folderLinked => "S'ha copiat l'enllaç de la carpeta al canal";

  @override
  String get folderShared => "S'ha compartit la carpeta al canal";

  @override
  String get folderUploaded => "S'ha pujat la carpeta a canal";

  @override
  String get folderNotFound => "Carpeta no trobada";

  @override
  String get folderNameIncorrect => "El nom per a la carpeta no és vàlid";

  @override
  String get cloneFolder => "clonar carpeta";

  @override
  String get cloneFolderInfo => "A l'clonar una carpeta es crea una nova carpeta al canal destí amb el mateix estat i contingut de la carpeta seleccionada en aquest instant de temps.";

  @override
  String get folderDeleted => "No es pot accedir a una carpeta eliminada";

  @override
  String get youWereInADeletedFolder => "La carpeta en la qual es trobava va ser eliminada";

  @override
  String get dateFormat6 => "MM/dd/yyyy";

  @override
  String get createdTask => "tasca Creada";

  @override
  String get loggedIn => "Sessió Iniciada";

  @override
  String get mention => "Menció";

  @override
  String get messageSent => "missatge Enviat";

  @override
  String get taskAssigned => "tasca Assignada";

  @override
  String get taskUnassigned => "tasca Desasignada";

  @override
  String get uploadedFile => "arxiu Penjat";

  @override
  String get uploadedFileFolder => "Archivo/Carpeta Subido";

  @override
  String get uploadedFolder => "carpeta Pujada";

  @override
  String get downloadedFile => "arxiu Descarregat";

  @override
  String get downloadedFileFolder => "Arxiu / Carpeta Descarregat";

  @override
  String get downloadedFolder => "carpeta Descarregada";

  @override
  String get messageUnavailable => "Missatge no disponible";

  @override
  String get activityZone => "Zona d'Activitat";

  @override
  String get categories => "categories";

  @override
  String get category => "categoria";

  @override
  String get clearAll => "netejar Tot";

  @override
  String get errorFetchingData => "Error obtenint dades";

  @override
  String get filters => "filtres";

  @override
  String get openSessions => "sessions Obertes";

  @override
  String activityFileFolderUploadedDownloaded(String user, String name, String channel, {bool download = false, bool isDirect = false, isFolder = false}) {
    String part1 = "has ${download ? "descarregat" : "pujat"}${isFolder ? " la carpeta " : " l'arxiu "}";
    String part2 = download ? "des del canal" : "al canal";
    return "$part1 <i class=\"mention-generic\">$name</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMentioned(String user, String channel, {bool isDirect = false}) {
    String part1 = "Has estat esmentat al canal";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMessageSent(String user, String channel, {bool isDirect = false}) {
    String part1 = "Has enviat un missatge al canal";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activitySignedIn(String sessionInfo, String ip) {
    return "Heu iniciat la sessió a <i class=\"mention-generic\">$sessionInfo</i> IP: <i class=\"mention-generic\">$ip</i>";
  }

  @override
  String activityTaskAssigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Has estat assignat a la tasca";
    String part2 = "al canal";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskCreated(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Has creat la tasca";
    String part2 = "al canal";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskUnassigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Has estat desassignat de la tasca";
    String part2 = "al canal";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String get activityZoneHeader => "Aquí és on comença la Zona d'activitat";

  @override
  String get selectEvent => "Seleccioneu esdeveniment";

  @override
  String get googleCalendar => "Google";

  @override
  String get outlookCalendar => "Outlook";

  @override
  String get noysiCalendar => "Noysi";

  @override
  String get autogenerateRoomNameQuestion => "Voleu generar el nom de la sala automàticament?";

  @override
  String get createMeetingEvent => "Crear Esdeveniment-Reunió";

  @override
  String get externalGuests => "convidats externs";

  @override
  String get internalGuests => "convidats interns";

  @override
  String get newMeetingEvent => "Nou esdeveniment-Reunió";

  @override
  String get roomName => "Nom de la sala";

  @override
  String get eventMeeting => "Esdeveniment-Reunió";

  @override
  String get personalNote => "Nota Personal";

  @override
  String get updateExternalGuests => "Actualitzar Convidats externs";

  @override
  String get nameTextWarning => "El text correspon a una cadena alfanumèrica de 1 a 25 caràcters. També pots fer servir espais i els caràcters _ -";

  @override
  String get nameTextWarningWithoutSpaces => "El text correspon a una cadena alfanumèrica de 1 a 18 caràcters sense espais. També podeu utilitzar els caràcters _ -";

  @override
  String get today => "avui";

  @override
  String get location => "lloc";

  @override
  String get sessions => "Sessions";

  @override
  String get appVersion => "versió App";

  @override
  String get browser => "navegador";

  @override
  String get device => "dispositiu";

  @override
  String get logout => "Tancar Sessió";

  @override
  String get manufacturer => "fabricant";

  @override
  String get no => "no";

  @override
  String get operativeSystem => "sistema Operatiu";

  @override
  String get yes => "sí";

  @override
  String get allDay => "Tot el dia";

  @override
  String get endDate => "Data de finalització";

  @override
  String get noTitle => "Sense títol";

  @override
  String get currentSession => "Sessió actual";

  @override
  String get logOutAllExceptForThisOne => "Tanqueu la sessió de tots els dispositius excepte aquest";

  @override
  String get terminateAllOtherSessions => "Finalitzeu la resta de sessions";

  @override
  String get closeAllSessionsConfirmation => "Voleu finalitzar la resta de sessions?";

  @override
  String get closeSessionConfirmation => "Voleu finalitzar la sessió?";

  @override
  String get connectionLost => "Vaja, sembla que no hi ha cap connexió";

  @override
  String get connectionEstablished => "Esteu de nou en línia";

  @override
  String get connectionStatus => "Estat de la connexió";

  @override
  String get anUserIsCalling => "Un usuari t'està trucant ...";

  @override
  String get answer => "respondre";

  @override
  String get hangDown => "penjar";

  @override
  String get incomingCall => "crida Entrant";

  @override
  String isCallingYou(String user) => "$user t'està trucant ...";

  @override
  String get callCouldNotBeInitialized => "No s'ha pogut inicialitzar la trucada";

  @override
  String get sentMessages => "Missatges enviats";

  @override
  String sentMessagesCount(String count) => "$count de 10000";

  @override
  String get teamDataUsage => "Ús de dades de l’equip";

  @override
  String get usedStorage => "Emmagatzematge usat";

  @override
  String usedStorageText(String used) => used + "GB de 5GB";

  @override
  String get userDataUsage => "Ús de dades d’usuari";

  @override
  String get audioEnabled => "Àudio activat";

  @override
  String get meetingOptions => "Opcions de reunió";

  @override
  String get videoEnabled => "Vídeo activat";

  @override
  String get dontShowThisMessage => "No ho tornis a mostrar";

  @override
  String get showDialogEveryTime => "Mostra el diàleg cada vegada que comença una reunió";

  @override
  String get micAndCameraRequiredAlert => "Calen permisos d'accés a la càmera i al micròfon. Assegureu-vos que heu concedit els permisos necessaris. Voleu anar a la configuració de permisos?";

  @override
  String get connectWith => "Connectar amb";

  @override
  String get noEvents => "Sense esdeveniments, tasques ni notes personals";

  @override
  String get or => "o bé";

  @override
  String get viewDetails => "Veure detalls";

  @override
  String zendeskTicketUpdated(String user, String status, String type, String title, String url) {
    String part1 = R.string.user;
    String part2 = "ha actualitzat el bitllet";
    String part3 = "de tipus";
    String part4 = "a l'estat";
    String part5 = R.string.viewDetails;
    return "<p>$part1 '$user' $part2 '$title' $part3 '$type' $part4 '$status'. <span><a href='$url'>$part5</a></span></p>";
  }


  @override
  String get accept => "Acceptar";

  @override
  String get busy => "Ocupat";

  @override
  String get configuration => "Configuració";

  @override
  String get downloads => "Descàrregues";

  @override
  String get editTeam => "Edita l'equip";

  @override
  String get general => "General";

  @override
  String get integrations => "Integracions";

  @override
  String get noRecents => "Sense Recents";

  @override
  String get noRecommendations => "Sense recomanacions";

  @override
  String get inAMeeting => "A una reunió";

  @override
  String get onFire => "On Fire";

  @override
  String get plans => "Plans";

  @override
  String get setAStatus => "Estableix un estat";

  @override
  String get sick => "Malalt";

  @override
  String get signOut => "Tanca sessió";

  @override
  String get suggestions => "Suggeriments";

  @override
  String get teams => "Equips";

  @override
  String get traveling => "Viatjant";

  @override
  String get whatsYourStatus => "Quin és el teu estat?";

  @override
  String get sendAlwaysAPush => "Envieu sempre una notificació push";

  @override
  String get robot => "Robot";

  @override
  String get deactivateUserWarning => "Els membres de l'equip no es podran comunicar amb un membre mentre estigui desactivat. Tanmateix, tota l'activitat realitzada pel membre desactivat a Noysi romandrà intacta i els missatges (canals oberts, missatges 1 a 1 i grups privats), fitxers i tasques seran accessibles.";

  @override
  String get activateUserWarning => "Un cop reactivat el membre, recuperarà l'accés als mateixos canals, grups, fitxers i tasques que tenia abans de ser desactivat.";

  @override
  String get changeRole => "Canviar de rol";

  @override
  String get userStatus => "Estat d'usuari";

  @override
  String get deactivateMyAccount => "desactiva el meu compte";

  @override
  String get deactivateMyAccountWarning => "Si desactiveu el vostre compte, se us desactivarà en tots els vostres equips, converses, fitxers, tasques i qualsevol activitat que hàgiu gestionat a través de Noysi fins que un administrador us torni a activar.";

  @override
  String get deactivateMyUserInThisTeam => "Desactiva el meu usuari en aquest equip";

  @override
  String get deactivateMyUserInThisTeamWarning => "Quan et desactives en un equip, tot el que tens en aquest equip es mantindrà fins que tornis a activar-te. Si sou l'únic administrador de l'equip, l'equip no se suprimirà.";

  @override
  String get operationConfirmation => "Esteu segur d'aquesta operació?";

  @override
  String get formatNotSupported => "Aquest format o extensió no és compatible amb el sistema operatiu";

  @override
  String get invitePrivateGroupLink => "Convida un membre al grup mitjançant aquest enllaç";

  @override
  String get invalidPhoneNumber => "Número de telèfon no vàlid";

  @override
  String get searchByCountryName => "Cerca per nom de país o codi de marcatge";

  @override
  String get kick => "Expulsar";

  @override
  String get deleteAll => "Eliminar tots";

  @override
  String get enterKeyManually => "Introduïu la clau manualment";

  @override
  String get noysiAuthenticator => "Autenticador Noysi";

  @override
  String get qrScanner => "QR";

  @override
  String get otpLabelWarning => "L'etiqueta OTP és una cadena alfanumèrica sense espais :@.,;()\$% també estan permesos";

  @override
  String get invalidBase32Chars => "Caràcters base32 no vàlids";

  @override
  String get label => "Etiqueta";

  @override
  String get secretCode => "Clau secreta";

  @override
  String get labelTextWarning => "L'etiqueta és buida, comproveu aquest valor";

  @override
  String missedCallFrom(String user) => "Trucada perduda de $user";

  @override
  String get activeItemBackgroundColor => "Fons de l'element actiu";

  @override
  String get activeItemTextColor => "Text de l'element actiu";

  @override
  String get activePresenceColor => "Presència activa";

  @override
  String get adminsCanDeleteMessage => "Els administradors poden suprimir missatges";

  @override
  String get allForAdminsOnly => "@all només per a administradors";

  @override
  String get channelForAdminsOnly => "@channel només per a administradors i creadors de canals";

  @override
  String get chooseTheme => "Tria un tema per al teu equip";

  @override
  String get enablePushAllChannels => "Activa les notificacions push a tots els canals";

  @override
  String get inactivePresenceColor => "Presència inactiva";

  @override
  String get leaveTeam => "Deixa aquest equip";

  @override
  String get leaveTeamWarning => "Quan deixeu un equip, se suprimirà tot el que teniu en aquest equip. Si sou l'únic administrador de l'equip, l'equip se suprimirà.";

  @override
  String get notificationBadgeBackgroundColor => "Fons de la insígnia";

  @override
  String get notificationBadgeTextColor => "Text de la insígnia";

  @override
  String get onlyAdminInvitesAllowed => "Convidats només autoritzats pels administradors";

  @override
  String get reset => "Restableix";

  @override
  String get settings => "Configuració";

  @override
  String get sidebarColor => "Color de la barra lateral";

  @override
  String get taskUpdateProtected => "Modificació de les Tasques reservades a Creadors i Administradors";

  @override
  String get teamName => "Nom de l'equip";

  @override
  String get textColor => "Color del text";

  @override
  String get theme => "Tema";

  @override
  String get updateUsernameBlocked => "Bloqueja el nom d'usuari en enviar la invitació";

  @override
  String get fileNotFound => "Arxiu no trobat";

  @override
  String get messageNotFound => "No s'ha trobat el missatge, comproveu si el missatge que busqueu està disponible a l'equip actual.";

  @override
  String get taskNotFound => "No s'ha trobat la tasca";

  @override
  String userHasPinnedMessage(String name) => "$name ha fixat un missatge al canal";

  @override
  String userHasUnpinnedMessage(String name) => "$name ha deixat de fixar el missatge d'aquest canal";

  @override
  String get pinMessage => "Fixa el missatge";

  @override
  String get unpinMessage => "Desenganxa el missatge";

  @override
  String get pinnedMessage => "Missatge fixat";

  @override
  String get deleteMyAccount => "Esborra el meu compte";

  @override
  String get yourDeleteRequestIsInProcess => "La vostra sol·licitud d'eliminació del compte està en procés  ";

  @override
  String get deleteMyAccountWarning => "Si suprimeixes el teu compte, l'acció serà irreversible. Si gestioneu un equip i no hi ha cap altre administrador, l'equip se suprimirà.";

  @override
  String get lifetimeDeal => "Ofertes de per vida";

  @override
  String get showEmails => "Mostra els correus electrònics dels usuaris";

  @override
  String get showPhoneNumbers => "Mostra els números de telèfon dels usuaris";

  @override
  String get addChannel => "Afegeix un canal";

  @override
  String get addPrivateGroup => "Afegeix un grup privat";

  @override
  String get selectUserFromTeam => "Seleccioneu un usuari d'aquest equip";

  @override
  String get selectUsersFromChannelGroup => "Seleccioneu usuaris del canal o grup";

  @override
  String get memberDeleted => "Membre suprimit";
}


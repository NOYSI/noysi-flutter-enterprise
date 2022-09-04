import 'dart:ui';

import 'package:code/_res/values/text/strings_base.dart';

import '../../../data/api/remote/endpoints.dart';
import '../../R.dart';
import '../config.dart';

class StringsDe implements StringsBase {
  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Noysi";

  @override
  String get yourTeams => "Ihre Teams";

  @override
  String get channel => "Kanal";

  @override
  String get channels => "Kanäle";

  @override
  String get directMessagesAbr => "DNs";

  @override
  String get email => "Email";

  @override
  String get home => "Zuhause";

  @override
  String get member => "Mitglied";

  @override
  String get administrator => "Administrator";

  @override
  String get guest => "Gast";

  @override
  String get guests => "Gäste";

  @override
  String get members => "Mitglieder";

  @override
  String get inactiveMember => "Mitglied inaktiv";

  @override
  String get message => "Botschaft";

  @override
  String get messages => "Mitteilungen";

  @override
  String get password => "Passwort";

  @override
  String get register => "Anmelden";

  @override
  String get search => "Suche";

  @override
  String get signIn => "Anmelden";

  @override
  String get task => "Aufgabe";

  @override
  String get tasks => "Aufgaben";

  @override
  String get createTask => "Aufgabe erstellen";

  @override
  String get newTask => "Neue Aufgabe";

  @override
  String get description => "Beschreibung";

  @override
  String get team => "Mannschaft";

  @override
  String get thread => "Faden";

  @override
  String get threads => "Themen";

  @override
  String get createTeam => "Team erstellen";

  @override
  String get confirmIsCorrectEmailAddress => "Ja! Das ist die richtige E-Mail";

  @override
  String get createTeamIntro =>
      "Du bist dabei, dein neues Team bei Noysi einzurichten.";

  @override
  String get isCorrectEmailAddress => "Ist das die richtige E-Mail-Adresse?";

  @override
  String get welcome => "Herzlich willkommen!";

  @override
  String get invitationSentAt => "Ihre Einladung wird gesendet an:";

  @override
  String get next => "Nächster";

  @override
  String get startNow => "Jetzt anfangen!";

  @override
  String get charsRemaining => "Verbleibende Charaktere:";

  @override
  String get teamNameOrgCompany =>
      "Geben Sie Ihren Teamnamen, Ihre Organisation oder Ihren Firmennamen ein.";

  @override
  String get teamNameOrgCompanyLabel => "Ex. Mein Firmenname";

  @override
  String get yourTeam => "Dein Team";

  @override
  String get noysiServiceNewsletters =>
      "Es ist in Ordnung, E-Mails über den NOYSI-Dienst zu erhalten.";

  @override
  String get userNameIntro =>
      "Ihr Benutzername ist, wie Sie anderen in Ihrem Team erscheinen.";

  @override
  String get userNameLabel => "Ex. ackerman";

  @override
  String get addAnother => "Neue hinzufügen";

  @override
  String get byProceedingAcceptTerms =>
      "* Indem Sie fortfahren, akzeptieren Sie unsere <b>Nutzungsbedingungen</b>";

  @override
  String get invitations => "Invitations";

  @override
  String get invitePeople => "Menschen einladen";

  @override
  String get noysiIsTeamWorkInvite =>
      "Noysi ist ein Teamwork-Tool. Lade mindestens eine Person ein";

  @override
  String get userName => "Nutzername";

  @override
  String get fieldMax18 => "Maximal 18 Zeichen";

  @override
  String get fieldMax25 => "Maximal 25 Zeichen";

  @override
  String get fieldPassword => "Passwort erforderlich";

  @override
  String get fieldRequired => "Pflichtfeld";

  @override
  String get missingEmailFormat => "Falsche E-mail";

  @override
  String get back => "Zurück";

  @override
  String get channelBrowser => "Kanalbrowser";

  @override
  String get help => "Hilfe";

  @override
  String get preferences => "Einstellungen";

  @override
  String get signOutOf => "Abmelden von";

  @override
  String get closed => "Geschlossen";

  @override
  String get closedMilestone => "Geschlossen";

  @override
  String get close => "Schließen";

  @override
  String get opened => "Geöffnet";

  @override
  String get chat => "Plaudern";

  @override
  String get allThreads => "Alle Themen";

  @override
  String get inviteMorPeople => "Lade mehr Leute ein";

  @override
  String get meeting => "Treffen";

  @override
  String get myFiles => "Meine Akten";

  @override
  String get myTasks => "Meine Aufgaben";

  @override
  String get myTeams => "Meine Teams";

  @override
  String get openChannels => "Kanäle öffnen";

  @override
  String get privateGroups => "Private Gruppen";

  @override
  String get favorites => "Favoriten";

  @override
  String get message1x1 => "Nachrichten 1 bis 1";

  @override
  String get acceptedTitle => "Akzeptiert";

  @override
  String get date => "Datum";

  @override
  String get invitationLanguageTitle => "Redewendung Sprache";

  @override
  String get invitationMessage => "Einladungsnachricht";

  @override
  String get revokeInvitation => "Einladung widerrufen";

  @override
  String get revoke => "Widerrufen";

  @override
  String get revokeInvitationWarning =>
      "Vorsicht, diese Aktion ist nicht reversibel";

  @override
  String get revokeInvitationDelete => "Einladung löschen";

  @override
  String get resendInvitationBefore24hrs =>
      "Eine erneute Einladung ist erst 24 Stunden nach dem letzten Senden möglich.";

  @override
  String get resendInvitationSuccess => "Einladungen erfolgreich gesendet.";

  @override
  String get resendInvitation => "Einladung erneut versenden";

  @override
  String get invitationMessageDefault =>
      "Hallo! Hier haben Sie eine Einladung zum Beitritt";

  @override
  String get inviteManyAsOnce => "Laden Sie viele wie einmal ein";

  @override
  String get inviteMemberTitle =>
      "Teammitglieder haben vollen Zugriff auf offene Kanäle, persönliche Nachrichten und Gruppen.";

  @override
  String get inviteMemberWarningTitle =>
      "Um neue Mitglieder einzuladen, müssen Sie der Teamadministrator sein.";

  @override
  String get inviteNewMemberWarningTitle =>
      "Jedes Mitglied des Teams kann unbegrenzt Gäste hinzufügen.";

  @override
  String get inviteSubtitle =>
      "Noysi ist ein Werkzeug, um besser mit Ihrem Team zusammenzuarbeiten. Lade sie jetzt ein!";

  @override
  String get inviteTitle => "Lade andere Leute ein";

  @override
  String get inviteToAGroup => "Zu einer Gruppe einladen (erforderlich)";

  @override
  String get inviteToAGroupNotRequired => "Zu einer Gruppe einladen (optional)";

  @override
  String get inviteMemberWarning =>
      "Neue Mitglieder treten automatisch dem Kanal #general bei. Optional können Sie sie jetzt auch einer privaten Gruppe hinzufügen.";

  @override
  String get inviteToThisTeam => "Laden Sie zu diesem Team ein";

  @override
  String get invitationsSent => "Einladungen gesendet";

  @override
  String get name => "Name";

  @override
  String get noPendingInvitations =>
      "Es gibt keine Einladungen zum Senden dieses Teams.";

  @override
  String get pendingTitle => "steht aus";

  @override
  String get chooseTitle => "Wählen";

  @override
  String get seePendingAcceptedInvitations =>
      "Siehe ausstehende und angenommene Einladungen";

  @override
  String get sendInvitations => "Einladungen verschicken";

  @override
  String get typeEmail => "Geben Sie eine E-Mail ein";

  @override
  String get typeEmailComaSeparated =>
      "Geben Sie E-Mails nach Koma getrennt ein";

  @override
  String get atNoysi => "bei Noysi";

  @override
  String get inviteNewMemberTitle =>
      "Gäste zahlen nicht und Sie können so viele einladen, wie Sie möchten, aber sie haben nur Zugriff auf eine Gruppe innerhalb dieses Teams.";

  @override
  String get invited => "Eingeladen";

  @override
  String get thisNameAlreadyExist =>
      "Scheint, als ob dieser Name bereits verwendet wird.";

  @override
  String get emptyList => "Leere Liste";

  @override
  String get ok => "OK";

  @override
  String get byNameFirst => "Mit Namen A-Z.";

  @override
  String get byNameInvertedFirst => "Mit Namen Z-A";

  @override
  String get download => "Herunterladen";

  @override
  String get files => "Dateien";

  @override
  String get folders => "Ordner";

  @override
  String get newTitle => "New";

  @override
  String get newestFirst => "Das neuste zuerst";

  @override
  String get oldestFirst => "Die ältesten zu erst";

  @override
  String get see => "Sehen";

  @override
  String get share => "Teilen";

  @override
  String get moreInfo => "Mehr Informationen";

  @override
  String get assigned => "Zugewiesen";

  @override
  String get author => "Autor";

  @override
  String get created => "Erstellt";

  @override
  String get earlyDeliverDate => "Vorzeitiger Liefertermin";

  @override
  String get farDeliverDate => "Weiterer Liefertermin";

  @override
  String get filterAuthor => "Nach Autor filtern";

  @override
  String get searchUsers => "Benutzer suchen";

  @override
  String get sort => "Sortieren";

  @override
  String get sortBy => "Sortieren nach";

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
  String get cancel => "Stornieren";

  @override
  String get exit => "Ausgang";

  @override
  String get exitWarning => "Bist du sicher?";

  @override
  String get deleteChannelWarning =>
      "Bist du sicher, dass du diesen Kanal verlassen willst?";

  @override
  String get typeMessage => "Geben Sie eine Nachricht ein ...";

  @override
  String get addChannelToFavorites => "Zu den Favoriten hinzufügen";

  @override
  String get removeFromFavorites => "Von Favoriten entfernen";

  @override
  String get channelInfo => "Kanalinfo";

  @override
  String get channelMembers => "Channel-Mitglieder";

  @override
  String get channelPreferences => "Kanaleinstellungen";

  @override
  String get closeChatVisibility => "Schließen Sie 1 zu 1";

  @override
  String get inviteToGroup => "Lade ein Mitglied zu diesem Kanal ein";

  @override
  String get leaveChannel => "Kanal verlassen";

  @override
  String get mentions => "Erwähnungen";

  @override
  String get seeFiles => "Siehe Dateien";

  @override
  String get seeLinks => "Siehe Links";

  @override
  String get links => "Links";

  @override
  String get taskManager => "Taskmanager";

  @override
  String get videoCall => "Videoanruf";

  @override
  String get addReaction => "Reaktion hinzufügen";

  @override
  String get addTag => "Tag hinzufügen";

  @override
  String get addMilestone => "Meilenstein hinzufügen";

  @override
  String get copyMessage => "Nachricht kopieren";

  @override
  String get copyPermanentLink => "Link kopieren";

  @override
  String get createThread => "Starten Sie einen Thread";

  @override
  String get edit => "Bearbeiten";

  @override
  String get favorite => "Liebling";

  @override
  String get remove => "Entfernen";

  @override
  String get tryAgain => "Versuchen Sie es nochmal";

  @override
  String get deleteMessageContent =>
      "Möchten Sie diese Nachricht wirklich löschen? Das kann nicht rückgängig gemacht werden.";

  @override
  String get deleteMessageTitle => "Nachricht löschen";

  @override
  String get edited => "Bearbeitet";

  @override
  String get seeAll => "Alles sehen";

  @override
  String get copiedToClipboard => "In die Zwischenablage kopiert!";

  @override
  String get underConstruction => "Bauarbeiten im Gange";

  @override
  String get reactions => "Reaktionen";

  @override
  String get all => "Alle";

  @override
  String get users => "Benutzer";

  @override
  String get documents => "Unterlagen";

  @override
  String get fromLocalStorage => "Aus dem lokalen Speicher";

  @override
  String get photoGallery => "Fotogallerie";

  @override
  String get recordVideo => "Nehmen Sie ein Video auf";

  @override
  String get takePhoto => "Mach ein Foto";

  @override
  String get useCamera => "From camera";

  @override
  String get videoGallery => "Videogalerie";

  @override
  String get changeName => "Namen ändern";

  @override
  String get createFolder => "Ordner erstellen";

  @override
  String get createNameWarning =>
      "Namen sollten maximal 18 Zeichen ohne Satzzeichen enthalten.";

  @override
  String get newName => "Neuer Name";

  @override
  String get rename => "Umbenennen";

  @override
  String get renameFile => "Datei umbenennen";

  @override
  String get renameFolder => "Ordner umbenennen";

  @override
  String get deleteFile => "Datei löschen";

  @override
  String get deleteFolder => "Lösche Ordner";

  @override
  String get deleteFileWarning =>
      "Der Ordner wird dauerhaft gelöscht und kann nicht wiederhergestellt werden. Auf den Ordner kann über keinen Link zugegriffen werden.";

  @override
  String get delete => "Löschen";

  @override
  String get open => "Öffnen";

  @override
  String get addCommentOptional => "Kommentar hinzufügen (optional)";

  @override
  String get shareFile => "Datei teilen";

  @override
  String get groups => "gruppen";

  @override
  String get to1_1 => "1 zu 1";

  @override
  String get day => "tag";

  @override
  String get days => "Tage";

  @override
  String get hour => "Stunde";

  @override
  String get hours => "Std";

  @override
  String get minute => "Minute";

  @override
  String get minutes => "Protokoll";

  @override
  String get month => "Monat";

  @override
  String get months => "Monate";

  @override
  String get year => "Jahr";

  @override
  String get years => "Jahre";

  @override
  String get by => "durch";

  @override
  String get deliveryDateIn => "Fälligkeitsdatum in";

  @override
  String get ago => "Vor";

  @override
  String get taskOpened => "Geöffnet";

  @override
  String get assignees => "Abtretungsempfänger";

  @override
  String get assigneeBy => "Zugeteilt von";

  @override
  String get closeTask => "Aufgabe schließen";

  @override
  String get comment => "Kommentar";

  @override
  String get deliveryDate => "Geburtstermin";

  @override
  String get leaveAComment => "Hinterlasse einen Kommentar";

  @override
  String get milestone => "Meilenstein";

  @override
  String get milestones => "Milestones";

  @override
  String get color => "Farbe";

  @override
  String get milestoneAdded => "Zum Meilenstein hinzugefügt";

  @override
  String get participants => "Teilnehmer";

  @override
  String get reopen => "Wieder öffnen";

  @override
  String get completed => "Abgeschlossen";

  @override
  String get dueDateUpdated => "Fälligkeitsdatum aktualisiert";

  @override
  String get dueDate => "Geburtstermin";

  @override
  String get lastDueDate => "Letzter Fälligkeitstermin";

  @override
  String get commented => "Kommentiert";

  @override
  String get tagAdded => "Tag hinzugefügt";

  @override
  String get tagRemoved => "Tag entfernt";

  @override
  String get tags => "Stichworte";

  @override
  String get update => "Aktualisieren";

  @override
  String get details => "Einzelheiten";

  @override
  String get timeline => "Zeitleiste";

  @override
  String get aboutMe => "Über mich";

  @override
  String get acceptNews => "Neuigkeiten erhalten";

  @override
  String get allActive => "Alles aktiv";

  @override
  String get changePhoto => "Foto ändern";

  @override
  String get changeYourPassword => "Change your password";

  @override
  String get changeYourPasswordAdvice =>
      "Das Passwort muss mindestens acht Zeichen einschließlich einer Nummer enthalten, ein Großbuchstabe und ein Kleinbuchstabe, Sie können Sonderzeichen wie verwenden @#\$%^&+= und zehn oder mehr Zeichen, um die Sicherheit Ihres Passworts zu verbessern";

  @override
  String get charge => "Aufladen";

  @override
  String get country => "Land";

  @override
  String get disabled => "Behindert";

  @override
  String get emailNotification => "E-Mail Benachrichtigungen";

  @override
  String get language => "Sprache";

  @override
  String get lastName => "Familienname, Nachname";

  @override
  String get maxEveryHour => "Jede Stunde";

  @override
  String get maxHalfDay => "Alle 12 Stunden";

  @override
  String get messages1x1AndMentions => "Nachrichten 1x1 und @Erwähnungen";

  @override
  String get myProfile => "Mein Profil";

  @override
  String get never => "noch nie";

  @override
  String get newPassword => "Neues Kennwort";

  @override
  String get newsLetters => "Newsletter";

  @override
  String get notReceiveNews => "Erhalten Sie keine Nachrichten";

  @override
  String get notifications => "Benachrichtigungen";

  @override
  String get passwordRequirements =>
      "Ändern Sie Ihr Passwort regelmäßig, um Ihre Sicherheit und Ihren Schutz zu erhöhen";

  @override
  String get phoneNotifications => "Telefonische Benachrichtigungen";

  @override
  String get phoneNumber => "Telefonnummer";

  @override
  String get photoSizeRestrictions =>
      "Verwenden Sie ein quadratisches Foto mit einer maximalen Breite von 400 Pixel (klein).";

  @override
  String get repeatNewPassword => "Wiederhole das neue Passwort";

  @override
  String get security => "Sicherheit";

  @override
  String get skypeUserName => "Skype-Benutzer";

  @override
  String get sounds => "Geräusche";

  @override
  String get yourUserName => "Dein Benutzername";

  @override
  String get saveChanges => "Änderungen speichern";

  @override
  String get profileEmailUsesWarning =>
      "Diese E-Mail wird nur für Benachrichtigungen in diesem Team verwendet.";

  @override
  String get pushMobileNotifications => "Push mobile Benachrichtigungen";

  @override
  String get saveNotificationChanges => "Benachrichtigungsänderungen speichern";

  @override
  String get updatePassword => "Passwort erneuern";

  @override
  String get updateProfileInfo => "Profilinformationen aktualisieren";

  @override
  String get password8CharsRequirement =>
      "Das Passwort muss mindestens 8 Zeichen lang sein.";

  @override
  String get passwordAtLeast1CapitalLetter =>
      "Das Passwort muss mindestens 1 Großbuchstaben enthalten.";

  @override
  String get passwordAtLeast1LowerCaseLetter =>
      "Das Passwort muss mindestens 1 Kleinbuchstaben enthalten.";

  @override
  String get passwordAtLeast1Number =>
      "Das Passwort muss mindestens 1 Nummer enthalten.";

  @override
  String get passwordMustMatch => "Passwort muss übereinstimmen.";

  @override
  String get notificationUpdatedSuccess =>
      "Benachrichtigungsänderungen aktualisiert.";

  @override
  String get passwordUpdatedSuccess => "Passwort aktualisiert.";

  @override
  String get profileUpdatedSuccess => "Profil aktualisiert";

  @override
  String get enablePermissions => "Berechtigungen aktivieren";

  @override
  String get permissionDenied => "Zugang verweigert";

  @override
  String get savePreferences => "Einstellungen speichern";

  @override
  String get turnOffChannelEmails => "Erhalten Sie keine Kanal-E-Mails";

  @override
  String get turnOffChannelSounds => "Schalten Sie die Kanaltöne aus";

  @override
  String get chatMessageUnavailable =>
      "Chat-Nachrichten sind für diesen Benutzer nicht verfügbar";

  @override
  String get createChannel => "Kanal erstellen";

  @override
  String get createNewChannel => "Erstellen Sie einen neuen Kanal";

  @override
  String get isTyping => "tippt...";

  @override
  String get createPrivateGroup => "Private Gruppe erstellen";

  @override
  String get createPrivateGroupWarning =>
      "Wenn Sie eine neue GRUPPE erstellen möchten, können Sie dieser Gruppe Personen hinzufügen, wenn diese bereits Teil Ihres Teams sind. Wenn nicht, erstellen Sie zuerst die Gruppe und laden Sie sie später ein.";

  @override
  String get createNewPrivateGroup => "Erstellen Sie eine neue private Gruppe";

  @override
  String get createNewChannelAction =>
      "Sie sind dabei, einen neuen offenen Kanal zu erstellen";

  @override
  String get createNewChannelForAdminsOnly =>
      "Nur Administratoren haben Zugriff auf das Schreiben";

  @override
  String get openChannelAllMemberAccess =>
      "Alle Teammitglieder haben Lesezugriff";

  @override
  String get and => "Und";

  @override
  String get userIsInactiveToChat =>
      "Sie können nicht mit diesem Benutzer chatten, da dieser inaktiv ist.";

  @override
  String get selectChannel => "Kanal auswählen";

  @override
  String get needToSelectChannel => "Sie müssen einen Kanal auswählen";

  @override
  String get fileAlreadyShared =>
      "Diese Datei ist in dem von Ihnen ausgewählten Kanal bereits mit demselben Namen geteilt.";

  @override
  String get inChannel => "im Kanal";

  @override
  String seeAnswerMessages(int count) => "Sehen $count Mitteilungen";

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
    return "Nutzer $name ist dem Kanal beigetreten";
  }

  @override
  String userHasLeft(String name) {
    return "Nutzer $name hat den Kanal verlassen";
  }

  @override
  String invitedBy(String name) {
    return "Eingeladen von $name";
  }

  @override
  String get answers => "Antworten";

  @override
  String get publishIn => "veröffentlichen in";

  @override
  String get hasCommentedOnThread => "Hat den Thread kommentiert:";

  @override
  String get unReadMessages => "Ungelesene Nachrichten";

  @override
  String get hasAddedTag => "Hat das Tag hinzugefügt";

  @override
  String get hasAssignedUser => "Hat den Benutzer zugewiesen";

  @override
  String get hasClosedTask => "Hat die Aufgabe geschlossen";

  @override
  String get hasCommentedTask => "Hat einen Kommentar hinzugefügt";

  @override
  String get hasCreatedTask => "Hat die Aufgabe erstellt";

  @override
  String get hasCreatedTaskAssignedTo =>
      "Hat eine neue Aufgabe erstellt, die zugewiesen ist";

  @override
  String get hasDeleteTag => "Hat das Tag gelöscht";

  @override
  String get hasDeletedCommentTask => "Hat einen Kommentar gelöscht";

  @override
  String get hasEditedCommentTask => "Hat einen Kommentar bearbeitet";

  @override
  String get hasEditedTask => "Hat die Aufgabe bearbeitet";

  @override
  String get hasRemovedEndDateTask => "Hat das Enddatum von gelöscht";

  @override
  String get hasReopenedTask => "Hat die Aufgabe wieder geöffnet";

  @override
  String get hasSetMilestone => "Hat den Meilenstein gesetzt";

  @override
  String get hasUnAssignedUser => "Hat den Benutzer nicht zugewiesen";

  @override
  String get hasUpdatedDateTask => "Hat das Enddatum von aktualisiert";

  @override
  String get inTheTask => "In der Aufgabe";

  @override
  String get to => "zu";

  @override
  String get hasAssignedNewDueDateFor =>
      "Hat ein neues Fälligkeitsdatum für zugewiesen";

  @override
  String get createNewTag => "Neues Tag erstellen";

  @override
  String get createNewMilestone => "Erstellen Sie einen neuen Meilenstein";

  @override
  String get editMilestone => "Meilenstein bearbeiten";

  @override
  String get editTag => "Tag bearbeiten";

  @override
  String get openTasks => "Offene Aufgaben";

  @override
  String get newPersonalNote => "Neue persönliche Notiz";

  @override
  String get createNewPersonalNote => "Persönliche Notiz erstellen";

  @override
  String get filterBy => "Filtern nach";

  @override
  String hereStartsYourMessagesWith(String name) =>
      "Hier beginnen Sie Ihre Nachrichten mit @$name";

  @override
  String thisChannelIsManagedBy(String name) =>
      "Dieser Kanal wird von @$name verwaltet. Wenden Sie sich bei Bedarf an den Administrator.";

  @override
  String newPush(String user, String repository, String repositoryUrl) {
    String part1 = "Neuer Schub von";
    String part2 = "im Repository";
    String part3 = "Detail";

    return "<p>$part1 <span class='link-mention'>@$user</span> $part2 <span><a href='$repositoryUrl'>$repository. $part3</a></span></p>";
  }

  @override
  String unassignedTask(
    String repository,
    String repositoryUrl,
  ) {
    String part1 = "Nicht zugewiesene Aufgabe im Repository";
    String part2 = "Detail";
    return "<p>$part1 <a href='$repositoryUrl'>$repository. $part2</a></p>";
  }

  @override
  String cardTrelloCreate(
      String board, String boardUrl, String card, String cardUrl, String list) {
    String part1 = "Karte erstellt";
    String part2 = "In der Liste";
    String part3 = "von Bord";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 $list $part3 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloRename(String board, String boardUrl, String oldName,
      String newName, String list) {
    String part1 = "Auf der Liste";
    String part2 = "von der Tafel";
    String part3 = "Die Karte wurde umbenannt";
    String part4 = "zu";
    return "<p>$part1 '$list' $part2 <a href='$boardUrl'>$board</a> $part3 '$oldName' $part4 '$newName'</p>";
  }

  @override
  String cardTrelloDescriptionChange(String board, String boardUrl, String card,
      String cardUrl, String list, String description) {
    String part1 = "Die Karte";
    String part2 = "der Liste";
    String part3 = "von der Tafel";
    String part4 = "hat seine Beschreibung in geändert";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4 '$description'</p>";
  }

  @override
  String cardTrelloMoveToOtherList(String board, String boardUrl, String card,
      String cardUrl, String oldList, String newList) {
    String part1 = "Die Karte";
    String part2 = "wurde aus der Liste verschoben";
    String part3 = "zur Liste";
    String part4= "auf der Tafel";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$oldList' $part3 '$newList' $part4 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloArchive(String board, String boardUrl, String card,
      String cardUrl, String list) {
    String part1 = "Die Karte";
    String part2 = "der Liste";
    String part3 = "von der Tafel";
    String part4 = "wurde archiviert";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4</p>";
  }

  @override
  String get comments => "Bemerkungen";

  @override
  String get addComment => "Einen Kommentar hinzufügen";

  @override
  String get editComment => "Kommentar bearbeiten";

  @override
  String get downloadAppsAndSynchronizer =>
      "<a href = 'https://noysi.com/a/#/downloads'>JETZT DIE APPS HERUNTERLADEN!</a>";

  @override
  String get welcomeToNoysiFirstName => "Herzlich willkommen! Dies ist Ihr persönlicher Kanal, niemand sonst wird ihn sehen, Sie kommunizieren mit niemandem, es ist Ihr persönlicher Kanal, in dem Sie persönliche Notizen hinterlassen und Dateien hochladen können, die sonst niemand sieht. Wie heißen Sie?";

  @override
  String get welcomeToNoysiTimeout =>
      "Du hast mir nicht geantwortet! Wenn Sie Hilfe benötigen, klicken Sie <a href='${Endpoint.helpUrl}'>hier.</a>";

  @override
  String get invite => "Einladen";

  @override
  String get groupRequired => "Gruppe erforderlich";

  @override
  String get wrongUsernamePassword => "Benutzername oder Passwort falsch";

  @override
  String get userInUse => "Dieser Benutzer wird verwendet";

  @override
  String get uploading => "Hochladen";

  @override
  String get downloading => "wird heruntergeladen";

  @override
  String get inviteGuestsWarning =>
      "Gäste schließen sich nur einer Gruppe in diesem Team an.";

  @override
  String get addMembers => "Fügen Sie Mitglieder hinzu";

  @override
  String get enterEmailsByComma =>
      "Geben Sie E-Mails ein, indem Sie sie durch Kommas trennen:";

  @override
  String get firstName => "Vorname";

  @override
  String get inviteFewMorePersonal => "Laden Sie ein paar ein und seien Sie persönlicher";

  @override
  String get inviteManyAtOnce => "Laden Sie viele auf einmal ein";

  @override
  String get addGuests => "Gäste hinzufügen";

  @override
  String get followThread => "folge diesem Thread";

  @override
  String get markThreadAsRead => "als gelesen markieren";

  @override
  String get stopFollowingThread => "Hör auf, diesem Thread zu folgen";

  @override
  String get needToVerifyAccountToInvite =>
      "Sie müssen das E-Mail-Konto überprüfen, um Mitglieder einzuladen.";

  @override
  String get createANewTeam => "Erstelle ein neues Team";

  @override
  String get createNewTeam => "Erstelle ein neues Team!";

  @override
  String get enterIntoYourAccount => "Geben Sie in Ihr Konto ein";

  @override
  String get forgotPassword => "Haben Sie Ihr Passwort vergessen?";

  @override
  String get goAhead => "Go ahead!";

  @override
  String get passwordRestriction =>
      "Das Passwort muss mindestens acht Zeichen enthalten, einschließlich einer Zahl, eines Großbuchstabens und eines Kleinbuchstabens. Sie können Sonderzeichen wie @ # \$ % ^ & + = und zehn oder mehr Zeichen verwenden, um die Sicherheit Ihres Passworts zu verbessern.";

  @override
  String get recoverYorPassword => "Stellen Sie Ihr Passwort wieder her";

  @override
  String get recoverYorPasswordWarning =>
      "Um Ihr Passwort wiederherzustellen, geben Sie die E-Mail-Adresse ein, mit der Sie sich bei noysi.com anmelden";

  @override
  String recoverPasswordResponse(String email) {
    return "Wir haben Ihnen eine E-Mail an $email gesendet";
  }

  @override
  String get recoverPasswordResponse1 =>
      "Überprüfen Sie Ihren Posteingang und befolgen Sie dort die Anweisungen, um Ihr neues Passwort zu erstellen";

  @override
  String get continueStr => "Fortsetzen";

  @override
  String get passwordAtLeast1SpecialChar => "Das Passwort muss mindestens 1 Sonderzeichen enthalten @#\$%^&+=";

  @override
  String welcomeToNoysiLastName(String name) => "Hallo $name. Wie ist dein Nachname?";

  @override
  String get welcomeToNoysiDescription => "Sehr gut. Alles ist richtig. Ich werde Ihr Profil aktualisieren.";

  @override
  String get welcomeToNoysiInvite => "<a href = '#'>Laden Sie jetzt Ihre Teammitglieder ein!</a>";

  @override
  String get activeFilter => "Aktiver Filter";

  @override
  String get newFileComment => "Neuer Kommentar in der Datei";

  @override
  String get removed => "Entfernt";

  @override
  String get sharedOn => "Geteilt am";

  @override
  String get notifyAllInThisChannel => "Benachrichtigen Sie alle auf diesem Kanal";

  @override
  String get notifyAllMembers => "Benachrichtigen Sie alle Mitglieder";

  @override
  String get keepPressingToRecord => "Bitte halten Sie die Taste gedrückt, um aufzunehmen";

  @override
  String get slideToCancel => "Wischen Sie zum Abbrechen";

  @override
  String get chooseASecurePasswordText => "Wählen Sie ein sicheres Passwort, an das Sie sich erinnern können";

  @override
  String get confirmPassword => "Passwort wiederholen";

  @override
  String get yourPassword => "Passwort";

  @override
  String get passwordDontMatch => "Passwörter stimmen nicht überein";

  @override
  String get changeCreateTeamMail => "Nein, ich möchte die E-Mail ändern";

  @override
  String step(int number) => "Schritt $number";

  @override
  String get user => "Nutzer";

  @override
  String get deleteFolderWarning => "Der Ordner wird dauerhaft gelöscht und kann nicht wiederhergestellt werden";

  @override
  String get calendar => "Kalender";

  @override
  String get week => "Woche";

  @override
  String get folderIsNotInCurrentTeam => "Der Ordner ist nicht dem aktuellen Team zugeordnet";

  @override
  String get folderIsNotInAvailableChannel => "Der Ordner, auf den verwiesen wird, befindet sich nicht in einem verfügbaren Kanal im Datei-Explorer";

  @override
  String get folderLinked => "Ordnerlink in Kanal kopiert";

  @override
  String get folderShared => "Der Ordner wurde auf dem Kanal freigegeben";

  @override
  String get folderUploaded => "Der Ordner wurde in den Kanal hochgeladen";

  @override
  String get folderNotFound => "Ordner nicht gefunden";

  @override
  String get folderNameIncorrect => "Der Name für den Ordner ist ungültig";

  @override
  String get cloneFolder => "Ordner klonen";

  @override
  String get cloneFolderInfo => "Durch das Klonen eines Ordners wird im Zielkanal ein neuer Ordner mit demselben Status und Inhalt wie der ausgewählte Ordner zu diesem Zeitpunkt erstellt.";

  @override
  String get folderDeleted => "Ich kann nicht auf einen gelöschten Ordner zugreifen";

  @override
  String get youWereInADeletedFolder => "Der Ordner, in dem er sich befand, wurde gelöscht";

  @override
  String get dateFormat6 => "MM/dd/yyyy";

  @override
  String get createdTask => "Aufgabe erstellt";

  @override
  String get loggedIn => "Sitzung eingeleitet";

  @override
  String get mention => "Erwähnen";

  @override
  String get messageSent => "Nachricht gesendet";

  @override
  String get taskAssigned => "Zugewiesene Aufgabe";

  @override
  String get taskUnassigned => "Nicht zugewiesene Aufgabe";

  @override
  String get uploadedFile => "Hochgeladene Datei";

  @override
  String get uploadedFileFolder => "Datei / Ordner hochgeladen";

  @override
  String get uploadedFolder => "Hochgeladener Ordner";

  @override
  String get downloadedFile => "Heruntergeladene Datei";

  @override
  String get downloadedFileFolder => "Heruntergeladene Datei / Ordner";

  @override
  String get downloadedFolder => "Heruntergeladener Ordner";

  @override
  String get messageUnavailable => "Nachricht nicht verfügbar";

  @override
  String get activityZone => "Aktivitätszone";

  @override
  String get categories => "Kategorien";

  @override
  String get category => "Kategorie";

  @override
  String get clearAll => "Alles löschen";

  @override
  String get errorFetchingData => "Fehler beim Abrufen der Daten";

  @override
  String get filters => "Filter";

  @override
  String get openSessions => "Offene Sitzungen";

  @override
  String activityFileFolderUploadedDownloaded(String user, String name, String channel, {bool download = false, bool isDirect = false, isFolder = false}) {
    String part1 = "Sie haben ${download ? "heruntergeladen" : "hochgeladen"}${isFolder ? " Mappe " : " die Datei "}";
    String part2 = download ? "aus dem Kanal" : "Im Kanal";
    return "$part1 <i class=\"mention-generic\">$name</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMentioned(String user, String channel, {bool isDirect = false}) {
    String part1 = "Sie wurden auf dem Kanal erwähnt";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMessageSent(String user, String channel, {bool isDirect = false}) {
    String part1 = "Sie haben eine Nachricht auf dem Kanal gesendet";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activitySignedIn(String sessionInfo, String ip) {
    return "Sie sind angemeldet <i class=\"mention-generic\">$sessionInfo</i> IP: <i class=\"mention-generic\">$ip</i>";
  }

  @override
  String activityTaskAssigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Sie wurden der Aufgabe zugewiesen";
    String part2 = "Im Kanal";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskCreated(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Sie haben die Aufgabe erstellt";
    String part2 = "Im Kanal";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskUnassigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Sie wurden von der Aufgabe freigegeben";
    String part2 = "Im Kanal";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String get activityZoneHeader => "Hier beginnt die Aktivitätszone";

  @override
  String get selectEvent => "Ereignis auswählen";

  @override
  String get googleCalendar => "Google";

  @override
  String get outlookCalendar => "Outlook";

  @override
  String get noysiCalendar => "Noysi";

  @override
  String get autogenerateRoomNameQuestion => "Möchten Sie den Raumnamen automatisch generieren?";

  @override
  String get createMeetingEvent => "Event-Meeting erstellen";

  @override
  String get externalGuests => "Externe Gäste";

  @override
  String get internalGuests => "Interne Gäste";

  @override
  String get newMeetingEvent => "Neues Event-Meeting";

  @override
  String get roomName => "Raumname";

  @override
  String get eventMeeting => "Event-Meeting";

  @override
  String get personalNote => "Persönliche Anmerkung";

  @override
  String get updateExternalGuests => "Aktualisieren Sie externe Gäste";

  @override
  String get nameTextWarning => "Der Text entspricht einer alphanumerischen Zeichenfolge von 1-25 Zeichen. Sie können auch Leerzeichen und die Zeichen _ verwenden -";

  @override
  String get nameTextWarningWithoutSpaces => "Der Text entspricht einer alphanumerischen Zeichenfolge von 1-18 Zeichen ohne Leerzeichen. Sie können auch die Zeichen _ verwenden -";

  @override
  String get today => "Heute";

  @override
  String get location => "Platz";

  @override
  String get sessions => "Sitzungen";

  @override
  String get appVersion => "App Version";

  @override
  String get browser => "Browser";

  @override
  String get device => "Gerät";

  @override
  String get logout => "Abmelden";

  @override
  String get manufacturer => "Hersteller";

  @override
  String get no => "Nicht";

  @override
  String get operativeSystem => "Betriebssystem";

  @override
  String get yes => "Ja";

  @override
  String get allDay => "Den ganzen Tag";

  @override
  String get endDate => "Endtermin";

  @override
  String get noTitle => "Kein Titel";

  @override
  String get currentSession => "Aktuelle Sitzung";

  @override
  String get logOutAllExceptForThisOne => "Alle Geräte außer diesem abmelden";

  @override
  String get terminateAllOtherSessions => "Alle anderen Sitzungen beenden other";

  @override
  String get closeAllSessionsConfirmation => "Möchten Sie alle anderen Sitzungen beenden?";

  @override
  String get closeSessionConfirmation => "Möchten Sie die Sitzung beenden?";

  @override
  String get connectionLost => "Ups, anscheinend gibt es keine Verbindung";

  @override
  String get connectionEstablished => "Du bist wieder online";

  @override
  String get connectionStatus => "Verbindungsstatus";

  @override
  String get anUserIsCalling => "Ein Benutzer ruft Sie an ...";

  @override
  String get answer => "Antworten";

  @override
  String get hangDown => "Aufhängen";

  @override
  String get incomingCall => "Eingehender Anruf";

  @override
  String isCallingYou(String user) => "$user ruft dich an...";

  @override
  String get callCouldNotBeInitialized => "Der Anruf konnte nicht initialisiert werden";

  @override
  String get sentMessages => "Gesendeten Nachrichten";

  @override
  String sentMessagesCount(String count) => "$count von 10000";

  @override
  String get teamDataUsage => "Datennutzung im Team";

  @override
  String get usedStorage => "Gebrauchter Speicher";

  @override
  String usedStorageText(String used) => used + "GB von 5GB";

  @override
  String get userDataUsage => "Nutzung von Benutzerdaten";

  @override
  String get audioEnabled => "Audio aktiviert";

  @override
  String get meetingOptions => "Besprechungsoptionen";

  @override
  String get videoEnabled => "Video aktiviert";

  @override
  String get dontShowThisMessage => "Nicht mehr anzeigen";

  @override
  String get showDialogEveryTime => "Dialog jedes Mal anzeigen, wenn ein Meeting beginnt";

  @override
  String get micAndCameraRequiredAlert => "Zugriffsberechtigungen für Kamera und Mikrofon sind erforderlich. Bitte stellen Sie sicher, dass Sie die erforderlichen Berechtigungen erteilt haben. Möchten Sie zu den Berechtigungseinstellungen gehen?";

  @override
  String get noEvents => "Keine Ereignisse, Aufgaben oder persönlichen Notizen";

  @override
  String get connectWith => "Verbinden mit";

  @override
  String get or => "oder";

  @override
  String get viewDetails => "Details anzeigen";

  @override
  String zendeskTicketUpdated(String user, String status, String type, String title, String url) {
    String part1 = R.string.user;
    String part2 = "das ticket aktualisiert";
    String part3 = "vom typ";
    String part4 = "zum status";
    String part5 = R.string.viewDetails;
    return "<p>$part1 '$user' $part2 '$title' $part3 '$type' $part4 '$status'. <span><a href='$url'>$part5</a></span></p>";
  }


  @override
  String get accept => "Akzeptieren";

  @override
  String get busy => "Beschäftigt";

  @override
  String get configuration => "Konfiguration";

  @override
  String get downloads => "Herunterladen";

  @override
  String get editTeam => "Team bearbeiten";

  @override
  String get general => "Allgemein";

  @override
  String get integrations => "Integrationen";

  @override
  String get noRecents => "Keine Rekorde";

  @override
  String get noRecommendations => "Keine Empfehlungen";

  @override
  String get inAMeeting => "In einer Sitzung";

  @override
  String get onFire => "On Fire";

  @override
  String get plans => "Pläne";

  @override
  String get setAStatus => "Einen Status festlegen";

  @override
  String get sick => "Kranke";

  @override
  String get signOut => "Abmelden";

  @override
  String get suggestions => "Vorschläge";

  @override
  String get teams => "Mannschaften";

  @override
  String get traveling => "Reisen";

  @override
  String get whatsYourStatus => "Wie ist Ihr Status?";

  @override
  String get sendAlwaysAPush => "Sende immer eine Push-Benachrichtigung";

  @override
  String get robot => "Roboter";

  @override
  String get deactivateUserWarning => "Teammitglieder können nicht mit einem Mitglied kommunizieren, solange es deaktiviert ist. Alle Aktivitäten des deaktivierten Mitglieds in Noysi bleiben jedoch intakt und Nachrichten (offene Kanäle, 1-zu-1-Nachrichten und private Gruppen), Dateien und Aufgaben sind zugänglich.";

  @override
  String get activateUserWarning => "Sobald das Mitglied reaktiviert ist, erhält es den Zugriff auf dieselben Kanäle, Gruppen, Dateien und Aufgaben zurück, die er vor der Deaktivierung hatte.";

  @override
  String get changeRole => "Rolle ändern";

  @override
  String get userStatus => "Benutzerstatus";

  @override
  String get deactivateMyAccount => "Meinen Account deaktivieren";

  @override
  String get deactivateMyAccountWarning => "Wenn Sie Ihr Konto deaktivieren, werden Sie in all Ihren Teams, Unterhaltungen, Dateien, Aufgaben und allen Aktivitäten, die Sie über Noysi verwaltet haben, deaktiviert, bis ein Administrator Sie wieder reaktiviert.";

  @override
  String get deactivateMyUserInThisTeam => "Meinen Benutzer in diesem Team deaktivieren";

  @override
  String get deactivateMyUserInThisTeamWarning => "Wenn Sie sich in einem Team deaktivieren, bleibt alles, was Sie in diesem Team besitzen, bis Sie wieder aktiviert werden. Wenn Sie der einzige Teamadministrator sind, wird das Team nicht gelöscht.";

  @override
  String get operationConfirmation => "Sind Sie sich dieser Operation sicher?";

  @override
  String get formatNotSupported => "Dieses Format oder diese Erweiterung wird vom Betriebssystem nicht unterstützt";

  @override
  String get invitePrivateGroupLink => "Laden Sie über diesen Link ein Mitglied in die Gruppe ein";

  @override
  String get invalidPhoneNumber => "Ungültige Telefonnummer";

  @override
  String get searchByCountryName => "Suche nach Ländernamen oder Vorwahl";

  @override
  String get kick => "Vertreiben";

  @override
  String get deleteAll => "Alles löschen";

  @override
  String get enterKeyManually => "Schlüssel manuell eingeben";

  @override
  String get noysiAuthenticator => "Noysi Authentifikator";

  @override
  String get qrScanner => "QR";

  @override
  String get otpLabelWarning => "OTP-Kennung ist eine alphanumerische Zeichenfolge ohne Leerzeichen :@.,;()\$% sind auch erlaubt";

  @override
  String get invalidBase32Chars => "Ungültige base32-Zeichen";

  @override
  String get label => "Etikett";

  @override
  String get secretCode => "Geheimer Schlüssel";

  @override
  String get labelTextWarning => "Etikett ist leer, bitte überprüfen Sie diesen Wert";

  @override
  String missedCallFrom(String user) => "Verpasster Anruf von $user";

  @override
  String get activeItemBackgroundColor => "Hintergrund des aktiven Elements";

  @override
  String get activeItemTextColor => "Aktiver Artikeltext";

  @override
  String get activePresenceColor => "Aktive Präsenz";

  @override
  String get adminsCanDeleteMessage => "Administratoren können Nachrichten löschen";

  @override
  String get allForAdminsOnly => "@all nur für Administratoren";

  @override
  String get channelForAdminsOnly => "@channel nur für Administratoren und Kanalersteller";

  @override
  String get chooseTheme => "Wählen Sie ein Thema für Ihr Team";

  @override
  String get enablePushAllChannels => "Aktivieren Sie Push-Benachrichtigungen auf allen Kanälen";

  @override
  String get inactivePresenceColor => "Inaktive Präsenz";

  @override
  String get leaveTeam => "Verlasse dieses Team";

  @override
  String get leaveTeamWarning => "Wenn Sie ein Team verlassen, wird alles, was Sie in diesem Team besitzen, gelöscht. Wenn Sie der einzige Teamadministrator sind, wird das Team gelöscht.";

  @override
  String get notificationBadgeBackgroundColor => "Abzeichen-Hintergrund";

  @override
  String get notificationBadgeTextColor => "Abzeichen-Text";

  @override
  String get onlyAdminInvitesAllowed => "Nur von Administratoren autorisierte Gäste";

  @override
  String get reset => "Zurücksetzen";

  @override
  String get settings => "Einstellungen";

  @override
  String get sidebarColor => "Farbe der Seitenleiste";

  @override
  String get taskUpdateProtected => "Änderung von Aufgaben, die Erstellern und Administratoren vorbehalten sind";

  @override
  String get teamName => "Teamname";

  @override
  String get textColor => "Textfarbe";

  @override
  String get theme => "Thema";

  @override
  String get updateUsernameBlocked => "Benutzernamen beim Senden der Einladung blockieren";

  @override
  String get fileNotFound => "Datei nicht gefunden";

  @override
  String get messageNotFound => "Nachricht nicht gefunden, bitte überprüfen Sie, ob die gesuchte Nachricht im aktuellen Team verfügbar ist.";

  @override
  String get taskNotFound => "Aufgabe nicht gefunden";

  @override
  String userHasPinnedMessage(String name) => "$name hat eine Nachricht an den Kanal gepinnt";

  @override
  String userHasUnpinnedMessage(String name) => "$name hat die Nachricht von diesem Kanal gelöst";

  @override
  String get pinMessage => "Pin-Nachricht";

  @override
  String get unpinMessage => "Nachricht loslösen";

  @override
  String get pinnedMessage => "Gepinnte Nachricht";

  @override
  String get deleteMyAccount => "Mein Konto löschen";

  @override
  String get yourDeleteRequestIsInProcess => "Ihre Anfrage zur Kontolöschung wird bearbeitet";

  @override
  String get deleteMyAccountWarning => "Wenn Sie Ihr Konto löschen, ist die Aktion irreversibel. Wenn Sie ein Team verwalten und es keinen weiteren Administrator gibt, wird das Team gelöscht.";

  @override
  String get lifetimeDeal => "Lebenslange Angebote";

  @override
  String get showEmails => "Benutzer-E-Mails anzeigen";

  @override
  String get showPhoneNumbers => "Telefonnummern der Benutzer anzeigen";

  @override
  String get addChannel => "Kanal hinzufügen";

  @override
  String get addPrivateGroup => "Private Gruppe hinzufügen";

  @override
  String get selectUserFromTeam => "Benutzer aus diesem Team auswählen";

  @override
  String get selectUsersFromChannelGroup => "Wählen Sie Benutzer aus dem Kanal oder der Gruppe aus";

  @override
  String get memberDeleted => "Mitglied gelöscht";
}

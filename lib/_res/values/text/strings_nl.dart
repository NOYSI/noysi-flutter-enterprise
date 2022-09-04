import 'dart:ui';

import 'package:code/_res/values/config.dart';
import 'package:code/_res/values/text/strings_base.dart';

import '../../../data/api/remote/endpoints.dart';
import '../../R.dart';

class StringsNl implements StringsBase {
  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Noysi";

  @override
  String get yourTeams => "Uw teams";

  @override
  String get channel => "Kanaal";

  @override
  String get channels => "Kanalen";

  @override
  String get directMessagesAbr => "DM's";

  @override
  String get email => "E-mail";

  @override
  String get home => "Huis";

  @override
  String get member => "Lid";

  @override
  String get administrator => "Beheerder";

  @override
  String get guest => "Gast";

  @override
  String get guests => "Gasten";

  @override
  String get members => "Leden";

  @override
  String get inactiveMember => "Lid gedeactiveerd";

  @override
  String get message => "Bericht";

  @override
  String get messages => "Berichten";

  @override
  String get password => "Wachtwoord";

  @override
  String get register => "Inschrijven";

  @override
  String get search => "Zoekopdracht";

  @override
  String get signIn => "Inloggen";

  @override
  String get task => "Taak";

  @override
  String get tasks => "Taken";

  @override
  String get createTask => "Taak maken";

  @override
  String get newTask => "Nieuwe taak";

  @override
  String get description => "Beschrijving";

  @override
  String get team => "Team";

  @override
  String get thread => "Draad";

  @override
  String get threads => "Draden";

  @override
  String get createTeam => "Team maken";

  @override
  String get confirmIsCorrectEmailAddress => "Ja! Dat is de juiste e-mail";

  @override
  String get createTeamIntro =>
      "Je staat op het punt je nieuwe team op te zetten bij Noysi.";

  @override
  String get isCorrectEmailAddress => "Is dit het juiste e-mailadres?";

  @override
  String get welcome => "Welkom!";

  @override
  String get invitationSentAt => "Uw uitnodiging wordt verzonden naar:";

  @override
  String get next => "Volgende";

  @override
  String get startNow => "Begin nu!";

  @override
  String get charsRemaining => "Overgebleven karakters:";

  @override
  String get teamNameOrgCompany =>
      "Voer uw teamnaam, organisatie- of bedrijfsnaam in.";

  @override
  String get teamNameOrgCompanyLabel => "Ex. Mijn bedrijfsnaam";

  @override
  String get yourTeam => "Jouw team";

  @override
  String get noysiServiceNewsletters =>
      "Het is oké om (heel af en toe) e-mails te ontvangen over de service van NOYSI.";

  @override
  String get userNameIntro =>
      "Uw gebruikersnaam is hoe u overkomt op anderen in uw team.";

  @override
  String get userNameLabel => "Ex. ackerman";

  @override
  String get addAnother => "Een andere toevoegen";

  @override
  String get byProceedingAcceptTerms =>
      "* Door verder te gaan accepteert u onze <b>Servicevoorwaarden</b>";

  @override
  String get invitations => "Uitnodigingen";

  @override
  String get invitePeople => "Mensen uitnodigen";

  @override
  String get noysiIsTeamWorkInvite =>
      "Noysi is een tool voor teamwork. Nodig minimaal één persoon uit";

  @override
  String get userName => "gebruikersnaam";

  @override
  String get fieldMax18 => "maximaal 18 tekens";

  @override
  String get fieldMax25 => "maximaal 25 tekens";

  @override
  String get fieldPassword => "wachtwoord benodigd";

  @override
  String get fieldRequired => "Veld vereist";

  @override
  String get missingEmailFormat => "Foute email";

  @override
  String get back => "achter";

  @override
  String get channelBrowser => "Kanaalbrowser";

  @override
  String get help => "Helpen";

  @override
  String get preferences => "voorkeuren";

  @override
  String get signOutOf => "Afmelden";

  @override
  String get closed => "Gesloten";

  @override
  String get closedMilestone => "Gesloten";

  @override
  String get close => "Dichtbij";

  @override
  String get opened => "geopend";

  @override
  String get chat => "Chatten";

  @override
  String get allThreads => "Alle draden";

  @override
  String get inviteMorPeople => "Nodig meer mensen uit";

  @override
  String get meeting => "Ontmoeting";

  @override
  String get myFiles => "Mijn bestanden";

  @override
  String get myTasks => "Mijn taken";

  @override
  String get myTeams => "Mijn teams";

  @override
  String get openChannels => "Kanalen openen";

  @override
  String get privateGroups => "Privé groepen";

  @override
  String get favorites => "Favorieten";

  @override
  String get message1x1 => "Berichten 1 tot 1";

  @override
  String get acceptedTitle => "Geaccepteerd";

  @override
  String get date => "Datum";

  @override
  String get invitationLanguageTitle => "Taal";

  @override
  String get invitationMessage => "Uitnodigingsbericht";

  @override
  String get revokeInvitation => "Uitnodiging intrekken";

  @override
  String get revoke => "Herroepen";

  @override
  String get revokeInvitationWarning =>
      "Let op, deze actie is niet omkeerbaar";

  @override
  String get revokeInvitationDelete => "Uitnodiging verwijderen";

  @override
  String get resendInvitationBefore24hrs =>
      "Het opnieuw verzenden van de uitnodiging is pas 24 uur na de laatste verzending toegestaan.";

  @override
  String get resendInvitationSuccess => "Uitnodigingen zijn verzonden.";

  @override
  String get resendInvitation => "Verstuur de uitnodiging opnieuw";

  @override
  String get invitationMessageDefault =>
      "Hoi! Hier heb je een uitnodiging om mee te doen";

  @override
  String get inviteManyAsOnce => "Nodig velen uit als een keer";

  @override
  String get inviteMemberTitle =>
      "Teamleden hebben volledige toegang tot open kanalen, persoonlijke berichten en groepen.";

  @override
  String get inviteMemberWarningTitle =>
      "Om nieuwe leden uit te nodigen, moet u de teambeheerder zijn.";

  @override
  String get inviteNewMemberWarningTitle =>
      "Elk lid van het team kan onbeperkt gasten toevoegen.";

  @override
  String get inviteSubtitle =>
      "Noysi is een tool om beter samen te werken met je team. Nodig ze nu uit!";

  @override
  String get inviteTitle => "Nodig andere mensen uit";

  @override
  String get inviteToAGroup => "Uitnodigen voor een groep (verplicht)";

  @override
  String get inviteToAGroupNotRequired => "Uitnodigen voor een groep (optioneel)";

  @override
  String get inviteMemberWarning =>
      "Nieuwe leden worden automatisch lid van het #general kanaal. Optioneel kun je ze nu ook toevoegen aan een besloten groep.";

  @override
  String get inviteToThisTeam => "Uitnodigen voor dit team";

  @override
  String get invitationsSent => "Uitnodigingen verzonden";

  @override
  String get name => "Naam";

  @override
  String get noPendingInvitations =>
      "Er zijn geen uitnodigingen om dit team in te sturen.";

  @override
  String get pendingTitle => "In behandeling";

  @override
  String get chooseTitle => "Kiezen";

  @override
  String get seePendingAcceptedInvitations =>
      "Openstaande en geaccepteerde uitnodigingen bekijken";

  @override
  String get sendInvitations => "Uitnodigingen versturen";

  @override
  String get typeEmail => "Typ een e-mail";

  @override
  String get typeEmailComaSeparated => "Typ e-mails door komma gescheiden";

  @override
  String get atNoysi => "bij Noysi";

  @override
  String get inviteNewMemberTitle =>
      "Gasten betalen niet en je kunt er zoveel uitnodigen als je wilt, maar ze hebben maar toegang tot één groep binnen dit team.";

  @override
  String get invited => "Uitgenodigd";

  @override
  String get thisNameAlreadyExist =>
      "Het lijkt erop dat deze naam al in gebruik is.";

  @override
  String get emptyList => "Lege lijst";

  @override
  String get ok => "oke";

  @override
  String get byNameFirst => "Op naam A-Z";

  @override
  String get byNameInvertedFirst => "Op naam Z-A";

  @override
  String get download => "Downloaden";

  @override
  String get files => "Bestanden";

  @override
  String get folders => "mappen";

  @override
  String get newTitle => "Nieuw";

  @override
  String get newestFirst => "Nieuwste eerst";

  @override
  String get oldestFirst => "Oudste eerst";

  @override
  String get see => "Zien";

  @override
  String get share => "Deel";

  @override
  String get moreInfo => "Meer informatie";

  @override
  String get assigned => "Toegewezen";

  @override
  String get author => "Auteur";

  @override
  String get created => "Gemaakt";

  @override
  String get earlyDeliverDate => "Vroege leveringsdatum";

  @override
  String get farDeliverDate => "Verre leveringsdatum";

  @override
  String get filterAuthor => "Filteren op auteur";

  @override
  String get searchUsers => "Gebruikers zoeken";

  @override
  String get sort => "Soort";

  @override
  String get sortBy => "Sorteer op";

  @override
  String get cancel => "Annuleren";

  @override
  String get exit => "Uitgang";

  @override
  String get exitWarning => "Weet je zeker dat?";

  @override
  String get deleteChannelWarning =>
      "Weet je zeker dat je dit kanaal wilt verlaten?";

  @override
  String get typeMessage => "Type een bericht...";

  @override
  String get addChannelToFavorites => "Toevoegen aan favorieten";

  @override
  String get removeFromFavorites => "Verwijder van favorieten";

  @override
  String get channelInfo => "Kanaalinfo";

  @override
  String get channelMembers => "Kanaalleden";

  @override
  String get channelPreferences => "Kanaalvoorkeuren";

  @override
  String get closeChatVisibility => "Sluit 1 tot 1";

  @override
  String get inviteToGroup => "Nodig lid uit voor dit kanaal";

  @override
  String get leaveChannel => "kanaal verlaten";

  @override
  String get mentions => "vermeldingen";

  @override
  String get seeFiles => "Bestanden bekijken";

  @override
  String get seeLinks => "Zie links";

  @override
  String get links => "Links";

  @override
  String get taskManager => "Taakbeheer";

  @override
  String get videoCall => "Video-oproep";

  @override
  String get addReaction => "Reactie toevoegen";

  @override
  String get addTag => "Tag toevoegen";

  @override
  String get addMilestone => "Mijlpaal toevoegen";

  @override
  String get copyMessage => "Bericht kopiëren";

  @override
  String get copyPermanentLink => "Kopieer link";

  @override
  String get createThread => "Start een draad";

  @override
  String get edit => "Bewerk";

  @override
  String get favorite => "Favoriet";

  @override
  String get remove => "Verwijderen";

  @override
  String get tryAgain => "Probeer opnieuw";

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
      "Weet je zeker dat je dit bericht wilt verwijderen? Dit kan niet ongedaan gemaakt worden.";

  @override
  String get deleteMessageTitle => "Verwijder bericht";

  @override
  String get edited => "Bewerkt";

  @override
  String get seeAll => "Alles zien";

  @override
  String get copiedToClipboard => "Gekopieerd naar het klembord!";

  @override
  String get underConstruction => "In opbouw";

  @override
  String get reactions => "reacties";

  @override
  String get all => "Allemaal";

  @override
  String get users => "Gebruikers";

  @override
  String get documents => "Documenten";

  @override
  String get fromLocalStorage => "Van lokale opslag";

  @override
  String get photoGallery => "fotogallerij";

  @override
  String get recordVideo => "Een video opnemen";

  @override
  String get takePhoto => "Maak een foto";

  @override
  String get useCamera => "Van camera";

  @override
  String get videoGallery => "Video Gallerij";

  @override
  String get changeName => "Naam veranderen";

  @override
  String get createFolder => "Map aanmaken";

  @override
  String get createNameWarning =>
      "Namen mogen maximaal 18 tekens bevatten, zonder leestekens.";

  @override
  String get newName => "Nieuwe naam";

  @override
  String get rename => "Hernoemen";

  @override
  String get renameFile => "Hernoem bestand";

  @override
  String get renameFolder => "Map hernoemen";

  @override
  String get deleteFile => "Verwijder bestand";

  @override
  String get deleteFolder => "Verwijder map";

  @override
  String get deleteFileWarning => "De map wordt permanent verwijderd en kan niet worden hersteld. De map is vanaf geen enkele link toegankelijk.";

  @override
  String get delete => "Verwijderen";

  @override
  String get open => "Open";

  @override
  String get addCommentOptional => "Opmerking toevoegen (optioneel)";

  @override
  String get shareFile => "Deel bestand";

  @override
  String get groups => "Groepen";

  @override
  String get to1_1 => "1 to 1";

  @override
  String get day => "dag";

  @override
  String get days => "dagen";

  @override
  String get hour => "uur";

  @override
  String get hours => "uur";

  @override
  String get minute => "minuut";

  @override
  String get minutes => "minuten";

  @override
  String get month => "Maand";

  @override
  String get months => "Maanden";

  @override
  String get year => "jaar";

  @override
  String get years => "jaar";

  @override
  String get by => "door";

  @override
  String get deliveryDateIn => "Uitgerekende datum binnen";

  @override
  String get ago => "Geleden";

  @override
  String get taskOpened => "geopend";

  @override
  String get assignees => "Toegewezen personen";

  @override
  String get assigneeBy => "Toegewezen door";

  @override
  String get closeTask => "Taak sluiten";

  @override
  String get comment => "Commentaar";

  @override
  String get deliveryDate => "Deadline";

  @override
  String get leaveAComment => "laat een reactie achter";

  @override
  String get milestone => "Mijlpaal";

  @override
  String get milestones => "Mijlpalen";

  @override
  String get color => "Kleur";

  @override
  String get milestoneAdded => "Toegevoegd aan mijlpaal";

  @override
  String get participants => "Deelnemers";

  @override
  String get reopen => "heropenen";

  @override
  String get completed => "Voltooid";

  @override
  String get dueDateUpdated => "Vervaldatum bijgewerkt";

  @override
  String get dueDate => "Deadline";

  @override
  String get lastDueDate => "Laatste vervaldatum";

  @override
  String get commented => "Gecommentarieerd";

  @override
  String get tagAdded => "Tag toegevoegd";

  @override
  String get tagRemoved => "Tag verwijderd";

  @override
  String get tags => "Tags";

  @override
  String get update => "Bijwerken";

  @override
  String get details => "Details";

  @override
  String get timeline => "Tijdlijn";

  @override
  String get aboutMe => "Over mij";

  @override
  String get acceptNews => "Nieuws ontvangen";

  @override
  String get allActive => "Allemaal actief";

  @override
  String get changePhoto => "Verander foto";

  @override
  String get changeYourPassword => "Wijzig uw wachtwoord";

  @override
  String get changeYourPasswordAdvice =>
      "Het wachtwoord moet minimaal acht tekens bevatten, waaronder een cijfer, een hoofdletter en een kleine letter. U kunt speciale tekens gebruiken zoals: @#\$%^&+= en tien of meer tekens om de beveiliging van uw wachtwoord te verbeteren";

  @override
  String get charge => "Aanval";

  @override
  String get country => "Land";

  @override
  String get disabled => "Gehandicapt";

  @override
  String get emailNotification => "E-mail notificaties";

  @override
  String get language => "Taal";

  @override
  String get lastName => "Achternaam";

  @override
  String get maxEveryHour => "Elk uur";

  @override
  String get maxHalfDay => "Elke 12 uur";

  @override
  String get messages1x1AndMentions => "Berichten 1x1 en @vermeldingen";

  @override
  String get myProfile => "Mijn profiel";

  @override
  String get never => "Nooit";

  @override
  String get newPassword => "Nieuw paswoord";

  @override
  String get newsLetters => "Nieuwsbrief";

  @override
  String get notReceiveNews => "Geen nieuws ontvangen";

  @override
  String get notifications => "Meldingen";

  @override
  String get passwordRequirements =>
      "Wijzig uw wachtwoord regelmatig om uw veiligheid en bescherming te vergroten";

  @override
  String get phoneNotifications => "Telefoonmeldingen";

  @override
  String get phoneNumber => "Telefoonnummer";

  @override
  String get photoSizeRestrictions =>
      "Gebruik een vierkante foto met een maximale breedte van 400px (klein)";

  @override
  String get repeatNewPassword => "Herhaal nieuw wachtwoord";

  @override
  String get security => "Veiligheid";

  @override
  String get skypeUserName => "Skype-gebruiker";

  @override
  String get sounds => "Geluiden";

  @override
  String get yourUserName => "Je gebruikersnaam";

  @override
  String get saveChanges => "Wijzigingen opslaan";

  @override
  String get profileEmailUsesWarning =>
      "Dit e-mailadres wordt alleen gebruikt voor meldingen over dit team.";

  @override
  String get pushMobileNotifications => "Mobiele pushmeldingen";

  @override
  String get saveNotificationChanges => "Wijzigingen in meldingen opslaan";

  @override
  String get updatePassword => "Vernieuw wachtwoord";

  @override
  String get updateProfileInfo => "Profielgegevens bijwerken";

  @override
  String get password8CharsRequirement =>
      "Wachtwoord moet minimaal 8 tekens bevatten.";

  @override
  String get passwordAtLeast1CapitalLetter =>
      "Wachtwoord moet minimaal 1 hoofdletter bevatten.";

  @override
  String get passwordAtLeast1LowerCaseLetter =>
      "Wachtwoord moet minimaal 1 kleine letter bevatten.";

  @override
  String get passwordAtLeast1Number =>
      "Wachtwoord moet minimaal 1 cijfer bevatten.";

  @override
  String get passwordMustMatch => "Wachtwoorden moeten overeenkomen.";

  @override
  String get notificationUpdatedSuccess => "Wijzigingen in meldingen bijgewerkt.";

  @override
  String get passwordUpdatedSuccess => "Wachtwoord bijgewerkt.";

  @override
  String get profileUpdatedSuccess => "Profiel geüpdatet";

  @override
  String get enablePermissions => "Machtigingen inschakelen";

  @override
  String get permissionDenied => "Toestemming geweigerd";

  @override
  String get savePreferences => "Voorkeuren opslaan";

  @override
  String get turnOffChannelEmails => "Geen kanaal-e-mails ontvangen";

  @override
  String get turnOffChannelSounds => "Kanaalgeluiden uitschakelen";

  @override
  String get chatMessageUnavailable =>
      "Chatberichten zijn niet beschikbaar voor deze gebruiker";

  @override
  String get createChannel => "Kanaal maken";

  @override
  String get createNewChannel => "Een nieuw kanaal maken";

  @override
  String get isTyping => "is aan het typen...";

  @override
  String get createPrivateGroup => "Privégroep maken";

  @override
  String get createPrivateGroupWarning =>
      "Je gaat een nieuwe GROEP maken, je kunt mensen aan deze groep toevoegen als ze al deel uitmaken van je team, zo niet, maak dan eerst de groep aan en nodig ze later uit.";

  @override
  String get createNewPrivateGroup => "Een nieuwe privégroep maken";

  @override
  String get createNewChannelAction =>
      "Je staat op het punt een nieuw open kanaal te maken.";

  @override
  String get createNewChannelForAdminsOnly => "Alleen beheerders hebben toegang om te schrijven.";

  @override
  String get openChannelAllMemberAccess => "Alle teamleden hebben leestoegang.";

  @override
  String get and => "And";

  @override
  String get userIsInactiveToChat =>
      "U kunt niet met deze gebruiker chatten omdat deze inactief is.";

  @override
  String get selectChannel => "Selecteer kanaal";

  @override
  String get needToSelectChannel => "Je moet een kanaal selecteren";

  @override
  String get fileAlreadyShared =>
      "Dit bestand is al gedeeld met dezelfde naam in het kanaal dat je hebt geselecteerd.";

  @override
  String get inChannel => "in kanaal";

  @override
  String seeAnswerMessages(int count) => "Zien $count berichten";

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
    return "Gebruiker $name is lid geworden van het kanaal";
  }

  @override
  String userHasLeft(String name) {
    return "Gebruiker $name heeft het kanaal verlaten";
  }

  @override
  String invitedBy(String name) {
    return "Uitgenodigd door $name";
  }

  @override
  String get answers => "antwoorden";

  @override
  String get publishIn => "publiceren in";

  @override
  String get hasCommentedOnThread => "Heeft gereageerd op een draad:";

  @override
  String get unReadMessages => "Ongelezen berichten";

  @override
  String get hasAddedTag => "Heeft de tag toegevoegd";

  @override
  String get hasAssignedUser => "Heeft de gebruiker toegewezen";

  @override
  String get hasClosedTask => "Heeft de taak gesloten";

  @override
  String get hasCommentedTask => "Heeft een reactie toegevoegd";

  @override
  String get hasCreatedTask => "Heeft de taak gemaakt";

  @override
  String get hasCreatedTaskAssignedTo => "Heeft een nieuwe taak gemaakt die is toegewezen aan";

  @override
  String get hasDeleteTag => "Heeft de tag verwijderd";

  @override
  String get hasDeletedCommentTask => "Heeft een reactie verwijderd";

  @override
  String get hasEditedCommentTask => "Heeft een opmerking bewerkt";

  @override
  String get hasEditedTask => "Heeft de taak bewerkt";

  @override
  String get hasRemovedEndDateTask => "Heeft de einddatum van verwijderd";

  @override
  String get hasReopenedTask => "Heeft de taak heropend";

  @override
  String get hasSetMilestone => "Heeft de mijlpaal bereikt";

  @override
  String get hasUnAssignedUser => "Heeft de toewijzing van de gebruiker ongedaan gemaakt";

  @override
  String get hasUpdatedDateTask => "Heeft de einddatum van geüpdatet";

  @override
  String get inTheTask => "In de taak";

  @override
  String get to => "naar";

  @override
  String get hasAssignedNewDueDateFor => "Heeft een nieuwe vervaldatum toegewezen voor";

  @override
  String get createNewTag => "Nieuwe tag maken";

  @override
  String get createNewMilestone => "Nieuwe mijlpaal maken";

  @override
  String get editMilestone => "Mijlpaal bewerken";

  @override
  String get editTag => "Bewerk label";

  @override
  String get openTasks => "Openstaande taken";

  @override
  String get newPersonalNote => "Nieuwe persoonlijke notitie";

  @override
  String get createNewPersonalNote => "Persoonlijke notitie maken";

  @override
  String get filterBy => "Filteren op";

  @override
  String hereStartsYourMessagesWith(String name) =>
      "Begin hier je berichten met @$name";

  @override
  String thisChannelIsManagedBy(String name) =>
      "Dit kanaal wordt beheerd door @$name, neem indien nodig contact op met de beheerder.";

  @override
  String newPush(String user, String repository, String repositoryUrl) {
    String part1 = "Nieuwe push van";
    String part2 = "in de repository";
    String part3 = R.string.viewDetails;

    return "<p>$part1 <span class='link-mention'>@$user</span> $part2 <span><a href='$repositoryUrl'>$repository. $part3</a></span></p>";
  }

  @override
  String unassignedTask(
      String repository,
      String repositoryUrl,
      ) {
    String part1 = "Niet-toegewezen taak in de repository";
    String part2 = R.string.viewDetails;
    return "<p>$part1 <a href='$repositoryUrl'>$repository. $part2</a></p>";
  }

  @override
  String cardTrelloCreate(
      String board, String boardUrl, String card, String cardUrl, String list) {
    String part1 = "Kaart gemaakt";
    String part2 = "in de lijst";
    String part3 = "van boord";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 $list $part3 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloRename(String board, String boardUrl, String oldName,
      String newName, String list) {
    String part1 = "In de lijst";
    String part2 = "van boord";
    String part3 = "de kaart is hernoemd";
    String part4 = "naar";
    return "<p>$part1 '$list' $part2 <a href='$boardUrl'>$board</a> $part3 '$oldName' $part4 '$newName'</p>";
  }

  @override
  String cardTrelloDescriptionChange(String board, String boardUrl, String card,
      String cardUrl, String list, String description) {
    String part1 = "De kaart";
    String part2 = "van de lijst";
    String part3 = "van het bestuur";
    String part4 = "heeft de beschrijving veranderd in";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4 '$description'</p>";
  }

  @override
  String cardTrelloMoveToOtherList(String board, String boardUrl, String card,
      String cardUrl, String oldList, String newList) {
    String part1 = "De kaart";
    String part2 = "is verplaatst van de lijst";
    String part3 = "naar de lijst";
    String part4= "in het bord";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$oldList' $part3 '$newList' $part4 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloArchive(String board, String boardUrl, String card,
      String cardUrl, String list) {
    String part1 = "De kaart";
    String part2 = "van de lijst";
    String part3 = "van het bestuur";
    String part4 = "is gearchiveerd";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4</p>";
  }

  @override
  String get comments => "Opmerkingen";

  @override
  String get addComment => "Voeg commentaar toe";

  @override
  String get editComment => "Opmerking bewerken";

  @override
  String get downloadAppsAndSynchronizer =>
      "<a href = 'https://noysi.com/a/#/downloads'>DOWNLOAD DE APPS NU!</a>";

  @override
  String get welcomeToNoysiFirstName => "Hoi! Welkom bij Noysi. Wat is je naam?";

  @override
  String get welcomeToNoysiTimeout =>
      "Je hebt me niet geantwoord! Als je hulp nodig hebt, klik dan op <a href='${Endpoint.helpUrl}'>hier.</a>";

  @override
  String get wrongUsernamePassword => "Verkeerde gebruikersnaam of wachtwoord";

  @override
  String get userInUse => "Deze gebruiker is al in gebruik";

  @override
  String get invite => "Uitnodiging";

  @override
  String get groupRequired => "Groep vereist";

  @override
  String get uploading => "Uploaden";

  @override
  String get downloading => "downloaden";

  @override
  String get inviteGuestsWarning => "Gasten worden lid van slechts één groep in dit team.";

  @override
  String get addMembers => "Leden toevoegen";

  @override
  String get enterEmailsByComma =>
      "Voer e-mails in door ze te scheiden met komma's:";

  @override
  String get firstName => "Voornaam";

  @override
  String get inviteFewMorePersonal => "Nodig er een paar uit en wees persoonlijker";

  @override
  String get inviteManyAtOnce => "Nodig er velen tegelijk uit";

  @override
  String get addGuests => "Gasten toevoegen";

  @override
  String get followThread => "Volg deze draad";

  @override
  String get markThreadAsRead => "Markeer als gelezen";

  @override
  String get stopFollowingThread => "Stop met het volgen van deze thread";

  @override
  String get needToVerifyAccountToInvite =>
      "U moet het e-mailaccount verifiëren om leden uit te nodigen.";

  @override
  String get createANewTeam => "Een nieuw team maken";

  @override
  String get createNewTeam => "Creëer een nieuw team!";

  @override
  String get enterIntoYourAccount => "Ga naar uw account";

  @override
  String get forgotPassword => "uw wachtwoord vergeten?";

  @override
  String get goAhead => "Doe Maar!";

  @override
  String get passwordRestriction => "Het wachtwoord moet minimaal acht tekens bevatten, waaronder een cijfer, een hoofdletter en een kleine letter, u kunt speciale tekens gebruiken zoals @ # \$% ^ & + = en tien of meer tekens om de beveiliging van uw wachtwoord te verbeteren.";

  @override
  String get recoverYorPassword => "Herstel uw wachtwoord";

  @override
  String get recoverYorPasswordWarning => "Om je wachtwoord te herstellen, voer je het e-mailadres in waarmee je inlogt op noysi.com";

  @override
  String recoverPasswordResponse(String email) {
    return "We hebben je een e-mail gestuurd naar: $email";
  }

  @override
  String get recoverPasswordResponse1 =>
      "Controleer je inbox en volg daar de instructies om je nieuwe wachtwoord aan te maken";

  @override
  String get continueStr => "Doorgaan";

  @override
  String get passwordAtLeast1SpecialChar => "Het wachtwoord moet minimaal 1 speciaal teken bevatten @#\$%^&+=";

  @override
  String welcomeToNoysiLastName(String name) => "Hallo $name. Wat is je voornaam?";

  @override
  String get welcomeToNoysiDescription => "Very well. Everything is correct. I will proceed to update your profile.";

  @override
  String get welcomeToNoysiInvite => "<a href = '#'>Invite your team members now!</a>";

  @override
  String get activeFilter => "Actief filter";

  @override
  String get newFileComment => "Nieuwe opmerking in het bestand";

  @override
  String get removed => "VERWIJDERD";

  @override
  String get sharedOn => "Gedeeld op";

  @override
  String get notifyAllInThisChannel => "breng iedereen in dit kanaal op de hoogte";

  @override
  String get notifyAllMembers => "breng alle leden op de hoogte";

  @override
  String get keepPressingToRecord => "Houd de knop ingedrukt om op te nemen";

  @override
  String get slideToCancel => "Veeg om te annuleren";

  @override
  String get chooseASecurePasswordText => "Kies een veilig wachtwoord dat u kunt onthouden";

  @override
  String get confirmPassword => "herhaal wachtwoord";

  @override
  String get yourPassword => "Wachtwoord";

  @override
  String get passwordDontMatch => "Wachtwoorden komen niet overeen";

  @override
  String get changeCreateTeamMail => "Nee, ik wil het e-mailadres wijzigen";

  @override
  String step(int number) => "Stap $number";

  @override
  String get user => "Gebruiker";

  @override
  String get deleteFolderWarning => "De map wordt permanent verwijderd en kan niet worden hersteld";

  @override
  String get calendar => "Kalender";

  @override
  String get week => "Week";

  @override
  String get folderIsNotInCurrentTeam => "De map is niet gekoppeld aan het huidige team";

  @override
  String get folderIsNotInAvailableChannel => "De map waarnaar wordt verwezen, bevindt zich niet in een beschikbaar kanaal in de bestandsverkenner";

  @override
  String get folderLinked => "Map gekoppeld in kanaal";

  @override
  String get folderShared => "De map is gedeeld met het kanaal";

  @override
  String get folderUploaded => "De map is geüpload naar het kanaal";

  @override
  String get folderNotFound => "Map niet gevonden";

  @override
  String get folderNameIncorrect => "De mapnaam is niet geldig";

  @override
  String get cloneFolder => "Kloon map";

  @override
  String get cloneFolderInfo => "Door een map te klonen, wordt een nieuwe map in het doelkanaal gemaakt met dezelfde status en inhoud als de geselecteerde map op dit moment.";

  @override
  String get folderDeleted => "U heeft geen toegang tot een verwijderde map";

  @override
  String get youWereInADeletedFolder => "Je bevond je in een map die is verwijderd";

  @override
  String get dateFormat6 => "MM/dd/yyyy";

  @override
  String get activityZone => "Activiteitszone";

  @override
  String get categories => "Categorieën";

  @override
  String get category => "Categorie";

  @override
  String get clearAll => "Wis alles";

  @override
  String get createdTask => "Taak aangemaakt";

  @override
  String get errorFetchingData => "Fout bij ophalen van gegevens";

  @override
  String get filters => "Filters";

  @override
  String get loggedIn => "Ingelogd";

  @override
  String get mention => "Vermelden";

  @override
  String get messageSent => "Bericht verzonden";

  @override
  String get messageUnavailable => "Bericht niet beschikbaar";

  @override
  String get openSessions => "Sessies openen";

  @override
  String get taskAssigned => "Toegewezen taak";

  @override
  String get taskUnassigned => "Niet-toegewezen taak";

  @override
  String get uploadedFile => "Bestand geüpload";

  @override
  String get uploadedFileFolder => "Bestand/map geüpload";

  @override
  String get uploadedFolder => "Map geüpload";

  @override
  String get downloadedFile => "Bestand gedownload";

  @override
  String get downloadedFileFolder => "Bestand/map gedownload";

  @override
  String get downloadedFolder => "Map gedownload";

  @override
  String activityFileFolderUploadedDownloaded(String user, String name, String channel, {bool download = false, bool isDirect = false, isFolder = false}) {
    String part1 = "Jij hebt ${download ? "gedownload" : "geüpload"}${isFolder ? " de map " : " het bestand "}";
    String part2 = download ? "van het kanaal" : "op het kanaal";
    return "$part1 <i class=\"mention-generic\">$name</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMentioned(String user, String channel, {bool isDirect = false}) {
    String part1 = "Je bent genoemd op het kanaal";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMessageSent(String user, String channel, {bool isDirect = false}) {
    String part1 = "Je hebt een bericht op het kanaal gestuurd";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activitySignedIn(String sessionInfo, String ip) {
    return "Je bent ingelogd <i class=\"mention-generic\">$sessionInfo</i> IP: <i class=\"mention-generic\">$ip</i>";
  }

  @override
  String activityTaskAssigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Je bent toegewezen aan de taak";
    String part2 = "op het kanaal";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskCreated(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Je hebt de taak gemaakt";
    String part2 = "op het kanaal";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskUnassigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "De toewijzing van de taak is ongedaan gemaakt";
    String part2 = "op het kanaal";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String get activityZoneHeader => "Hier begint de activiteitenzone";

  @override
  String get selectEvent => "Selecteer evenement";

  @override
  String get googleCalendar => "Google";

  @override
  String get outlookCalendar => "Outlook";

  @override
  String get noysiCalendar => "Noysi";

  @override
  String get autogenerateRoomNameQuestion => "Wilt u de kamernaam automatisch genereren?";

  @override
  String get createMeetingEvent => "Evenement-vergadering maken";

  @override
  String get externalGuests => "Externe gasten";

  @override
  String get internalGuests => "Interne gasten";

  @override
  String get newMeetingEvent => "Nieuwe evenement-vergadering";

  @override
  String get roomName => "Kamer naam";

  @override
  String get eventMeeting => "Evenement-vergadering";

  @override
  String get personalNote => "persoonlijke opmerking";

  @override
  String get updateExternalGuests => "Externe gasten bijwerken";

  @override
  String get nameTextWarning => "De tekst verwijst naar een alfanumerieke reeks van 1-25 tekens. U kunt ook spaties en de tekens gebruiken _ -";

  @override
  String get nameTextWarningWithoutSpaces => "De tekst komt overeen met een alfanumerieke reeks van 1-18 tekens zonder spaties. Je kunt ook de karakters gebruiken _ -";

  @override
  String get today => "Vandaag";

  @override
  String get location => "Plaats";

  @override
  String get sessions => "Sessies";

  @override
  String get appVersion => "App versie";

  @override
  String get browser => "Browser";

  @override
  String get device => "Apparaat";

  @override
  String get logout => "Uitloggen";

  @override
  String get manufacturer => "Fabrikant";

  @override
  String get no => "Nee";

  @override
  String get operativeSystem => "Operatief systeem";

  @override
  String get yes => "Ja";

  @override
  String get allDay => "De hele dag";

  @override
  String get endDate => "Einddatum";

  @override
  String get noTitle => "Geen titel";

  @override
  String get currentSession => "Huidige sessie";

  @override
  String get logOutAllExceptForThisOne => "Log uit alle apparaten behalve deze";

  @override
  String get terminateAllOtherSessions => "Alle andere sessies beëindigen";

  @override
  String get closeAllSessionsConfirmation => "Wil je alle andere sessies beëindigen?";

  @override
  String get closeSessionConfirmation => "Wil je de sessie beëindigen?";

  @override
  String get connectionLost => "Oeps, het lijkt erop dat er geen verbinding is";

  @override
  String get connectionEstablished => "Je bent weer online";

  @override
  String get connectionStatus => "Verbindingsstatus";

  @override
  String get anUserIsCalling => "Een gebruiker belt u...";

  @override
  String get answer => "Antwoord";

  @override
  String get hangDown => "Hangen";

  @override
  String get incomingCall => "Binnenkomend telefoongesprek";

  @override
  String isCallingYou(String user) => "$user belt je...";

  @override
  String get callCouldNotBeInitialized => "De oproep kan niet worden geïnitialiseerd";

  @override
  String get sentMessages => "Verzonden berichten";

  @override
  String sentMessagesCount(String count) => "$count van 10000";

  @override
  String get teamDataUsage => "Gebruik van teamgegevens";

  @override
  String get usedStorage => "Gebruikte opslag";

  @override
  String usedStorageText(String used) => used + "GB van 5 GB";

  @override
  String get userDataUsage => "Gebruik van gebruikersgegevens";

  @override
  String get audioEnabled => "Audio ingeschakeld";

  @override
  String get meetingOptions => "Vergaderopties";

  @override
  String get videoEnabled => "Video ingeschakeld";

  @override
  String get dontShowThisMessage => "Niet meer laten zien";

  @override
  String get showDialogEveryTime => "Dialoogvenster weergeven telkens wanneer een vergadering begint";

  @override
  String get micAndCameraRequiredAlert => "Toegangsrechten voor camera en microfoon zijn vereist. Zorg ervoor dat u de benodigde rechten hebt verleend. Wil je naar de toestemmingsinstellingen gaan?";

  @override
  String get connectWith => "Aanmelden met";

  @override
  String get or => "of";

  @override
  String get viewDetails => "Details bekijken";

  @override
  String zendeskTicketUpdated(String user, String status, String type, String title, String url) {
    String part1 = R.string.user;
    String part2 = "ticket bijgewerkt";
    String part3 = "van het type";
    String part4 = "naar status";
    String part5 = R.string.viewDetails;
    return "<p>$part1 '$user' $part2 '$title' $part3 '$type' $part4 '$status'. <span><a href='$url'>$part5</a></span></p>";
  }

  @override
  String get accept => "Aanvaarden";

  @override
  String get busy => "Druk";

  @override
  String get configuration => "Configuratie";

  @override
  String get downloads => "Downloads";

  @override
  String get editTeam => "Team bewerken";

  @override
  String get general => "Algemeen";

  @override
  String get integrations => "Integraties";

  @override
  String get noRecents => "Geen recente";

  @override
  String get noRecommendations => "Geen recente";

  @override
  String get inAMeeting => "In een vergadering";

  @override
  String get onFire => "Goed bezig";

  @override
  String get plans => "Plannen";

  @override
  String get setAStatus => "Een status instellen";

  @override
  String get sick => "Ziek";

  @override
  String get signOut => "Afmelden";

  @override
  String get suggestions => "Suggesties";

  @override
  String get teams => "teams";

  @override
  String get traveling => "Reizend";

  @override
  String get whatsYourStatus => "Wat is uw status?";

  @override
  String get sendAlwaysAPush => "Stuur altijd een pushmelding";

  @override
  String get robot => "Robot";

  @override
  String get deactivateUserWarning => "Teamleden kunnen niet communiceren met een lid terwijl dit is uitgeschakeld. Alle activiteiten van het gedeactiveerde lid in Noysi blijven echter intact en berichten (open kanalen, 1 op 1 berichten en privégroepen), bestanden en taken blijven toegankelijk.";

  @override
  String get activateUserWarning => "Zodra het lid opnieuw is geactiveerd, krijgt hij de toegang tot dezelfde kanalen, groepen, bestanden en taken die hij had voordat hij werd gedeactiveerd.";

  @override
  String get changeRole => "Verander rol";

  @override
  String get userStatus => "Gebruikers status";

  @override
  String get deactivateMyAccount => "deactiveer mijn account";

  @override
  String get deactivateMyAccountWarning => "Als je je account deactiveert, wordt je gedeactiveerd in al je teams, gesprekken, bestanden, taken en alle activiteiten die je via Noysi hebt beheerd totdat een beheerder je opnieuw activeert.";

  @override
  String get deactivateMyUserInThisTeam => "Deactiveer mijn gebruiker in dit team";

  @override
  String get deactivateMyUserInThisTeamWarning => "Als je jezelf deactiveert in een team, blijft alles wat je bezit in dat team totdat je weer wordt geactiveerd. Als u de enige teambeheerder bent, wordt het team niet verwijderd.";

  @override
  String get operationConfirmation => "Bent u zeker van deze operatie?";

  @override
  String get formatNotSupported => "Deze indeling of extensie wordt niet ondersteund door het besturingssysteem";

  @override
  String get invitePrivateGroupLink => "Nodig een lid uit voor de groep via deze link";

  @override
  String get invalidPhoneNumber => "Ongeldig telefoonnummer";

  @override
  String get searchByCountryName => "Zoeken op landnaam of kiescode";

  @override
  String get kick => "Trap";

  @override
  String get noEvents => "Geen evenementen, taken of persoonlijke notities";

  @override
  String get deleteAll => "Verwijder alles";

  @override
  String get enterKeyManually => "Voer de sleutel handmatig in";

  @override
  String get noysiAuthenticator => "Noysi Authenticator";

  @override
  String get qrScanner => "QR";

  @override
  String get otpLabelWarning => "OTP-label is een alfanumerieke tekenreeks zonder spaties :@.,;()\$% zijn ook toegestaan";

  @override
  String get invalidBase32Chars => "Ongeldige base32-tekens";

  @override
  String get label => "Label";

  @override
  String get secretCode => "Geheime sleutel";

  @override
  String get labelTextWarning => "Label is leeg, controleer deze waarde";

  @override
  String missedCallFrom(String user) => "Gemiste oproep van $user";

  @override
  String get activeItemBackgroundColor => "Achtergrond actief item";

  @override
  String get activeItemTextColor => "Tekst actief item";

  @override
  String get activePresenceColor => "Actieve aanwezigheid";

  @override
  String get adminsCanDeleteMessage => "Beheerders kunnen berichten verwijderen";

  @override
  String get allForAdminsOnly => "@all alleen voor beheerders";

  @override
  String get channelForAdminsOnly => "@channel alleen voor beheerders en kanaalmakers";

  @override
  String get chooseTheme => "Kies een thema voor je team";

  @override
  String get enablePushAllChannels => "Pushmeldingen inschakelen op alle kanalen";

  @override
  String get inactivePresenceColor => "Inactieve aanwezigheid";

  @override
  String get leaveTeam => "Dit team verlaten";

  @override
  String get leaveTeamWarning => "Als je een team verlaat, wordt alles wat je in dat team bezit, verwijderd. Als u de enige teambeheerder bent, wordt het team verwijderd.";

  @override
  String get notificationBadgeBackgroundColor => "Badge-achtergrond";

  @override
  String get notificationBadgeTextColor => "Badgetekst";

  @override
  String get onlyAdminInvitesAllowed => "Gasten alleen geautoriseerd door beheerders";

  @override
  String get reset => "Resetten";

  @override
  String get settings => "Instellingen";

  @override
  String get sidebarColor => "Kleur zijbalk";

  @override
  String get taskUpdateProtected => "Wijziging van taken die zijn gereserveerd voor makers en beheerders";

  @override
  String get teamName => "Teamnaam";

  @override
  String get textColor => "Tekst kleur";

  @override
  String get theme => "Thema";

  @override
  String get updateUsernameBlocked => "Gebruikersnaam blokkeren bij het verzenden van de uitnodiging";

  @override
  String get fileNotFound => "Bestand niet gevonden";

  @override
  String get messageNotFound => "Bericht niet gevonden, controleer of het bericht dat u zoekt beschikbaar is in het huidige team.";

  @override
  String get taskNotFound => "Taak niet gevonden";

  @override
  String userHasPinnedMessage(String name) => "$name heeft een bericht op het kanaal vastgezet";

  @override
  String userHasUnpinnedMessage(String name) => "$name heeft het bericht van dit kanaal losgemaakt";

  @override
  String get pinMessage => "Pin bericht";

  @override
  String get unpinMessage => "Bericht losmaken";

  @override
  String get pinnedMessage => "vastgezet bericht";

  @override
  String get deleteMyAccount => "Verwijder mijn account";

  @override
  String get yourDeleteRequestIsInProcess => "Uw verzoek om accountverwijdering is in behandeling";

  @override
  String get deleteMyAccountWarning => "Als u uw account verwijdert, is de actie onomkeerbaar. Als u een team beheert en er is geen andere beheerder, wordt het team verwijderd.";

  @override
  String get lifetimeDeal => "Levenslange aanbiedingen";

  @override
  String get showEmails => "E-mailadressen van gebruikers weergeven";

  @override
  String get showPhoneNumbers => "Telefoonnummers van gebruikers weergeven";

  @override
  String get addChannel => "Kanaal toevoegen";

  @override
  String get addPrivateGroup => "Privégroep toevoegen";

  @override
  String get selectUserFromTeam => "Selecteer gebruiker van dit team";

  @override
  String get selectUsersFromChannelGroup => "Selecteer gebruikers uit kanaal of groep";

  @override
  String get memberDeleted => "Lid verwijderd";
}
import 'dart:ui';

import 'package:code/_res/values/config.dart';
import 'package:code/_res/values/text/strings_base.dart';

import '../../../data/api/remote/endpoints.dart';
import '../../R.dart';

class StringsIt implements StringsBase {
  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Noysi";

  @override
  String get yourTeams => "Le vostre squadre";

  @override
  String get channel => "Canale";

  @override
  String get channels => "Canali";

  @override
  String get directMessagesAbr => "DMs";

  @override
  String get email => "Email";

  @override
  String get home => "Casa";

  @override
  String get member => "Membro";

  @override
  String get administrator => "Amministratore";

  @override
  String get guest => "Ospite";

  @override
  String get guests => "Ospiti";

  @override
  String get members => "Membri";

  @override
  String get inactiveMember => "Membro disattivato";

  @override
  String get message => "Messaggio";

  @override
  String get messages => "Messaggi";

  @override
  String get password => "Password";

  @override
  String get register => "Iscriviti";

  @override
  String get search => "Cerca";

  @override
  String get signIn => "Accedi";

  @override
  String get task => "Compito";

  @override
  String get tasks => "Compiti";

  @override
  String get createTask => "Creare un compito";

  @override
  String get newTask => "Nuovo compito";

  @override
  String get description => "Descrizione";

  @override
  String get team => "Squadra";

  @override
  String get thread => "Filo";

  @override
  String get threads => "Threads";

  @override
  String get createTeam => "Creare una squadra";

  @override
  String get confirmIsCorrectEmailAddress => "Sì! Questa è l'e-mail corretta";

  @override
  String get createTeamIntro =>
      "Stai per mettere in piedi la tua nuova squadra a Noysi.";

  @override
  String get isCorrectEmailAddress => "È l'indirizzo email corretto?";

  @override
  String get welcome => "Benvenuti!";

  @override
  String get invitationSentAt => "Il tuo invito sarà inviato a:";

  @override
  String get next => "Prossimo";

  @override
  String get startNow => "Inizia ora!";

  @override
  String get charsRemaining => "Personaggi rimanenti:";

  @override
  String get teamNameOrgCompany =>
      "Enter your Team Name, Organization or Company Name.";

  @override
  String get teamNameOrgCompanyLabel => "Ex. Il nome della mia azienda";

  @override
  String get yourTeam => "La tua squadra";

  @override
  String get noysiServiceNewsletters =>
      "Va bene ricevere (molto occasionalmente) email sul servizio NOYSI.";

  @override
  String get userNameIntro =>
      "Il tuo nome utente è il modo in cui appari agli altri membri della tua squadra.";

  @override
  String get userNameLabel => "Ex. ackerman";

  @override
  String get addAnother => "Aggiungere un altro";

  @override
  String get byProceedingAcceptTerms =>
      "* Procedendo, accettate il nostro <b>Condizioni di servizio</b>";

  @override
  String get invitations => "Inviti";

  @override
  String get invitePeople => "Invite people";

  @override
  String get noysiIsTeamWorkInvite =>
      "Noysi è uno strumento di lavoro di squadra. Invita almeno una persona";

  @override
  String get userName => "Nome utente";

  @override
  String get fieldMax18 => "18 caratteri al massimo";

  @override
  String get fieldMax25 => "25 caratteri al massimo";

  @override
  String get fieldPassword => "Password richiesta";

  @override
  String get fieldRequired => "Campo richiesto";

  @override
  String get missingEmailFormat => "Email sbagliata";

  @override
  String get back => "Indietro";

  @override
  String get channelBrowser => "Browser dei canali";

  @override
  String get help => "Aiuto";

  @override
  String get preferences => "Preferenze";

  @override
  String get signOutOf => "Firma fuori da";

  @override
  String get closed => "Chiuso";

  @override
  String get closedMilestone => "Chiuso";

  @override
  String get close => "Chiudere";

  @override
  String get opened => "Aperto";

  @override
  String get chat => "Chat";

  @override
  String get allThreads => "Tutti i fili";

  @override
  String get inviteMorPeople => "Invitare più persone";

  @override
  String get meeting => "Riunione";

  @override
  String get myFiles => "I miei file";

  @override
  String get myTasks => "I miei compiti";

  @override
  String get myTeams => "Le mie squadre";

  @override
  String get openChannels => "Canali aperti";

  @override
  String get privateGroups => "Gruppi privati";

  @override
  String get favorites => "Preferiti";

  @override
  String get message1x1 => "Messaggi 1 a 1";

  @override
  String get acceptedTitle => "Accettato";

  @override
  String get date => "Data";

  @override
  String get invitationLanguageTitle => "Lingua";

  @override
  String get invitationMessage => "Messaggio d'invito";

  @override
  String get revokeInvitation => "Revocare l'invito";

  @override
  String get revoke => "Revocare";

  @override
  String get revokeInvitationWarning =>
      "Fate attenzione, questa azione non è reversibile";

  @override
  String get revokeInvitationDelete => "Invito a cancellare";

  @override
  String get resendInvitationBefore24hrs =>
      "Il reinvio dell'invito non è permesso fino a 24 ore dall'ultimo invio.";

  @override
  String get resendInvitationSuccess => "Inviti inviati con successo.";

  @override
  String get resendInvitation => "Reinvia l'invito";

  @override
  String get invitationMessageDefault =>
      "Ciao! Qui c'è un invito a partecipare";

  @override
  String get inviteManyAsOnce => "Invitare molti come una volta";

  @override
  String get inviteMemberTitle =>
      "I membri del team hanno pieno accesso ai canali aperti, ai messaggi da persona a persona e ai gruppi.";

  @override
  String get inviteMemberWarningTitle =>
      "Per invitare nuovi membri devi essere l'amministratore della squadra.";

  @override
  String get inviteNewMemberWarningTitle =>
      "Ogni membro del team può aggiungere ospiti illimitatamente.";

  @override
  String get inviteSubtitle =>
      "Noysi è uno strumento per lavorare meglio con la tua squadra. Invitali ora!";

  @override
  String get inviteTitle => "Invitare altre persone";

  @override
  String get inviteToAGroup => "Invita a un gruppo (richiesto)";

  @override
  String get inviteToAGroupNotRequired => "Invita a un gruppo (opzionale)";

  @override
  String get inviteMemberWarning =>
      "I nuovi membri si uniranno automaticamente al canale #general. Facoltativamente, puoi anche aggiungerli ad un gruppo privato ora.";

  @override
  String get inviteToThisTeam => "Invita a questa squadra";

  @override
  String get invitationsSent => "Inviti inviati";

  @override
  String get name => "Nome";

  @override
  String get noPendingInvitations =>
      "Non ci sono inviti da inviare in questa squadra.";

  @override
  String get pendingTitle => "In attesa di";

  @override
  String get chooseTitle => "Scegliere";

  @override
  String get seePendingAcceptedInvitations =>
      "Vedere gli inviti pendenti e accettati";

  @override
  String get sendInvitations => "Inviare inviti";

  @override
  String get typeEmail => "Digitare un'e-mail";

  @override
  String get typeEmailComaSeparated => "Digitare le e-mail per coma separato";

  @override
  String get atNoysi => "a Noysi";

  @override
  String get inviteNewMemberTitle =>
      "Gli ospiti non pagano e puoi invitare tutti quelli che vuoi, ma avranno accesso solo a un gruppo all'interno di questo Team.";

  @override
  String get invited => "Invitato";

  @override
  String get thisNameAlreadyExist =>
      "Sembra che questo nome sia già in uso.";

  @override
  String get emptyList => "Lista vuota";

  @override
  String get ok => "OK";

  @override
  String get byNameFirst => "Per nome A-Z";

  @override
  String get byNameInvertedFirst => "Per nome Z-A";

  @override
  String get download => "Scaricare";

  @override
  String get files => "File";

  @override
  String get folders => "Cartelle";

  @override
  String get newTitle => "Nuovo";

  @override
  String get newestFirst => "Prima i più nuovi";

  @override
  String get oldestFirst => "Prima il più vecchio";

  @override
  String get see => "Vedere";

  @override
  String get share => "Condividi";

  @override
  String get moreInfo => "Più informazioni";

  @override
  String get assigned => "Assegnato";

  @override
  String get author => "Autore";

  @override
  String get created => "Creato";

  @override
  String get earlyDeliverDate => "Data di consegna anticipata";

  @override
  String get farDeliverDate => "Data di consegna lontana";

  @override
  String get filterAuthor => "Filtrare per autore";

  @override
  String get searchUsers => "Ricerca utenti";

  @override
  String get sort => "Ordina";

  @override
  String get sortBy => "Ordina per";

  @override
  String get cancel => "Cancella";

  @override
  String get exit => "Uscita";

  @override
  String get exitWarning => "Sei sicuro?";

  @override
  String get deleteChannelWarning =>
      "Sei sicuro di voler lasciare questo canale?";

  @override
  String get typeMessage => "Scrivi un messaggio...";

  @override
  String get addChannelToFavorites => "Aggiungi ai preferiti";

  @override
  String get removeFromFavorites => "Rimuovi dai preferiti";

  @override
  String get channelInfo => "Informazioni sul canale";

  @override
  String get channelMembers => "Membri del canale";

  @override
  String get channelPreferences => "Preferenze di canale";

  @override
  String get closeChatVisibility => "Chiudere 1 a 1";

  @override
  String get inviteToGroup => "Invita un membro a questo canale";

  @override
  String get leaveChannel => "Lascia il canale";

  @override
  String get mentions => "Menzioni";

  @override
  String get seeFiles => "Vedere i file";

  @override
  String get seeLinks => "Vedi link";

  @override
  String get links => "Link";

  @override
  String get taskManager => "Gestore delle attività";

  @override
  String get videoCall => "Video chiamata";

  @override
  String get addReaction => "Aggiungere la reazione";

  @override
  String get addTag => "Aggiungi tag";

  @override
  String get addMilestone => "Aggiungi una pietra miliare";

  @override
  String get copyMessage => "Copiare il messaggio";

  @override
  String get copyPermanentLink => "Copiare il link";

  @override
  String get createThread => "Iniziare un thread";

  @override
  String get edit => "Modifica";

  @override
  String get favorite => "Preferito";

  @override
  String get remove => "Rimuovi";

  @override
  String get tryAgain => "Prova di nuovo";

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
      "Sei sicuro di voler cancellare questo messaggio? Questo non può essere annullato.";

  @override
  String get deleteMessageTitle => "Cancellare il messaggio";

  @override
  String get edited => "Modificato";

  @override
  String get seeAll => "Vedi tutti";

  @override
  String get copiedToClipboard => "Copiato negli appunti!";

  @override
  String get underConstruction => "In costruzione";

  @override
  String get reactions => "Reazioni";

  @override
  String get all => "Tutti";

  @override
  String get users => "Utenti";

  @override
  String get documents => "Documenti";

  @override
  String get fromLocalStorage => "Dall'archiviazione locale";

  @override
  String get photoGallery => "Galleria fotografica";

  @override
  String get recordVideo => "Registrare un video";

  @override
  String get takePhoto => "Scattare una foto";

  @override
  String get useCamera => "Dalla macchina fotografica";

  @override
  String get videoGallery => "Galleria video";

  @override
  String get changeName => "Cambia nome";

  @override
  String get createFolder => "Crea cartella";

  @override
  String get createNameWarning =>
      "I nomi devono avere al massimo 18 caratteri, senza segni di punteggiatura.";

  @override
  String get newName => "Nuovo nome";

  @override
  String get rename => "Rinominare";

  @override
  String get renameFile => "Rinomina il file";

  @override
  String get renameFolder => "Rinomina la cartella";

  @override
  String get deleteFile => "Cancellare il file";

  @override
  String get deleteFolder => "Cancellare la cartella";

  @override
  String get deleteFileWarning => "La cartella verrà cancellata in modo permanente e non potrà essere recuperata. La cartella sarà inaccessibile da qualsiasi link.";

  @override
  String get delete => "Cancellare";

  @override
  String get open => "Aprire";

  @override
  String get addCommentOptional => "Aggiungi un commento (opzionale)";

  @override
  String get shareFile => "Condividi file";

  @override
  String get groups => "Gruppi";

  @override
  String get to1_1 => "1 a 1";

  @override
  String get day => "giorno";

  @override
  String get days => "Giorni";

  @override
  String get hour => "ora";

  @override
  String get hours => "ore";

  @override
  String get minute => "minuto";

  @override
  String get minutes => "minuti";

  @override
  String get month => "Mese";

  @override
  String get months => "Mesi";

  @override
  String get year => "anno";

  @override
  String get years => "anni";

  @override
  String get by => "da";

  @override
  String get deliveryDateIn => "Data di scadenza in";

  @override
  String get ago => "Ago";

  @override
  String get taskOpened => "Aperto";

  @override
  String get assignees => "Assegnatari";

  @override
  String get assigneeBy => "Assegnato da";

  @override
  String get closeTask => "Chiudere il compito";

  @override
  String get comment => "Commento";

  @override
  String get deliveryDate => "Data di scadenza";

  @override
  String get leaveAComment => "Lascia un commento";

  @override
  String get milestone => "Pietra miliare";

  @override
  String get milestones => "Pietre miliari";

  @override
  String get color => "Colore";

  @override
  String get milestoneAdded => "Aggiunto alla pietra miliare";

  @override
  String get participants => "Partecipanti";

  @override
  String get reopen => "Riaprire";

  @override
  String get completed => "Completato";

  @override
  String get dueDateUpdated => "Data di scadenza aggiornata";

  @override
  String get dueDate => "Data di scadenza";

  @override
  String get lastDueDate => "Ultima data di scadenza";

  @override
  String get commented => "Commentato";

  @override
  String get tagAdded => "Tag aggiunto";

  @override
  String get tagRemoved => "Tag rimosso";

  @override
  String get tags => "Tags";

  @override
  String get update => "Aggiornamento";

  @override
  String get details => "Dettagli";

  @override
  String get timeline => "Timeline";

  @override
  String get aboutMe => "Su di me";

  @override
  String get acceptNews => "Ricevere notizie";

  @override
  String get allActive => "Tutti gli attivi";

  @override
  String get changePhoto => "Cambia foto";

  @override
  String get changeYourPassword => "Cambia la tua password";

  @override
  String get changeYourPasswordAdvice =>
      "La password deve avere almeno otto caratteri tra cui un numero, una lettera maiuscola e una minuscola, è possibile utilizzare caratteri speciali come @#\$%^&+= e dieci o più caratteri per migliorare la sicurezza della vostra password";

  @override
  String get charge => "Carica";

  @override
  String get country => "Paese";

  @override
  String get disabled => "Disabile";

  @override
  String get emailNotification => "Notifiche via e-mail";

  @override
  String get language => "Lingua";

  @override
  String get lastName => "Nome e cognome";

  @override
  String get maxEveryHour => "Ogni ora";

  @override
  String get maxHalfDay => "Ogni 12 ore";

  @override
  String get messages1x1AndMentions => "Messaggi 1x1 e @mentions";

  @override
  String get myProfile => "Il mio profilo";

  @override
  String get never => "Mai";

  @override
  String get newPassword => "Nuova password";

  @override
  String get newsLetters => "Newsletter";

  @override
  String get notReceiveNews => "Non ricevere notizie";

  @override
  String get notifications => "Notifiche";

  @override
  String get passwordRequirements =>
      "Cambia periodicamente la tua password per aumentare la tua sicurezza e protezione";

  @override
  String get phoneNotifications => "Notifiche telefoniche";

  @override
  String get phoneNumber => "Numero di telefono";

  @override
  String get photoSizeRestrictions =>
      "Usa una foto quadrata con una larghezza massima di 400px (piccola)";

  @override
  String get repeatNewPassword => "Ripetere la nuova password";

  @override
  String get security => "Sicurezza";

  @override
  String get skypeUserName => "Utente Skype";

  @override
  String get sounds => "Suona";

  @override
  String get yourUserName => "Il tuo nome utente";

  @override
  String get saveChanges => "Salvare le modifiche";

  @override
  String get profileEmailUsesWarning =>
      "Questa e-mail viene utilizzata solo per le notifiche su questa squadra.";

  @override
  String get pushMobileNotifications => "Notifiche mobili push";

  @override
  String get saveNotificationChanges => "Salvare le modifiche di notifica";

  @override
  String get updatePassword => "Aggiorna la password";

  @override
  String get updateProfileInfo => "Aggiorna le informazioni del profilo";

  @override
  String get password8CharsRequirement =>
      "La password deve avere almeno 8 caratteri.";

  @override
  String get passwordAtLeast1CapitalLetter =>
      "La password deve contenere almeno 1 lettera maiuscola.";

  @override
  String get passwordAtLeast1LowerCaseLetter =>
      "La password deve contenere almeno 1 lettera minuscola.";

  @override
  String get passwordAtLeast1Number =>
      "La password deve contenere almeno 1 numero.";

  @override
  String get passwordMustMatch => "La password deve corrispondere.";

  @override
  String get notificationUpdatedSuccess => "Modifiche di notifica aggiornate.";

  @override
  String get passwordUpdatedSuccess => "Password aggiornata.";

  @override
  String get profileUpdatedSuccess => "Profilo aggiornato";

  @override
  String get enablePermissions => "Abilitare i permessi";

  @override
  String get permissionDenied => "Permesso negato";

  @override
  String get savePreferences => "Salvare le preferenze";

  @override
  String get turnOffChannelEmails => "Non ricevere le email del canale";

  @override
  String get turnOffChannelSounds => "Spegnere i suoni del canale";

  @override
  String get chatMessageUnavailable =>
      "I messaggi di chat non sono disponibili per questo utente";

  @override
  String get createChannel => "Creare un canale";

  @override
  String get createNewChannel => "Creare un nuovo canale";

  @override
  String get isTyping => "sta digitando...";

  @override
  String get createPrivateGroup => "Creare un gruppo privato";

  @override
  String get createPrivateGroupWarning =>
      "Stai per creare un nuovo GRUPPO, puoi aggiungere persone a questo gruppo se fanno già parte della tua squadra, se no, crea prima il gruppo e invitale dopo.";

  @override
  String get createNewPrivateGroup => "Creare un nuovo gruppo privato";

  @override
  String get createNewChannelAction =>
      "Stai per creare un nuovo canale aperto.";

  @override
  String get createNewChannelForAdminsOnly => "Solo gli amministratori hanno accesso alla scrittura.";

  @override
  String get openChannelAllMemberAccess => "Tutti i membri del team hanno accesso in lettura.";

  @override
  String get and => "E";

  @override
  String get userIsInactiveToChat =>
      "Non puoi chattare con questo utente perché è inattivo.";

  @override
  String get selectChannel => "Selezionare il canale";

  @override
  String get needToSelectChannel => "È necessario selezionare un canale";

  @override
  String get fileAlreadyShared =>
      "Questo file è già condiviso con lo stesso nome nel canale che hai selezionato.";

  @override
  String get inChannel => "nel canale";

  @override
  String seeAnswerMessages(int count) => "Vedere $count messaggi";

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
    return "Utente $name si è unito al canale";
  }

  @override
  String userHasLeft(String name) {
    return "Utente $name ha lasciato il canale";
  }

  @override
  String invitedBy(String name) {
    return "Invitato da $name";
  }

  @override
  String get answers => "Risposte";

  @override
  String get publishIn => "pubblicare in";

  @override
  String get hasCommentedOnThread => "Ha commentato un thread:";

  @override
  String get unReadMessages => "Messaggi non letti";

  @override
  String get hasAddedTag => "Ha aggiunto il tag";

  @override
  String get hasAssignedUser => "Ha assegnato l'utente";

  @override
  String get hasClosedTask => "Ha chiuso il compito";

  @override
  String get hasCommentedTask => "Ha aggiunto un commento";

  @override
  String get hasCreatedTask => "Ha creato il compito";

  @override
  String get hasCreatedTaskAssignedTo => "Ha creato un nuovo compito assegnato a";

  @override
  String get hasDeleteTag => "Ha cancellato il tag";

  @override
  String get hasDeletedCommentTask => "Ha cancellato un commento";

  @override
  String get hasEditedCommentTask => "Ha modificato un commento";

  @override
  String get hasEditedTask => "Ha modificato il compito";

  @override
  String get hasRemovedEndDateTask => "Ha cancellato la data di fine di";

  @override
  String get hasReopenedTask => "Ha riaperto il compito";

  @override
  String get hasSetMilestone => "Ha fissato la pietra miliare";

  @override
  String get hasUnAssignedUser => "Ha tolto l'assegnazione all'utente";

  @override
  String get hasUpdatedDateTask => "Ha aggiornato la data di fine di";

  @override
  String get inTheTask => "Nel compito";

  @override
  String get to => "a";

  @override
  String get hasAssignedNewDueDateFor => "Ha assegnato una nuova data di scadenza per";

  @override
  String get createNewTag => "Crea un nuovo tag";

  @override
  String get createNewMilestone => "Creare una nuova pietra miliare";

  @override
  String get editMilestone => "Modifica pietra miliare";

  @override
  String get editTag => "Modifica tag";

  @override
  String get openTasks => "Compiti aperti";

  @override
  String get newPersonalNote => "Nuova nota personale";

  @override
  String get createNewPersonalNote => "Creare una nota personale";

  @override
  String get filterBy => "Filtrare per";

  @override
  String hereStartsYourMessagesWith(String name) =>
      "Qui iniziate i vostri messaggi con @$name";

  @override
  String thisChannelIsManagedBy(String name) =>
      "Questo canale è gestito da @$name, se hai bisogno di aiuto contatta l'amministratore.";

  @override
  String newPush(String user, String repository, String repositoryUrl) {
    String part1 = "Nuova spinta di";
    String part2 = "nel repository";
    String part3 = R.string.viewDetails;

    return "<p>$part1 <span class='link-mention'>@$user</span> $part2 <span><a href='$repositoryUrl'>$repository. $part3</a></span></p>";
  }

  @override
  String unassignedTask(
      String repository,
      String repositoryUrl,
      ) {
    String part1 = "Compito non assegnato nel repository";
    String part2 = R.string.viewDetails;
    return "<p>$part1 <a href='$repositoryUrl'>$repository. $part2</a></p>";
  }

  @override
  String cardTrelloCreate(
      String board, String boardUrl, String card, String cardUrl, String list) {
    String part1 = "Carta creata";
    String part2 = "nella lista";
    String part3 = "del consiglio di amministrazione";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 $list $part3 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloRename(String board, String boardUrl, String oldName,
      String newName, String list) {
    String part1 = "Nella lista";
    String part2 = "del consiglio di amministrazione";
    String part3 = "la scheda è stata rinominata";
    String part4 = "a";
    return "<p>$part1 '$list' $part2 <a href='$boardUrl'>$board</a> $part3 '$oldName' $part4 '$newName'</p>";
  }

  @override
  String cardTrelloDescriptionChange(String board, String boardUrl, String card,
      String cardUrl, String list, String description) {
    String part1 = "La carta";
    String part2 = "della lista";
    String part3 = "del consiglio di amministrazione";
    String part4 = "ha cambiato la sua descrizione in";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4 '$description'</p>";
  }

  @override
  String cardTrelloMoveToOtherList(String board, String boardUrl, String card,
      String cardUrl, String oldList, String newList) {
    String part1 = "La carta";
    String part2 = "è stato spostato dalla lista";
    String part3 = "alla lista";
    String part4= "nel consiglio";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$oldList' $part3 '$newList' $part4 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloArchive(String board, String boardUrl, String card,
      String cardUrl, String list) {
    String part1 = "La carta";
    String part2 = "della lista";
    String part3 = "del consiglio di amministrazione";
    String part4 = "è stato archiviato";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4</p>";
  }

  @override
  String get comments => "Commenti";

  @override
  String get addComment => "Aggiungi un commento";

  @override
  String get editComment => "Modifica Commento";

  @override
  String get downloadAppsAndSynchronizer =>
      "<a href = 'https://noysi.com/a/#/downloads'>SCARICA LE APPLICAZIONI ORA!</a>";

  @override
  String get welcomeToNoysiFirstName => "Ben arrivato! Questo è il tuo canale personale, nessun altro lo vedrà, non hai comunicazione con nessuno, è il tuo canale personale per lasciare note personali e caricare file che nessun altro vedrà. Come ti chiami?";

  @override
  String get welcomeToNoysiTimeout =>
      "Non mi hai risposto! Se hai bisogno di aiuto clicca <a href='${Endpoint.helpUrl}'>qui.</a>";

  @override
  String get wrongUsernamePassword => "Nome utente o password sbagliati";

  @override
  String get userInUse => "Questo utente è già in uso";

  @override
  String get invite => "Invita";

  @override
  String get groupRequired => "Gruppo richiesto";

  @override
  String get uploading => "Caricamento di";

  @override
  String get downloading => "Scaricare";

  @override
  String get inviteGuestsWarning => "Gli ospiti si uniscono a un solo gruppo in questa squadra.";

  @override
  String get addMembers => "Aggiungere membri";

  @override
  String get enterEmailsByComma =>
      "Inserisci le e-mail separandole con delle virgole:";

  @override
  String get firstName => "Nome";

  @override
  String get inviteFewMorePersonal => "Invita pochi e sii più personale";

  @override
  String get inviteManyAtOnce => "Invita molti in una volta sola";

  @override
  String get addGuests => "Aggiungere ospiti";

  @override
  String get followThread => "Segui questo thread";

  @override
  String get markThreadAsRead => "Segna come letto";

  @override
  String get stopFollowingThread => "Smetti di seguire questo thread";

  @override
  String get needToVerifyAccountToInvite =>
      "È necessario verificare l'account di posta elettronica per invitare i membri.";

  @override
  String get createANewTeam => "Creare una nuova squadra";

  @override
  String get createNewTeam => "Crea una nuova squadra!";

  @override
  String get enterIntoYourAccount => "Entra nel tuo account";

  @override
  String get forgotPassword => "Hai dimenticato la tua password?";

  @override
  String get goAhead => "Vai avanti!";

  @override
  String get passwordRestriction => "La password deve avere almeno otto caratteri tra cui un numero, una lettera maiuscola e una lettera minuscola, si possono usare caratteri speciali come @ # \$% ^ & + = e dieci o più caratteri per migliorare la sicurezza della vostra password.";

  @override
  String get recoverYorPassword => "Recupera la tua password";

  @override
  String get recoverYorPasswordWarning => "Per ripristinare la tua password, inserisci l'indirizzo email che usi per accedere a noysi.com";

  @override
  String recoverPasswordResponse(String email) {
    return "Ti abbiamo inviato un'e-mail a $email";
  }

  @override
  String get recoverPasswordResponse1 =>
      "Controlla la tua casella di posta e segui le istruzioni per creare la tua nuova password";

  @override
  String get continueStr => "Continua";

  @override
  String get passwordAtLeast1SpecialChar => "La password deve includere almeno 1 carattere speciale @#\$%^&+=";

  @override
  String welcomeToNoysiLastName(String name) => "Hello $name. Qual è il suo cognome?";

  @override
  String get welcomeToNoysiDescription => "Molto bene. Tutto è corretto. Procederò ad aggiornare il suo profilo.";

  @override
  String get welcomeToNoysiInvite => "<a href = '#'>Invita i membri del tuo team ora!</a>";

  @override
  String get activeFilter => "Filtro attivo";

  @override
  String get newFileComment => "Nuovo commento nel file";

  @override
  String get removed => "Rimosso";

  @override
  String get sharedOn => "Condiviso su";

  @override
  String get notifyAllInThisChannel => "avvisare tutti in questo canale";

  @override
  String get notifyAllMembers => "avvisare tutti i membri";

  @override
  String get keepPressingToRecord => "Tenere premuto il pulsante per registrare";

  @override
  String get slideToCancel => "Scorri per cancellare";

  @override
  String get chooseASecurePasswordText => "Scegli una password sicura che puoi ricordare";

  @override
  String get confirmPassword => "Ripetere la password";

  @override
  String get yourPassword => "Password";

  @override
  String get passwordDontMatch => "Le password non corrispondono";

  @override
  String get changeCreateTeamMail => "No, voglio cambiare l'email";

  @override
  String step(int number) => "Passo $number";

  @override
  String get user => "Utente";

  @override
  String get deleteFolderWarning => "La cartella sarà cancellata in modo permanente e non potrà essere recuperata";

  @override
  String get calendar => "Calendario";

  @override
  String get week => "Settimana";

  @override
  String get folderIsNotInCurrentTeam => "La cartella non è associata al Team corrente";

  @override
  String get folderIsNotInAvailableChannel => "La cartella di riferimento non è in un canale disponibile in File Explorer";

  @override
  String get folderLinked => "Cartella collegata nel canale";

  @override
  String get folderShared => "La cartella è stata condivisa sul canale";

  @override
  String get folderUploaded => "La cartella è stata caricata sul canale";

  @override
  String get folderNotFound => "Cartella non trovata";

  @override
  String get folderNameIncorrect => "Il nome della cartella non è valido";

  @override
  String get cloneFolder => "Cartella clone";

  @override
  String get cloneFolderInfo => "La clonazione di una cartella crea una nuova cartella nel canale di destinazione con lo stesso stato e contenuto della cartella selezionata in questo momento.";

  @override
  String get folderDeleted => "Non è possibile accedere a una cartella cancellata";

  @override
  String get youWereInADeletedFolder => "Eri in una cartella che è stata cancellata";

  @override
  String get dateFormat6 => "MM/dd/yyyy";

  @override
  String get activityZone => "Zona di attività";

  @override
  String get categories => "Categorie";

  @override
  String get category => "Categoria";

  @override
  String get clearAll => "Cancella tutto";

  @override
  String get createdTask => "Compito creato";

  @override
  String get errorFetchingData => "Errore nel recupero dei dati";

  @override
  String get filters => "Filtri";

  @override
  String get loggedIn => "Registrato";

  @override
  String get mention => "Menzione";

  @override
  String get messageSent => "Messaggio inviato";

  @override
  String get messageUnavailable => "Messaggio non disponibile";

  @override
  String get openSessions => "Sessioni aperte";

  @override
  String get taskAssigned => "Compito assegnato";

  @override
  String get taskUnassigned => "Compito non assegnato";

  @override
  String get uploadedFile => "File caricato";

  @override
  String get uploadedFileFolder => "File/cartella caricata";

  @override
  String get uploadedFolder => "Cartella caricata";

  @override
  String get downloadedFile => "File scaricato";

  @override
  String get downloadedFileFolder => "File/cartella scaricata";

  @override
  String get downloadedFolder => "Cartella scaricata";

  @override
  String activityFileFolderUploadedDownloaded(String user, String name, String channel, {bool download = false, bool isDirect = false, isFolder = false}) {
    String part1 = "Tu hai ${download ? "scaricato" : "caricato"}${isFolder ? " la cartella " : " il file "}";
    String part2 = download ? "dal canale" : "sul canale";
    return "$part1 <i class=\"mention-generic\">$name</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMentioned(String user, String channel, {bool isDirect = false}) {
    String part1 = "Sei stato menzionato sul canale";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMessageSent(String user, String channel, {bool isDirect = false}) {
    String part1 = "Hai inviato un messaggio sul canale";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activitySignedIn(String sessionInfo, String ip) {
    return "You have logged in <i class=\"mention-generic\">$sessionInfo</i> IP: <i class=\"mention-generic\">$ip</i>";
  }

  @override
  String activityTaskAssigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Sei stato assegnato al compito";
    String part2 = "sul canale";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskCreated(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Hai creato il compito";
    String part2 = "sul canale";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskUnassigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Sei stato deallocato dal compito";
    String part2 = "sul canale";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String get activityZoneHeader => "Qui inizia la zona di attività";

  @override
  String get selectEvent => "Selezionare l'evento";

  @override
  String get googleCalendar => "Google";

  @override
  String get outlookCalendar => "Outlook";

  @override
  String get noysiCalendar => "Noysi";

  @override
  String get autogenerateRoomNameQuestion => "Vuoi generare automaticamente il nome della stanza?";

  @override
  String get createMeetingEvent => "Creare un evento-riunione";

  @override
  String get externalGuests => "Ospiti esterni";

  @override
  String get internalGuests => "Ospiti interni";

  @override
  String get newMeetingEvent => "Nuovo evento-incontro";

  @override
  String get roomName => "Nome della camera";

  @override
  String get eventMeeting => "Evento-incontro";

  @override
  String get personalNote => "Nota personale";

  @override
  String get updateExternalGuests => "Aggiornare gli ospiti esterni";

  @override
  String get nameTextWarning => "Il testo corrisponde a una stringa alfanumerica di 1-25 caratteri. Puoi anche usare gli spazi e i caratteri _ -";

  @override
  String get nameTextWarningWithoutSpaces => "Il testo corrisponde ad una stringa alfanumerica di 1-18 caratteri senza spazi. Puoi anche usare i caratteri _ -";

  @override
  String get today => "Oggi";

  @override
  String get location => "Posizione";

  @override
  String get sessions => "Sessioni";

  @override
  String get appVersion => "App Version";

  @override
  String get browser => "Browser";

  @override
  String get device => "Dispositivo";

  @override
  String get logout => "Esci";

  @override
  String get manufacturer => "Produttore";

  @override
  String get no => "No";

  @override
  String get operativeSystem => "Sistema operativo";

  @override
  String get yes => "Sì";

  @override
  String get allDay => "Tutto il giorno";

  @override
  String get endDate => "Data di fine";

  @override
  String get noTitle => "Nessun titolo";

  @override
  String get currentSession => "Sessione corrente";

  @override
  String get logOutAllExceptForThisOne => "Disconnetti tutti i dispositivi tranne questo";

  @override
  String get terminateAllOtherSessions => "Terminare tutte le altre sessioni";

  @override
  String get closeAllSessionsConfirmation => "Volete terminare tutte le altre sessioni?";

  @override
  String get closeSessionConfirmation => "Vuoi terminare la sessione?";

  @override
  String get connectionLost => "Ops, sembra che non ci sia alcuna connessione";

  @override
  String get connectionEstablished => "Sei di nuovo online";

  @override
  String get connectionStatus => "Stato della connessione";

  @override
  String get anUserIsCalling => "Un utente ti sta chiamando...";

  @override
  String get answer => "Rispondi";

  @override
  String get hangDown => "Appendere giù";

  @override
  String get incomingCall => "Chiamata in arrivo";

  @override
  String isCallingYou(String user) => "$user ti sta chiamando...";

  @override
  String get callCouldNotBeInitialized => "La chiamata non può essere inizializzata";

  @override
  String get sentMessages => "Messaggi inviati";

  @override
  String sentMessagesCount(String count) => "$count di 10000";

  @override
  String get teamDataUsage => "Uso dei dati del team";

  @override
  String get usedStorage => "Deposito usato";

  @override
  String usedStorageText(String used) => used + "GB di 5GB";

  @override
  String get userDataUsage => "Uso dei dati dell'utente";

  @override
  String get audioEnabled => "Audio abilitato";

  @override
  String get meetingOptions => "Opzioni di riunione";

  @override
  String get videoEnabled => "Video abilitato";

  @override
  String get dontShowThisMessage => "Non mostrare più";

  @override
  String get showDialogEveryTime => "Mostra il dialogo ogni volta che inizia una riunione";

  @override
  String get micAndCameraRequiredAlert => "Sono necessari i permessi di accesso alla videocamera e al microfono, assicurati di aver concesso i permessi necessari. Vuoi andare alle impostazioni dei permessi?";

  @override
  String get connectWith => "Accedi con";

  @override
  String get or => "o";

  @override
  String get viewDetails => "Visualizza i dettagli";

  @override
  String zendeskTicketUpdated(String user, String status, String type, String title, String url) {
    String part1 = R.string.user;
    String part2 = "aggiornato il biglietto";
    String part3 = "di tipo";
    String part4 = "allo stato";
    String part5 = R.string.viewDetails;
    return "<p>$part1 '$user' $part2 '$title' $part3 '$type' $part4 '$status'. <span><a href='$url'>$part5</a></span></p>";
  }

  @override
  String get accept => "Accettare";

  @override
  String get busy => "Occupato";

  @override
  String get configuration => "Configurazione";

  @override
  String get downloads => "Scarica";

  @override
  String get editTeam => "Modifica squadra";

  @override
  String get general => "Generale";

  @override
  String get integrations => "Integrazioni";

  @override
  String get noRecents => "No Recenti";

  @override
  String get noRecommendations => "Nessuna raccomandazione";

  @override
  String get inAMeeting => "In una riunione";

  @override
  String get onFire => "In fiamme";

  @override
  String get plans => "Piani";

  @override
  String get setAStatus => "Impostare uno stato";

  @override
  String get sick => "Malato";

  @override
  String get signOut => "Firma fuori";

  @override
  String get suggestions => "Suggerimenti";

  @override
  String get teams => "Squadre";

  @override
  String get traveling => "Viaggiando";

  @override
  String get whatsYourStatus => "Qual è il tuo stato?";

  @override
  String get sendAlwaysAPush => "Invia sempre una notifica push";

  @override
  String get robot => "Robot";

  @override
  String get deactivateUserWarning => "I membri del team non saranno in grado di comunicare con un membro mentre è disattivato. Tuttavia, tutte le attività svolte dal membro disattivato in Noysi rimarranno intatte e i messaggi (canali aperti, messaggi 1 a 1 e gruppi privati), i file e i compiti saranno accessibili.";

  @override
  String get activateUserWarning => "Una volta che il membro è riattivato, recupererà l'accesso agli stessi canali, gruppi, file e attività che aveva prima di essere disattivato.";

  @override
  String get changeRole => "Cambiare ruolo";

  @override
  String get userStatus => "Stato dell'utente";

  @override
  String get deactivateMyAccount => "Disattivare il mio account";

  @override
  String get deactivateMyAccountWarning => "Se disattivi il tuo account, sarai disattivato in tutti i tuoi team, conversazioni, file, compiti e qualsiasi attività che hai gestito attraverso Noysi fino a quando un amministratore non ti riattiverà di nuovo.";

  @override
  String get deactivateMyUserInThisTeam => "Disattivare il mio utente in questa squadra";

  @override
  String get deactivateMyUserInThisTeamWarning => "Quando ti disattivi in una squadra, tutto ciò che possiedi in quella squadra rimarrà fino a quando non ti attiverai di nuovo. Se sei l'unico amministratore della squadra, la squadra non verrà cancellata.";

  @override
  String get operationConfirmation => "Sei sicuro di questa operazione?";

  @override
  String get formatNotSupported => "Questo formato o estensione non è supportato dal sistema operativo";

  @override
  String get invitePrivateGroupLink => "Invita un membro al gruppo usando questo link";

  @override
  String get invalidPhoneNumber => "Numero di telefono invalido";

  @override
  String get searchByCountryName => "Cerca per nome del paese o prefisso";

  @override
  String get kick => "Espellere";

  @override
  String get noEvents => "Nessun evento, attività o note personali";

  @override
  String get deleteAll => "Cancella tutto";

  @override
  String get enterKeyManually => "Immettere la chiave manualmente";

  @override
  String get noysiAuthenticator => "Noysi Autenticatore";

  @override
  String get qrScanner => "QR";

  @override
  String get otpLabelWarning => "L'etichetta OTP è una stringa alfanumerica senza spazi :@.,;()\$% sono anche ammessi";

  @override
  String get invalidBase32Chars => "Caratteri base32 non validi";

  @override
  String get label => "Etichetta";

  @override
  String get secretCode => "Chiave segreta";

  @override
  String get labelTextWarning => "L'etichetta è vuota, controlla questo valore";

  @override
  String missedCallFrom(String user) => "Chiamata persa da $user";

  @override
  String get activeItemBackgroundColor => "Sfondo dell'oggetto attivo";

  @override
  String get activeItemTextColor => "Testo dell'elemento attivo";

  @override
  String get activePresenceColor => "Presenza attiva";

  @override
  String get adminsCanDeleteMessage => "Gli amministratori possono eliminare i messaggi";

  @override
  String get allForAdminsOnly => "@all solo per amministratori";

  @override
  String get channelForAdminsOnly => "@channel solo per amministratori e creatori di canali";

  @override
  String get chooseTheme => "Scegli un tema per la tua squadra";

  @override
  String get enablePushAllChannels => "Abilita le notifiche push su tutti i canali";

  @override
  String get inactivePresenceColor => "Presenza inattiva";

  @override
  String get leaveTeam => "Lascia questa squadra";

  @override
  String get leaveTeamWarning => "Quando lasci una squadra, tutto ciò che possiedi in quella squadra verrà eliminato. Se sei l'unico amministratore del team, il team verrà eliminato.";

  @override
  String get notificationBadgeBackgroundColor => "Sfondo distintivo";

  @override
  String get notificationBadgeTextColor => "Testo distintivo";

  @override
  String get onlyAdminInvitesAllowed => "Ospiti autorizzati solo dagli amministratori";

  @override
  String get reset => "Ripristina";

  @override
  String get settings => "Impostazioni";

  @override
  String get sidebarColor => "Colore della barra laterale";

  @override
  String get taskUpdateProtected => "Modifica degli Incarichi riservati a Creatori e Amministratori";

  @override
  String get teamName => "Nome della squadra";

  @override
  String get textColor => "Colore del testo";

  @override
  String get theme => "Tema";

  @override
  String get updateUsernameBlocked => "Blocca il nome utente durante l'invio dell'invito";

  @override
  String get fileNotFound => "File non trovato";

  @override
  String get messageNotFound => "Messaggio non trovato, controlla se il messaggio che stai cercando è disponibile nel team attuale.";

  @override
  String get taskNotFound => "Attività non trovata";

  @override
  String userHasPinnedMessage(String name) => "$name ha aggiunto un messaggio al canale";

  @override
  String userHasUnpinnedMessage(String name) => "$name ha sbloccato il messaggio da questo canale";

  @override
  String get pinMessage => "Appuntare il messaggio";

  @override
  String get unpinMessage => "Sblocca messaggio";

  @override
  String get pinnedMessage => "Messaggio bloccato";

  @override
  String get deleteMyAccount => "Cancella il mio account";

  @override
  String get yourDeleteRequestIsInProcess => "La tua richiesta di cancellazione dell'account è in corso";

  @override
  String get deleteMyAccountWarning => "Se elimini il tuo account, l'azione sarà irreversibile. Se gestisci un team e non ci sono altri amministratori, il team verrà eliminato.";

  @override
  String get lifetimeDeal => "Offerte a vita";

  @override
  String get showEmails => "Mostra le email degli utenti";

  @override
  String get showPhoneNumbers => "Mostra i numeri di telefono degli utenti";

  @override
  String get addChannel => "Aggiungi canale";

  @override
  String get addPrivateGroup => "Aggiungi gruppo privato";

  @override
  String get selectUserFromTeam => "Seleziona l'utente da questo team";

  @override
  String get selectUsersFromChannelGroup => "Seleziona gli utenti dal canale o dal gruppo";

  @override
  String get memberDeleted => "Membro eliminato";
}
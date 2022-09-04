import 'dart:ui';
import 'package:code/_res/values/config.dart';
import 'package:code/_res/values/text/strings_base.dart';

import '../../../data/api/remote/endpoints.dart';
import '../../R.dart';


class StringsFr implements StringsBase {
  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Noysi";

  @override
  String get yourTeams => "Vos équipes";

  @override
  String get channel => "Canal";

  @override
  String get channels => "Chaînes";

  @override
  String get directMessagesAbr => "DM";

  @override
  String get email => "Email";

  @override
  String get home => "Accueil";

  @override
  String get member => "Membre";

  @override
  String get administrator => "Administrateur";

  @override
  String get guest => "Client";

  @override
  String get guests => "Invités";

  @override
  String get members => "Membres";

  @override
  String get inactiveMember => "Membre désactivé";

  @override
  String get message => "Message";

  @override
  String get messages => "messages";

  @override
  String get password => "Mot de passe";

  @override
  String get register => "S'inscrire";

  @override
  String get search => "Chercher";

  @override
  String get signIn => "se connecter";

  @override
  String get task => "Tâche";

  @override
  String get tasks => "Tâches";

  @override
  String get createTask => "Créer une tâche";

  @override
  String get newTask => "Nouvelle tâche";

  @override
  String get description => "La description";

  @override
  String get team => "Équipe";

  @override
  String get thread => "Fil";

  @override
  String get threads => "Fils";

  @override
  String get createTeam => "Créer une équipe";

  @override
  String get confirmIsCorrectEmailAddress => "Oui! C'est le bon email";

  @override
  String get createTeamIntro =>
      "Vous êtes sur le point de créer votre nouvelle équipe chez Noysi.";

  @override
  String get isCorrectEmailAddress => "Est-ce la bonne adresse e-mail?";

  @override
  String get welcome => "Bienvenue!";

  @override
  String get invitationSentAt => "Votre invitation sera envoyée à:";

  @override
  String get next => "Suivant";

  @override
  String get startNow => "Commencez maintenant!";

  @override
  String get charsRemaining => "Caractères restants:";

  @override
  String get teamNameOrgCompany =>
      "Saisissez le nom de votre équipe, votre organisation ou le nom de votre société.";

  @override
  String get teamNameOrgCompanyLabel => "Ex. Nom de mon entreprise";

  @override
  String get yourTeam => "Ton équipe";

  @override
  String get noysiServiceNewsletters =>
      "Vous pouvez recevoir (très occasionnellement) des courriels concernant le service NOYSI.";

  @override
  String get userNameIntro =>
      "Votre nom d'utilisateur est la façon dont vous apparaissez aux autres membres de votre équipe.";

  @override
  String get userNameLabel => "Ex. Ackerman";

  @override
  String get addAnother => "Ajouter un autre";

  @override
  String get byProceedingAcceptTerms =>
      "* En continuant, vous acceptez nos <b> Conditions d'utilisation </b>";

  @override
  String get invitations => "Invitations";

  @override
  String get invitePeople => "Inviter des gens";

  @override
  String get noysiIsTeamWorkInvite =>
      "Noysi est un outil de travail d'équipe. Invitez au moins une personne";

  @override
  String get userName => "Nom d'utilisateur";

  @override
  String get fieldMax18 => "18 caractères maximum";

  @override
  String get fieldMax25 => "25 caractères maximum";

  @override
  String get fieldPassword => "Mot de passe requis";

  @override
  String get fieldRequired => "Champ obligatoire";

  @override
  String get missingEmailFormat => "Mauvaise adresse mail";

  @override
  String get back => "Retour";

  @override
  String get channelBrowser => "Navigateur de chaînes";

  @override
  String get help => "Aidez-moi";

  @override
  String get preferences => "Préférences";

  @override
  String get signOutOf => "Déconnexion de";

  @override
  String get closed => "Fermé";

  @override
  String get closedMilestone => "Fermé";

  @override
  String get close => "proche";

  @override
  String get opened => "Ouvert";

  @override
  String get chat => "Bavarder";

  @override
  String get allThreads => "Toutes les discussions";

  @override
  String get inviteMorPeople => "Invitez plus de personnes";

  @override
  String get meeting => "Réunion";

  @override
  String get myFiles => "Mes dossiers";

  @override
  String get myTasks => "Mes tâches";

  @override
  String get myTeams => "Mes équipes";

  @override
  String get openChannels => "Canaux ouverts";

  @override
  String get privateGroups => "Groupes privés";

  @override
  String get favorites => "Favoris";

  @override
  String get message1x1 => "Messages 1 à 1";

  @override
  String get acceptedTitle => "Accepté";

  @override
  String get date => "Date";

  @override
  String get invitationLanguageTitle => "Langue idiomatique";

  @override
  String get invitationMessage => "Message d'invitation";

  @override
  String get revokeInvitation => "Révoquer l'invitation";

  @override
  String get revoke => "Révoquer";

  @override
  String get revokeInvitationWarning =>
      "Attention, cette action n'est pas réversible";

  @override
  String get revokeInvitationDelete => "Suppression de l'invitation";

  @override
  String get resendInvitationBefore24hrs =>
      "Le renvoi d'invitation n'est autorisé que 24 heures après le dernier envoi.";

  @override
  String get resendInvitationSuccess => "Les invitations ont bien été envoyées.";

  @override
  String get resendInvitation => "Renvoyer l'invitation";

  @override
  String get invitationMessageDefault =>
      "Salut! Ici vous avez une invitation à rejoindre";

  @override
  String get inviteManyAsOnce => "Invitez-en plusieurs une fois";

  @override
  String get inviteMemberTitle =>
      "Les membres de l'équipe ont un accès complet aux canaux ouverts, aux messages de personne à personne et aux groupes.";

  @override
  String get inviteMemberWarningTitle =>
      "Pour inviter de nouveaux membres, vous devez être l'administrateur de l'équipe.";

  @override
  String get inviteNewMemberWarningTitle =>
      "Tout membre de l'équipe peut ajouter des invités de manière illimitée.";

  @override
  String get inviteSubtitle =>
      "Noysi est un outil pour mieux travailler avec votre équipe. Invitez-les maintenant!";

  @override
  String get inviteTitle => "Invitez d'autres personnes";

  @override
  String get inviteToAGroup => "Inviter à un groupe (obligatoire)";

  @override
  String get inviteToAGroupNotRequired => "Inviter à un groupe (facultatif)";

  @override
  String get inviteMemberWarning =>
      "Les nouveaux membres rejoindront automatiquement la chaîne #general. En option, vous pouvez également les ajouter à un groupe privé maintenant.";

  @override
  String get inviteToThisTeam => "Inviter dans cette équipe";

  @override
  String get invitationsSent => "Invitations envoyées";

  @override
  String get name => "Nom";

  @override
  String get noPendingInvitations =>
      "Il n'y a aucune invitation à envoyer dans cette équipe.";

  @override
  String get pendingTitle => "En attente";

  @override
  String get chooseTitle => "Choisir";

  @override
  String get seePendingAcceptedInvitations =>
      "Voir les invitations en attente et acceptées";

  @override
  String get sendInvitations => "Envoyez des invitations";

  @override
  String get typeEmail => "Tapez un e-mail";

  @override
  String get typeEmailComaSeparated => "Tapez les e-mails par virgule séparés";

  @override
  String get atNoysi => "chez Noysi";

  @override
  String get inviteNewMemberTitle =>
      "Les invités ne paient pas et vous pouvez en inviter autant que vous le souhaitez, mais ils n'auront accès qu'à un seul groupe de cette équipe.";

  @override
  String get invited => "Invité";

  @override
  String get thisNameAlreadyExist =>
      "On dirait que ce nom est déjà utilisé.";

  @override
  String get emptyList => "Liste vide";

  @override
  String get ok => "D'accord";

  @override
  String get byNameFirst => "Par nom A-Z";

  @override
  String get byNameInvertedFirst => "Par nom Z-A";

  @override
  String get download => "Télécharger";

  @override
  String get files => "Des dossiers";

  @override
  String get folders => "Dossiers";

  @override
  String get newTitle => "Nouveau";

  @override
  String get newestFirst => "Le plus récent d'abord";

  @override
  String get oldestFirst => "Le plus ancien en premier";

  @override
  String get see => "Voir";

  @override
  String get share => "Partager";

  @override
  String get moreInfo => "Plus d'information";

  @override
  String get assigned => "Attribué";

  @override
  String get author => "Auteur";

  @override
  String get created => "Créé";

  @override
  String get earlyDeliverDate => "Date de livraison anticipée";

  @override
  String get farDeliverDate => "Date de livraison éloignée";

  @override
  String get filterAuthor => "Filtrer par auteur";

  @override
  String get searchUsers => "Rechercher des utilisateurs";

  @override
  String get sort => "Trier";

  @override
  String get sortBy => "Trier par";

  @override
  String get cancel => "Annuler";

  @override
  String get exit => "Sortie";

  @override
  String get exitWarning => "Êtes-vous sûr?";

  @override
  String get deleteChannelWarning =>
      "Voulez-vous vraiment quitter cette chaîne?";

  @override
  String get typeMessage => "Tapez un message ...";

  @override
  String get addChannelToFavorites => "Ajouter aux Favoris";

  @override
  String get removeFromFavorites => "Retirer des favoris";

  @override
  String get channelInfo => "Informations sur la chaîne";

  @override
  String get channelMembers => "Membres de la chaîne";

  @override
  String get channelPreferences => "Préférences de chaîne";

  @override
  String get closeChatVisibility => "Près de 1 à 1";

  @override
  String get inviteToGroup => "Inviter un membre sur cette chaîne";

  @override
  String get leaveChannel => "Quitter la chaîne";

  @override
  String get mentions => "Mentions";

  @override
  String get seeFiles => "Voir les fichiers";

  @override
  String get seeLinks => "Voir les liens";

  @override
  String get links => "Liens";

  @override
  String get taskManager => "Gestionnaire des tâches";

  @override
  String get videoCall => "Appel vidéo";

  @override
  String get addReaction => "Ajouter une réaction";

  @override
  String get addTag => "Ajouter une étiquette";

  @override
  String get addMilestone => "Ajouter un jalon";

  @override
  String get copyMessage => "Copier le message";

  @override
  String get copyPermanentLink => "Copier le lien";

  @override
  String get createThread => "Démarrer un fil";

  @override
  String get edit => "Éditer";

  @override
  String get favorite => "Favori";

  @override
  String get remove => "Retirer";

  @override
  String get tryAgain => "Réessayer";

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
      "Etes-vous sur de vouloir supprimer ce message? Ça ne peut pas être annulé.";

  @override
  String get deleteMessageTitle => "Supprimer le message";

  @override
  String get edited => "Édité";

  @override
  String get seeAll => "Voir tout";

  @override
  String get copiedToClipboard => "Copié dans le presse-papier!";

  @override
  String get underConstruction => "En construction";

  @override
  String get reactions => "Réactions";

  @override
  String get all => "Tout";

  @override
  String get users => "Utilisateurs";

  @override
  String get documents => "Des documents";

  @override
  String get fromLocalStorage => "À partir du stockage local";

  @override
  String get photoGallery => "galerie de photos";

  @override
  String get recordVideo => "Enregistrer une vidéo";

  @override
  String get takePhoto => "Prendre une photo";

  @override
  String get useCamera => "De la caméra";

  @override
  String get videoGallery => "Galerie vidéo";

  @override
  String get changeName => "Changer de nom";

  @override
  String get createFolder => "Créer le dossier";

  @override
  String get createNameWarning =>
      "Les noms doivent comporter au maximum 18 caractères, sans signes de ponctuation.";

  @override
  String get newName => "Nouveau nom";

  @override
  String get rename => "Renommer";

  @override
  String get renameFile => "Renommer le fichier";

  @override
  String get renameFolder => "Renommer le dossier";

  @override
  String get deleteFile => "Supprimer le fichier";

  @override
  String get deleteFolder => "Supprimer le dossier";

  @override
  String get deleteFileWarning => "Le dossier sera définitivement supprimé et ne pourra pas être récupéré. Le dossier sera inaccessible à partir de n'importe quel lien.";

  @override
  String get delete => "Supprimer";

  @override
  String get open => "Ouvert";

  @override
  String get addCommentOptional => "Ajouter un commentaire (facultatif)";

  @override
  String get shareFile => "Partagez le fichier";

  @override
  String get groups => "Groupes";

  @override
  String get to1_1 => "1 à 1";

  @override
  String get day => "journée";

  @override
  String get days => "Journées";

  @override
  String get hour => "heure";

  @override
  String get hours => "heures";

  @override
  String get minute => "minute";

  @override
  String get minutes => "minutes";

  @override
  String get month => "Mois";

  @override
  String get months => "Mois";

  @override
  String get year => "an";

  @override
  String get years => "années";

  @override
  String get by => "par";

  @override
  String get deliveryDateIn => "Date d'échéance en";

  @override
  String get ago => "Depuis";

  @override
  String get taskOpened => "Ouvert";

  @override
  String get assignees => "Cessionnaires";

  @override
  String get assigneeBy => "Assigné par";

  @override
  String get closeTask => "Fermer la tâche";

  @override
  String get comment => "Commentaire";

  @override
  String get deliveryDate => "Date d'échéance";

  @override
  String get leaveAComment => "laissez un commentaire";

  @override
  String get milestone => "Étape importante";

  @override
  String get milestones => "Jalons";

  @override
  String get color => "Couleur";

  @override
  String get milestoneAdded => "Ajouté au jalon";

  @override
  String get participants => "Les participants";

  @override
  String get reopen => "Rouvrir";

  @override
  String get completed => "Terminé";

  @override
  String get dueDateUpdated => "Date d'échéance mise à jour";

  @override
  String get dueDate => "Date d'échéance";

  @override
  String get lastDueDate => "Dernière date d'échéance";

  @override
  String get commented => "Commenté";

  @override
  String get tagAdded => "Tag ajouté";

  @override
  String get tagRemoved => "Tag supprimé";

  @override
  String get tags => "Mots clés";

  @override
  String get update => "Mise à jour";

  @override
  String get details => "Détails";

  @override
  String get timeline => "Chronologie";

  @override
  String get aboutMe => "À propos de moi";

  @override
  String get acceptNews => "Recevoir des nouvelles";

  @override
  String get allActive => "Tous actifs";

  @override
  String get changePhoto => "Changer la photo";

  @override
  String get changeYourPassword => "changez votre mot de passe";

  @override
  String get changeYourPasswordAdvice =>
      "Le mot de passe doit avoir au moins huit caractères dont un chiffre, une majuscule et une minuscule, vous pouvez utiliser des caractères spéciaux comme @ # \$% ^ & + = et dix caractères ou plus pour améliorer la sécurité de votre mot de passe";

  @override
  String get charge => "Charge";

  @override
  String get country => "Pays";

  @override
  String get disabled => "désactivé";

  @override
  String get emailNotification => "Notifications par email";

  @override
  String get language => "Langue";

  @override
  String get lastName => "Nom de famille";

  @override
  String get maxEveryHour => "Toutes les heures";

  @override
  String get maxHalfDay => "Toutes les 12 heures";

  @override
  String get messages1x1AndMentions => "Messages 1x1 et @mentions";

  @override
  String get myProfile => "Mon profil";

  @override
  String get never => "Jamais";

  @override
  String get newPassword => "Nouveau mot de passe";

  @override
  String get newsLetters => "Lettres de nouvelles";

  @override
  String get notReceiveNews => "Ne pas recevoir de nouvelles";

  @override
  String get notifications => "Notifications";

  @override
  String get passwordRequirements =>
      "Changez régulièrement votre mot de passe pour augmenter votre sécurité et votre protection";

  @override
  String get phoneNotifications => "Notifications téléphoniques";

  @override
  String get phoneNumber => "Numéro de téléphone";

  @override
  String get photoSizeRestrictions =>
      "Utilisez une photo carrée d'une largeur maximale de 400 pixels (petite)";

  @override
  String get repeatNewPassword => "Répété le nouveau mot de passe";

  @override
  String get security => "Sécurité";

  @override
  String get skypeUserName => "Utilisateur Skype";

  @override
  String get sounds => "Des sons";

  @override
  String get yourUserName => "Ton nom d'utilisateur";

  @override
  String get saveChanges => "Sauvegarder les modifications";

  @override
  String get profileEmailUsesWarning =>
      "Cet e-mail est utilisé uniquement pour les notifications de cette équipe.";

  @override
  String get pushMobileNotifications => "Notifications push mobiles";

  @override
  String get saveNotificationChanges => "Enregistrer les modifications de notification";

  @override
  String get updatePassword => "Mettre à jour le mot de passe";

  @override
  String get updateProfileInfo => "Mettre à jour les informations de profil";

  @override
  String get password8CharsRequirement =>
      "Le mot de passe doit comporter au moins 8 caractères.";

  @override
  String get passwordAtLeast1CapitalLetter =>
      "Le mot de passe doit contenir au moins 1 lettre majuscule.";

  @override
  String get passwordAtLeast1LowerCaseLetter =>
      "Le mot de passe doit contenir au moins 1 lettre minuscule.";

  @override
  String get passwordAtLeast1Number =>
      "Le mot de passe doit contenir au moins 1 chiffre.";

  @override
  String get passwordMustMatch => "Le mot de passe doit correspondre.";

  @override
  String get notificationUpdatedSuccess => "Modifications de notification mises à jour.";

  @override
  String get passwordUpdatedSuccess => "Mot de passe mis à jour.";

  @override
  String get profileUpdatedSuccess => "Profil mis à jour";

  @override
  String get enablePermissions => "Activer les autorisations";

  @override
  String get permissionDenied => "Permission refusée";

  @override
  String get savePreferences => "Enregistrer les préférences";

  @override
  String get turnOffChannelEmails => "Ne pas recevoir d'e-mails de chaîne";

  @override
  String get turnOffChannelSounds => "Désactiver les sons des canaux";

  @override
  String get chatMessageUnavailable =>
      "Les messages de chat ne sont pas disponibles avec pour cet utilisateur";

  @override
  String get createChannel => "Créer une chaîne";

  @override
  String get createNewChannel => "Créer une nouvelle chaîne";

  @override
  String get isTyping => "est en train d'écrire...";

  @override
  String get createPrivateGroup => "Créer un groupe privé";

  @override
  String get createPrivateGroupWarning =>
      "Vous allez créer un nouveau GROUPE, vous pouvez ajouter des personnes à ce groupe si elles font déjà partie de votre équipe, sinon, créez d'abord le groupe et invitez-les plus tard.";

  @override
  String get createNewPrivateGroup => "Créer un nouveau groupe privé";

  @override
  String get createNewChannelAction =>
      "Vous êtes sur le point de créer un nouveau canal ouvert.";

  @override
  String get createNewChannelForAdminsOnly => "Seuls les administrateurs ont accès à l'écriture.";

  @override
  String get openChannelAllMemberAccess => "Tous les membres de l'équipe ont un accès en lecture.";

  @override
  String get and => "Et";

  @override
  String get userIsInactiveToChat =>
      "Vous ne pouvez pas discuter avec cet utilisateur car il est inactif.";

  @override
  String get selectChannel => "Sélectionnez la chaîne";

  @override
  String get needToSelectChannel => "Vous devez sélectionner une chaîne";

  @override
  String get fileAlreadyShared =>
      "Ce fichier est déjà partagé avec le même nom dans le canal que vous avez sélectionné.";

  @override
  String get inChannel => "dans le canal";

  @override
  String seeAnswerMessages(int count) => "Voir $count  messages";

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
    return "Utilisateur $name  a rejoint la chaîne";
  }

  @override
  String userHasLeft(String name) {
    return "Utilisateur $name  a quitté la chaîne";
  }

  @override
  String invitedBy(String name) {
    return "Inviter par $name";
  }

  @override
  String get answers => "Réponses";

  @override
  String get publishIn => "publier dans";

  @override
  String get hasCommentedOnThread => "A commenté le fil:";

  @override
  String get unReadMessages => "Messages non lus";

  @override
  String get hasAddedTag => "A ajouté le tag";

  @override
  String get hasAssignedUser => "A attribué à l'utilisateur";

  @override
  String get hasClosedTask => "A fermé la tâche";

  @override
  String get hasCommentedTask => "A ajouté un commentaire";

  @override
  String get hasCreatedTask => "A créé la tâche";

  @override
  String get hasCreatedTaskAssignedTo => "A créé une nouvelle tâche affectée à";

  @override
  String get hasDeleteTag => "A supprimé la balise";

  @override
  String get hasDeletedCommentTask => "A supprimé un commentaire";

  @override
  String get hasEditedCommentTask => "A modifié un commentaire";

  @override
  String get hasEditedTask => "A modifié la tâche";

  @override
  String get hasRemovedEndDateTask => "A supprimé la date de fin de";

  @override
  String get hasReopenedTask => "A rouvert la tâche";

  @override
  String get hasSetMilestone => "A posé le jalon";

  @override
  String get hasUnAssignedUser => "A désattribué l'utilisateur";

  @override
  String get hasUpdatedDateTask => "A mis à jour la date de fin de";

  @override
  String get inTheTask => "Dans la tâche";

  @override
  String get to => "à";

  @override
  String get hasAssignedNewDueDateFor => "A attribué une nouvelle date d'échéance pour";

  @override
  String get createNewTag => "Créer une nouvelle balise";

  @override
  String get createNewMilestone => "Créer un nouveau jalon";

  @override
  String get editMilestone => "Modifier le jalon";

  @override
  String get editTag => "Modifier la balise";

  @override
  String get openTasks => "Tâches ouvertes";

  @override
  String get newPersonalNote => "Nouvelle note personnelle";

  @override
  String get createNewPersonalNote => "Créer une note personnelle";

  @override
  String get filterBy => "Filtrer par";

  @override
  String hereStartsYourMessagesWith(String name) =>
      "Ici commencez vos messages avec @$name";

  @override
  String thisChannelIsManagedBy(String name) =>
      "Cette chaîne est gérée par @$name, si besoin d'aide, contactez l'administrateur.";

  @override
  String newPush(String user, String repository, String repositoryUrl) {
    String part1 = "Nouvelle poussée de";
    String part2 = "dans le référentiel";
    String part3 = "Détail";

    return "<p>$part1  <span class = 'link-mention'> @$user</span> $part2  <span> <a href = '$repositoryUrl'>$repository. $part3</a> </span> </p>";
  }

  @override
  String unassignedTask(
    String repository,
    String repositoryUrl,
  ) {
    String part1 = "Tâche non attribuée dans le référentiel";
    String part2 = "Détail";
    return "<p>$part1  <a href = '$repositoryUrl'>$repository. $part2</a> </p>";
  }

  @override
  String cardTrelloCreate(
      String board, String boardUrl, String card, String cardUrl, String list) {
    String part1 = "Carte créée";
    String part2 = "dans la liste";
    String part3 = "de planche";
    return "<p>$part1  <a href = '$cardUrl'>$card</a> $part2   $list   $part3  <a href = '$boardUrl'>$board</a> </p>";
  }

  @override
  String cardTrelloRename(String board, String boardUrl, String oldName,
      String newName, String list) {
    String part1 = "Sur la liste";
    String part2 = "du tableau";
    String part3 = "la carte a été renommée";
    String part4 = "à";
    return "<p>$part1 '$list' $part2 <a href='$boardUrl'>$board</a> $part3 '$oldName' $part4 '$newName'</p>";
  }

  @override
  String cardTrelloDescriptionChange(String board, String boardUrl, String card,
      String cardUrl, String list, String description) {
    String part1 = "La carte";
    String part2 = "de la liste";
    String part3 = "du tableau";
    String part4 = "a changé sa description en";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4 '$description'</p>";
  }

  @override
  String cardTrelloMoveToOtherList(String board, String boardUrl, String card,
      String cardUrl, String oldList, String newList) {
    String part1 = "La carte";
    String part2 = "a été déplacé de la liste";
    String part3 = "à la liste";
    String part4= "sur le tableau";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$oldList' $part3 '$newList' $part4 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloArchive(String board, String boardUrl, String card,
      String cardUrl, String list) {
    String part1 = "La carte";
      String part2 = "de la liste";
    String part3 = "du tableau";
    String part4 = "a été archivé";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4</p>";
  }

  @override
  String get comments => "commentaires";

  @override
  String get addComment => "Ajouter un commentaire";

  @override
  String get editComment => "Modifier le commentaire";

  @override
  String get downloadAppsAndSynchronizer =>
      "<a href ='https://noysi.com/a/#/downloads'>TÉLÉCHARGEZ LES APPLICATIONS MAINTENANT!</a>";

  @override
  String get welcomeToNoysiFirstName => "Bienvenue! Ceci est votre chaîne personnelle, personne d'autre ne la verra, vous n'avez de communication avec personne, c'est votre chaîne personnelle pour que vous puissiez laisser des notes personnelles et télécharger des fichiers que personne d'autre ne verra. Comment tu t'appelles?";

  @override
  String get welcomeToNoysiTimeout =>
      "Vous ne m'avez pas répondu! Si vous avez besoin d'aide, cliquez sur <a href = '${Endpoint.helpUrl}'> ici. </a>";

  @override
  String get wrongUsernamePassword => "Mauvais nom d'utilisateur ou mot de passe";

  @override
  String get userInUse => "Cet utilisateur est déjà utilisé";

  @override
  String get invite => "Inviter";

  @override
  String get groupRequired => "Groupe requis";

  @override
  String get uploading => "Téléchargement";

  @override
  String get downloading => "Téléchargement";

  @override
  String get inviteGuestsWarning => "Les invités ne rejoignent qu'un seul groupe de cette équipe.";

  @override
  String get addMembers => "Ajouter des membres";

  @override
  String get enterEmailsByComma =>
      "Saisissez les e-mails en les séparant par des virgules:";

  @override
  String get firstName => "Prénom";

  @override
  String get inviteFewMorePersonal => "Invitez-en quelques-uns et soyez plus personnel";

  @override
  String get inviteManyAtOnce => "Invitez plusieurs à la fois";

  @override
  String get addGuests => "Ajouter des invités";

  @override
  String get followThread => "Suivez ce fil";

  @override
  String get markThreadAsRead => "Marquer comme lu";

  @override
  String get stopFollowingThread => "Arrêtez de suivre ce fil";

  @override
  String get needToVerifyAccountToInvite =>
      "Vous devez vérifier le compte de messagerie pour inviter des membres.";

  @override
  String get createANewTeam => "Créer une nouvelle équipe";

  @override
  String get createNewTeam => "Créez une nouvelle équipe!";

  @override
  String get enterIntoYourAccount => "Entrez dans votre compte";

  @override
  String get forgotPassword => "Mot de passe oublié?";

  @override
  String get goAhead => "Aller de l'avant!";

  @override
  String get passwordRestriction => "Le mot de passe doit comporter au moins huit caractères dont un chiffre, une lettre majuscule et une lettre minuscule, vous pouvez utiliser des caractères spéciaux comme @ # \$% ^ & + = et dix caractères ou plus pour améliorer la sécurité de votre mot de passe.";

  @override
  String get recoverYorPassword => "Récupérez votre mot de passe";

  @override
  String get recoverYorPasswordWarning => "Pour restaurer votre mot de passe, saisissez l'adresse e-mail que vous utilisez pour vous connecter à noysi.com";

  @override
  String recoverPasswordResponse(String email) {
    return "Nous vous avons envoyé un e-mail à $email";
  }

  @override
  String get recoverPasswordResponse1 =>
      "Vérifiez votre boîte de réception et suivez les instructions pour créer votre nouveau mot de passe";

  @override
  String get continueStr => "Continuer";

  @override
  String get passwordAtLeast1SpecialChar => throw "Le mot de passe doit avoir au moins 1 caractère spécial @#\$%^&+=";

  @override
  String welcomeToNoysiLastName(String name) => "Bonjour $name. Quel est ton nom de famille?";

  @override
  String get welcomeToNoysiDescription => "Très bien. Tout est bon. Je vais procéder à la mise à jour de votre profil.";

  @override
  String get welcomeToNoysiInvite => "<a href = '#'>Invitez les membres de votre équipe maintenant!</a>";

  @override
  String get activeFilter => "Filtre actif";

  @override
  String get newFileComment => "Nouveau commentaire dans le fichier";

  @override
  String get removed => "Enlevé";

  @override
  String get sharedOn => "Partagé sur";

  @override
  String get notifyAllInThisChannel => "avertir tout le monde sur cette chaîne";

  @override
  String get notifyAllMembers => "informer tous les membres";

  @override
  String get keepPressingToRecord => "Veuillez continuer à appuyer sur le bouton pour enregistrer";

  @override
  String get slideToCancel => "Faites glisser pour annuler";

  @override
  String get chooseASecurePasswordText => "Choisissez un mot de passe sécurisé dont vous vous souvenez";

  @override
  String get confirmPassword => "Répéter le mot de passe";

  @override
  String get yourPassword => "Mot de passe";

  @override
  String get passwordDontMatch => "Les mots de passe ne correspondent pas";

  @override
  String get changeCreateTeamMail => "Non, je souhaite modifier l'e-mail";

  @override
  String step(int number) => "Étape $number";

  @override
  String get user => "Utilisateur";

  @override
  String get deleteFolderWarning => "Le dossier sera définitivement supprimé et ne pourra pas être récupéré";

  @override
  String get calendar => "Calendrier";

  @override
  String get week => "Semaine";

  @override
  String get folderIsNotInCurrentTeam => "Le dossier n'est pas associé à l'équipe actuelle";

  @override
  String get folderIsNotInAvailableChannel => "Le dossier référencé n'est pas dans un canal disponible dans l'explorateur de fichiers";

  @override
  String get folderLinked => "Lien de dossier copié sur la chaîne";

  @override
  String get folderShared => "Le dossier a été partagé sur la chaîne";

  @override
  String get folderUploaded => "Le dossier a été téléchargé sur la chaîne";

  @override
  String get folderNotFound => "Dossier introuvable";

  @override
  String get folderNameIncorrect => "Le nom du dossier n'est pas valide";

  @override
  String get cloneFolder => "Dossier de clonage";

  @override
  String get cloneFolderInfo => "Le clonage d'un dossier crée un nouveau dossier dans le canal de destination avec le même statut et le même contenu que le dossier sélectionné à ce stade.";

  @override
  String get folderDeleted => "Impossible d'accéder à un dossier supprimé";

  @override
  String get youWereInADeletedFolder => "Le dossier dans lequel il se trouvait a été supprimé";

  @override
  String get dateFormat6 => "MM/dd/yyyy";

  @override
  String get createdTask => "Tâche créée";

  @override
  String get loggedIn => "Session initiée";

  @override
  String get mention => "Mention";

  @override
  String get messageSent => "Message envoyé";

  @override
  String get taskAssigned => "Tâche assignée";

  @override
  String get taskUnassigned => "Tâche non attribuée";

  @override
  String get uploadedFile => "Fichier téléchargé";

  @override
  String get uploadedFileFolder => "Fichier / dossier téléchargé ";

  @override
  String get uploadedFolder => "Dossier téléchargé";

  @override
  String get downloadedFile => "Fichier téléchargé";

  @override
  String get downloadedFileFolder => "Fichier/dossier téléchargé";

  @override
  String get downloadedFolder => "Dossier téléchargé";

  @override
  String get messageUnavailable => "Message non disponible";

  @override
  String get activityZone => "Zone d'activité";

  @override
  String get categories => "Catégories";

  @override
  String get category => "Catégorie";

  @override
  String get clearAll => "Tout effacer";

  @override
  String get errorFetchingData => "Erreur lors de l'obtention des données";

  @override
  String get filters => "Filtres";

  @override
  String get openSessions => "Sessions ouvertes";

  @override
  String activityFileFolderUploadedDownloaded(String user, String name, String channel, {bool download = false, bool isDirect = false, isFolder = false}) {
    String part1 = "Vous avez ${download ? " téléchargé" : "téléversé"}${isFolder ? " le tapis " : " l'archive "}";
    String part2 = download ? "de la chaîne" : "Dans le canal";
    return "$part1 <i class=\"mention-generic\">$name</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMentioned(String user, String channel, {bool isDirect = false}) {
    String part1 = "Vous avez été mentionné sur la chaîne";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMessageSent(String user, String channel, {bool isDirect = false}) {
    String part1 = "Vous avez envoyé un message sur la chaîne";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activitySignedIn(String sessionInfo, String ip) {
    return "Vous êtes connecté <i class=\"mention-generic\">$sessionInfo</i> IP: <i class=\"mention-generic\">$ip</i>";
  }

  @override
  String activityTaskAssigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Vous avez été affecté à la tâche";
    String part2 = "Dans le canal";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskCreated(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Vous avez créé la tâche";
    String part2 = "Dans le canal";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskUnassigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Vous avez été désalloué de la tâche";
    String part2 = "Dans le canal";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String get activityZoneHeader => "C'est ici que commence la zone d'activité";

  @override
  String get selectEvent => "Sélectionnez un événement";

  @override
  String get googleCalendar => "Google";

  @override
  String get outlookCalendar => "Outlook";

  @override
  String get noysiCalendar => "Noysi";

  @override
  String get autogenerateRoomNameQuestion => "Voulez-vous générer le nom de la salle automatiquement?";

  @override
  String get createMeetingEvent => "Créer une réunion événementielle";

  @override
  String get externalGuests => "Invités externes";

  @override
  String get internalGuests => "Invités internes";

  @override
  String get newMeetingEvent => "Nouvel événement-réunion";

  @override
  String get roomName => "Nom de la salle";

  @override
  String get eventMeeting => "Réunion-événement";

  @override
  String get personalNote => "Note personnelle";

  @override
  String get updateExternalGuests => "Mettre à jour les invités externes";

  @override
  String get nameTextWarning => "Le texte correspond à une chaîne alphanumérique de 1 à 25 caractères. Vous pouvez également utiliser des espaces et les caractères _ -";

  @override
  String get nameTextWarningWithoutSpaces => "Le texte correspond à une chaîne alphanumérique de 1 à 18 caractères sans espaces. Vous pouvez également utiliser les caractères _ -";

  @override
  String get today => "Aujourd'hui";

  @override
  String get location => "Endroit";


  @override
  String get sessions => "Séances";

  @override
  String get appVersion => "Version de l'application";

  @override
  String get browser => "Le navigateur";

  @override
  String get device => "Appareil";

  @override
  String get logout => "Fermer la session";

  @override
  String get manufacturer => "Fabricant";

  @override
  String get no => "Pas";

  @override
  String get operativeSystem => "Système opératif";

  @override
  String get yes => "Oui";

  @override
  String get allDay => "Toute la journée";

  @override
  String get endDate => "Date de fin";

  @override
  String get noTitle => "Pas de titre";

  @override
  String get currentSession => "Session actuelle";

  @override
  String get logOutAllExceptForThisOne => "Déconnectez-vous de tous les appareils sauf celui-ci";

  @override
  String get terminateAllOtherSessions => "Mettre fin à toutes les autres sessions";

  @override
  String get closeAllSessionsConfirmation => "Voulez-vous mettre fin à toutes les autres sessions ?";

  @override
  String get closeSessionConfirmation => "Voulez-vous mettre fin à la session ?";

  @override
  String get connectionLost => "Oups, il semble qu'il n'y ait aucun lien";

  @override
  String get connectionEstablished => "Vous êtes de retour en ligne";

  @override
  String get connectionStatus => "Statut de connexion";

  @override
  String get anUserIsCalling => "Un utilisateur vous appelle...";

  @override
  String get answer => "Répondre";

  @override
  String get hangDown => "Raccrocher";

  @override
  String get incomingCall => "Appel entrant";

  @override
  String isCallingYou(String user) => "$user vous appelle...";

  @override
  String get callCouldNotBeInitialized => "L'appel n'a pas pu être initialisé";

  @override
  String get sentMessages => "Messages envoyés";

  @override
  String sentMessagesCount(String count) => "$count de 10000";

  @override
  String get teamDataUsage => "Utilisation des données d'équipe";

  @override
  String get usedStorage => "Stockage utilisé";

  @override
  String usedStorageText(String used) => used + "GB de 5GB";

  @override
  String get userDataUsage => "Utilisation des données utilisateur";

  @override
  String get audioEnabled => "Audio activé";

  @override
  String get meetingOptions => "Options de réunion";

  @override
  String get videoEnabled => "Vidéo activée";

  @override
  String get dontShowThisMessage => "Ne plus afficher";

  @override
  String get showDialogEveryTime => "Afficher la boîte de dialogue à chaque démarrage d'une réunion";

  @override
  String get micAndCameraRequiredAlert => "Les autorisations d'accès à la caméra et au microphone sont requises, veuillez vous assurer que vous avez accordé les autorisations nécessaires. Voulez-vous accéder aux paramètres d'autorisation ?";

  @override
  String get connectWith => "Se connecter avec";

  @override
  String get or => "ou";

  @override
  String get noEvents => "Pas d'événements, de tâches ou de notes personnelles";

  @override
  String get viewDetails => "Voir les détails";

  @override
  String zendeskTicketUpdated(String user, String status, String type, String title, String url) {
    String part1 = R.string.user;
    String part2 = "mise à jour du ticket";
    String part3 = "de type";
    String part4 = "au statut";
    String part5 = R.string.viewDetails;
    return "<p>$part1 '$user' $part2 '$title' $part3 '$type' $part4 '$status'. <span><a href='$url'>$part5</a></span></p>";
  }


  @override
  String get accept => "Accepter";

  @override
  String get busy => "Occupé";

  @override
  String get configuration => "Configuration";

  @override
  String get downloads => "Téléchargements";

  @override
  String get editTeam => "Equipe de rédaction";

  @override
  String get general => "Général";

  @override
  String get integrations => "Intégrations";

  @override
  String get noRecents => "Pas de récents";

  @override
  String get noRecommendations => "Aucune recommandation";

  @override
  String get inAMeeting => "Dans une réunion";

  @override
  String get onFire => "On Fire";

  @override
  String get plans => "Plans";

  @override
  String get setAStatus => "Définir un statut";

  @override
  String get sick => "Malade";

  @override
  String get signOut => "Se déconnecter";

  @override
  String get suggestions => "Suggestions";

  @override
  String get teams => "Équipes";

  @override
  String get traveling => "En voyageant";

  @override
  String get whatsYourStatus => "Quel est votre statut ?";

  @override
  String get sendAlwaysAPush => "Envoyez toujours une notification push";

  @override
  String get robot => "Robot";

  @override
  String get deactivateUserWarning => "Les membres de l'équipe ne pourront pas communiquer avec un membre lorsqu'il est désactivé. Cependant, toutes les activités effectuées par le membre désactivé dans Noysi resteront intactes et les messages (canaux ouverts, messages 1 à 1 et groupes privés), les fichiers et les tâches seront accessibles.";

  @override
  String get activateUserWarning => "Une fois le membre réactivé, il récupérera l'accès aux mêmes canaux, groupes, fichiers et tâches qu'il avait avant d'être désactivé.";

  @override
  String get changeRole => "Changer de rôle";

  @override
  String get userStatus => "Statut de l'utilisateur";

  @override
  String get deactivateMyAccount => "Désactivez mon compte";

  @override
  String get deactivateMyAccountWarning => "Si vous désactivez votre compte, vous serez désactivé dans toutes vos équipes, conversations, fichiers, tâches et toutes les activités que vous avez gérées via Noysi jusqu'à ce qu'un administrateur vous réactive à nouveau.";

  @override
  String get deactivateMyUserInThisTeam => "Désactiver mon utilisateur dans cette équipe";

  @override
  String get deactivateMyUserInThisTeamWarning => "Lorsque vous vous désactivez dans une équipe, tout ce que vous possédez dans cette équipe restera jusqu'à ce que vous soyez à nouveau activé. Si vous êtes le seul administrateur de l'équipe, l'équipe ne sera pas supprimée.";

  @override
  String get operationConfirmation => "Êtes-vous sûr de cette opération ?";

  @override
  String get formatNotSupported => "Ce format ou cette extension n'est pas pris en charge par le système d'exploitation";

  @override
  String get invitePrivateGroupLink => "Invitez un membre au groupe en utilisant ce lien";

  @override
  String get invalidPhoneNumber => "Numéro de téléphone invalide";

  @override
  String get searchByCountryName => "Rechercher par nom de pays ou code de numérotation";

  @override
  String get kick => "Expulser";

  @override
  String get deleteAll => "Supprimer tout";

  @override
  String get enterKeyManually => "Entrez la clé manuellement";

  @override
  String get noysiAuthenticator => "Noysi Authentificateur";

  @override
  String get qrScanner => "QR";

  @override
  String get otpLabelWarning => "Le label OTP est une chaîne alphanumérique sans espace :@.,;()\$% sont également autorisés";

  @override
  String get invalidBase32Chars => "Caractères base32 non valides";

  @override
  String get label => "Étiquette";

  @override
  String get secretCode => "Clé secrète";

  @override
  String get labelTextWarning => "L'étiquette est vide, veuillez vérifier cette valeur";

  @override
  String missedCallFrom(String user) => "Appel manqué de $user";

  @override
  String get activeItemBackgroundColor => "Arrière-plan de l'élément actif";

  @override
  String get activeItemTextColor => "Texte de l'élément actif";

  @override
  String get activePresenceColor => "Présence active";

  @override
  String get adminsCanDeleteMessage => "Les administrateurs peuvent supprimer des messages";

  @override
  String get allForAdminsOnly => "@all pour les administrateurs uniquement";

  @override
  String get channelForAdminsOnly => "@channel uniquement pour les administrateurs et les créateurs de chaînes";

  @override
  String get chooseTheme => "Choisissez un thème pour votre équipe";

  @override
  String get enablePushAllChannels => "Activer les notifications push sur tous les canaux";

  @override
  String get inactivePresenceColor => "Présence inactive";

  @override
  String get leaveTeam => "Quitter cette équipe";

  @override
  String get leaveTeamWarning => "Lorsque vous quittez une équipe, tout ce que vous possédez dans cette équipe sera supprimé. Si vous êtes le seul administrateur de l'équipe, l'équipe sera supprimée.";

  @override
  String get notificationBadgeBackgroundColor => "Fond d'insigne";

  @override
  String get notificationBadgeTextColor => "Texte du badge";

  @override
  String get onlyAdminInvitesAllowed => "Invités uniquement autorisés par les administrateurs";

  @override
    String get reset => "Réinitialiser";

  @override
  String get settings => "Réglages";

  @override
  String get sidebarColor => "Couleur de la barre latérale";

  @override
  String get taskUpdateProtected => "Modification des Tâches réservées aux Créateurs et Administrateurs";

  @override
  String get teamName => "Nom de l'équipe";

  @override
  String get textColor => "Couleur du texte";

  @override
  String get theme => "Thème";

  @override
  String get updateUsernameBlocked => "Bloquer le nom d'utilisateur lors de l'envoi d'une invitation";

  @override
  String get fileNotFound => "Fichier introuvable";

  @override
  String get messageNotFound => "Message introuvable, veuillez vérifier si le message que vous recherchez est disponible dans l'équipe actuelle.";

  @override
  String get taskNotFound => "Tâche introuvable";

  @override
  String userHasPinnedMessage(String name) => "$name a épinglé un message sur la chaîne";

  @override
  String userHasUnpinnedMessage(String name) => "$name a retiré le message de cette chaîne";

  @override
  String get pinMessage => "Épingler le message";

  @override
  String get unpinMessage => "Détacher le message";

  @override
  String get pinnedMessage => "Message épinglé";

  @override
  String get deleteMyAccount => "Supprimer mon compte";

  @override
  String get yourDeleteRequestIsInProcess => "Votre demande de suppression de compte est en cours";

  @override
  String get deleteMyAccountWarning => "Si vous supprimez votre compte, l'action sera irréversible. Si vous gérez une équipe et qu'il n'y a pas d'autre administrateur, l'équipe sera supprimée.";

  @override
  String get lifetimeDeal => "Offres à vie";

  @override
  String get showEmails => "Afficher les e-mails des utilisateurs";

  @override
  String get showPhoneNumbers => "Afficher les numéros de téléphone des utilisateurs";

  @override
  String get addChannel => "Ajouter une chaîne";

  @override
  String get addPrivateGroup => "Ajouter un groupe privé";

  @override
  String get selectUserFromTeam => "Sélectionnez l'utilisateur de cette équipe";

  @override
  String get selectUsersFromChannelGroup => "Sélectionner les utilisateurs du canal ou du groupe";

  @override
  String get memberDeleted => "Membre supprimé";
}


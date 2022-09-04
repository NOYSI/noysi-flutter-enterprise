import 'dart:ui';
import 'package:code/_res/values/config.dart';
import 'package:code/_res/values/text/strings_base.dart';

import '../../../data/api/remote/endpoints.dart';
import '../../R.dart';


class StringsGl implements StringsBase {
  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Noysi";

  @override
  String get yourTeams => "Os teus equipos";

  @override
  String get channel => "Canle";

  @override
  String get channels => "Canles";

  @override
  String get directMessagesAbr => "DM";

  @override
  String get email => "Correo electrónico";

  @override
  String get home => "Casa";

  @override
  String get member => "Membro";

  @override
  String get administrator => "Administrador";

  @override
  String get guest => "Convidado";

  @override
  String get guests => "Convidados";

  @override
  String get members => "Membros";

  @override
  String get inactiveMember => "Membro desactivado";

  @override
  String get message => "Mensaxe";

  @override
  String get messages => "Mensaxes";

  @override
  String get password => "Contrasinal";

  @override
  String get register => "Rexistrarse";

  @override
  String get search => "Buscar";

  @override
  String get signIn => "Rexístrate";

  @override
  String get task => "Tarefa";

  @override
  String get tasks => "Tarefas";

  @override
  String get createTask => "Crear tarefa";

  @override
  String get newTask => "Nova tarefa";

  @override
  String get description => "Descrición";

  @override
  String get team => "Equipo";

  @override
  String get thread => "Fío";

  @override
  String get threads => "Fíos";

  @override
  String get createTeam => "Crear equipo";

  @override
  String get confirmIsCorrectEmailAddress => "¡Si! Ese é o correo electrónico correcto";

  @override
  String get createTeamIntro =>
      "Estás a piques de configurar o teu novo equipo en Noysi.";

  @override
  String get isCorrectEmailAddress => "Este é o enderezo de correo electrónico correcto?";

  @override
  String get welcome => "Benvido!";

  @override
  String get invitationSentAt => "A súa invitación enviarase a:";

  @override
  String get next => "A continuación";

  @override
  String get startNow => "Comeza agora.";

  @override
  String get charsRemaining => "Personaxes restantes:";

  @override
  String get teamNameOrgCompany =>
      "Introduce o nome do teu equipo, organización ou nome da empresa.";

  @override
  String get teamNameOrgCompanyLabel => "Ex. Nome da miña empresa";

  @override
  String get yourTeam => "O teu equipo";

  @override
  String get noysiServiceNewsletters =>
      "Está ben recibir correos electrónicos (moi ocasionalmente) sobre o servizo NOYSI.";

  @override
  String get userNameIntro =>
      "O teu nome de usuario é como apareces aos demais no teu equipo.";

  @override
  String get userNameLabel => "Ex. ackerman";

  @override
  String get addAnother => "Engade outro";

  @override
  String get byProceedingAcceptTerms =>
      "* Ao continuar aceptas os nosos <b> Termos de servizos </b>";

  @override
  String get invitations => "Invitacións";

  @override
  String get invitePeople => "Invita á xente";

  @override
  String get noysiIsTeamWorkInvite =>
      "Noysi é unha ferramenta de traballo en equipo. Invita polo menos a unha persoa";

  @override
  String get userName => "Nome de usuario";

  @override
  String get fieldMax18 => "18 caracteres como máximo";

  @override
  String get fieldMax25 => "25 caracteres como máximo";

  @override
  String get fieldPassword => "Contrasinal obrigatorio";

  @override
  String get fieldRequired => "Campo obrigatorio";

  @override
  String get missingEmailFormat => "Correo electrónico incorrecto";

  @override
  String get back => "De volta";

  @override
  String get channelBrowser => "Explorador de canles";

  @override
  String get help => "Axuda";

  @override
  String get preferences => "Preferencias";

  @override
  String get signOutOf => "Pecha sesión";

  @override
  String get closed => "Pechado";

  @override
  String get closedMilestone => "Pechado";

  @override
  String get close => "Pechar";

  @override
  String get opened => "Aberto";

  @override
  String get chat => "Chatear";

  @override
  String get allThreads => "Todos os fíos";

  @override
  String get inviteMorPeople => "Invita a máis xente";

  @override
  String get meeting => "Reunión";

  @override
  String get myFiles => "Os meus ficheiros";

  @override
  String get myTasks => "As miñas tarefas";

  @override
  String get myTeams => "Os meus equipos";

  @override
  String get openChannels => "Abre canles";

  @override
  String get privateGroups => "Grupos privados";

  @override
  String get favorites => "Favoritos";

  @override
  String get message1x1 => "Mensaxes 1 a 1";

  @override
  String get acceptedTitle => "Aceptado";

  @override
  String get date => "Data";

  @override
  String get invitationLanguageTitle => "Linguaxe idiomática";

  @override
  String get invitationMessage => "Mensaxe de invitación";

  @override
  String get revokeInvitation => "Revogar invitación";

  @override
  String get revoke => "Revogar";

  @override
  String get revokeInvitationWarning =>
      "Ten coidado, esta acción non é reversible";

  @override
  String get revokeInvitationDelete => "Eliminación de invitación";

  @override
  String get resendInvitationBefore24hrs =>
      "Non se permite reenvialo ata 24 horas desde o último envío.";

  @override
  String get resendInvitationSuccess => "Invitacións enviadas con éxito.";

  @override
  String get resendInvitation => "Volve enviar a invitación";

  @override
  String get invitationMessageDefault =>
      "Ola! Aquí tes unha invitación para unirte";

  @override
  String get inviteManyAsOnce => "Invita a moitos coma unha vez";

  @override
  String get inviteMemberTitle =>
      "Os membros do equipo teñen acceso completo a canles abertos, mensaxes de persoa a persoa e grupos.";

  @override
  String get inviteMemberWarningTitle =>
      "Para invitar novos membros debe ser o administrador do equipo.";

  @override
  String get inviteNewMemberWarningTitle =>
      "Calquera membro do equipo pode engadir invitados de xeito ilimitado.";

  @override
  String get inviteSubtitle =>
      "Noysi é unha ferramenta para traballar mellor co teu equipo. Invítaos agora!";

  @override
  String get inviteTitle => "Invita a outras persoas";

  @override
  String get inviteToAGroup => "Invitar a un grupo (obrigatorio)";

  @override
  String get inviteToAGroupNotRequired => "Invitar a un grupo (opcional)";

  @override
  String get inviteMemberWarning =>
      "Os novos membros uniranse á canle # xeral automaticamente. Opcionalmente, tamén podes engadilos a un grupo privado agora.";

  @override
  String get inviteToThisTeam => "Invita a este equipo";

  @override
  String get invitationsSent => "Invitacións enviadas";

  @override
  String get name => "Nome";

  @override
  String get noPendingInvitations =>
      "Non hai invitacións para enviar neste equipo.";

  @override
  String get pendingTitle => "Pendente";

  @override
  String get chooseTitle => "Escolla";

  @override
  String get seePendingAcceptedInvitations =>
      "Ver invitacións pendentes e aceptadas";

  @override
  String get sendInvitations => "Enviar invitacións";

  @override
  String get typeEmail => "Escribe un correo electrónico";

  @override
  String get typeEmailComaSeparated => "Escribe os correos electrónicos separados por coma";

  @override
  String get atNoysi => "en Noysi";

  @override
  String get inviteNewMemberTitle =>
      "Os hóspedes non pagan e podes invitar cantos queiras, pero só terán acceso a un grupo dentro deste equipo.";

  @override
  String get invited => "Invitado";

  @override
  String get thisNameAlreadyExist =>
      "Parece que este nome xa está en uso.";

  @override
  String get emptyList => "Lista baleira";

  @override
  String get ok => "Ok";

  @override
  String get byNameFirst => "Polo nome A-Z";

  @override
  String get byNameInvertedFirst => "Polo nome Z-A";

  @override
  String get download => "Descargar";

  @override
  String get files => "Arquivos";

  @override
  String get folders => "Cartafoles";

  @override
  String get newTitle => "Novidade";

  @override
  String get newestFirst => "O máis novo primeiro";

  @override
  String get oldestFirst => "O máis antigo primeiro";

  @override
  String get see => "Ver";

  @override
  String get share => "Compartir";

  @override
  String get moreInfo => "Máis información";

  @override
  String get assigned => "Asignado";

  @override
  String get author => "Autor";

  @override
  String get created => "Creado";

  @override
  String get earlyDeliverDate => "Data de entrega anticipada";

  @override
  String get farDeliverDate => "Data de entrega remota";

  @override
  String get filterAuthor => "Filtrar por autor";

  @override
  String get searchUsers => "Buscar usuarios";

  @override
  String get sort => "Ordenar";

  @override
  String get sortBy => "Ordenar por";

  @override
  String get cancel => "Cancelar";

  @override
  String get exit => "Saír";

  @override
  String get exitWarning => "Estás seguro?";

  @override
  String get deleteChannelWarning =>
      "Seguro que queres deixar esta canle?";

  @override
  String get typeMessage => "Escribe unha mensaxe ...";

  @override
  String get addChannelToFavorites => "Engadir aos favoritos";

  @override
  String get removeFromFavorites => "Eliminar dos favoritos";

  @override
  String get channelInfo => "Información da canle";

  @override
  String get channelMembers => "Membros da canle";

  @override
  String get channelPreferences => "Preferencias de canle";

  @override
  String get closeChatVisibility => "Pecha o 1 ao 1";

  @override
  String get inviteToGroup => "Invita a membros a esta canle";

  @override
  String get leaveChannel => "Saír da canle";

  @override
  String get mentions => "Mencións";

  @override
  String get seeFiles => "Ver ficheiros";

  @override
  String get seeLinks => "Ver ligazóns";

  @override
  String get links => "Ligazóns";

  @override
  String get taskManager => "Xestor de tarefas";

  @override
  String get videoCall => "Videochamada";

  @override
  String get addReaction => "Engade reacción";

  @override
  String get addTag => "Engadir etiqueta";

  @override
  String get addMilestone => "Engade un fito";

  @override
  String get copyMessage => "Copiar mensaxe";

  @override
  String get copyPermanentLink => "Copiar ligazón";

  @override
  String get createThread => "Inicia un fío";

  @override
  String get edit => "Editar";

  @override
  String get favorite => "Favorito";

  @override
  String get remove => "Quitar";

  @override
  String get tryAgain => "Téntao de novo";

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
      "Seguro que queres eliminar esta mensaxe? Isto non se pode desfacer.";

  @override
  String get deleteMessageTitle => "Eliminar mensaxe";

  @override
  String get edited => "Editado";

  @override
  String get seeAll => "Ver todo";

  @override
  String get copiedToClipboard => "Copiouse ao portapapeis.";

  @override
  String get underConstruction => "En construcción";

  @override
  String get reactions => "Reaccións";

  @override
  String get all => "Todos";

  @override
  String get users => "Usuarios";

  @override
  String get documents => "Documentos";

  @override
  String get fromLocalStorage => "Do almacenamento local";

  @override
  String get photoGallery => "Galería de fotos";

  @override
  String get recordVideo => "Grava un vídeo";

  @override
  String get takePhoto => "Sacar unha foto";

  @override
  String get useCamera => "Da cámara";

  @override
  String get videoGallery => "Galería de vídeos";

  @override
  String get changeName => "Cambiar nome";

  @override
  String get createFolder => "Crear cartafol";

  @override
  String get createNameWarning =>
      "Os nomes deben ter un máximo de 18 caracteres, sen signos de puntuación.";

  @override
  String get newName => "Novo nome";

  @override
  String get rename => "Cambiar o nome";

  @override
  String get renameFile => "Cambiar o nome do ficheiro";

  @override
  String get renameFolder => "Cambiar o nome do cartafol";

  @override
  String get deleteFile => "Eliminar ficheiro";

  @override
  String get deleteFolder => "Eliminar cartafol";

  @override
  String get deleteFileWarning => "O cartafol eliminarase permanentemente e non se poderá recuperar. O cartafol será inaccesible desde calquera ligazón.";

  @override
  String get delete => "Eliminar";

  @override
  String get open => "Aberto";

  @override
  String get addCommentOptional => "Engadir comentario (opcional)";

  @override
  String get shareFile => "Compartir ficheiro";

  @override
  String get groups => "Grupos";

  @override
  String get to1_1 => "1 a 1";

  @override
  String get day => "día";

  @override
  String get days => "Días";

  @override
  String get hour => "hora";

  @override
  String get hours => "horas";

  @override
  String get minute => "minuto";

  @override
  String get minutes => "minutos";

  @override
  String get month => "Mes";

  @override
  String get months => "Meses";

  @override
  String get year => "ano";

  @override
  String get years => "anos";

  @override
  String get by => "por";

  @override
  String get deliveryDateIn => "Data de vencemento en";

  @override
  String get ago => "Hai moito";

  @override
  String get taskOpened => "Aberto";

  @override
  String get assignees => "Destinatarios";

  @override
  String get assigneeBy => "Asignado por";

  @override
  String get closeTask => "Pechar tarefa";

  @override
  String get comment => "Comentario";

  @override
  String get deliveryDate => "Data de caducidade";

  @override
  String get leaveAComment => "Deixe un comentario";

  @override
  String get milestone => "Fito";

  @override
  String get milestones => "Fitos";

  @override
  String get color => "Cor";

  @override
  String get milestoneAdded => "Engadido ao fito";

  @override
  String get participants => "Participantes";

  @override
  String get reopen => "Volve abrir";

  @override
  String get completed => "Completado";

  @override
  String get dueDateUpdated => "Data de vencemento actualizada";

  @override
  String get dueDate => "Data de caducidade";

  @override
  String get lastDueDate => "Última data de vencemento";

  @override
  String get commented => "Comentado";

  @override
  String get tagAdded => "Etiqueta engadida";

  @override
  String get tagRemoved => "Eliminouse a etiqueta";

  @override
  String get tags => "Etiquetas";

  @override
  String get update => "Actualización";

  @override
  String get details => "Detalles";

  @override
  String get timeline => "Cronoloxía";

  @override
  String get aboutMe => "Sobre min";

  @override
  String get acceptNews => "Recibe novas";

  @override
  String get allActive => "Todo activo";

  @override
  String get changePhoto => "Cambiar foto";

  @override
  String get changeYourPassword => "Cambia o teu contrasinal";

  @override
  String get changeYourPasswordAdvice =>
      "O contrasinal debe ter polo menos oito caracteres, incluído un número, unha maiúscula e unha minúscula. Podes usar caracteres especiais como @ # \$% ^ & + = e dez ou máis caracteres para mellorar a seguridade do teu contrasinal.";

  @override
  String get charge => "Cargar";

  @override
  String get country => "País";

  @override
  String get disabled => "Desactivado";

  @override
  String get emailNotification => "Notificacións por correo electrónico";

  @override
  String get language => "Lingua";

  @override
  String get lastName => "Apelido";

  @override
  String get maxEveryHour => "Cada hora";

  @override
  String get maxHalfDay => "Cada 12 horas";

  @override
  String get messages1x1AndMentions => "Mensaxes 1x1 e @mentions";

  @override
  String get myProfile => "O meu perfil";

  @override
  String get never => "Nunca";

  @override
  String get newPassword => "Novo contrasinal";

  @override
  String get newsLetters => "Cartas de novas";

  @override
  String get notReceiveNews => "Non recibir novas";

  @override
  String get notifications => "Notificacións";

  @override
  String get passwordRequirements =>
      "Cambia o teu contrasinal periodicamente para aumentar a túa seguridade e protección";

  @override
  String get phoneNotifications => "Notificacións telefónicas";

  @override
  String get phoneNumber => "Número de teléfono";

  @override
  String get photoSizeRestrictions =>
      "Usa unha foto cadrada cun ancho máximo de 400 px (pequena)";

  @override
  String get repeatNewPassword => "Repita o novo contrasinal";

  @override
  String get security => "Seguridade";

  @override
  String get skypeUserName => "Usuario de Skype";

  @override
  String get sounds => "Sons";

  @override
  String get yourUserName => "O teu nome de usuario";

  @override
  String get saveChanges => "Gardar cambios";

  @override
  String get profileEmailUsesWarning =>
      "Este correo electrónico só se usa para as notificacións deste equipo.";

  @override
  String get pushMobileNotifications => "Notificacións push móbiles";

  @override
  String get saveNotificationChanges => "Garda os cambios de notificación";

  @override
  String get updatePassword => "Actualizar contrasinal";

  @override
  String get updateProfileInfo => "Actualiza a información do perfil";

  @override
  String get password8CharsRequirement =>
      "O contrasinal debe ter polo menos 8 caracteres.";

  @override
  String get passwordAtLeast1CapitalLetter =>
      "O contrasinal debe conter polo menos 1 maiúscula.";

  @override
  String get passwordAtLeast1LowerCaseLetter =>
      "O contrasinal debe conter polo menos 1 letra minúscula.";

  @override
  String get passwordAtLeast1Number =>
      "O contrasinal debe conter polo menos 1 número.";

  @override
  String get passwordMustMatch => "O contrasinal debe coincidir.";

  @override
  String get notificationUpdatedSuccess => "Actualizáronse os cambios de notificación.";

  @override
  String get passwordUpdatedSuccess => "Actualizouse o contrasinal.";

  @override
  String get profileUpdatedSuccess => "Perfil actualizado";

  @override
  String get enablePermissions => "Activar permisos";

  @override
  String get permissionDenied => "Permiso denegado";

  @override
  String get savePreferences => "Gardar preferencias";

  @override
  String get turnOffChannelEmails => "Non recibas correos electrónicos de canles";

  @override
  String get turnOffChannelSounds => "Desactiva os sons da canle";

  @override
  String get chatMessageUnavailable =>
      "As mensaxes de chat non están dispoñibles para este usuario";

  @override
  String get createChannel => "Crear canle";

  @override
  String get createNewChannel => "Crea unha nova canle";

  @override
  String get isTyping => "está escribindo ...";

  @override
  String get createPrivateGroup => "Crear grupo privado";

  @override
  String get createPrivateGroupWarning =>
      "Vas crear un novo GRUPO, podes engadir persoas a este grupo se xa forman parte do teu equipo, se non, crea o grupo primeiro e invítalos despois.";

  @override
  String get createNewPrivateGroup => "Crea un novo grupo privado";

  @override
  String get createNewChannelAction =>
      "Estás a piques de crear unha nova canle aberta.";

  @override
  String get createNewChannelForAdminsOnly => "Só os administradores teñen acceso a escribir.";

  @override
  String get openChannelAllMemberAccess => "Todos os membros do equipo teñen acceso de lectura.";

  @override
  String get and => "E";

  @override
  String get userIsInactiveToChat =>
      "Non podes chatear con este usuario porque está inactivo.";

  @override
  String get selectChannel => "Selecciona canle";

  @override
  String get needToSelectChannel => "Debe seleccionar unha canle";

  @override
  String get fileAlreadyShared =>
      "Este ficheiro xa se comparte co mesmo nome na canle que seleccionaches.";

  @override
  String get inChannel => "en canle";

  @override
  String seeAnswerMessages(int count) => "Ver $count  mensaxes";

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
    return "Usuario $name  uniuse á canle";
  }

  @override
  String userHasLeft(String name) {
    return "Usuario $name  saíu da canle";
  }

  @override
  String invitedBy(String name) {
    return "Invitado por $name";
  }

  @override
  String get answers => "Respostas";

  @override
  String get publishIn => "publicar en";

  @override
  String get hasCommentedOnThread => "Comentou o fío:";

  @override
  String get unReadMessages => "Mensaxes sen ler";

  @override
  String get hasAddedTag => "Engadiu a etiqueta";

  @override
  String get hasAssignedUser => "Asignou ao usuario";

  @override
  String get hasClosedTask => "Pechou a tarefa";

  @override
  String get hasCommentedTask => "Engadiu un comentario";

  @override
  String get hasCreatedTask => "Creou a tarefa";

  @override
  String get hasCreatedTaskAssignedTo => "Creou unha nova tarefa asignada a";

  @override
  String get hasDeleteTag => "Eliminou a etiqueta";

  @override
  String get hasDeletedCommentTask => "Eliminou un comentario";

  @override
  String get hasEditedCommentTask => "Editou un comentario";

  @override
  String get hasEditedTask => "Editou a tarefa";

  @override
  String get hasRemovedEndDateTask => "Eliminou a data de finalización de";

  @override
  String get hasReopenedTask => "Abriu de novo a tarefa";

  @override
  String get hasSetMilestone => "Estableceu o fito";

  @override
  String get hasUnAssignedUser => "Anulou a asignación do usuario";

  @override
  String get hasUpdatedDateTask => "Actualizou a data de finalización de";

  @override
  String get inTheTask => "Na tarefa";

  @override
  String get to => "a";

  @override
  String get hasAssignedNewDueDateFor => "Asignou unha nova data de vencemento para";

  @override
  String get createNewTag => "Crear nova etiqueta";

  @override
  String get createNewMilestone => "Crea un novo fito";

  @override
  String get editMilestone => "Editar o fito";

  @override
  String get editTag => "Editar etiqueta";

  @override
  String get openTasks => "Tarefas abertas";

  @override
  String get newPersonalNote => "Nova nota persoal";

  @override
  String get createNewPersonalNote => "Crear nota persoal";

  @override
  String get filterBy => "Filtrar por";

  @override
  String hereStartsYourMessagesWith(String name) =>
      "Aquí comeza as túas mensaxes con @$name";

  @override
  String thisChannelIsManagedBy(String name) =>
      "Esta canle está xestionada por @$name Se precisa axuda, contacte co administrador.";

  @override
  String newPush(String user, String repository, String repositoryUrl) {
    String part1 = "Novo pulo de";
    String part2 = "no repositorio";
    String part3 = "Detalle";

    return "<p>$part1  <span class = 'link-mention'> @$user</span> $part2  <span> <a href = '$repositoryUrl'>$repository. $part3</a> </span> </p>";
  }

  @override
  String unassignedTask(
    String repository,
    String repositoryUrl,
  ) {
    String part1 = "Tarefa sen asignar no repositorio";
    String part2 = "Detalle";
    return "<p>$part1  <a href = '$repositoryUrl'>$repository. $part2</a> </p>";
  }

  @override
  String cardTrelloCreate(
      String board, String boardUrl, String card, String cardUrl, String list) {
    String part1 = "Tarxeta creada";
    String part2 = "na lista";
    String part3 = "de taboleiro";
    return "<p>$part1  <a href = '$cardUrl'>$card</a> $part2   $list   $part3  <a href = '$boardUrl'>$board</a> </p>";
  }

  @override
  String cardTrelloRename(String board, String boardUrl, String oldName,
      String newName, String list) {
    String part1 = "Na lista";
    String part2 = "de taboleiro";
    String part3 = "cambiouse o nome da tarxeta";
    String part4 = "a";
    return "<p>$part1 '$list' $part2 <a href='$boardUrl'>$board</a> $part3 '$oldName' $part4 '$newName'</p>";
  }

  @override
  String cardTrelloDescriptionChange(String board, String boardUrl, String card,
      String cardUrl, String list, String description) {
    String part1 = "A tarxeta";
    String part2 = "da lista";
    String part3 = "de taboleiro";
    String part4 = "cambiou a súa descrición a";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4 '$description'</p>";
  }

  @override
  String cardTrelloMoveToOtherList(String board, String boardUrl, String card,
      String cardUrl, String oldList, String newList) {
    String part1 = "A tarxeta";
    String part2 = "foi movido da lista";
    String part3 = "á lista";
    String part4= "no taboleiro";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$oldList' $part3 '$newList' $part4 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloArchive(String board, String boardUrl, String card,
      String cardUrl, String list) {
    String part1 = "A tarxeta";
    String part2 = "da lista";
    String part3 = "de taboleiro";
    String part4 = "foi arquivado";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4</p>";
  }

  @override
  String get comments => "Comentarios";

  @override
  String get addComment => "Engadir comentario";

  @override
  String get editComment => "Editar comentario";

  @override
  String get downloadAppsAndSynchronizer =>
      "<a href ='https://noysi.com/a/#/downloads'>DESCARGA AS APLICACIÓNS XA!</a>";

  @override
  String get welcomeToNoysiFirstName => "Benvido! Esta é a túa canle persoal, ninguén máis a verá, non tes comunicación con ninguén, é a túa canle persoal para que deixes notas persoais e cargues ficheiros que ninguén máis verá. Como te chamas?";

  @override
  String get welcomeToNoysiTimeout =>
      "Non me contestaches! Se precisas axuda, fai clic en <a href = '${Endpoint.helpUrl}'> aquí. </a>";

  @override
  String get wrongUsernamePassword => "Nome de usuario ou contrasinal incorrecto";

  @override
  String get userInUse => "Este usuario xa está en uso";

  @override
  String get invite => "Invitar";

  @override
  String get groupRequired => "Requírese grupo";

  @override
  String get uploading => "Cargando";

  @override
  String get downloading => "Descargando";

  @override
  String get inviteGuestsWarning => "Os convidados únense a un grupo neste equipo.";

  @override
  String get addMembers => "Engade membros";

  @override
  String get enterEmailsByComma =>
      "Insira correos electrónicos separándoos con comas:";

  @override
  String get firstName => "Nome";

  @override
  String get inviteFewMorePersonal => "Invita a algúns e sé máis persoal";

  @override
  String get inviteManyAtOnce => "Invita a moitos á vez";

  @override
  String get addGuests => "Engade invitados";

  @override
  String get followThread => "Siga este fío";

  @override
  String get markThreadAsRead => "Marcar como lido";

  @override
  String get stopFollowingThread => "Deixa de seguir este fío";

  @override
  String get needToVerifyAccountToInvite =>
      "Debe verificar a conta de correo electrónico para convidar membros.";

  @override
  String get createANewTeam => "Crea un novo equipo";

  @override
  String get createNewTeam => "Crea un novo equipo.";

  @override
  String get enterIntoYourAccount => "Entra na túa conta";

  @override
  String get forgotPassword => "Esqueceu o contrasinal?";

  @override
  String get goAhead => "Adiante!";

  @override
  String get passwordRestriction => "O contrasinal debe ter polo menos oito caracteres incluíndo un número, unha letra maiúscula e unha minúscula. Podes usar caracteres especiais como @ # \$% ^ & + = e dez ou máis caracteres para mellorar a seguridade do teu contrasinal.";

  @override
  String get recoverYorPassword => "Recupera o teu contrasinal";

  @override
  String get recoverYorPasswordWarning => "Para restaurar o seu contrasinal, introduza o enderezo de correo electrónico que usa para iniciar sesión en noysi.com";

  @override
  String recoverPasswordResponse(String email) {
    return "Enviámosche un correo electrónico a $email";
  }

  @override
  String get recoverPasswordResponse1 =>
      "Comprobe a caixa de entrada e siga as instrucións para crear o seu novo contrasinal";

  @override
  String get continueStr => "Continuar";

  @override
  String get passwordAtLeast1SpecialChar => "O contrasinal debe ter polo menos un carácter especial @#\$%^&+=";

  @override
  String welcomeToNoysiLastName(String name) => "Ola $name. Cal é o teu apelido?";

  @override
  String get welcomeToNoysiDescription => "Moi ben. Todo está correcto. Vou proceder á actualización do teu perfil.";

  @override
  String get welcomeToNoysiInvite => "<a href = '#'>Invita agora aos membros do teu equipo.</a>";

  @override
  String get activeFilter => "Filtro activo";

  @override
  String get newFileComment => "Novo comentario no ficheiro";

  @override
  String get removed => "Eliminado";

  @override
  String get sharedOn => "Compartido en";

  @override
  String get notifyAllInThisChannel => "avisa a todos nesta canle";

  @override
  String get notifyAllMembers => "avisar a todos os membros";

  @override
  String get keepPressingToRecord => "Sigue premendo o botón para gravar";

  @override
  String get slideToCancel => "Pasa o dedo para cancelar";

  @override
  String get chooseASecurePasswordText => "Elixe un contrasinal seguro que podes recordar";

  @override
  String get confirmPassword => "Repite o contrasinal";

  @override
  String get yourPassword => "Contrasinal";

  @override
  String get passwordDontMatch => "Os contrasinais non coinciden";

  @override
  String get changeCreateTeamMail => "Non, quero cambiar o correo electrónico";

  @override
  String step(int number) => "Paso $number";

  @override
  String get user => "Usuario";

  @override
  String get deleteFolderWarning => "O cartafol eliminarase permanentemente e non se poderá recuperar";

  @override
  String get calendar => "Calendario";

  @override
  String get week => "Semana";

  @override
  String get folderIsNotInCurrentTeam => "O cartafol non está asociado co equipo actual";

  @override
  String get folderIsNotInAvailableChannel => "O cartafol referenciado non está nunha canle dispoñible no explorador de ficheiros";

  @override
  String get folderLinked => "Copiouse a ligazón do cartafol á canle";

  @override
  String get folderShared => "A carpeta compartiuse na canle";

  @override
  String get folderUploaded => "O cartafol cargouse á canle";

  @override
  String get folderNotFound => "Non se atopou o cartafol";

  @override
  String get folderNameIncorrect => "O nome do cartafol non é válido";

  @override
  String get cloneFolder => "Cartafol de clonación";

  @override
  String get cloneFolderInfo => "A clonación dun cartafol crea un cartafol novo na canle de destino co mesmo estado e contido que o cartafol seleccionado neste momento.";

  @override
  String get folderDeleted => "Non se pode acceder a un cartafol eliminado";

  @override
  String get youWereInADeletedFolder => "Eliminouse o cartafol no que estaba";

  @override
  String get dateFormat6 => "MM/dd/yyyy";

  @override
  String get createdTask => "Tarefa creada";

  @override
  String get loggedIn => "Sesión iniciada";

  @override
  String get mention => "Mención";

  @override
  String get messageSent => "Mensaxe enviada";

  @override
  String get taskAssigned => "Tarefa asignada";

  @override
  String get taskUnassigned => "Tarefa sen asignar";

  @override
  String get uploadedFile => "Ficheiro cargado";

  @override
  String get uploadedFileFolder => "Ficheiro / cartafol cargado";

  @override
  String get uploadedFolder => "Cartafol cargado";

  @override
  String get downloadedFile => "Arquivo descargado";

  @override
  String get downloadedFileFolder => "Ficheiro / cartafol descargado";

  @override
  String get downloadedFolder => "Cartafol descargado";

  @override
  String get messageUnavailable => "A mensaxe non está dispoñible";

  @override
  String get activityZone => "Zona de Actividades";

  @override
  String get categories => "Ccategorías";

  @override
  String get category => "Categoría";

  @override
  String get clearAll => "Limpar todo";

  @override
  String get errorFetchingData => "Erro ao obter datos";

  @override
  String get filters => "Filtros";

  @override
  String get openSessions => "Sesións abertas";

  @override
  String activityFileFolderUploadedDownloaded(String user, String name, String channel, {bool download = false, bool isDirect = false, isFolder = false}) {
    String part1 = "${download ? "Descargaches" : "Cargaches"}${isFolder ? " Cartafol " : " o ficheiro "}";
    String part2 = download ? "da canle" : "Na canle";
    return "$part1 <i class=\"mention-generic\">$name</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMentioned(String user, String channel, {bool isDirect = false}) {
    String part1 = "Fomos mencionado na canle";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMessageSent(String user, String channel, {bool isDirect = false}) {
    String part1 = "Enviou unha mensaxe na canle";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activitySignedIn(String sessionInfo, String ip) {
    return "Iniciaches sesión <i class=\"mention-generic\">$sessionInfo</i> IP: <i class=\"mention-generic\">$ip</i>";
  }

  @override
  String activityTaskAssigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Foi asignado á tarefa";
    String part2 = "Na canle";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskCreated(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Creaches a tarefa";
    String part2 = "Na canle";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskUnassigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Foi deslocalizado da tarefa";
    String part2 = "Na canle";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String get activityZoneHeader => "Aquí é onde comeza a Zona de Actividades";

  @override
  String get selectEvent => "Selecciona un evento";

  @override
  String get googleCalendar => "Google";

  @override
  String get outlookCalendar => "Outlook";

  @override
  String get noysiCalendar => "Noysi";

  @override
  String get autogenerateRoomNameQuestion => "¿Quere xerar o nome da sala automaticamente?";

  @override
  String get createMeetingEvent => "Crear evento-reunión";

  @override
  String get externalGuests => "Convidados externos";

  @override
  String get internalGuests => "Convidados internos";

  @override
  String get newMeetingEvent => "Novo evento-encontro";

  @override
  String get roomName => "Nome da sala";

  @override
  String get eventMeeting => "Evento-Encontro";

  @override
  String get personalNote => "Nota persoal";

  @override
  String get updateExternalGuests => "Actualizar invitados externos";

  @override
  String get nameTextWarning => "O texto corresponde a unha cadea alfanumérica de 1 a 25 caracteres. Tamén podes usar espazos e os caracteres _ -";

  @override
  String get nameTextWarningWithoutSpaces => "O texto corresponde a unha cadea alfanumérica de 1 a 18 caracteres sen espazos. Tamén podes usar os caracteres _ -";

  @override
  String get today => "Hoxe";

  @override
  String get location => "Lugar";


  @override
  String get sessions => "Sesións";

  @override
  String get appVersion => "Versión da aplicación";

  @override
  String get browser => "Navegador";

  @override
  String get device => "Dispositivo";

  @override
  String get logout => "Asinar";

  @override
  String get manufacturer => "Creador";

  @override
  String get no => "Non";

  @override
  String get operativeSystem => "Sistema Operativo";

  @override
  String get yes => "Si";

  @override
  String get allDay => "Todo o día";

  @override
  String get endDate => "Data de finalización";

  @override
  String get noTitle => "Sen título";

  @override
  String get currentSession => "Sesión actual";

  @override
  String get logOutAllExceptForThisOne => "Pecha sesión en todos os dispositivos, agás este";

  @override
  String get terminateAllOtherSessions => "Finaliza todas as demais sesións";

  @override
  String get closeAllSessionsConfirmation => "¿Queres finalizar todas as demais sesións?";

  @override
  String get closeSessionConfirmation => "¿Queres rematar a sesión?";

  @override
  String get connectionLost => "Parece que non hai ningunha conexión";

  @override
  String get connectionEstablished => "Estás de volta en liña";

  @override
  String get connectionStatus => "Estado da conexión";

  @override
  String get anUserIsCalling => "Un usuario chámate ...";

  @override
  String get answer => "Resposta";

  @override
  String get hangDown => "Colgar";

  @override
  String get incomingCall => "Chamada entrante";

  @override
  String isCallingYou(String user) => "$user está chamándote ...";

  @override
  String get callCouldNotBeInitialized => "Non se puido inicializar a chamada";

  @override
  String get sentMessages => "Mensaxes enviadas";

  @override
  String sentMessagesCount(String count) => "$count de 10000";

  @override
  String get teamDataUsage => "Uso de datos do equipo";

  @override
  String get usedStorage => "Almacenamento usado";

  @override
  String usedStorageText(String used) => used + "GB de 5GB";

  @override
  String get userDataUsage => "Uso de datos do usuario";

  @override
  String get audioEnabled => "Audio habilitado";

  @override
  String get meetingOptions => "Opcións de reunión";

  @override
  String get videoEnabled => "Vídeo habilitado";

  @override
  String get dontShowThisMessage => "Non volva amosar";

  @override
  String get showDialogEveryTime => "Mostrar o diálogo cada vez que comeza unha reunión";

  @override
  String get micAndCameraRequiredAlert => "Son necesarios permisos de acceso á cámara e ao micrófono. Asegúrese de que concedeu os permisos necesarios. ¿Quere ir á configuración de permisos?";

  @override
  String get connectWith => "Conéctate con";

  @override
  String get or => "ou";

  @override
  String get noEvents => "Non hai eventos, tarefas nin notas persoais";

  @override
  String get viewDetails => "Ver detalles";

  @override
  String zendeskTicketUpdated(String user, String status, String type, String title, String url) {
    String part1 = R.string.user;
    String part2 = "actualizou o billete";
    String part3 = "de tipo";
    String part4 = "ao estado";
    String part5 = R.string.viewDetails;
    return "<p>$part1 '$user' $part2 '$title' $part3 '$type' $part4 '$status'. <span><a href='$url'>$part5</a></span></p>";
  }


  @override
  String get accept => "Aceptar";

  @override
  String get busy => "Ocupado";

  @override
  String get configuration => "Configuración";

  @override
  String get downloads => "Descargas";

  @override
  String get editTeam => "Equipo de edición";

  @override
  String get general => "Xeral";

  @override
  String get integrations => "Integracións";

  @override
  String get noRecents => "Sen recentes";

  @override
  String get noRecommendations => "Sen recomendacións";

  @override
  String get inAMeeting => "Nunha reunión";

  @override
  String get onFire => "On Fire";

  @override
  String get plans => "Plans";

  @override
  String get setAStatus => "Establecer un estado";

  @override
  String get sick => "Doente";

  @override
  String get signOut => "Pechar sesión";

  @override
  String get suggestions => "Suxestións";

  @override
  String get teams => "Equipos";

  @override
  String get traveling => "Viaxando";

  @override
  String get whatsYourStatus => "Cal é o teu estado?";

  @override
  String get sendAlwaysAPush => "Envía sempre unha notificación push";

  @override
  String get robot => "Robot";

  @override
  String get deactivateUserWarning => "Os membros do equipo non poderán comunicarse cun membro mentres estea desactivado. Non obstante, toda a actividade que realice o membro desactivado en Noysi permanecerá intacta e estarán accesibles as mensaxes (canles abertas, mensaxes 1 a 1 e grupos privados), ficheiros e tarefas.";

  @override
  String get activateUserWarning => "Unha vez reactivado o membro, recuperará o acceso ás mesmas canles, grupos, ficheiros e tarefas que tiña antes de ser desactivado.";

  @override
  String get changeRole => "Cambiar rol";

  @override
  String get userStatus => "Estado de usuario";

  @override
  String get deactivateMyAccount => "Desactivar a miña conta";

  @override
  String get deactivateMyAccountWarning => "Se desactivas a túa conta, desactivarase en todos os teus equipos, conversas, ficheiros, tarefas e calquera actividade que xestionases a través de Noysi ata que un administrador te reactive de novo.";

  @override
  String get deactivateMyUserInThisTeam => "Desactivar o meu usuario neste equipo";

  @override
  String get deactivateMyUserInThisTeamWarning => "Cando te desactives nun equipo, todo o que posúes nese equipo permanecerá ata que te actives de novo. Se es o único administrador do equipo, o equipo non se eliminará.";

  @override
  String get operationConfirmation => "Estás seguro desta operación?";

  @override
  String get formatNotSupported => "Este formato ou extensión non é compatible co sistema operativo";

  @override
  String get invitePrivateGroupLink => "Convida un membro ao grupo usando esta ligazón";

  @override
  String get invalidPhoneNumber => "Número de teléfono non válido";

  @override
  String get searchByCountryName => "Busca por nome do país ou código de marcación";

  @override
  String get kick => "Expulsar";

  @override
  String get deleteAll => "Eliminar todo";

  @override
  String get enterKeyManually => "Introduza a tecla manualmente";

  @override
  String get noysiAuthenticator => "Noysi Autentificador";

  @override
  String get qrScanner => "QR";

  @override
  String get otpLabelWarning => "A etiqueta OTP é unha cadea alfanumérica sen espazos :@.,;()\$% tamén están permitidos";

  @override
  String get invalidBase32Chars => "Caracteres base32 non válidos";

  @override
  String get label => "Etiqueta";

  @override
  String get secretCode => "Chave secreta";

  @override
  String get labelTextWarning => "A etiqueta está baleira, comprobe este valor";

  @override
  String missedCallFrom(String user) => "Chamada perdida de $user";

  @override
  String get activeItemBackgroundColor => "Bloquear o nome de usuario ao enviar a invitación";

  @override
  String get activeItemTextColor => "Texto do elemento activo";

  @override
  String get activePresenceColor => "Presenza activa";

  @override
  String get adminsCanDeleteMessage => "Os administradores poden eliminar mensaxes";

  @override
  String get allForAdminsOnly => "@all só para administradores";

  @override
  String get channelForAdminsOnly => "@channel só para administradores e creadores de canles";

  @override
  String get chooseTheme => "Escolle un tema para o teu equipo";

  @override
  String get enablePushAllChannels => "Activa as notificacións push en todas as canles";

  @override
  String get inactivePresenceColor => "Presenza inactiva";

  @override
  String get leaveTeam => "Deixa este equipo";

  @override
  String get leaveTeamWarning => "Cando deixes un equipo, borrarase todo o que posúas nese equipo. Se es o único administrador do equipo, o equipo será eliminado.";

  @override
  String get notificationBadgeBackgroundColor => "Fondo de insignia";

  @override
    String get notificationBadgeTextColor => "Texto do distintivo";

  @override
  String get onlyAdminInvitesAllowed => "Invitados só autorizados polos administradores";

  @override
  String get reset => "Restablecer";

  @override
  String get settings => "Configuración";

  @override
  String get sidebarColor => "Cor da barra lateral";

  @override
  String get taskUpdateProtected => "Modificación de Tarefas reservadas a Creadores e Administradores";

  @override
  String get teamName => "Nome do equipo";

  @override
  String get textColor => "Cor do texto";

  @override
  String get theme => "Tema";

  @override
  String get updateUsernameBlocked => "Bloquear o nome de usuario ao enviar a invitación";

  @override
  String get fileNotFound => "Arquivo non atopado";

  @override
  String get messageNotFound => "Non se atopou a mensaxe, comprobe se a mensaxe que busca está dispoñible no equipo actual.";

  @override
  String get taskNotFound => "Non se atopou a tarefa";

  @override
  String userHasPinnedMessage(String name) => "$name fixou unha mensaxe na canle";

  @override
  String userHasUnpinnedMessage(String name) => "$name quitou a mensaxe desta canle";

  @override
  String get pinMessage => "Fixar mensaxe";

  @override
  String get unpinMessage => "Desfixar a mensaxe";

  @override
  String get pinnedMessage => "Mensaxe fixada";

  @override
  String get deleteMyAccount => "Eliminar a miña conta";

  @override
  String get yourDeleteRequestIsInProcess => "A túa solicitude de eliminación da conta está en proceso";

  @override
  String get deleteMyAccountWarning => "Se eliminas a túa conta, a acción será irreversible. Se xestionas un equipo e non hai outro administrador, o equipo eliminarase.";

  @override
  String get lifetimeDeal => "Ofertas de por vida";

  @override
  String get showEmails => "Mostra os correos electrónicos dos usuarios";

  @override
  String get showPhoneNumbers => "Mostrar os números de teléfono dos usuarios";

  @override
    String get addChannel => "Engadir canle";

  @override
  String get addPrivateGroup => "Engadir grupo privado";

  @override
  String get selectUserFromTeam => "Sélectionnez l'utilisateur de cette équipe";

  @override
  String get selectUsersFromChannelGroup => "Sélectionner les utilisateurs du canal ou du groupe";

  @override
  String get memberDeleted => "Membro eliminado";
}


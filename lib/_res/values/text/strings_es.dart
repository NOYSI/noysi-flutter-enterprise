import 'dart:ui';

import 'package:code/_res/values/config.dart';
import 'package:code/_res/values/text/strings_base.dart';

import '../../../data/api/remote/endpoints.dart';
import '../../R.dart';

class StringsEs implements StringsBase {
  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Noysi";

  @override
  String get yourTeams => "Tus equipos";

  @override
  String get channel => "Canal";

  @override
  String get channels => "Canales";

  @override
  String get directMessagesAbr => "MDs";

  @override
  String get email => "Correo";

  @override
  String get home => "Inicio";

  @override
  String get member => "Miembro";

  @override
  String get administrator => "Administrador";

  @override
  String get guest => "Invitado";

  @override
  String get guests => "Invitados";

  @override
  String get members => "Miembros";

  @override
  String get inactiveMember => "Miembro desactivado";

  @override
  String get message => "Mensaje";

  @override
  String get messages => "Mensajes";

  @override
  String get password => "Contraseña";

  @override
  String get register => "Registrarme";

  @override
  String get search => "Buscar";

  @override
  String get signIn => "Iniciar sesión";

  @override
  String get task => "Tarea";

  @override
  String get tasks => "Tareas";

  @override
  String get createTask => "Crear Tarea";

  @override
  String get newTask => "Nueva Tarea";

  @override
  String get description => "Descripción";

  @override
  String get team => "Equipo";

  @override
  String get thread => "Hilo";

  @override
  String get threads => "Hilos";

  @override
  String get createTeam => "Crear equipo";

  @override
  String get confirmIsCorrectEmailAddress => "Si! Es el email correcto";

  @override
  String get createTeamIntro =>
      "Estás a punto de configurar tu nuevo equipo en Noysi.";

  @override
  String get isCorrectEmailAddress => "¿Es el email correcto?";

  @override
  String get welcome => "Bienvenido!";

  @override
  String get invitationSentAt => "Su invitación será enviada a:";

  @override
  String get next => "Siguiente";

  @override
  String get startNow => "Iniciar ahora!";

  @override
  String get charsRemaining => "Caracteres restantes:";

  @override
  String get teamNameOrgCompany =>
      "Escribe el nombre de tu Equipo, Organización o Compañía.";

  @override
  String get teamNameOrgCompanyLabel => "Ej. Mi Compañía";

  @override
  String get yourTeam => "Tu equipo";

  @override
  String get noysiServiceNewsletters =>
      "Estoy de acuerdo en recibir (ocasionalmente) correos acerca de los servicios de Noysi.";

  @override
  String get userNameIntro =>
      "Tu nombre de usuario es la forma en la que te ve el resto de tu equipo.";

  @override
  String get userNameLabel => "Ej. ackerman";

  @override
  String get addAnother => "Agregar otro";

  @override
  String get byProceedingAcceptTerms =>
      "* Al proceder aceptas nuestros <b>Términos de servicios</b>";

  @override
  String get invitations => "Invitaciones";

  @override
  String get invitePeople => "Invitar personas";

  @override
  String get noysiIsTeamWorkInvite =>
      "Noysi es una herramienta de trabajo en equipo. Invita al menos una persona";

  @override
  String get userName => "Nombre de usuario";

  @override
  String get fieldMax18 => "18 caracteres máximo";

  @override
  String get fieldMax25 => "25 caracteres máximo";

  @override
  String get fieldPassword => "Contraseña requerida";

  @override
  String get fieldRequired => "Campo requerido";

  @override
  String get missingEmailFormat => "Correo incorrecto";

  @override
  String get back => "Atrás";

  @override
  String get channelBrowser => "Buscador del canal";

  @override
  String get help => "Ayuda";

  @override
  String get preferences => "Preferencias";

  @override
  String get signOutOf => "Cerrar sesión de";

  @override
  String get closed => "Cerrada";

  @override
  String get closedMilestone => "Cerrado";

  @override
  String get close => "Cerrar";

  @override
  String get opened => "Abierto";

  @override
  String get chat => "Chat";

  @override
  String get allThreads => "Todos los hilos";

  @override
  String get inviteMorPeople => "Invitar más personas";

  @override
  String get meeting => "Reunión";

  @override
  String get myFiles => "Mis archivos";

  @override
  String get myTasks => "Mis tareas";

  @override
  String get myTeams => "Mis equipos";

  @override
  String get openChannels => "Canales abiertos";

  @override
  String get privateGroups => "Grupos privados";

  @override
  String get favorites => "Favoritos";

  @override
  String get message1x1 => "Mensaje 1 a 1";

  @override
  String get acceptedTitle => "Aceptado";

  @override
  String get date => "Fecha";

  @override
  String get invitationLanguageTitle => "Idioma";

  @override
  String get invitationMessage => "Mensaje de invitación";

  @override
  String get revokeInvitation => "Revocar invitación";

  @override
  String get revoke => "Revocar";

  @override
  String get revokeInvitationWarning =>
      "Ten precaución, esta acción no es reversible";

  @override
  String get revokeInvitationDelete => "Eliminar invitación";

  @override
  String get resendInvitationBefore24hrs =>
      "Reenviar invitaciones no está permitido hasta pasadas 24 horas después del último envío.";

  @override
  String get resendInvitationSuccess =>
      "Invitaciones enviadas satisfactoriamente.";

  @override
  String get resendInvitation => "Reenviar invitación";

  @override
  String get invitationMessageDefault =>
      "Hola! Aquí tienes una invitación para unirte";

  @override
  String get inviteManyAsOnce => "Invitar a muchos a la vez";

  @override
  String get inviteMemberTitle =>
      "Los miembros del equipo tienen acceso total a los canales abiertos, mensajes persona a persona, y grupos.";

  @override
  String get inviteMemberWarningTitle =>
      "Para invitar a nuevos miembros debes ser administrador del equipo.";

  @override
  String get inviteNewMemberWarningTitle =>
      "Cualquier miembro del equipo puede agregar invitados de forma ilimitada.";

  @override
  String get inviteSubtitle =>
      "Noysi es una herramienta para trabajar mejor con tu equipo. Invítales ahora!";

  @override
  String get inviteTitle => "Invitar otra persona";

  @override
  String get inviteToAGroup => "Invitar a un grupo(requerido)";

  @override
  String get inviteToAGroupNotRequired => "Invitar a un grupo (opcional)";

  @override
  String get inviteMemberWarning =>
      "Nuevos miembros se unirán al canal #general automáticamente. Opcionalmente, también puedes agregarlos a un grupo privado ahora.";

  @override
  String get inviteToThisTeam => "Invitar a este equipo";

  @override
  String get invitationsSent => "Invitaciones enviadas";

  @override
  String get name => "Nombre";

  @override
  String get noPendingInvitations =>
      "No hay invitaciones para enviar en este equipo.";

  @override
  String get pendingTitle => "Pendiente";

  @override
  String get chooseTitle => "Escoge";

  @override
  String get seePendingAcceptedInvitations =>
      "Ver invitaciones pendientes y aceptadas";

  @override
  String get sendInvitations => "Enviar invitaciones";

  @override
  String get typeEmail => "Escribe un correo";

  @override
  String get typeEmailComaSeparated => "Escribe correos separados por coma";

  @override
  String get atNoysi => "en Noysi";

  @override
  String get inviteNewMemberTitle =>
      "Los invitados no pagan y puedes invitar a tantos como quieras, pero solo tendrán acceso a un grupo dentro de este equipo.";

  @override
  String get invited => "Invitado(a)";

  @override
  String get thisNameAlreadyExist => "Parece que este nombre ya está en uso.";

  @override
  String get emptyList => "Lista vacía";

  @override
  String get ok => "OK";

  @override
  String get byNameFirst => "Por nombre A-Z";

  @override
  String get byNameInvertedFirst => "Por nombre Z-A";

  @override
  String get download => "Descargar";

  @override
  String get files => "Archivos";

  @override
  String get folders => "Carpetas";

  @override
  String get newTitle => "Nuevo";

  @override
  String get newestFirst => "Los más nuevos primero";

  @override
  String get oldestFirst => "Los mas viejos primero";

  @override
  String get see => "Ver";

  @override
  String get share => "Compartir";

  @override
  String get moreInfo => "Más información";

  @override
  String get assigned => "Asignada";

  @override
  String get author => "Autor";

  @override
  String get created => "Creada";

  @override
  String get earlyDeliverDate => "Fecha de entrega más temprana";

  @override
  String get farDeliverDate => "Fecha de entrega más tarde";

  @override
  String get filterAuthor => "Filtrar por autor";

  @override
  String get searchUsers => "Buscar usuarios";

  @override
  String get sort => "Ordenar";

  @override
  String get sortBy => "Ordenar por";

  @override
  String get dateFormat1 => "MMM dd, yyyy hh.mm";

  @override
  String get cancel => "Cancelar";

  @override
  String get exit => "Salir";

  @override
  String get exitWarning => "¿Estás seguro?";

  @override
  String get deleteChannelWarning =>
      "¿Estás seguro de que quieres salir de este canal?";

  @override
  String get typeMessage => "Escribir un mensaje...";

  @override
  String get addChannelToFavorites => "Agregar a favoritos";

  @override
  String get removeFromFavorites => "Eliminar de favoritos";

  @override
  String get channelInfo => "Información del canal";

  @override
  String get channelMembers => "Miembros del canal";

  @override
  String get channelPreferences => "Preferencias del canal";

  @override
  String get closeChatVisibility => "Cerrar 1 a 1";

  @override
  String get inviteToGroup => "Invitar miembro a este canal";

  @override
  String get leaveChannel => "Abandonar canal";

  @override
  String get mentions => "Menciones";

  @override
  String get seeFiles => "Ver archivos";

  @override
  String get seeLinks => "Ver enlaces";

  @override
  String get links => "Enlaces";

  @override
  String get taskManager => "Administrador de tareas";

  @override
  String get videoCall => "Video llamada";

  @override
  String get addReaction => "Agregar reacción";

  @override
  String get addTag => "Agregar etiqueta";

  @override
  String get addMilestone => "Agregar hito";

  @override
  String get copyMessage => "Copiar mensaje";

  @override
  String get copyPermanentLink => "Copiar enlace";

  @override
  String get createThread => "Iniciar un hilo";

  @override
  String get edit => "Editar";

  @override
  String get favorite => "Favorito";

  @override
  String get remove => "Eliminar";

  @override
  String get dateFormat2 => "H:mm";

  @override
  String get dateFormat3 => "MMM d, yyyy";

  @override
  String get tryAgain => "Intentar de nuevo";

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
      "Seguro que quieres borrar este mensaje? Esto no se puede deshacer.";

  @override
  String get deleteMessageTitle => "Eliminar mensaje";

  @override
  String get edited => "Editado";

  @override
  String get seeAll => "Ver todo";

  @override
  String get copiedToClipboard => "Copiado a portapapeles!";

  @override
  String get underConstruction => "Bajo construcción";

  @override
  String get reactions => "Reacciones";

  @override
  String get all => "Todos";

  @override
  String get users => "Usuarios";

  @override
  String get documents => "Documentos";

  @override
  String get fromLocalStorage => "Desde el almacenamiento local";

  @override
  String get photoGallery => "Galería de fotos";

  @override
  String get recordVideo => "Grabar un video";

  @override
  String get takePhoto => "Tomar una foto";

  @override
  String get useCamera => "Desde la cámara";

  @override
  String get videoGallery => "Galería de videos";

  @override
  String get changeName => "Cambiar nombre";

  @override
  String get createFolder => "Crear carpeta";

  @override
  String get createNameWarning =>
      "Los nombres deben tener un máximo de 18 caracteres, sin signos de puntuación.";

  @override
  String get newName => "Nuevo nombre";

  @override
  String get rename => "Renombrar";

  @override
  String get renameFile => "Renombrar archivo";

  @override
  String get renameFolder => "Renombrar carpeta";

  @override
  String get deleteFile => "Eliminar archivo";

  @override
  String get deleteFolder => "Eliminar carpeta";

  @override
  String get deleteFileWarning => "El archivo se eliminará permanentemente y no podrá ser recuperado";

  @override
  String get delete => "Eliminar";

  @override
  String get open => "Abierta";

  @override
  String get addCommentOptional => "Agregar comentario(opcional)";

  @override
  String get shareFile => "Compartir archivo";

  @override
  String get groups => "Grupos";

  @override
  String get to1_1 => "1 a 1";

  @override
  String get day => "día";

  @override
  String get days => "Días";

  @override
  String get hour => "horas";

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
  String get year => "año";

  @override
  String get years => "años";

  @override
  String get by => "por";

  @override
  String get deliveryDateIn => "Fecha de entrega en";

  @override
  String get ago => "Hace";

  @override
  String get taskOpened => "Abierto";

  @override
  String get assignees => "Asignaciones";

  @override
  String get assigneeBy => "Asignado por";

  @override
  String get closeTask => "Cerrar tarea";

  @override
  String get comment => "Comentario";

  @override
  String get deliveryDate => "Fecha de entrega";

  @override
  String get leaveAComment => "Deja un comentario";

  @override
  String get milestone => "Hito";

  @override
  String get milestones => "Hitos";

  @override
  String get color => "Color";

  @override
  String get milestoneAdded => "Agregado al hito";

  @override
  String get participants => "Participantes";

  @override
  String get reopen => "Reabrir";

  @override
  String get completed => "Completado";

  @override
  String get dueDateUpdated => "Fecha de vencimiento actualizada";

  @override
  String get dueDate => "Fecha de vencimiento";

  @override
  String get lastDueDate => "Ultima fecha de vencimiento";

  @override
  String get commented => "Comentado";

  @override
  String get tagAdded => "Etiqueta agregada";

  @override
  String get tagRemoved => "Etiqueta removida";

  @override
  String get tags => "Etiquetas";

  @override
  String get update => "Actualizar";

  @override
  String get details => "Detalles";

  @override
  String get timeline => "Línea de tiempo";

  @override
  String get aboutMe => "Acerca de mí";

  @override
  String get acceptNews => "Recibir noticias";

  @override
  String get allActive => "Todos activos";

  @override
  String get changePhoto => "Cambiar foto";

  @override
  String get changeYourPassword => "Cambiar tu contraseña";

  @override
  String get changeYourPasswordAdvice =>
      "La contraseña debe tener al menos ocho caracteres, incluido un número, una letra mayúscula y una letra minúscula, puedes usar caracteres especiales como @#\$%^&+= y diez o más caracteres para mejorar la seguridad de tu contraseña";

  @override
  String get charge => "Cargo";

  @override
  String get country => "País";

  @override
  String get disabled => "Deshabilitado";

  @override
  String get emailNotification => "Notificaciónes de Correo Electrónico";

  @override
  String get language => "Idioma";

  @override
  String get lastName => "Apellido";

  @override
  String get maxEveryHour => "Cada hora";

  @override
  String get maxHalfDay => "Cada 12 horas";

  @override
  String get messages1x1AndMentions => "Mensajes 1x1 y @menciones";

  @override
  String get myProfile => "Mi perfil";

  @override
  String get never => "Nunca";

  @override
  String get newPassword => "Nueva contraseña";

  @override
  String get newsLetters => "Boletines";

  @override
  String get notReceiveNews => "No recibir noticias";

  @override
  String get notifications => "Notificaciones";

  @override
  String get passwordRequirements =>
      "Cambie su contraseña periódicamente para aumentar su seguridad y protección";

  @override
  String get phoneNotifications => "Notificaciones telefónicas";

  @override
  String get phoneNumber => "Número telefónico";

  @override
  String get photoSizeRestrictions =>
      "Utilice una foto cuadrada con un ancho máximo de 400 px (pequeña)";

  @override
  String get repeatNewPassword => "Repita la nueva contraseña";

  @override
  String get security => "Seguridad";

  @override
  String get skypeUserName => "Usuario de Skype";

  @override
  String get sounds => "Sonidos";

  @override
  String get yourUserName => "Tu nombre de usuario";

  @override
  String get saveChanges => "Salvar cambios";

  @override
  String get profileEmailUsesWarning =>
      "Este correo electrónico se usa solo para notificaciones en este equipo.";

  @override
  String get pushMobileNotifications => "Notificaciones móviles Push";

  @override
  String get saveNotificationChanges => "Guardar cambios de notificación";

  @override
  String get updatePassword => "Actualizar contraseña";

  @override
  String get updateProfileInfo => "Actualizar información de perfil";

  @override
  String get password8CharsRequirement =>
      "La contraseña debe tener al menos 8 caracteres.";

  @override
  String get passwordAtLeast1CapitalLetter =>
      "La contraseña debe contener al menos 1 letra mayúscula.";

  @override
  String get passwordAtLeast1LowerCaseLetter =>
      "La contraseña debe contener al menos 1 letra minúscula.";

  @override
  String get passwordAtLeast1Number =>
      "La contraseña debe contener al menos 1 número.";

  @override
  String get passwordMustMatch => "Contraseña debe coincidir.";

  @override
  String get notificationUpdatedSuccess =>
      "Se actualizaron los cambios de notificación.";

  @override
  String get passwordUpdatedSuccess => "Contraseña actualiza.";

  @override
  String get profileUpdatedSuccess => "Perfil actualizado";

  @override
  String get enablePermissions => "Habilitar permisos";

  @override
  String get permissionDenied => "Permisos denegados";

  @override
  String get savePreferences => "Salvar preferencias";

  @override
  String get turnOffChannelEmails =>
      "No recibir correos electrónicos del canal";

  @override
  String get turnOffChannelSounds => "Desactivar los sonidos del canal";

  @override
  String get chatMessageUnavailable =>
      "Los mensajes de chat no están disponibles para este usuario";

  @override
  String get createChannel => "Crear canal";

  @override
  String get createNewChannel => "Crear un nuevo canal";

  @override
  String get isTyping => "está escribiendo...";

  @override
  String get createPrivateGroup => "Crear grupo privado";

  @override
  String get createPrivateGroupWarning =>
      "Vas a crear un nuevo GRUPO, puedes agregar personas a este grupo si ya son parte de tu equipo, si no, crea el grupo primero e invítalos después.";

  @override
  String get createNewPrivateGroup => "Crea un nuevo grupo privado";

  @override
  String get createNewChannelAction =>
      "Estás a punto de crear un nuevo canal abierto.";

  @override
  String get createNewChannelForAdminsOnly =>
      "Solo los administradores tienen acceso para escribir.";

  @override
  String get openChannelAllMemberAccess =>
      "Todos los miembros del equipo tienen acceso de lectura.";

  @override
  String get and => "y";

  @override
  String get userIsInactiveToChat =>
      "No puedes chatear con este usuario porque está inactivo.";

  @override
  String get selectChannel => "Seleccionar canal";

  @override
  String get needToSelectChannel => "Necesitas seleccionar un canal";

  @override
  String get fileAlreadyShared =>
      "Este archivo ya está compartido con el mismo nombre en el canal que seleccionó.";

  @override
  String get inChannel => "en canal";

  @override
  String seeAnswerMessages(int count) => "Ver $count mensajes";

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
    return "Usuario $name se ha unido al canal";
  }

  @override
  String userHasLeft(String name) {
    return "Usuario $name ha dejado el canal";
  }

  @override
  String invitedBy(String name) {
    return "Invitado por $name";
  }

  @override
  String get answers => "Respuestas";

  @override
  String get publishIn => "publicar en";

  @override
  String get hasCommentedOnThread => "Ha comentado en el hilo:";

  @override
  String get unReadMessages => "Mensajes no leídos";

  @override
  String get hasAddedTag => "Ha agregado la etiqueta";

  @override
  String get hasAssignedUser => "Ha asignado al usuario";

  @override
  String get hasClosedTask => "Ha cerrado la tarea";

  @override
  String get hasCommentedTask => "Ha agregado un comentario";

  @override
  String get hasCreatedTask => "Ha creado una tarea";

  @override
  String get hasCreatedTaskAssignedTo => "Ha creado una nueva tarea asignada a";

  @override
  String get hasDeleteTag => "Ha eliminado la etiqueta";

  @override
  String get hasDeletedCommentTask => "Ha eliminado un comentario";

  @override
  String get hasEditedCommentTask => "Ha editado un comentario";

  @override
  String get hasEditedTask => "Ha editado la tarea";

  @override
  String get hasRemovedEndDateTask =>
      "Ha eliminado la fecha de finalización de";

  @override
  String get hasReopenedTask => "Ha reabierto la tarea";

  @override
  String get hasSetMilestone => "Ha marcado el hito";

  @override
  String get hasUnAssignedUser => "Ha desasignado al usuario";

  @override
  String get hasUpdatedDateTask => "Ha actualizado la fecha de finalización de";

  @override
  String get inTheTask => "En la tarea";

  @override
  String get to => "a";

  @override
  String get hasAssignedNewDueDateFor =>
      "Ha asignado una nueva fecha de vencimiento para";

  @override
  String get createNewTag => "Crear nueva etiqueta";

  @override
  String get createNewMilestone => "Crear nuevo hito";

  @override
  String get editMilestone => "Editar hito";

  @override
  String get editTag => "Editar etiqueta";

  @override
  String get openTasks => "Abrir tareas";

  @override
  String get newPersonalNote => "Nueva nota personal";

  @override
  String get createNewPersonalNote => "Crear nota personal";

  @override
  String get filterBy => "Filtrar por";

  @override
  String hereStartsYourMessagesWith(String name) =>
      "Aquí comienza tus mensajes con @$name";

  @override
  String thisChannelIsManagedBy(String name) =>
      "Este canal es administrado por @$name, si necesitas ayuda contacta al administrador.";

  @override
  String newPush(String user, String repository, String repositoryUrl) {
    String part1 = "Nuevo push de";
    String part2 = "en el repositorio";
    String part3 = "Detalle";

    return "<p>$part1 <span class='link-mention'>@$user</span> $part2 <span><a href='$repositoryUrl'>$repository. $part3</a></span></p>";
  }

  @override
  String unassignedTask(
    String repository,
    String repositoryUrl,
  ) {
    String part1 = "Tarea sin asignar en el repositorio";
    String part2 = "Detalle";
    return "<p>$part1 <a href='$repositoryUrl'>$repository. $part2</a></p>";
  }

  @override
  String cardTrelloCreate(
      String board, String boardUrl, String card, String cardUrl, String list) {
    String part1 = "Se ha creado la tarjeta";
    String part2 = "en la lista";
    String part3 = "del tablero";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 $list $part3 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloRename(String board, String boardUrl, String oldName,
      String newName, String list) {
    String part1 = "En la lista";
    String part2 = "del tablero";
    String part3 = "se ha renombrado la tarjeta";
    String part4 = "a";
    return "<p>$part1 '$list' $part2 <a href='$boardUrl'>$board</a> $part3 '$oldName' $part4 '$newName'</p>";
  }

  @override
  String cardTrelloDescriptionChange(String board, String boardUrl, String card,
      String cardUrl, String list, String description) {
    String part1 = "La tarjeta";
    String part2 = "de la lista";
    String part3 = "del tablero";
    String part4 = "ha cambiado su descripcion a";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4 '$description'</p>";
  }

  @override
  String cardTrelloMoveToOtherList(String board, String boardUrl, String card,
      String cardUrl, String oldList, String newList) {
    String part1 = "La tarjeta";
    String part2 = "se ha movido de la lista";
    String part3 = "a la lista";
    String part4= "en el tablero";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$oldList' $part3 '$newList' $part4 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloArchive(String board, String boardUrl, String card,
      String cardUrl, String list) {
    String part1 = "La tarjeta";
    String part2 = "de la lista";
    String part3 = "del tablero";
    String part4 = "ha sido archivada";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4</p>";
  }

  @override
  String get comments => "Comentarios";

  @override
  String get addComment => "Adicionar comentario";

  @override
  String get editComment => "Actualizar comentario";

  @override
  String get downloadAppsAndSynchronizer =>
      "<a href = 'https://noysi.com/a/#/downloads'>¡DESCARGA YA LAS APPS!</a>";

  @override
  String get welcomeToNoysiFirstName =>
      "¡Te damos la bienvenida! Este es tu canal personal, no lo verá nadie más que tú, no tiene comunicación con nadie, es tu canal personal para que dejes notas personales y subas archivos que nadie más verá. ¿Cuál es tu nombre?";

  @override
  String get welcomeToNoysiTimeout =>
      "¡No me has contestado! Si necesitas ayuda haz click <a href='${Endpoint.helpUrl}'>aquí.</a>";

  @override
  String get wrongUsernamePassword =>
      "Nombre de Usuario o Contraseña incorrecto";

  @override
  String get userInUse => "Este usuario ya se encuentra en uso";

  @override
  String get invite => "Invitar";

  @override
  String get groupRequired => "Grupo requerido";

  @override
  String get uploading => "Subiendo";

  @override
  String get downloading => "Descargando";

  @override
  String get inviteGuestsWarning =>
      "Los invitados solo se unirán a un grupo en este equipo";

  @override
  String get addMembers => "Agregar miembros";

  @override
  String get enterEmailsByComma => "Introduce los correos separados por coma.";

  @override
  String get firstName => "Primer nombre";

  @override
  String get inviteFewMorePersonal => "Invita a uno y sé más personal";

  @override
  String get inviteManyAtOnce => "Invita varios a la vez";

  @override
  String get addGuests => "Agregar invitados";

  @override
  String get followThread => "Seguir este Hilo";

  @override
  String get markThreadAsRead => "Marcar como leído";

  @override
  String get stopFollowingThread => "Dejar de seguir este hilo";

  @override
  String get needToVerifyAccountToInvite =>
      "Es necesario verificar la cuenta para invitar nuevos miembros o invitados.";

  @override
  String get createANewTeam => "Crear un nuevo equipo";

  @override
  String get createNewTeam => "Crear nuevo equipo!";

  @override
  String get enterIntoYourAccount => "Entra en tu cuenta";

  @override
  String get forgotPassword => "Olvidaste tu contraseña?";

  @override
  String get goAhead => "Vamos!";

  @override
  String get passwordRestriction =>
      "La contraseña debe tener al menos ocho caractéres incluyendo un número, una letra mayúscula y una minúscula, puedes usar caractéres especiales como @#\$%^&+= y diez o más caractéres para mejorar la seguridad de tu contraseña.";

  @override
  String get recoverYorPassword => "Recuperar contraseña";

  @override
  String get recoverYorPasswordWarning =>
      "Para restaurar la contraseña, introduzca el correo que usa para noysi.com";

  @override
  String recoverPasswordResponse(String email) {
    return "Te hemos envíado un correo a $email";
  }

  @override
  String get recoverPasswordResponse1 =>
      "Por favor chequea tu bandeja de entrada y sigue las instrucciones para cambiar la contraseña";

  @override
  String get continueStr => "Seguir";

  @override
  String get passwordAtLeast1SpecialChar =>
      "La contraseña debe incluir al menos 1 caracter especial @#\$%^&+=";

  @override
  String welcomeToNoysiLastName(String name) =>
      "Hola $name. ¿Cuál es tu apellido?";

  @override
  String get welcomeToNoysiDescription =>
      "Muy bien. Todo está correcto. Voy a proceder a actualizar tu perfil.";

  @override
  String get welcomeToNoysiInvite =>
      "<a href = '#'>¡Invita ya a los miembros de tu equipo!</a>";

  @override
  String get activeFilter => "Filtro activo";

  @override
  String get newFileComment => "Nuevo comentario en el fichero";

  @override
  String get removed => "Eliminado";

  @override
  String get sharedOn => "Compartido en";

  @override
  String get notifyAllInThisChannel => "notificar a todos en este canal";

  @override
  String get notifyAllMembers => "notificar a todos los miembros";

  @override
  String get keepPressingToRecord => "Mantén presionando el botón para grabar";

  @override
  String get slideToCancel => "Desliza para cancelar";

  @override
  String get chooseASecurePasswordText => "Elige una contraseña suficientemente segura y que puedas recordar";

  @override
  String get confirmPassword => "Confirmar contraseña";

  @override
  String get yourPassword => "Tu contraseña";

  @override
  String get passwordDontMatch => "Las contraseñas no coinciden";

  @override
  String get changeCreateTeamMail => "No, quiero cambiar el email";

  @override
  String step(int number) => "Paso $number";

  @override
  String get user => "Usuario";

  @override
  String get calendar => "Calendario";

  @override
  String get week => "Semana";

  String get deleteFolderWarning => "La carpeta se eliminará permanentemente y no podrá ser recuperada. La carpeta será inaccesible desde cualquier enlace.";

  @override
  String get folderIsNotInCurrentTeam => "La carpeta no esta asociada al Equipo actual";

  @override
  String get folderIsNotInAvailableChannel => "La carpeta a la que se hace referencia no se encuentra en un canal disponible en el explorador de archivos";

  @override
  String get folderLinked => "Se ha copiado el enlace de la carpeta en el canal";

  @override
  String get folderShared => "Se ha compartido la carpeta en el canal";

  @override
  String get folderUploaded => "Se ha subido la carpeta al canal";

  @override
  String get folderNotFound => "Carpeta no encontrada";

  @override
  String get folderNameIncorrect => "El nombre de la carpeta no es válido";

  @override
  String get cloneFolder => "Clonar carpeta";

  @override
  String get cloneFolderInfo => "Al clonar una carpeta se crea una nueva carpeta en el canal destino con el mismo estado y contenido de la carpeta seleccionada en este instante de tiempo.";

  @override
  String get folderDeleted => "No se puede acceder a una carpeta eliminada";

  @override
  String get youWereInADeletedFolder => "La carpeta en la que se encontraba fue eliminada";

  @override
  String get dateFormat6 => "MM/dd/yyyy";

  @override
  String get createdTask => "Tarea Creada";

  @override
  String get loggedIn => "Sesión Iniciada";

  @override
  String get mention => "Mención";

  @override
  String get messageSent => "Mensaje Enviado";

  @override
  String get taskAssigned => "Tarea Asignada";

  @override
  String get taskUnassigned => "Tarea Desasignada";

  @override
  String get uploadedFile => "Archivo Subido";

  @override
  String get uploadedFileFolder => "Archivo/Carpeta Subido";

  @override
  String get uploadedFolder => "Carpeta Subida";

  @override
  String get downloadedFile => "Archivo Descargado";

  @override
  String get downloadedFileFolder => "Archivo/Carpeta Descargado";

  @override
  String get downloadedFolder => "Carpeta Descargada";

  @override
  String get messageUnavailable => "Mensaje no disponible";

  @override
  String get activityZone => "Zona de Actividad";

  @override
  String get categories => "Categorias";

  @override
  String get category => "Categoría";

  @override
  String get clearAll => "Limpiar Todo";

  @override
  String get errorFetchingData => "Error obteniendo datos";

  @override
  String get filters => "Filtros";

  @override
  String get openSessions => "Sesiones Abiertas";

  @override
  String activityFileFolderUploadedDownloaded(String user, String name, String channel, {bool download = false, bool isDirect = false, isFolder = false}) {
    String part1 = "Has ${download ? "descargado" : "subido"}${isFolder ? " la carpeta " : " el archivo "}";
    String part2 = download ? "del canal" : "en el canal";
    return "$part1 <i class=\"mention-generic\">$name</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMentioned(String user, String channel, {bool isDirect = false}) {
    String part1 = "Has sido mencionado en el canal";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMessageSent(String user, String channel, {bool isDirect = false}) {
    String part1 = "Has enviado un mensaje en el canal";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activitySignedIn(String sessionInfo, String ip) {
    return "Has iniciado sesión en <i class=\"mention-generic\">$sessionInfo</i> IP: <i class=\"mention-generic\">$ip</i>";
  }

  @override
  String activityTaskAssigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Has sido asignado a la tarea";
    String part2 = "en el canal";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskCreated(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Has creado la tarea";
    String part2 = "en el canal";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskUnassigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Has sido desasignado de la tarea";
    String part2 = "en el canal";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String get activityZoneHeader => "Aquí comienza la Zona de Actividad.";

  @override
  String get selectEvent => "Seleccione evento";

  @override
  String get googleCalendar => "Google";

  @override
  String get outlookCalendar => "Outlook";

  @override
  String get noysiCalendar => "Noysi";

  @override
  String get autogenerateRoomNameQuestion => "¿Desea generar el nombre de la sala automáticamente?";

  @override
  String get createMeetingEvent => "Crear Evento-Reunión";

  @override
  String get externalGuests => "Invitados externos";

  @override
  String get internalGuests => "Invitados internos";

  @override
  String get newMeetingEvent => "Nuevo Evento-Reunión";

  @override
  String get roomName => "Nombre de la sala";

  @override
  String get eventMeeting => "Evento-Reunión";

  @override
  String get personalNote => "Nota Personal";

  @override
  String get updateExternalGuests => "Actualizar Invitados externos";

  @override
  String get nameTextWarning => "El texto corresponde a una cadena alfanumérica de 1-25 caracteres. También puedes usar espacios y los caracteres _ -";

  @override
  String get nameTextWarningWithoutSpaces => "El texto corresponde a una cadena alfanumérica de 1-18 caracteres sin espacios. También puedes usar los caracteres _ -";

  @override
  String get today => "Hoy";

  @override
  String get location => "Lugar";

  @override
  String get sessions => "Sesiones";

  @override
  String get appVersion => "Versión App";

  @override
  String get browser => "Navegador";

  @override
  String get device => "Dispositivo";

  @override
  String get logout => "Cerrar Sesión";

  @override
  String get manufacturer => "Fabricante";

  @override
  String get no => "No";

  @override
  String get operativeSystem => "Sistema Operativo";

  @override
  String get yes => "Sí";

  @override
  String get allDay => "Todo el día";

  @override
  String get endDate => "Fecha de fin";

  @override
  String get noTitle => "Sin Título";

  @override
  String get currentSession => "Sesión Actual";

  @override
  String get logOutAllExceptForThisOne => "Cerrar sesión en todos los dispositivos excepto este.";

  @override
  String get terminateAllOtherSessions => "Cerrar todas las demás sesiones";

  @override
  String get closeAllSessionsConfirmation => "¿Quieres cerrar todas las demás sesiones?";

  @override
  String get closeSessionConfirmation => "¿Quires cerrar la sesión?";

  @override
  String get connectionLost => "Vaya, parece que no hay conexión";

  @override
  String get connectionEstablished => "Estás de vuelta en línea";

  @override
  String get connectionStatus => "Estado de conexión";

  @override
  String get anUserIsCalling => "Un usuario te está llamando...";

  @override
  String get answer => "Responder";

  @override
  String get hangDown => "Colgar";

  @override
  String get incomingCall => "Llamada Entrante";

  @override
  String isCallingYou(String user) => "$user te está llamando...";

  @override
  String get callCouldNotBeInitialized => "La llamada no pudo ser iniciada";

  @override
  String get sentMessages => "Mensajes Enviados";

  @override
  String sentMessagesCount(String count) => "$count de 10000";

  @override
  String get teamDataUsage => "Uso de Datos del equipo";

  @override
  String get usedStorage => "Almacenamiento utilizado";

  @override
  String usedStorageText(String used) => used + "GB de 5GB";

  @override
  String get userDataUsage => "Mi Uso de datos";

  @override
  String get audioEnabled => "Habilitar Audio";

  @override
  String get meetingOptions => "Opciones de Reunión";

  @override
  String get videoEnabled => "Habilitar Video";

  @override
  String get dontShowThisMessage => "No volver a mostrar";

  @override
  String get showDialogEveryTime => "Mostrar diálogo cada vez que comienza una reunión";

  @override
  String get micAndCameraRequiredAlert => "Los permisos de acceso a cámara y micrófono son requeridos, por favor, asegúrese de haber otorgado los permisos necesarios. ¿Desea ir a los ajustes de permisos?";

  @override
  String get connectWith => "Accede con";

  @override
  String get or => "o";

  @override
  String get noEvents => "No hay eventos, tareas o notas personales";

  @override
  String get viewDetails => "Ver detalles";

  @override
  String zendeskTicketUpdated(String user, String status, String type, String title, String url) {
    String part1 = R.string.user;
    String part2 = "actualizó el ticket";
    String part3 = "de tipo";
    String part4 = "al estado";
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
  String get editTeam => "Editar equipo";

  @override
  String get general => "General";

  @override
  String get integrations => "Integraciones";

  @override
  String get noRecents => "No hay recientes";

  @override
  String get noRecommendations => "No hay recomendaciones";

  @override
  String get inAMeeting => "Reunido";

  @override
  String get onFire => "On Fire";

  @override
  String get plans => "Planes";

  @override
  String get setAStatus => "Establecer un estado";

  @override
  String get sick => "Enfermo";

  @override
  String get signOut => "Cerrar Sesión";

  @override
  String get suggestions => "Sugerencias";

  @override
  String get teams => "Equipos";

  @override
  String get traveling => "De Viaje";

  @override
  String get whatsYourStatus => "¿Cuál es tu estado?";

  @override
  String get sendAlwaysAPush => "Enviar siempre una notificación push";

  @override
  String get robot => "Robot";

  @override
  String get deactivateUserWarning => "Los integrantes del equipo no podrán comunicarse con un miembro mientras está desactivado. Sin embargo, toda la actividad que haya realizado el miembro desactivado en Noysi permanecerá intacta y serán accesibles los mensajes (canales abiertos, mensajes 1 a 1 y grupos privados), los archivos y tareas.";

  @override
  String get activateUserWarning => "Una vez el miembro sea reactivado, recuperará el acceso a los mismos canales, grupos, archivos y tareas que tenía antes de ser desactivado.";

  @override
  String get changeRole => "Cambiar rol";

  @override
  String get userStatus => "Estado de usuario";

  @override
  String get deactivateMyAccount => "Desactivar mi cuenta";

  @override
  String get deactivateMyAccountWarning => "Si desactivas tu cuenta esto ocurrirá en todos tus equipos, conversaciones, ficheros, tareas,y cualquier otra actividad que hayas tenido en Noysi hasta que un administrador te reactive de nuevo.";

  @override
  String get deactivateMyUserInThisTeam => "Desactivar mi usuario en este equipo";

  @override
  String get deactivateMyUserInThisTeamWarning => "Cuando te desactivas en un equipo todo lo que tienes en él se mantendrá hasta que vuelvas a ser activado. Si eres el único administrador del equipo éste no será eliminado.";

  @override
  String get operationConfirmation => "Está seguro de esta operación?";

  @override
  String get formatNotSupported => "Este formato o extensión no es soportada por el Sistema Operativo";

  @override
  String get invitePrivateGroupLink => "Invitar a este grupo usando el link";

  @override
  String get invalidPhoneNumber => "Número no válido";

  @override
  String get searchByCountryName => "Buscar por nombre o código del país";

  @override
  String get kick => "Expulsar";

  @override
  String get deleteAll => "Eliminar Todos";

  @override
  String get enterKeyManually => "Ingresar clave manualmente";

  @override
  String get noysiAuthenticator => "Autenticador Noysi";

  @override
  String get qrScanner => "QR";

  @override
  String get otpLabelWarning => "La etiqueta OTP es una cadena alfanumérica sin espacios :@.,;()\$% también se permite";

  @override
  String get invalidBase32Chars => "Caracteres base32 no válidos";

  @override
  String get label => "Etiqueta";

  @override
  String get secretCode => "Clave secreta";

  @override
  String get labelTextWarning => "La etiqueta está vacía, compruebe este valor";

  @override
  String missedCallFrom(String user) => "Llamada perdida de $user";

  @override
  String get activeItemBackgroundColor => "Fondo de objeto activo";

  @override
  String get activeItemTextColor => "Texto de objeto activo";

  @override
  String get activePresenceColor => "Presencia activa";

  @override
  String get adminsCanDeleteMessage => "Admins pueden borrar mensajes";

  @override
  String get allForAdminsOnly => "@all solo para admins";

  @override
  String get channelForAdminsOnly => "@channel solo para admins y creadores del canal";

  @override
  String get chooseTheme => "Escoge un tema para tu equipo";

  @override
  String get enablePushAllChannels => "Habilitar notificaciones en todos los canales";

  @override
  String get inactivePresenceColor => "Presencia inactiva";

  @override
  String get leaveTeam => "Abandonar este equipo";

  @override
  String get leaveTeamWarning => "Cuando abandonas un equipo todos tus datos en ese equipo son eliminados. Si eres el único administrador el equipo será eliminado.";

  @override
  String get notificationBadgeBackgroundColor => "Fondo de indicador";

  @override
  String get notificationBadgeTextColor => "Texto de indicador";

  @override
  String get onlyAdminInvitesAllowed => "Invitados permitidos solo por admins";

  @override
  String get reset => "Resetear";

  @override
  String get settings => "Ajustes";

  @override
  String get sidebarColor => "Color de barra lateral";

  @override
  String get taskUpdateProtected => "Modificación de tareas solo para creadores y admins";

  @override
  String get teamName => "Nombre de equipo";

  @override
  String get textColor => "Color de texto";

  @override
  String get theme => "Tema";

  @override
  String get updateUsernameBlocked => "Bloquear nombre de usuario cuando se envía la invitación";

  @override
  String get fileNotFound => "Archivo no encontrado";

  @override
  String get messageNotFound => "Mensaje no encontrado, por favor revise si el mensaje que busca se encuentra disponible en el equipo actual.";

  @override
  String get taskNotFound => "Tarea no encontrada";

  @override
  String userHasPinnedMessage(String name) => "$name ha anclado un mensaje al canal";

  @override
  String userHasUnpinnedMessage(String name) => "$name ha descanclado el mensaje del canal";

  @override
  String get pinMessage => "Anclar mensaje";

  @override
  String get unpinMessage => "Desanclar mensaje";

  @override
  String get pinnedMessage => "Mensaje anclado";

  @override
  String get deleteMyAccount => "Eliminar mi cuenta";

  @override
  String get yourDeleteRequestIsInProcess => "Su solicitud de eliminación de cuenta está en proceso";

  @override
  String get deleteMyAccountWarning => "Si elimina su cuenta la acción será irreversible. Si administra un equipo y no existe otro administrador, el equipo será eliminado.";

  @override
  String get lifetimeDeal => "Ofertas de por Vida";

  @override
  String get showEmails => "Mostrar dirección de correos de usuarios";

  @override
  String get showPhoneNumbers => "Mostrar número de teléfono de usuarios";

  @override
  String get addChannel => "Agregar Canal";

  @override
  String get addPrivateGroup => "Agregar Grupo Privado";

  @override
  String get selectUserFromTeam => "Seleccionar usuario de este equipo";

  @override
  String get selectUsersFromChannelGroup => "Seleccionar usuarios de un canal o grupo";

  @override
  String get memberDeleted => "Usuario eliminado";
}

import 'dart:ui';
import 'package:code/_res/values/config.dart';
import 'package:code/_res/values/text/strings_base.dart';

import '../../../data/api/remote/endpoints.dart';
import '../../R.dart';


class StringsPt implements StringsBase {
  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Noysi";

  @override
  String get yourTeams => "Seus times";

  @override
  String get channel => "Canal";

  @override
  String get channels => "Canais";

  @override
  String get directMessagesAbr => "DMs";

  @override
  String get email => "O email";

  @override
  String get home => "Casa";

  @override
  String get member => "Membro";

  @override
  String get administrator => "Administrador";

  @override
  String get guest => "Hóspede";

  @override
  String get guests => "Convidados";

  @override
  String get members => "Membros";

  @override
  String get inactiveMember => "Membro desativado";

  @override
  String get message => "mensagem";

  @override
  String get messages => "Mensagens";

  @override
  String get password => "Senha";

  @override
  String get register => "inscrever-se";

  @override
  String get search => "Pesquisa";

  @override
  String get signIn => "assinar em";

  @override
  String get task => "Tarefa";

  @override
  String get tasks => "Tarefas";

  @override
  String get createTask => "Criar Tarefa";

  @override
  String get newTask => "Nova tarefa";

  @override
  String get description => "Descrição";

  @override
  String get team => "Equipe";

  @override
  String get thread => "Fio";

  @override
  String get threads => "Tópicos";

  @override
  String get createTeam => "Criar equipe";

  @override
  String get confirmIsCorrectEmailAddress => "Sim! Esse é o e-mail correto";

  @override
  String get createTeamIntro =>
      "Você está prestes a montar sua nova equipe na Noysi.";

  @override
  String get isCorrectEmailAddress => "Este é o endereço de e-mail correto?";

  @override
  String get welcome => "Bem-vinda!";

  @override
  String get invitationSentAt => "Seu convite será enviado em:";

  @override
  String get next => "Próximo";

  @override
  String get startNow => "Comece agora!";

  @override
  String get charsRemaining => "Caracteres restantes:";

  @override
  String get teamNameOrgCompany =>
      "Digite o nome da equipe, organização ou nome da empresa.";

  @override
  String get teamNameOrgCompanyLabel => "Ex. Nome da minha empresa";

  @override
  String get yourTeam => "Seu time";

  @override
  String get noysiServiceNewsletters =>
      "É normal receber (muito ocasionalmente) emails sobre o serviço NOYSI.";

  @override
  String get userNameIntro =>
      "Seu nome de usuário é como você aparece para os outros membros de sua equipe.";

  @override
  String get userNameLabel => "Ex. Ackerman";

  @override
  String get addAnother => "Adicionar outro";

  @override
  String get byProceedingAcceptTerms =>
      "* Ao continuar, você aceita nossos <b> Termos de serviço </b>";

  @override
  String get invitations => "Convites";

  @override
  String get invitePeople => "Convidar pessoas";

  @override
  String get noysiIsTeamWorkInvite =>
      "Noysi é uma ferramenta de trabalho em equipe. Convide pelo menos uma pessoa";

  @override
  String get userName => "Nome do usuário";

  @override
  String get fieldMax18 => "18 caracteres no máximo";

  @override
  String get fieldMax25 => "25 caracteres no máximo";

  @override
  String get fieldPassword => "Senha requerida";

  @override
  String get fieldRequired => "Campo requerido";

  @override
  String get missingEmailFormat => "E-mail errado";

  @override
  String get back => "Costas";

  @override
  String get channelBrowser => "Navegador de canal";

  @override
  String get help => "Socorro";

  @override
  String get preferences => "Preferências";

  @override
  String get signOutOf => "Sair de";

  @override
  String get closed => "Fechadas";

  @override
  String get closedMilestone => "Fechadas";

  @override
  String get close => "Fechar";

  @override
  String get opened => "Aberto";

  @override
  String get chat => "Bate-papo";

  @override
  String get allThreads => "Todos os tópicos";

  @override
  String get inviteMorPeople => "Convide mais pessoas";

  @override
  String get meeting => "encontro";

  @override
  String get myFiles => "Meus arquivos";

  @override
  String get myTasks => "Minhas tarefas";

  @override
  String get myTeams => "Minhas equipes";

  @override
  String get openChannels => "Canais abertos";

  @override
  String get privateGroups => "Grupos privados";

  @override
  String get favorites => "Favoritos";

  @override
  String get message1x1 => "Mensagens 1 a 1";

  @override
  String get acceptedTitle => "Aceitaram";

  @override
  String get date => "Encontro";

  @override
  String get invitationLanguageTitle => "Idioma";

  @override
  String get invitationMessage => "Mensagem de convite";

  @override
  String get revokeInvitation => "Revogar convite";

  @override
  String get revoke => "Revogar";

  @override
  String get revokeInvitationWarning =>
      "Cuidado, esta ação não é reversível";

  @override
  String get revokeInvitationDelete => "Apagar convite";

  @override
  String get resendInvitationBefore24hrs =>
      "O reenvio do convite não é permitido até 24 horas após o último envio.";

  @override
  String get resendInvitationSuccess => "Convites enviados com sucesso.";

  @override
  String get resendInvitation => "Reenviar convite";

  @override
  String get invitationMessageDefault =>
      "Oi! Aqui você tem um convite para entrar";

  @override
  String get inviteManyAsOnce => "Convide muitos de uma vez";

  @override
  String get inviteMemberTitle =>
      "Os membros da equipe têm acesso total a canais abertos, mensagens pessoa a pessoa e grupos.";

  @override
  String get inviteMemberWarningTitle =>
      "Para convidar novos membros, você deve ser o administrador da equipe.";

  @override
  String get inviteNewMemberWarningTitle =>
      "Qualquer membro da equipe pode adicionar convidados sem limites.";

  @override
  String get inviteSubtitle =>
      "O Noysi é uma ferramenta para trabalhar melhor com sua equipe. Convide-os agora!";

  @override
  String get inviteTitle => "Convide outras pessoas";

  @override
  String get inviteToAGroup => "Convidar para um grupo (obrigatório)";

  @override
  String get inviteToAGroupNotRequired => "Convidar para um grupo (opcional)";

  @override
  String get inviteMemberWarning =>
      "Novos membros entrarão no canal #general automaticamente. Opcionalmente, você também pode adicioná-los a um grupo privado agora.";

  @override
  String get inviteToThisTeam => "Convidar para esta equipe";

  @override
  String get invitationsSent => "Convites enviados";

  @override
  String get name => "Nome";

  @override
  String get noPendingInvitations =>
      "Não há convites para enviar nesta equipe.";

  @override
  String get pendingTitle => "Pendente";

  @override
  String get chooseTitle => "Escolher";

  @override
  String get seePendingAcceptedInvitations =>
      "Ver convites pendentes e aceitos";

  @override
  String get sendInvitations => "Enviar convites";

  @override
  String get typeEmail => "Digite um e-mail";

  @override
  String get typeEmailComaSeparated => "Digite e-mails separados por vírgulas";

  @override
  String get atNoysi => "em Noysi";

  @override
  String get inviteNewMemberTitle =>
      "Os convidados não pagam e você pode convidar quantos quiser, mas eles só terão acesso a um grupo dentro desta equipe.";

  @override
  String get invited => "Convidamos";

  @override
  String get thisNameAlreadyExist =>
      "Parece que este nome já está em uso.";

  @override
  String get emptyList => "Lista vazia";

  @override
  String get ok => "Está bem";

  @override
  String get byNameFirst => "Por nome A-Z";

  @override
  String get byNameInvertedFirst => "Por nome Z-A";

  @override
  String get download => "Baixar";

  @override
  String get files => "arquivos";

  @override
  String get folders => "Pastas";

  @override
  String get newTitle => "Novo";

  @override
  String get newestFirst => "Os mais novos primeiro";

  @override
  String get oldestFirst => "Mais velhos primeiro";

  @override
  String get see => "Vejo";

  @override
  String get share => "Compartilhar";

  @override
  String get moreInfo => "Mais Informações";

  @override
  String get assigned => "Atribuído";

  @override
  String get author => "Autor";

  @override
  String get created => "Criado";

  @override
  String get earlyDeliverDate => "Data de entrega antecipada";

  @override
  String get farDeliverDate => "Data de entrega distante";

  @override
  String get filterAuthor => "Filtrar por autor";

  @override
  String get searchUsers => "Usuários de pesquisa";

  @override
  String get sort => "Ordenar";

  @override
  String get sortBy => "Ordenar por";

  @override
  String get cancel => "Cancelar";

  @override
  String get exit => "Saída";

  @override
  String get exitWarning => "Você tem certeza?";

  @override
  String get deleteChannelWarning =>
      "Tem certeza de que deseja sair deste canal?";

  @override
  String get typeMessage => "Digite uma mensagem...";

  @override
  String get addChannelToFavorites => "Adicionar aos favoritos";

  @override
  String get removeFromFavorites => "Remover dos favoritos";

  @override
  String get channelInfo => "Informação do canal";

  @override
  String get channelMembers => "Membros do canal";

  @override
  String get channelPreferences => "Preferências de canal";

  @override
  String get closeChatVisibility => "Fechar 1 para 1";

  @override
  String get inviteToGroup => "Convide um membro para este canal";

  @override
  String get leaveChannel => "Sair do canal";

  @override
  String get mentions => "Menções";

  @override
  String get seeFiles => "Ver arquivos";

  @override
  String get seeLinks => "Veja os links";

  @override
  String get links => "Links";

  @override
  String get taskManager => "Gerenciador de tarefas";

  @override
  String get videoCall => "Video chamada";

  @override
  String get addReaction => "Adicionar reação";

  @override
  String get addTag => "Adicionar etiqueta";

  @override
  String get addMilestone => "Adicionar marco";

  @override
  String get copyMessage => "Copiar mensagem";

  @override
  String get copyPermanentLink => "Link de cópia";

  @override
  String get createThread => "Iniciar um tópico";

  @override
  String get edit => "Editar";

  @override
  String get favorite => "Favorito";

  @override
  String get remove => "Remover";

  @override
  String get tryAgain => "Tente novamente";

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
      "Você tem certeza que quer deletar esta mensagem? Isto não pode ser desfeito.";

  @override
  String get deleteMessageTitle => "Apagar mensagem";

  @override
  String get edited => "Editado";

  @override
  String get seeAll => "Ver tudo";

  @override
  String get copiedToClipboard => "Copiado para a área de transferência!";

  @override
  String get underConstruction => "Em construção";

  @override
  String get reactions => "Reações";

  @override
  String get all => "Todos";

  @override
  String get users => "Comercial";

  @override
  String get documents => "Documentos";

  @override
  String get fromLocalStorage => "Do armazenamento local";

  @override
  String get photoGallery => "galeria de fotos";

  @override
  String get recordVideo => "Gravar um video";

  @override
  String get takePhoto => "Tire uma foto";

  @override
  String get useCamera => "Da câmera";

  @override
  String get videoGallery => "Galeria de vídeo";

  @override
  String get changeName => "Mude o nome";

  @override
  String get createFolder => "Criar pasta";

  @override
  String get createNameWarning =>
      "Os nomes devem ter no máximo 18 caracteres, sem sinais de pontuação.";

  @override
  String get newName => "Novo nome";

  @override
  String get rename => "Renomear";

  @override
  String get renameFile => "Renomear arquivo";

  @override
  String get renameFolder => "Renomear pasta";

  @override
  String get deleteFile => "Excluir arquivo";

  @override
  String get deleteFolder => "Excluir pasta";

  @override
  String get deleteFileWarning => "A pasta será excluída permanentemente e não pode ser recuperada. A pasta ficará inacessível a partir de qualquer link.";

  @override
  String get delete => "Excluir";

  @override
  String get open => "Abrir";

  @override
  String get addCommentOptional => "Adicionar comentário (opcional)";

  @override
  String get shareFile => "Compartilhar arquivo";

  @override
  String get groups => "Grupos";

  @override
  String get to1_1 => "1 para 1";

  @override
  String get day => "dia";

  @override
  String get days => "Dias";

  @override
  String get hour => "hora";

  @override
  String get hours => "horas";

  @override
  String get minute => "minuto";

  @override
  String get minutes => "minutos";

  @override
  String get month => "Mês";

  @override
  String get months => "Meses";

  @override
  String get year => "ano";

  @override
  String get years => "anos";

  @override
  String get by => "por";

  @override
  String get deliveryDateIn => "Data de vencimento em";

  @override
  String get ago => "Atrás";

  @override
  String get taskOpened => "Aberto";

  @override
  String get assignees => "Cessionários";

  @override
  String get assigneeBy => "Assinado por";

  @override
  String get closeTask => "Fechar tarefa";

  @override
  String get comment => "Comente";

  @override
  String get deliveryDate => "Data de Vencimento";

  @override
  String get leaveAComment => "Deixe um comentário";

  @override
  String get milestone => "Marco histórico";

  @override
  String get milestones => "Milestones";

  @override
  String get color => "Cor";

  @override
  String get milestoneAdded => "Adicionado ao marco";

  @override
  String get participants => "Participantes";

  @override
  String get reopen => "Reabrir";

  @override
  String get completed => "Concluído";

  @override
  String get dueDateUpdated => "Data de vencimento atualizada";

  @override
  String get dueDate => "Data de Vencimento";

  @override
  String get lastDueDate => "Última data de vencimento";

  @override
  String get commented => "Comentou";

  @override
  String get tagAdded => "Tag adicionada";

  @override
  String get tagRemoved => "Tag removida";

  @override
  String get tags => "Tag";

  @override
  String get update => "Atualizar";

  @override
  String get details => "Detalhes";

  @override
  String get timeline => "Linha do tempo";

  @override
  String get aboutMe => "Sobre mim";

  @override
  String get acceptNews => "Receber notícias";

  @override
  String get allActive => "Todos ativos";

  @override
  String get changePhoto => "Mudar foto";

  @override
  String get changeYourPassword => "Mude sua senha";

  @override
  String get changeYourPasswordAdvice =>
      "A senha deve ter pelo menos oito caracteres, incluindo um número, uma letra maiúscula e uma letra minúscula, você pode usar caracteres especiais como @ # \$% ^ & + = e dez ou mais caracteres para melhorar a segurança de sua senha";

  @override
  String get charge => "Carregar";

  @override
  String get country => "País";

  @override
  String get disabled => "Desativado";

  @override
  String get emailNotification => "Notificações de email";

  @override
  String get language => "Língua";

  @override
  String get lastName => "Último nome";

  @override
  String get maxEveryHour => "Toda hora";

  @override
  String get maxHalfDay => "A cada 12 horas";

  @override
  String get messages1x1AndMentions => "Mensagens 1x1 e @ menções";

  @override
  String get myProfile => "Meu perfil";

  @override
  String get never => "Nunca";

  @override
  String get newPassword => "Nova senha";

  @override
  String get newsLetters => "Boletins informativos";

  @override
  String get notReceiveNews => "Não receba notícias";

  @override
  String get notifications => "Notificações";

  @override
  String get passwordRequirements =>
      "Altere sua senha periodicamente para aumentar sua segurança e proteção";

  @override
  String get phoneNotifications => "Notificações de telefone";

  @override
  String get phoneNumber => "Número de telefone";

  @override
  String get photoSizeRestrictions =>
      "Use uma foto quadrada com largura máxima de 400 px (pequena)";

  @override
  String get repeatNewPassword => "Repita a nova senha";

  @override
  String get security => "Segurança";

  @override
  String get skypeUserName => "Usuário Skype";

  @override
  String get sounds => "Sons";

  @override
  String get yourUserName => "Seu nome de usuário";

  @override
  String get saveChanges => "Salvar alterações";

  @override
  String get profileEmailUsesWarning =>
      "Este e-mail é usado apenas para notificações desta equipe.";

  @override
  String get pushMobileNotifications => "Push mobile notificações";

  @override
  String get saveNotificationChanges => "Salvar alterações de notificação";

  @override
  String get updatePassword => "Atualizar senha";

  @override
  String get updateProfileInfo => "Atualizar informações de perfil";

  @override
  String get password8CharsRequirement =>
      "A senha deve ter pelo menos 8 caracteres.";

  @override
  String get passwordAtLeast1CapitalLetter =>
      "A senha deve conter pelo menos 1 letra maiúscula.";

  @override
  String get passwordAtLeast1LowerCaseLetter =>
      "A senha deve conter pelo menos 1 letra minúscula.";

  @override
  String get passwordAtLeast1Number =>
      "A senha deve conter pelo menos 1 número.";

  @override
  String get passwordMustMatch => "A senha deve corresponder.";

  @override
  String get notificationUpdatedSuccess => "Alterações de notificação atualizadas.";

  @override
  String get passwordUpdatedSuccess => "Senha atualizada.";

  @override
  String get profileUpdatedSuccess => "perfil atualizado";

  @override
  String get enablePermissions => "Habilitar permissões";

  @override
  String get permissionDenied => "Permissão negada";

  @override
  String get savePreferences => "Salvar preferências";

  @override
  String get turnOffChannelEmails => "Não receba e-mails do canal";

  @override
  String get turnOffChannelSounds => "Desligue os sons do canal";

  @override
  String get chatMessageUnavailable =>
      "As mensagens de bate-papo não estão disponíveis para este usuário";

  @override
  String get createChannel => "Criar canal";

  @override
  String get createNewChannel => "Crie um novo canal";

  @override
  String get isTyping => "está digitando...";

  @override
  String get createPrivateGroup => "Criar Grupo Privado";

  @override
  String get createPrivateGroupWarning =>
      "Você vai criar um novo GRUPO, você pode adicionar pessoas a este grupo se elas já fizerem parte de sua equipe, se não, crie o grupo primeiro e convide-as depois.";

  @override
  String get createNewPrivateGroup => "Crie um novo grupo privado";

  @override
  String get createNewChannelAction =>
      "Você está prestes a criar um novo canal aberto.";

  @override
  String get createNewChannelForAdminsOnly => "Apenas administradores têm acesso para escrever.";

  @override
  String get openChannelAllMemberAccess => "Todos os membros da equipe têm acesso de leitura.";

  @override
  String get and => "E";

  @override
  String get userIsInactiveToChat =>
      "Você não pode bater papo com este usuário porque ele está inativo.";

  @override
  String get selectChannel => "Selecione o canal";

  @override
  String get needToSelectChannel => "Você precisa selecionar um canal";

  @override
  String get fileAlreadyShared =>
      "Este arquivo já está compartilhado com o mesmo nome no canal que você selecionou.";

  @override
  String get inChannel => "no canal";

  @override
  String seeAnswerMessages(int count) => "Vejo $count  mensagens";

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
    return "Do utilizador $name  entrou no canal";
  }

  @override
  String userHasLeft(String name) {
    return "Do utilizador $name  saiu do canal";
  }

  @override
  String invitedBy(String name) {
    return "Convidado por $name";
  }

  @override
  String get answers => "Respostas";

  @override
  String get publishIn => "publicar em";

  @override
  String get hasCommentedOnThread => "Comentou no tópico:";

  @override
  String get unReadMessages => "Mensagens não lidas";

  @override
  String get hasAddedTag => "Adicionou a tag";

  @override
  String get hasAssignedUser => "Atribuiu o usuário";

  @override
  String get hasClosedTask => "Fechou a tarefa";

  @override
  String get hasCommentedTask => "Adicionou um comentário";

  @override
  String get hasCreatedTask => "Criou a tarefa";

  @override
  String get hasCreatedTaskAssignedTo => "Criou uma nova tarefa atribuída a";

  @override
  String get hasDeleteTag => "Excluiu a tag";

  @override
  String get hasDeletedCommentTask => "Excluiu um comentário";

  @override
  String get hasEditedCommentTask => "Editou um comentário";

  @override
  String get hasEditedTask => "Editou a tarefa";

  @override
  String get hasRemovedEndDateTask => "Excluiu a data de término de";

  @override
  String get hasReopenedTask => "Reabriu a tarefa";

  @override
  String get hasSetMilestone => "Estabeleceu o marco";

  @override
  String get hasUnAssignedUser => "Cancelou a atribuição do usuário";

  @override
  String get hasUpdatedDateTask => "Atualizou a data de término de";

  @override
  String get inTheTask => "Na tarefa";

  @override
  String get to => "para";

  @override
  String get hasAssignedNewDueDateFor => "Atribuiu uma nova data de vencimento para";

  @override
  String get createNewTag => "Criar nova tag";

  @override
  String get createNewMilestone => "Crie um novo marco";

  @override
  String get editMilestone => "Editar marco";

  @override
  String get editTag => "Editar etiqueta";

  @override
  String get openTasks => "Tarefas abertas";

  @override
  String get newPersonalNote => "Nova nota pessoal";

  @override
  String get createNewPersonalNote => "Criar nota pessoal";

  @override
  String get filterBy => "Filtrar por";

  @override
  String hereStartsYourMessagesWith(String name) =>
      "Comece aqui suas mensagens com @$name";

  @override
  String thisChannelIsManagedBy(String name) =>
      "Este canal é administrado por @$name, se precisar de ajuda, entre em contato com o administrador.";

  @override
  String newPush(String user, String repository, String repositoryUrl) {
    String part1 = "Novo impulso de";
    String part2 = "no repositório";
    String part3 = "Detalhe";

    return "<p>$part1  <span class = 'link-mention'> @$user</span> $part2  <span> <a href = '$repositoryUrl'>$repository. $part3</a> </span> </p>";
  }

  @override
  String unassignedTask(
    String repository,
    String repositoryUrl,
  ) {
    String part1 = "Tarefa não atribuída no repositório";
    String part2 = "Detalhe";
    return "<p>$part1  <a href = '$repositoryUrl'>$repository. $part2</a> </p>";
  }

  @override
  String cardTrelloCreate(
      String board, String boardUrl, String card, String cardUrl, String list) {
    String part1 = "Cartão criado";
    String part2 = "na lista";
    String part3 = "de bordo";
    return "<p>$part1  <a href = '$cardUrl'>$card</a> $part2   $list   $part3  <a href = '$boardUrl'>$board</a> </p>";
  }

  @override
  String cardTrelloRename(String board, String boardUrl, String oldName,
      String newName, String list) {
    String part1 = "Na lista";
    String part2 = "do tabuleiro";
    String part3 = "o cartão foi renomeado";
    String part4 = "para";
    return "<p>$part1 '$list' $part2 <a href='$boardUrl'>$board</a> $part3 '$oldName' $part4 '$newName'</p>";
  }

  @override
  String cardTrelloDescriptionChange(String board, String boardUrl, String card,
      String cardUrl, String list, String description) {
    String part1 = "O cartão";
    String part2 = "da lista";
    String part3 = "do tabuleiro";
    String part4 = "mudou sua descrição para";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4 '$description'</p>";
  }

  @override
  String cardTrelloMoveToOtherList(String board, String boardUrl, String card,
      String cardUrl, String oldList, String newList) {
    String part1 = "O cartão";
    String part2 = "foi movido da lista";
    String part3 = "para a lista";
    String part4= "no quadro";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$oldList' $part3 '$newList' $part4 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloArchive(String board, String boardUrl, String card,
      String cardUrl, String list) {
    String part1 = "O cartão";
    String part2 = "da lista";
    String part3 = "do tabuleiro";
    String part4 = "foi arquivado";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4</p>";
  }

  @override
  String get comments => "Comentários";

  @override
  String get addComment => "Adicionar comentário";

  @override
  String get editComment => "Editar Comentário";

  @override
  String get downloadAppsAndSynchronizer =>
      "<a href ='https://noysi.com/a/#/downloads'>BAIXE OS APLICATIVOS AGORA!</a>";

  @override
  String get welcomeToNoysiFirstName => "Bem vinda! Este é o seu canal pessoal, ninguém mais verá, você não tem comunicação com ninguém, é o seu canal pessoal para você deixar notas pessoais e enviar arquivos que ninguém mais verá. Qual é o seu nome?";

  @override
  String get welcomeToNoysiTimeout =>
      "Você não me respondeu! Se precisar de ajuda, clique em <a href = '${Endpoint.helpUrl}'> aqui. </a>";

  @override
  String get wrongUsernamePassword => "Nome de usuário ou senha errada";

  @override
  String get userInUse => "Este usuário já está em uso";

  @override
  String get invite => "Convite";

  @override
  String get groupRequired => "Grupo necessário";

  @override
  String get uploading => "Enviando";

  @override
  String get downloading => "Baixando";

  @override
  String get inviteGuestsWarning => "Os convidados participam de apenas um grupo nesta equipe.";

  @override
  String get addMembers => "Adicionar membros";

  @override
  String get enterEmailsByComma =>
      "Insira os e-mails separando-os com vírgulas:";

  @override
  String get firstName => "Primeiro nome";

  @override
  String get inviteFewMorePersonal => "Convide alguns e seja mais pessoal";

  @override
  String get inviteManyAtOnce => "Convide muitos de uma vez";

  @override
  String get addGuests => "Adicionar convidados";

  @override
  String get followThread => "Siga este tópico";

  @override
  String get markThreadAsRead => "marcar como Lido";

  @override
  String get stopFollowingThread => "Pare de seguir este tópico";

  @override
  String get needToVerifyAccountToInvite =>
      "Você precisa verificar a conta de e-mail para convidar membros.";

  @override
  String get createANewTeam => "Crie uma nova equipe";

  @override
  String get createNewTeam => "Crie uma nova equipe!";

  @override
  String get enterIntoYourAccount => "Entre em sua conta";

  @override
  String get forgotPassword => "Esqueceu sua senha?";

  @override
  String get goAhead => "Continue!";

  @override
  String get passwordRestriction => "A senha deve ter pelo menos oito caracteres, incluindo um número, uma letra maiúscula e uma letra minúscula, você pode usar caracteres especiais como @ # \$% ^ & + = e dez ou mais caracteres para melhorar a segurança de sua senha.";

  @override
  String get recoverYorPassword => "Recupere sua senha";

  @override
  String get recoverYorPasswordWarning => "Para restaurar sua senha, digite o endereço de e-mail que você usa para fazer login no noysi.com";

  @override
  String recoverPasswordResponse(String email) {
    return "Enviamos um e-mail para $email";
  }

  @override
  String get recoverPasswordResponse1 =>
      "Verifique sua caixa de entrada e siga as instruções para criar sua nova senha";

  @override
  String get continueStr => "Continuar";

  @override
  String get passwordAtLeast1SpecialChar => "A senha deve ter pelo menos um caractere especial @#\$%^&+=";

  @override
  String welcomeToNoysiLastName(String name) => "Olá $name. Qual é o seu sobrenome?";

  @override
  String get welcomeToNoysiDescription => "Muito bem. Tudo está correto. Vou continuar a atualizar o seu perfil.";

  @override
  String get welcomeToNoysiInvite => "<a href = '#'>Convide os membros da sua equipe agora!</a>";

  @override
  String get activeFilter => "Filtro ativo";

  @override
  String get newFileComment => "Novo comentário no arquivo";

  @override
  String get removed => "Removido";

  @override
  String get sharedOn => "Compartilhado em";

  @override
  String get notifyAllInThisChannel => "notificar todos neste canal";

  @override
  String get notifyAllMembers => "notificar todos os membros";

  @override
  String get keepPressingToRecord => "Continue pressionando o botão para gravar";

  @override
  String get slideToCancel => "Deslize para cancelar";

  @override
  String get chooseASecurePasswordText => "Escolha uma senha segura que você possa lembrar";

  @override
  String get confirmPassword => "Repita a senha";

  @override
  String get yourPassword => "Senha";

  @override
  String get passwordDontMatch => "As senhas não correspondem";

  @override
  String get changeCreateTeamMail => "Não, eu quero mudar o e-mail";

  @override
  String step(int number) => "Etapa $number";

  @override
  String get user => "Do utilizador";

  @override
  String get deleteFolderWarning => "A pasta será excluída permanentemente e não pode ser recuperada";

  @override
  String get calendar => "Calendário";

  @override
  String get week => "Semana";

  @override
  String get folderIsNotInCurrentTeam => "A pasta não está associada à equipe atual";

  @override
  String get folderIsNotInAvailableChannel => "A pasta referenciada não está em um canal disponível no explorador de arquivos";

  @override
  String get folderLinked => "Link da pasta copiado para o canal";

  @override
  String get folderShared => "A pasta foi compartilhada no canal";

  @override
  String get folderUploaded => "A pasta foi enviada para o canal";

  @override
  String get folderNotFound => "Pasta não encontrada";

  @override
  String get folderNameIncorrect => "O nome da pasta não é válido";

  @override
  String get cloneFolder => "Pasta clone";

  @override
  String get cloneFolderInfo => "A clonagem de uma pasta cria uma nova pasta no canal de destino com o mesmo status e conteúdo da pasta selecionada neste momento.";

  @override
  String get folderDeleted => "Não é possível acessar uma pasta excluída";

  @override
  String get youWereInADeletedFolder => "A pasta em que ele estava foi excluída";

  @override
  String get dateFormat6 => "MM/dd/yyyy";

  @override
  String get createdTask => "Tarefa Criada";

  @override
  String get loggedIn => "Sessão iniciada ";

  @override
  String get mention => "Menção";

  @override
  String get messageSent => "Mensagem enviada";

  @override
  String get taskAssigned => "Tarefa atribuída";

  @override
  String get taskUnassigned => "Tarefa não atribuída";

  @override
  String get uploadedFile => "Arquivo carregado";

  @override
  String get uploadedFileFolder => "Arquivo / pasta carregado";

  @override
  String get uploadedFolder => "Pasta carregada";

  @override
  String get downloadedFile => "Arquivo baixado";

  @override
  String get downloadedFileFolder => "Arquivo / pasta baixado";

  @override
  String get downloadedFolder => "Pasta baixada";

  @override
  String get messageUnavailable => "Mensagem não disponível";

  @override
  String get activityZone => "Zona de Atividade";

  @override
  String get categories => "Categorias";

  @override
  String get category => "Categoria";

  @override
  String get clearAll => "Limpar tudo";

  @override
  String get errorFetchingData => "Erro ao obter dados";

  @override
  String get filters => "Filtros";

  @override
  String get openSessions => "Sessões abertas";

  @override
  String activityFileFolderUploadedDownloaded(String user, String name, String channel, {bool download = false, bool isDirect = false, isFolder = false}) {
    String part1 = "Você ${download ? "baixou" : "carregou"}${isFolder ? " a pasta " : " o arquivo "}";
    String part2 = download ? "do canal" : "No canal";
    return "$part1 <i class=\"mention-generic\">$name</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMentioned(String user, String channel, {bool isDirect = false}) {
    String part1 = "Você foi mencionado no canal";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMessageSent(String user, String channel, {bool isDirect = false}) {
    String part1 = "Você enviou uma mensagem no canal";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activitySignedIn(String sessionInfo, String ip) {
    return "Você está logado em <i class=\"mention-generic\">$sessionInfo</i> IP: <i class=\"mention-generic\">$ip</i>";
  }

  @override
  String activityTaskAssigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Você foi designado para a tarefa";
    String part2 = "No canal";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskCreated(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Você criou a tarefa";
    String part2 = "No canal";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskUnassigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Você foi desalocado da tarefa";
    String part2 = "No canal";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String get activityZoneHeader => "É aqui que começa a Zona de Atividade";

  @override
  String get selectEvent => "Selecione o evento";

  @override
  String get googleCalendar => "Google";

  @override
  String get outlookCalendar => "Outlook";

  @override
  String get noysiCalendar => "Noysi";

  @override
  String get autogenerateRoomNameQuestion => "Você deseja gerar o nome da sala automaticamente?";

  @override
  String get createMeetingEvent => "Criar Evento-Reunião";

  @override
  String get externalGuests => "Convidados externos";

  @override
  String get internalGuests => "Convidados internos";

  @override
  String get newMeetingEvent => "Novo Evento-Reunião";

  @override
  String get roomName => "Nome da sala";

  @override
  String get eventMeeting => "Evento-Reunião";

  @override
  String get personalNote => "Nota pessoal";

  @override
  String get updateExternalGuests => "Atualizar convidados externos";

  @override
  String get nameTextWarning => "O texto corresponde a uma sequência alfanumérica de 1 a 25 caracteres. Você também pode usar espaços e os caracteres _ -";

  @override
  String get nameTextWarningWithoutSpaces => "O texto corresponde a uma sequência alfanumérica de 1 a 18 caracteres sem espaços. Você também pode usar os caracteres _ -";

  @override
  String get today => "Hoje";

  @override
  String get location => "Lugar";

  @override
  String get sessions => "Sessões";

  @override
  String get appVersion => "Versão do aplicativo";

  @override
  String get browser => "Navegador";

  @override
  String get device => "Dispositivo";

  @override
  String get logout => "Fechar Sessão";

  @override
  String get manufacturer => "criador";

  @override
  String get no => "Não";

  @override
  String get operativeSystem => "Sistema Operativo";

  @override
  String get yes => "sim";

  @override
  String get allDay => "Dia todo";

  @override
  String get endDate => "Data final";

  @override
  String get noTitle => "Sem Título";

  @override
  String get currentSession => "Sessão atual";

  @override
  String get logOutAllExceptForThisOne => "Desconecte todos os dispositivos, exceto este";

  @override
  String get terminateAllOtherSessions => "Encerrar todas as outras sessões";

  @override
  String get closeAllSessionsConfirmation => "Você deseja encerrar todas as outras sessões?";

  @override
  String get closeSessionConfirmation => "Você quer encerrar a sessão?";

  @override
  String get connectionLost => "Opa, parece que não há conexão";

  @override
  String get connectionEstablished => "Você está de volta online";

  @override
  String get connectionStatus => "Status da conexão";

  @override
  String get anUserIsCalling => "Um usuário está ligando para você ...";

  @override
  String get answer => "Responder";

  @override
  String get hangDown => "Pendurar";

  @override
  String get incomingCall => "Chamada recebida";

  @override
  String isCallingYou(String user) => "$user está chamando você ...";

  @override
  String get callCouldNotBeInitialized => "A chamada não pôde ser inicializada";

  @override
  String get sentMessages => "Mensagens Enviadas";

  @override
  String sentMessagesCount(String count) => "$count do 10000";

  @override
  String get teamDataUsage => "Uso de dados da equipe";

  @override
  String get usedStorage => "Armazenamento Usado";

  @override
  String usedStorageText(String used) => used + "GB do 5GB";

  @override
  String get userDataUsage => "Uso de dados do usuário";

  @override
  String get audioEnabled => "Áudio habilitado";

  @override
  String get meetingOptions => "Opções de reunião";

  @override
  String get videoEnabled => "Vídeo habilitado";

  @override
  String get dontShowThisMessage => "Não mostra de novo";

  @override
  String get showDialogEveryTime => "Mostrar diálogo sempre que uma reunião começa";

  @override
  String get micAndCameraRequiredAlert => "São necessárias permissões de acesso à câmera e ao microfone, certifique-se de ter concedido as permissões necessárias. Você quer ir para as configurações de permissão?";

  @override
  String get connectWith => "Conectar com";

  @override
  String get or => "ou";

  @override
  String get noEvents => "Sem eventos, tarefas ou notas pessoais";

  @override
  String get viewDetails => "Ver Detalhes";

  @override
  String zendeskTicketUpdated(String user, String status, String type, String title, String url) {
    String part1 = R.string.user;
    String part2 = "actualizou o bilhete";
    String part3 = "do tipo";
    String part4 = "ao estatuto";
    String part5 = R.string.viewDetails;
    return "<p>$part1 '$user' $part2 '$title' $part3 '$type' $part4 '$status'. <span><a href='$url'>$part5</a></span></p>";
  }


  @override
  String get accept => "Aceitar";

  @override
  String get busy => "Ocupado";

  @override
  String get configuration => "Configuração";

  @override
  String get downloads => "Downloads";

  @override
  String get editTeam => "Equipa de edição";

  @override
  String get general => "Geral";

  @override
  String get integrations => "Integrações";

  @override
  String get noRecents => "Sem Recentes";

  @override
  String get noRecommendations => "Sem Recomendações";

  @override
  String get inAMeeting => "Numa Reunião";

  @override
  String get onFire => "On Fire";

  @override
  String get plans => "Planos";

  @override
  String get setAStatus => "Definir um estado";

  @override
  String get sick => "Doente";

  @override
  String get signOut => "Sair";

  @override
  String get suggestions => "Sugestões";

  @override
  String get teams => "Equipas";

  @override
  String get traveling => "Viajando";

  @override
  String get whatsYourStatus => "Qual é a sua situação?";

  @override
  String get sendAlwaysAPush => "Envie sempre uma notificação push";

  @override
  String get robot => "Robô";

  @override
  String get deactivateUserWarning => "Os membros da equipe não poderão se comunicar com um membro enquanto ele estiver desabilitado. No entanto, todas as atividades realizadas pelo membro desativado no Noysi permanecerão intactas e as mensagens (canais abertos, 1 a 1 mensagens e grupos privados), arquivos e tarefas estarão acessíveis.";

  @override
  String get activateUserWarning => "Assim que o membro for reativado, ele irá recuperar o acesso aos mesmos canais, grupos, arquivos e tarefas que tinha antes de ser desativado.";

  @override
  String get changeRole => "Mudança de papel";

  @override
  String get userStatus => "Status do usuário";

  @override
  String get deactivateMyAccount => "Desativar minha conta";

  @override
  String get deactivateMyAccountWarning => "Se você desativar sua conta, você será desativado em todas as suas equipes, conversas, arquivos, tarefas e quaisquer atividades que você gerenciou através do Noysi até que um administrador o reative novamente.";

  @override
  String get deactivateMyUserInThisTeam => "Desativar meu usuário nesta equipe";

  @override
  String get deactivateMyUserInThisTeamWarning => "Quando você se desativa em uma equipe, tudo o que você possui nessa equipe permanecerá até que você seja ativado novamente. Se você for o único administrador da equipe, ela não será excluída.";

  @override
  String get operationConfirmation => "Tem certeza desta operação?";

  @override
  String get formatNotSupported => "Este formato ou extensão não é compatível com o sistema operacional";

  @override
  String get invitePrivateGroupLink => "Convide um membro para o grupo usando este link";

  @override
  String get invalidPhoneNumber => "Número de telefone inválido";

  @override
  String get searchByCountryName => "Pesquise por nome de país ou código de discagem";

  @override
  String get kick => "Expulsar";

  @override
  String get deleteAll => "Excluir tudo";

  @override
  String get enterKeyManually => "Digite a chave manualmente";

  @override
  String get noysiAuthenticator => "Noysi Autenticador";

  @override
  String get qrScanner => "QR";

  @override
  String get otpLabelWarning => "A etiqueta OTP é uma cadeia alfanumérica sem espaços :@.,;()\$% também são permitidos";

  @override
  String get invalidBase32Chars => "Base inválida32 caracteres";

  @override
  String get label => "Etiqueta";

  @override
  String get secretCode => "Chave secreta";

  @override
  String get labelTextWarning => "A etiqueta está vazia, por favor verifique este valor";

  @override
  String missedCallFrom(String user) => "Ligação perdida de $user";

  @override
  String get activeItemBackgroundColor => "Plano de fundo do item ativo";

  @override
  String get activeItemTextColor => "Texto do item ativo";

  @override
  String get activePresenceColor => "Presença ativa";

  @override
  String get adminsCanDeleteMessage => "Os administradores podem excluir mensagens";

  @override
  String get allForAdminsOnly => "@all apenas para administradores";

  @override
  String get channelForAdminsOnly => "@channel apenas para administradores e criadores de canais";

  @override
  String get chooseTheme => "Escolha um tema para sua equipe";

  @override
  String get enablePushAllChannels => "Ativar notificações push em todos os canais";

  @override
  String get inactivePresenceColor => "Presença inativa";

  @override
  String get leaveTeam => "Sair desta equipe";

  @override
  String get leaveTeamWarning => "Quando você sai de uma equipe, tudo o que você possui nessa equipe será excluído. Se você for o único administrador da equipe, a equipe será excluída.";

  @override
  String get notificationBadgeBackgroundColor => "Fundo do emblema";

  @override
  String get notificationBadgeTextColor => "Texto do emblema";

  @override
  String get onlyAdminInvitesAllowed => "Convidados autorizados apenas por Administradores";

  @override
  String get reset => "Redefinir";

  @override
  String get settings => "Settings";

  @override
  String get sidebarColor => "Cor da barra lateral";

  @override
  String get taskUpdateProtected => "Modificação de tarefas reservadas para criadores e administradores";

  @override
  String get teamName => "Nome do time";

  @override
  String get textColor => "Cor do texto";

  @override
  String get theme => "Tema";

  @override
  String get updateUsernameBlocked => "Bloquear nome de usuário ao enviar convite";

  @override
  String get fileNotFound => "Arquivo não encontrado";

  @override
  String get messageNotFound => "Mensagem não encontrada, verifique se a mensagem que você procura está disponível na equipe atual.";

  @override
  String get taskNotFound => "Tarefa não encontrada";

  @override
  String userHasPinnedMessage(String name) => "$name fixou uma mensagem no canal";

  @override
  String userHasUnpinnedMessage(String name) => "$name desafixou a mensagem deste canal";

  @override
  String get pinMessage => "Fixar mensagem";

  @override
  String get unpinMessage => "Liberar mensagem";

  @override
  String get pinnedMessage => "Mensagem fixada";

  @override
  String get deleteMyAccount => "Deletar minha conta";

  @override
  String get yourDeleteRequestIsInProcess => "Sua solicitação de exclusão de conta está em andamento";

  @override
  String get deleteMyAccountWarning => "Se você excluir sua conta, a ação será irreversível. Se você gerenciar uma equipe e não houver outro administrador, a equipe será excluída.";

  @override
  String get lifetimeDeal => "Ofertas vitalícias";

  @override
  String get showEmails => "Mostrar e-mails de usuários";

  @override
  String get showPhoneNumbers => "Mostrar números de telefone do usuário";

  @override
  String get addChannel => "Adicionar canal";

  @override
  String get addPrivateGroup => "Adicionar grupo privado";

  @override
  String get selectUserFromTeam => "Selecionar usuário desta equipe";

  @override
  String get selectUsersFromChannelGroup => "Selecionar usuários do canal ou grupo";

  @override
  String get memberDeleted => "Membro excluído";
}


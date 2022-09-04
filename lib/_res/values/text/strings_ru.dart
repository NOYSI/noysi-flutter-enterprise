import 'dart:ui';
import 'package:code/_res/values/config.dart';
import 'package:code/_res/values/text/strings_base.dart';

import '../../../data/api/remote/endpoints.dart';
import '../../R.dart';


class StringsRu implements StringsBase {
  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Noysi";

  @override
  String get yourTeams => "Ваши команды";

  @override
  String get channel => "Канал";

  @override
  String get channels => "Каналы";

  @override
  String get directMessagesAbr => "DM";

  @override
  String get email => "Электронная почта";

  @override
  String get home => "Домой";

  @override
  String get member => "Член";

  @override
  String get administrator => "Администратор";

  @override
  String get guest => "Гость";

  @override
  String get guests => "Гости";

  @override
  String get members => "Члены";

  @override
  String get inactiveMember => "Элемент неактивен";

  @override
  String get message => "Сообщение";

  @override
  String get messages => "Сообщения";

  @override
  String get password => "Пароль";

  @override
  String get register => "Вход в систему";

  @override
  String get search => "Поиск";

  @override
  String get signIn => "Вход в систему";

  @override
  String get task => "Задача";

  @override
  String get tasks => "Задачи";

  @override
  String get createTask => "Создать задачу";

  @override
  String get newTask => "Создать задачу";

  @override
  String get description => "Описание";

  @override
  String get team => "Коллектив";

  @override
  String get thread => "Нить";

  @override
  String get threads => "Потоки";

  @override
  String get createTeam => "Создать коллектив";

  @override
  String get confirmIsCorrectEmailAddress => "Да! Это правильный адрес электронной почты.";

  @override
  String get createTeamIntro =>
      "Вы собираетесь создать свою новую команду в Нойси.";

  @override
  String get isCorrectEmailAddress => "Это правильный адрес электронной почты?";

  @override
  String get welcome => "Добро пожаловать!";

  @override
  String get invitationSentAt => "Ваше приглашение будет отправлено по адресу:";

  @override
  String get next => "Далее";

  @override
  String get startNow => "Начинай!";

  @override
  String get charsRemaining => "Оставшиеся символы:";

  @override
  String get teamNameOrgCompany =>
      "Введите имя группы, название организации или компании.";

  @override
  String get teamNameOrgCompanyLabel => "Бывший. Имя моей компании";

  @override
  String get yourTeam => "Ваша команда";

  @override
  String get noysiServiceNewsletters =>
      "Это нормально, чтобы получать (очень редко) электронные сообщения о службе NOYSI.";

  @override
  String get userNameIntro =>
      "Ваше имя пользователя-это то, как вы предстаете перед другими в вашей команде.";

  @override
  String get userNameLabel => "Экерман";

  @override
  String get addAnother => "Добавить еще";

  @override
  String get byProceedingAcceptTerms =>
      "* С помощью процедуры <b>Условия предоставления услуг</b>";

  @override
  String get invitations => "Приглашения";

  @override
  String get invitePeople => "Пригласить пользователей";

  @override
  String get noysiIsTeamWorkInvite =>
      "Noysi-это инструмент командной работы. Пригласить по крайней мере одного сотрудника";

  @override
  String get userName => "Имя пользователя";

  @override
  String get fieldMax18 => "Максимум 18 символов";

  @override
  String get fieldMax25 => "Максимум 25 символов";

  @override
  String get fieldPassword => "Требуется пароль";

  @override
  String get fieldRequired => "Требуемое поле";

  @override
  String get missingEmailFormat => "Неправильное электронное сообщение";

  @override
  String get back => "Назад";

  @override
  String get channelBrowser => "Браузер канала";

  @override
  String get help => "Справка";

  @override
  String get preferences => "Параметры";

  @override
  String get signOutOf => "Выйти из системы";

  @override
  String get closed => "Закрыто";

  @override
  String get closedMilestone => "Закрыто";

  @override
  String get close => "Закрыть";

  @override
  String get opened => "Открыто";

  @override
  String get chat => "Разговор";

  @override
  String get allThreads => "Все потоки";

  @override
  String get inviteMorPeople => "Пригласить больше пользователей";

  @override
  String get meeting => "Совещание";

  @override
  String get myFiles => "Мои файлы";

  @override
  String get myTasks => "Мои задачи";

  @override
  String get myTeams => "Мои команды";

  @override
  String get openChannels => "Открытые каналы";

  @override
  String get privateGroups => "Частные группы";

  @override
  String get favorites => "Избранное";

  @override
  String get message1x1 => "Сообщения 1-1";

  @override
  String get acceptedTitle => "Принято";

  @override
  String get date => "Дата";

  @override
  String get invitationLanguageTitle => "Язык идиома";

  @override
  String get invitationMessage => "Приглашение";

  @override
  String get revokeInvitation => "Аннулировать приглашение";

  @override
  String get revoke => "Аннулировать";

  @override
  String get revokeInvitationWarning =>
      "Позаботься, это действие не обратимо";

  @override
  String get revokeInvitationDelete => "Приглашение удалить";

  @override
  String get resendInvitationBefore24hrs =>
      "Пересылка приглашений не допускается до 24 часов с момента последней отправки.";

  @override
  String get resendInvitationSuccess => "Приглашения отправлены успешно.";

  @override
  String get resendInvitation => "Приглашение повторно отправить";

  @override
  String get invitationMessageDefault =>
      "Привет! Здесь у вас есть приглашение присоединиться";

  @override
  String get inviteManyAsOnce => "Пригласить много раз";

  @override
  String get inviteMemberTitle =>
      "Члены команды имеют полный доступ к открытым каналам, сообщениям о сотрудниках и группам.";

  @override
  String get inviteMemberWarningTitle =>
      "Чтобы пригласить новых участников, вы должны быть администратором группы.";

  @override
  String get inviteNewMemberWarningTitle =>
      "Любой член команды может добавить гостей неограниченно.";

  @override
  String get inviteSubtitle =>
      "Noysi-это инструмент, который лучше работать с вашей командой. Пригласите их сейчас!";

  @override
  String get inviteTitle => "Пригласить других пользователей";

  @override
  String get inviteToAGroup => "Пригласить в группу (обязательно)";

  @override
  String get inviteToAGroupNotRequired => "Пригласить в группу";

  @override
  String get inviteMemberWarning =>
      "Новые участники будут автоматически присоединяться к каналу #general . Дополнительно можно добавить их в частную группу.";

  @override
  String get inviteToThisTeam => "Пригласить в эту команду";

  @override
  String get invitationsSent => "Отправлено приглашений";

  @override
  String get name => "Имя";

  @override
  String get noPendingInvitations =>
      "Нет приглашений для отправки в эту команду.";

  @override
  String get pendingTitle => "Ожидание";

  @override
  String get chooseTitle => "Выбрать";

  @override
  String get seePendingAcceptedInvitations =>
      "Просмотреть отложенные и принятые приглашения";

  @override
  String get sendInvitations => "Отправить приглашения";

  @override
  String get typeEmail => "Введите электронную почту";

  @override
  String get typeEmailComaSeparated => "Введите сообщения по электронной почте";

  @override
  String get atNoysi => "в Нойси";

  @override
  String get inviteNewMemberTitle =>
      "Гости не платят и вы можете пригласить столько, сколько хотите, но у них будет доступ только к одной группе внутри этой команды.";

  @override
  String get invited => "Приглашен";

  @override
  String get thisNameAlreadyExist =>
      "Похоже, что это имя уже используется.";

  @override
  String get emptyList => "Пустой список";

  @override
  String get ok => "OK";

  @override
  String get byNameFirst => "По имени A-Z";

  @override
  String get byNameInvertedFirst => "По имени Z-A";

  @override
  String get download => "Загрузить";

  @override
  String get files => "Файлы";

  @override
  String get folders => "Папки";

  @override
  String get newTitle => "Новый";

  @override
  String get newestFirst => "Новейшие первые";

  @override
  String get oldestFirst => "Самый старый первый";

  @override
  String get see => "См.";

  @override
  String get share => "Совместное использование";

  @override
  String get moreInfo => "Дополнительная информация";

  @override
  String get assigned => "Назначено";

  @override
  String get author => "Автор";

  @override
  String get created => "Создано";

  @override
  String get earlyDeliverDate => "Дата начала поставки";

  @override
  String get farDeliverDate => "Дата поставки";

  @override
  String get filterAuthor => "Фильтр по автору";

  @override
  String get searchUsers => "Поиск пользователей";

  @override
  String get sort => "Сортировать";

  @override
  String get sortBy => "Сортировать по";

  @override
  String get cancel => "Отмена";

  @override
  String get exit => "Выход";

  @override
  String get exitWarning => "Вы уверены?";

  @override
  String get deleteChannelWarning =>
      "Вы уверены, что хотите покинуть этот канал?";

  @override
  String get typeMessage => "Введите сообщение ...";

  @override
  String get addChannelToFavorites => "Добавить в избранное";

  @override
  String get removeFromFavorites => "Удалить из избранного";

  @override
  String get channelInfo => "Информация о канале";

  @override
  String get channelMembers => "Члены канала";

  @override
  String get channelPreferences => "Параметры канала";

  @override
  String get closeChatVisibility => "Закрыть 1 к 1";

  @override
  String get inviteToGroup => "Пригласить участника на этот канал";

  @override
  String get leaveChannel => "Оставить канал";

  @override
  String get mentions => "Упоминания";

  @override
  String get seeFiles => "См. файлы";

  @override
  String get seeLinks => "См. ссылки";

  @override
  String get links => "Ссылки";

  @override
  String get taskManager => "Администратор задач";

  @override
  String get videoCall => "Видеовызов";

  @override
  String get addReaction => "Добавить реакцию";

  @override
  String get addTag => "Добавить тег";

  @override
  String get addMilestone => "Добавить веху";

  @override
  String get copyMessage => "Копировать сообщение";

  @override
  String get copyPermanentLink => "Копировать ссылку";

  @override
  String get createThread => "Запустить поток";

  @override
  String get edit => "Изменить";

  @override
  String get favorite => "Избранное";

  @override
  String get remove => "Удалить";

  @override
  String get tryAgain => "Повторите попытку";

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
      "Вы действительно хотите удалить это сообщение? Это невозможно отменить.";

  @override
  String get deleteMessageTitle => "Удалить сообщение";

  @override
  String get edited => "Изменено";

  @override
  String get seeAll => "Посмотреть все";

  @override
  String get copiedToClipboard => "Скопировано в буфер обмена!";

  @override
  String get underConstruction => "В стадии строительства";

  @override
  String get reactions => "Реакция";

  @override
  String get all => "Все";

  @override
  String get users => "Пользователи";

  @override
  String get documents => "Документы";

  @override
  String get fromLocalStorage => "Из локального хранилища";

  @override
  String get photoGallery => "Фотогалерея";

  @override
  String get recordVideo => "Записать видео";

  @override
  String get takePhoto => "Сфотографировать";

  @override
  String get useCamera => "С камеры";

  @override
  String get videoGallery => "Видео галерея";

  @override
  String get changeName => "Изменить имя";

  @override
  String get createFolder => "Создать папку";

  @override
  String get createNameWarning =>
      "Имена должны содержать не более 18 символов без знаков препинания.";

  @override
  String get newName => "Новое имя";

  @override
  String get rename => "Переименовать";

  @override
  String get renameFile => "Переименовать файл";

  @override
  String get renameFolder => "Переименовать папку";

  @override
  String get deleteFile => "Удалить файл";

  @override
  String get deleteFolder => "Удалить папку";

  @override
  String get deleteFileWarning => "Папка будет удалена без возможности восстановления. Папка будет недоступна по любой ссылке.";

  @override
  String get delete => "Удалить";

  @override
  String get open => "Открыть";

  @override
  String get addCommentOptional => "Добавить комментарий (необязательно)";

  @override
  String get shareFile => "Общий файл";

  @override
  String get groups => "Группы";

  @override
  String get to1_1 => "1 к 1";

  @override
  String get day => "день";

  @override
  String get days => "дн.";

  @override
  String get hour => "час";

  @override
  String get hours => "ч.";

  @override
  String get minute => "минута";

  @override
  String get minutes => "мин.";

  @override
  String get month => "месяц";

  @override
  String get months => "мес.";

  @override
  String get year => "Год";

  @override
  String get years => "годы";

  @override
  String get by => "по";

  @override
  String get deliveryDateIn => "Дата выполнения в";

  @override
  String get ago => "Назад";

  @override
  String get taskOpened => "Открыто";

  @override
  String get assignees => "Цессионарии";

  @override
  String get assigneeBy => "Кем назначено";

  @override
  String get closeTask => "Закрыть задачу";

  @override
  String get comment => "Комментарий";

  @override
  String get deliveryDate => "Дата выполнения";

  @override
  String get leaveAComment => "Оставить комментарий";

  @override
  String get milestone => "Веха";

  @override
  String get milestones => "Этапы";

  @override
  String get color => "Цвет";

  @override
  String get milestoneAdded => "Добавлено в этап";

  @override
  String get participants => "Участники";

  @override
  String get reopen => "Повторно открыть";

  @override
  String get completed => "Завершено";

  @override
  String get dueDateUpdated => "Дата выполнения обновлена";

  @override
  String get dueDate => "Дата выполнения";

  @override
  String get lastDueDate => "Дата последнего выполнения";

  @override
  String get commented => "Комментарий";

  @override
  String get tagAdded => "Тег добавлен";

  @override
  String get tagRemoved => "Тег удален";

  @override
  String get tags => "Теги";

  @override
  String get update => "Обновить";

  @override
  String get details => "Сведения";

  @override
  String get timeline => "Временная шкала";

  @override
  String get aboutMe => "Обо мне";

  @override
  String get acceptNews => "Новости приема";

  @override
  String get allActive => "Все активные";

  @override
  String get changePhoto => "Изменить фотографию";

  @override
  String get changeYourPassword => "Изменить пароль";

  @override
  String get changeYourPasswordAdvice =>
      "Пароль должен содержать не менее восьми символов, включая число, столичное письмо и строчную букву, вы можете использовать специальные символы, такие как @#\$%^&+= и десять или более символов для повышения безопасности вашего пароля";

  @override
  String get charge => "Заряд";

  @override
  String get country => "Страна";

  @override
  String get disabled => "Выключено";

  @override
  String get emailNotification => "Электронные уведомления";

  @override
  String get language => "Язык";

  @override
  String get lastName => "Фамилия";

  @override
  String get maxEveryHour => "Каждый час";

  @override
  String get maxHalfDay => "Каждые 12 часов";

  @override
  String get messages1x1AndMentions => "Сообщения 1x1 и @mentions";

  @override
  String get myProfile => "Мой профиль";

  @override
  String get never => "Никогда";

  @override
  String get newPassword => "Новый пароль";

  @override
  String get newsLetters => "Новостные письма";

  @override
  String get notReceiveNews => "Не получать новости";

  @override
  String get notifications => "Уведомления";

  @override
  String get passwordRequirements =>
      "Периодически изменять пароль для повышения безопасности и защиты";

  @override
  String get phoneNotifications => "Уведомления по телефону";

  @override
  String get phoneNumber => "Номер телефона";

  @override
  String get photoSizeRestrictions =>
      "Использовать квадратное фото с максимальной шириной 400px (малая)";

  @override
  String get repeatNewPassword => "Повторить новый пароль";

  @override
  String get security => "Безопасность";

  @override
  String get skypeUserName => "пользователь Skype";

  @override
  String get sounds => "Звуки";

  @override
  String get yourUserName => "Ваше имя пользователя";

  @override
  String get saveChanges => "Сохранить изменения";

  @override
  String get profileEmailUsesWarning =>
      "Это сообщение электронной почты используется только для уведомлений в этой команде.";

  @override
  String get pushMobileNotifications => "Отталкивать мобильные уведомления";

  @override
  String get saveNotificationChanges => "Сохранить изменения уведомлений";

  @override
  String get updatePassword => "Обновить пароль";

  @override
  String get updateProfileInfo => "Обновить информацию о профайле";

  @override
  String get password8CharsRequirement =>
      "Пароль должен содержать не менее 8 символов.";

  @override
  String get passwordAtLeast1CapitalLetter =>
      "Пароль должен содержать не менее 1 заглавной буквы.";

  @override
  String get passwordAtLeast1LowerCaseLetter =>
      "Пароль должен содержать не менее 1 строчной буквы.";

  @override
  String get passwordAtLeast1Number =>
      "Пароль должен содержать не менее 1 числа.";

  @override
  String get passwordMustMatch => "Пароль должен совпадать.";

  @override
  String get notificationUpdatedSuccess => "Изменения уведомлений обновлены.";

  @override
  String get passwordUpdatedSuccess => "Пароль обновлен.";

  @override
  String get profileUpdatedSuccess => "Профайл обновлен";

  @override
  String get enablePermissions => "Разрешить разрешения";

  @override
  String get permissionDenied => "Отказано в разрешении";

  @override
  String get savePreferences => "Сохранить предпочтения";

  @override
  String get turnOffChannelEmails => "Не получать сообщения электронной почты канала";

  @override
  String get turnOffChannelSounds => "Выключить звуковые каналы";

  @override
  String get chatMessageUnavailable =>
      "Сообщения чата недоступны для этого пользователя";

  @override
  String get createChannel => "Создать канал";

  @override
  String get createNewChannel => "Создать новый канал";

  @override
  String get isTyping => "-ввод ...";

  @override
  String get createPrivateGroup => "Создать частную группу";

  @override
  String get createPrivateGroupWarning =>
      "Вы собираетесь создать новую группу, вы можете добавить пользователей в эту группу, если они уже являются частью вашей команды, если нет, сначала создайте группу и пригласите их позже.";

  @override
  String get createNewPrivateGroup => "Создать новую частную группу";

  @override
  String get createNewChannelAction =>
      "Вы собираетесь создать новый открытый канал.";

  @override
  String get createNewChannelForAdminsOnly => "Только доступ администратора к записи.";

  @override
  String get openChannelAllMemberAccess => "У всех членов команды есть права на чтение.";

  @override
  String get and => "И";

  @override
  String get userIsInactiveToChat =>
      "Вы не можете общаться с этим пользователем, так как он неактивен.";

  @override
  String get selectChannel => "Выбрать канал";

  @override
  String get needToSelectChannel => "Необходимо выбрать канал";

  @override
  String get fileAlreadyShared =>
      "Этот файл уже используется совместно с тем же именем в выбранном канале.";

  @override
  String get inChannel => "в канале";

  @override
  String seeAnswerMessages(int count) => "См. $count Сообщения";

  @override
  String participantsAndSeparated(List<String> names, {String separator = ""}) {
    String result = "";
    for (int i = 0; i < names.length; i++) {
      if (i > 0) {
        result = "$result $separator ${ names [ i] }";
      } else {
        result = "<b>${names[i]}</b>";
      }
    }
    return result;
  }

  @override
  String userHasJoined(String name) {
    return "Пользователь $name присоединился к каналу";
  }

  @override
  String userHasLeft(String name) {
    return "Пользователь $name покинул канал";
  }

  @override
  String invitedBy(String name) {
    return "Кем приглашен $name";
  }

  @override
  String get answers => "Ответы";

  @override
  String get publishIn => "опубликовать в";

  @override
  String get hasCommentedOnThread => "Комментарий к потоку:";

  @override
  String get unReadMessages => "Непрочитаны сообщения";

  @override
  String get hasAddedTag => "Добавлен тег";

  @override
  String get hasAssignedUser => "Присвоен пользователю";

  @override
  String get hasClosedTask => "Закрыла задачу";

  @override
  String get hasCommentedTask => "Добавлен комментарий";

  @override
  String get hasCreatedTask => "Создана задача";

  @override
  String get hasCreatedTaskAssignedTo => "Создана новая задача,";

  @override
  String get hasDeleteTag => "Удален тег";

  @override
  String get hasDeletedCommentTask => "Удален комментарий";

  @override
  String get hasEditedCommentTask => "Отредактировал комментарий";

  @override
  String get hasEditedTask => "Отредактировал задачу";

  @override
  String get hasRemovedEndDateTask => "Удалила конечную дату";

  @override
  String get hasReopenedTask => "Повторно открыла задачу";

  @override
  String get hasSetMilestone => "Присвоило веху";

  @override
  String get hasUnAssignedUser => "Не присвоен пользователю";

  @override
  String get hasUpdatedDateTask => "Обновлена дата окончания";

  @override
  String get inTheTask => "В задаче";

  @override
  String get to => "в";

  @override
  String get hasAssignedNewDueDateFor => "Присвоен новый срок исполнения для";

  @override
  String get createNewTag => "Создать тег";

  @override
  String get createNewMilestone => "Создать новую веху";

  @override
  String get editMilestone => "Изменить веху";

  @override
  String get editTag => "Изменить тег";

  @override
  String get openTasks => "Открытые задачи";

  @override
  String get newPersonalNote => "Новая личная заметка";

  @override
  String get createNewPersonalNote => "Создать личную заметку";

  @override
  String get filterBy => "Фильтр по";

  @override
  String hereStartsYourMessagesWith(String name) =>
      "Здесь начинаются ваши сообщения с @$name";

  @override
  String thisChannelIsManagedBy(String name) =>
      "Эти каналы управляются @$name, при необходимости обратитесь к администратору.";

  @override
  String newPush(String user, String repository, String repositoryUrl) {
    String part1 = "Новый толчок";
    String part2 = "в хранилище";
    String part3 = "Сведения";

    return "<p>$part1 <span class='link-mention' > @$user</span> $part2 <span><a href='$repositoryUrl' >$repository. $part3</a></span></p>";
  }

  @override
  String unassignedTask(
    String repository,
    String repositoryUrl,
  ) {
    String part1 = "Неприсвоенное задание в репозитории";
    String part2 = "Сведения";
    return "<p>$part1 <a href='$repositoryUrl' >$repository. $part2</a></p>";
  }

  @override
  String cardTrelloCreate(
      String board, String boardUrl, String card, String cardUrl, String list) {
    String part1 = "Карточка создана";
    String part2 = "в списке";
    String part3 = "Совет директоров";
    return "<p>$part1 <a href='$cardUrl' >$card</a> $part2 $list $part3 <a href='$boardUrl' >$board</a></p>";
  }

  @override
  String cardTrelloRename(String board, String boardUrl, String oldName,
      String newName, String list) {
    String part1 = "В списке";
    String part2 = "с доски";
    String part3 = "карта была переименована";
    String part4 = "к";
    return "<p>$part1 '$list' $part2 <a href='$boardUrl'>$board</a> $part3 '$oldName' $part4 '$newName'</p>";
  }

  @override
  String cardTrelloDescriptionChange(String board, String boardUrl, String card,
      String cardUrl, String list, String description) {
    String part1 = "Карта";
    String part2 = "списка";
    String part3 = "с доски";
    String part4 = "изменил свое описание на";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4 '$description'</p>";
  }

  @override
  String cardTrelloMoveToOtherList(String board, String boardUrl, String card,
      String cardUrl, String oldList, String newList) {
    String part1 = "Карта";
    String part2 = "был перемещен из списка";
    String part3 = "к списку";
    String part4= "на борту";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$oldList' $part3 '$newList' $part4 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloArchive(String board, String boardUrl, String card,
      String cardUrl, String list) {
    String part1 = "Карта";
    String part2 = "списка";
    String part3 = "с доски";
    String part4 = "был заархивирован";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4</p>";
  }

  @override
  String get comments => "Комментарии";

  @override
  String get addComment => "Добавить комментарий";

  @override
  String get editComment => "Изменить комментарий";

  @override
  String get downloadAppsAndSynchronizer => "<a href = 'https://noysi.com/a/#/downloads'>СКАЧАТЬ ПРИЛОЖЕНИЯ СЕЙЧАС!</a>";

  @override
  String get welcomeToNoysiFirstName => "Добро пожаловать! Это ваш личный канал, никто его не увидит, вы ни с кем не общаетесь, это ваш личный канал, где вы можете оставлять личные заметки и загружать файлы, которые никто другой не увидит. Как Вас зовут?";

  @override
    String get welcomeToNoysiTimeout => "Вы не ответили мне! Если вам нужна помощь, нажмите <a href= '${Endpoint.helpUrl}' >здесь.</a>";

  @override
  String get wrongUsernamePassword => "Неверное имя пользователя или пароль";

  @override
  String get userInUse => "Этот пользователь уже используется";

  @override
  String get invite => "Пригласить";

  @override
  String get groupRequired => "Требуется группа";

  @override
  String get uploading => "Передача";

  @override
  String get downloading => "Загрузка";

  @override
  String get inviteGuestsWarning => "Гости присоединяются только к одной группе в этой команде.";

  @override
  String get addMembers => "Добавить участников";

  @override
  String get enterEmailsByComma => "Введите сообщения электронной почты, разделяя их запятыми:";

  @override
  String get firstName => "Имя";

  @override
  String get inviteFewMorePersonal => "Пригласить несколько и быть более личным";

  @override
  String get inviteManyAtOnce => "Пригласить сразу много";

  @override
  String get addGuests => "Добавить гостей";

  @override
  String get followThread => "Следуйте этой теме";

  @override
  String get markThreadAsRead => "пометить, как прочитанное";

  @override
  String get needToVerifyAccountToInvite => "Вам необходимо подтвердить учетную запись электронной почты, чтобы приглашать участников.";

  @override
  String get stopFollowingThread => "Прекратите следить за этой цепочкой";

  @override
  String get createANewTeam => "Create a new team";

  @override
  String get createNewTeam => "Create new team!";

  @override
  String get enterIntoYourAccount => "Войдите в свой аккаунт";

  @override
  String get forgotPassword => "Забыли свой пароль?";

  @override
  String get goAhead => "Преуспевать!";

  @override
  String get passwordRestriction =>
      "Пароль должен состоять не менее чем из восьми символов, включая число, прописные и строчные буквы. Вы можете использовать специальные символы, такие как @ # \$ % ^ & + = и десять или более символов, чтобы повысить безопасность вашего пароля.";

  @override
  String get recoverYorPassword => "Восстановите свой пароль";

  @override
  String get recoverYorPasswordWarning => "Чтобы восстановить пароль, введите адрес электронной почты, который вы используете для входа на noysi.com.";

  @override
  String recoverPasswordResponse(String email) {
    return "Мы отправили вам электронное письмо на адрес $email";
  }

  @override
  String get recoverPasswordResponse1 =>
      "Проверьте свой почтовый ящик и следуйте инструкциям, чтобы создать новый пароль.";

  @override
  String get continueStr => "Продолжать";

  @override
  String get passwordAtLeast1SpecialChar => "В пароле должен быть хотя бы один специальный символ. @#\$%^&+=";

  @override
  String welcomeToNoysiLastName(String name) => "Привет, $name. Какая у тебя фамилия?";

  @override
  String get welcomeToNoysiDescription => "Отлично. Все правильно. Я продолжу обновлять ваш профиль.";

  @override
  String get welcomeToNoysiInvite => "<a href = '#'>Пригласите членов своей команды прямо сейчас!</a>";

  @override
  String get activeFilter => "Активный фильтр";

  @override
  String get newFileComment => "Новый комментарий в файле";

  @override
  String get removed => "удалено";

  @override
  String get sharedOn => "Опубликовано на";

  @override
  String get notifyAllInThisChannel => "уведомить всех на этом канале";

  @override
  String get notifyAllMembers => "уведомить всех участников";

  @override
  String get keepPressingToRecord => "Пожалуйста, продолжайте нажимать кнопку для записи";

  @override
  String get slideToCancel => "Проведите, чтобы отменить";

  @override
  String get chooseASecurePasswordText => "Выберите достаточно надежный пароль, который вы сможете запомнить";

  @override
  String get confirmPassword => "Подтвердить Пароль";

  @override
  String get yourPassword => "Твой пароль";

  @override
  String get passwordDontMatch => "Пароли не соответствуют";

  @override
  String get changeCreateTeamMail => "Нет, я хочу изменить адрес электронной почты";

  @override
  String step(int number) => "ШАГ $number";

  @override
  String get user => "Пользователь";

  @override
  String get deleteFolderWarning => "Папка будет удалена без возможности восстановления.";

  @override
  String get calendar => "Календарь";

  @override
  String get week => "Неделю";

  @override
  String get folderIsNotInCurrentTeam => "Папка не связана с текущей командой";

  @override
  String get folderIsNotInAvailableChannel => "Указанная папка отсутствует в доступном канале в проводнике файлов.";

  @override
  String get folderLinked => "Ссылка на папку скопирована в канал";

  @override
  String get folderShared => "Папка опубликована на канале";

  @override
  String get folderUploaded => "Папка загружена на канал";

  @override
  String get folderNotFound => "Папка не найдена";

  @override
  String get folderNameIncorrect => "Имя папки недействительно";

  @override
  String get cloneFolder => "Клонировать папку";

  @override
  String get cloneFolderInfo => "Клонирование папки создает новую папку в целевом канале с тем же статусом и содержимым, что и выбранная папка на данный момент.";

  @override
  String get folderDeleted => "Нет доступа к удаленной папке";

  @override
  String get youWereInADeletedFolder => "Папка, в которой он находился, была удалена";

  @override
  String get dateFormat6 => "MM/dd/yyyy";

  @override
  String get createdTask => "Задача создана";

  @override
  String get loggedIn => "Сессия инициирована";

  @override
  String get mention => "Упомянуть";

  @override
  String get messageSent => "Сообщение отправлено";

  @override
  String get taskAssigned => "Назначенная задача";

  @override
  String get taskUnassigned => "Неназначенная задача";

  @override
  String get uploadedFile => "Загруженный файл";

  @override
  String get uploadedFileFolder => "Файл / папка загружена";

  @override
  String get uploadedFolder => "Загруженная папка";

  @override
  String get downloadedFile => "Загруженный файл";

  @override
  String get downloadedFileFolder => "Загруженный файл / папка";

  @override
  String get downloadedFolder => "Загруженная папка";

  @override
  String get messageUnavailable => "Сообщение недоступно";

  @override
  String get activityZone => "Зона активности";

  @override
  String get categories => "Категории";

  @override
  String get category => "Категория";

  @override
  String get clearAll => "Очистить все";

  @override
  String get errorFetchingData => "Ошибка при получении данных";

  @override
  String get filters => "Фильтры";

  @override
  String get openSessions => "Открытые сессии";

  @override
  String activityFileFolderUploadedDownloaded(String user, String name, String channel, {bool download = false, bool isDirect = false, isFolder = false}) {
    String part1 = "Вы ${download ? "скачали" : "загрузили"}${isFolder ? " Папка " : " файл "}";
    String part2 = download ? "с канала" : "В канале";
    return "$part1 <i class=\"mention-generic\">$name</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMentioned(String user, String channel, {bool isDirect = false}) {
    String part1 = "Вас упомянули на канале";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMessageSent(String user, String channel, {bool isDirect = false}) {
    String part1 = "Вы отправили сообщение на канале";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activitySignedIn(String sessionInfo, String ip) {
    return "Вы вошли в систему <i class=\"mention-generic\">$sessionInfo</i> IP: <i class=\"mention-generic\">$ip</i>";
  }

  @override
  String activityTaskAssigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Вы получили задание";
    String part2 = "В канале";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskCreated(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Has creado la tarea";
    String part2 = "В канале";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskUnassigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "Вы были освобождены от задачи";
    String part2 = "В канале";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String get activityZoneHeader => "Здесь начинается зона активности";

    @override
    String get selectEvent => "Выбрать мероприятие";

  @override
  String get googleCalendar => "Google";

  @override
  String get outlookCalendar => "Outlook";

  @override
  String get noysiCalendar => "Noysi";

  @override
  String get autogenerateRoomNameQuestion => "Вы хотите автоматически сгенерировать название комнаты?";

  @override
  String get createMeetingEvent => "Создать мероприятие-встречу";

  @override
  String get externalGuests => "Внешние гости";

  @override
  String get internalGuests => "Внутренние гости";

  @override
  String get newMeetingEvent => "Новое Событие-Встреча";

  @override
  String get roomName => "Название комнаты";

  @override
  String get eventMeeting => "Событие-Встреча";

  @override
  String get personalNote => "Личное примечание";

  @override
  String get updateExternalGuests => "Обновить внешних гостей";

  @override
  String get nameTextWarning => "Текст соответствует буквенно-цифровой строке от 1 до 25 символов. Вы также можете использовать пробелы и символы _ -";

  @override
  String get nameTextWarningWithoutSpaces => "Текст соответствует буквенно-цифровой строке из 1-18 символов без пробелов. Вы также можете использовать символы _ -";

  @override
  String get today => "Сегодня";

  @override
  String get location => "Место";


  @override
  String get sessions => "Сессии";

  @override
  String get appVersion => "Версия приложения";

  @override
  String get browser => "Браузер";

  @override
  String get device => "Устройство";

  @override
  String get logout => "выйти";

  @override
  String get manufacturer => "Производитель";

  @override
  String get no => "Нет";

  @override
  String get operativeSystem => "Операционная система";

  @override
  String get yes => "да";

  @override
  String get allDay => "Весь день";

  @override
  String get endDate => "Дата окончания";

  @override
  String get noTitle => "Без заголовка";

  @override
  String get currentSession => "Текущая сессия";

  @override
  String get logOutAllExceptForThisOne => "Выйти из всех устройств, кроме этого";

  @override
  String get terminateAllOtherSessions => "Завершить все остальные сеансы";

  @override
  String get closeAllSessionsConfirmation => "Вы хотите завершить все остальные сеансы?";

  @override
  String get closeSessionConfirmation => "Вы хотите завершить сеанс?";

  @override
  String get connectionLost => "Упс вроде нет связи";

  @override
  String get connectionEstablished => "Вы снова в сети";

  @override
  String get connectionStatus => "Статус подключения";

  @override
  String get anUserIsCalling => "Вам звонит пользователь ...";

  @override
  String get answer => "Отвечать";

  @override
  String get hangDown => "Вешать";

  @override
  String get incomingCall => "Входящий звонок";

  @override
  String isCallingYou(String user) => "$user звонит тебе ...";

  @override
  String get callCouldNotBeInitialized => "Вызов не может быть инициализирован";

  @override
  String get sentMessages => "Отправленные сообщения";

  @override
  String sentMessagesCount(String count) => "$count из 10000";

  @override
  String get teamDataUsage => "Использование данных команды";

  @override
  String get usedStorage => "Используемое хранилище";

  @override
  String usedStorageText(String used) => used + "GB из 5GB";

  @override
  String get userDataUsage => "Использование пользовательских данных";

  @override
  String get audioEnabled => "Аудио включено";

  @override
  String get meetingOptions => "Параметры встречи";

  @override
  String get videoEnabled => "Видео включено";

  @override
  String get dontShowThisMessage => "Больше не показывать";

  @override
  String get showDialogEveryTime => "Показывать диалог каждый раз, когда начинается встреча";

  @override
  String get micAndCameraRequiredAlert => "Требуются разрешения на доступ к камере и микрофону, убедитесь, что вы предоставили необходимые разрешения. Хотите зайти в настройки разрешений?";

  @override
  String get noEvents => "Никаких событий, задач или личных заметок";

  @override
  String get connectWith => "Соединить с";

  @override
  String get or => "или";

  @override
  String get viewDetails => "Посмотреть детали";

  @override
  String zendeskTicketUpdated(String user, String status, String type, String title, String url) {
    String part1 = R.string.user;
    String part2 = "обновил билет";
    String part3 = "типа";
    String part4 = "к статусу";
    String part5 = R.string.viewDetails;
    return "<p>$part1 '$user' $part2 '$title' $part3 '$type' $part4 '$status'. <span><a href='$url'>$part5</a></span></p>";
  }


  @override
  String get accept => "Принять";

  @override
  String get busy => "Занято";

  @override
  String get configuration => "Конфигурация";

  @override
  String get downloads => "Загрузки";

  @override
  String get editTeam => "Команда редакторов";

  @override
  String get general => "Общий";

  @override
  String get integrations => "Интеграции";

  @override
  String get noRecents => "Без рецидивов";

  @override
  String get noRecommendations => "Нет рекомендаций";

  @override
  String get inAMeeting => "На встрече";

  @override
  String get onFire => "On Fire";

  @override
  String get plans => "Планы";

  @override
  String get setAStatus => "Установить статус";

  @override
  String get sick => "Больной";

  @override
  String get signOut => "Выписаться";

  @override
  String get suggestions => "Предложения";

  @override
  String get teams => "Команды";

  @override
  String get traveling => "Путешествие";

  @override
  String get whatsYourStatus => "Каков ваш статус?";

  @override
  String get sendAlwaysAPush => "Всегда отправлять push-уведомление";

  @override
  String get robot => "Робот";

  @override
  String get deactivateUserWarning => "Члены команды не смогут общаться с участником, пока он отключен. Однако все действия, выполняемые деактивированным участником в Noysi, останутся нетронутыми, а сообщения (открытые каналы, сообщения 1 к 1 и частные группы), файлы и задачи будут доступны.";

  @override
  String get activateUserWarning => "Как только участник будет повторно активирован, он восстановит доступ к тем же каналам, группам, файлам и задачам, которые у него были до деактивации.";

  @override
  String get changeRole => "Сменить роль";

  @override
  String get userStatus => "Статус пользователь";

  @override
  String get deactivateMyAccount => "Отключить аккаунт";

  @override
  String get deactivateMyAccountWarning => "Если вы деактивируете свою учетную запись, вы будете деактивированы во всех своих командах, беседах, файлах, задачах и любых действиях, которыми вы управляли через Noysi, до тех пор, пока администратор снова не активирует вас.";

  @override
  String get deactivateMyUserInThisTeam => "Деактивировать моего пользователя в этой команде";

  @override
  String get deactivateMyUserInThisTeamWarning => "Когда вы деактивируете себя в команде, все, что у вас есть в этой команде, останется, пока вы не активируете снова. Если вы единственный администратор команды, команда не будет удалена.";

  @override
  String get operationConfirmation => "Вы уверены в этой операции?";

  @override
  String get formatNotSupported => "Этот формат или расширение не поддерживается операционной системой.";

  @override
  String get invitePrivateGroupLink => "Пригласите участника в группу по этой ссылке";

  @override
  String get invalidPhoneNumber => "Неправильный номер телефона";

  @override
  String get searchByCountryName => "Поиск по названию страны или телефонному коду";

  @override
  String get kick => "Изгнать";

  @override
  String get deleteAll => "Удалить все";

  @override
  String get enterKeyManually => "Введите ключ вручную";

  @override
  String get noysiAuthenticator => "Noysi Аутентификатор";

  @override
  String get qrScanner => "QR";

  @override
  String get otpLabelWarning => "Метка OTP представляет собой буквенно-цифровую строку без пробелов :@.,;()\$% также разрешается";

  @override
  String get invalidBase32Chars => "Недопустимые символы base32";

  @override
  String get label => "Этикетка";

  @override
  String get secretCode => "Секретный ключ";

  @override
  String get labelTextWarning => "Этикетка пуста, пожалуйста, проверьте это значение";

  @override
  String missedCallFrom(String user) => "Пропущенный звонок от $user";

  @override
  String get activeItemBackgroundColor => "Фон активного элемента";

  @override
  String get activeItemTextColor => "Текст активного элемента";

  @override
  String get activePresenceColor => "Активное присутствие";

  @override
  String get adminsCanDeleteMessage => "Админы могут удалять сообщения";

  @override
  String get allForAdminsOnly => "@all только для администраторов";

  @override
  String get channelForAdminsOnly => "@channel только для администраторов и создателей каналов";

  @override
  String get chooseTheme => "Выберите тему для своей команды";

  @override
  String get enablePushAllChannels => "Включите push-уведомления на всех каналах";

  @override
  String get inactivePresenceColor => "Неактивное присутствие";

  @override
  String get leaveTeam => "Покинуть эту команду";

  @override
  String get leaveTeamWarning => "Когда вы покидаете команду, все, что у вас есть в этой команде, будет удалено. Если вы единственный администратор команды, команда будет удалена.";

  @override
  String get notificationBadgeBackgroundColor => "Фон значка";

  @override
  String get notificationBadgeTextColor => "Текст значка";

  @override
  String get onlyAdminInvitesAllowed => "Гости, авторизованные только администраторами";

  @override
  String get reset => "Перезагрузить";

  @override
  String get settings => "Settings";

  @override
  String get sidebarColor => "Цвет боковой панели";

  @override
  String get taskUpdateProtected => "Модификация Заданий, зарезервированных для Создателей и Администраторов";

  @override
  String get teamName => "Название команды";

  @override
  String get textColor => "Цвет текста";

  @override
  String get theme => "Тема";

  @override
  String get updateUsernameBlocked => "Заблокировать имя пользователя при отправке приглашения";

  @override
  String get fileNotFound => "Файл не найден";

  @override
  String get messageNotFound => "Сообщение не найдено, проверьте, доступно ли искомое сообщение в текущей команде.";

  @override
  String get taskNotFound => "Задача не найдена";

  @override
  String userHasPinnedMessage(String name) => "$name закрепил сообщение на канале";

  @override
  String userHasUnpinnedMessage(String name) => "$name открепил сообщение с этого канала";

  @override
  String get pinMessage => "Закрепить сообщение";

  @override
  String get unpinMessage => "Открепить сообщение";

  @override
  String get pinnedMessage => "Закрепленное сообщение";

  @override
  String get deleteMyAccount => "Удалите мой аккаунт";

  @override
  String get yourDeleteRequestIsInProcess => "Ваш запрос на удаление аккаунта находится в обработке";

  @override
  String get deleteMyAccountWarning => "Если вы удалите свою учетную запись, действие будет необратимым. Если вы управляете командой, а другого администратора нет, команда будет удалена.";

  @override
  String get lifetimeDeal => "Пожизненные предложения";

  @override
  String get showEmails => "Показать электронные письма пользователей";

  @override
  String get showPhoneNumbers => "Показать номера телефонов пользователей";

  @override
  String get addChannel => "Добавить канал";

  @override
  String get addPrivateGroup => "Добавить частную группу";

  @override
  String get selectUserFromTeam => "Выберите пользователя из этой команды";

  @override
  String get selectUsersFromChannelGroup => "Выберите пользователей из канала или группы";

  @override
  String get memberDeleted => "Участник удален";
}


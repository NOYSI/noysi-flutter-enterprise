class RemoteConstants {
  static const code_success = 200;
  static const code_success_created = 201;
  static const code_success_accepted = 202;
  static const code_success_no_content = 204;

  static const code_bad_request = 400;
  static const code_un_authorized = 401;
  static const code_forbidden = 403;
  static const code_not_found = 404;
  static const code_conflict = 409;

  static const code_host_unable = 500;

  static const message_number_requested_by_next = 45;

  static const unable_host_massage = 'Failed host lookup:';

  static const result = 'result';
  static const defLang = 'en';

  static const fontFamily = "SourceSansPro";

  static const all = 'all';
  static const channel = 'channel';
  static const group = 'group';
  static const closed = 'closed';
  static const open = 'open';
  static const message1x1 = 'ims';
  static const welcomeFirstName = 'robot.welcome.questions.firstName';
  static const welcomeLastName = 'robot.welcome.questions.lastName';
  static const welcomeDescriptions = 'robot.welcome.questions.description';
  static const welcomeInvite = 'robot.welcome.questions.invite';
  static const welcomeDownloads = 'robot.welcome.questions.downloads';
  static const welcomeTimeout = 'robot.timeout';
  static const taskNotification = 'task_notification';
  static const fileComment = 'file_comment';
  static const noysiRobot = 'noysi:robot';
  static const noysiUsername = 'noysi';
  static const integrationMessage = 'integrations.';
  static const threadMessageDeleted = 'threads.message.deleted';
  static const integrationMessageTrello = 'trello:';
  static const integrationMessageGithub = 'github:';
  static const integrationMessageZendesk = 'zendesk:';
  static const channelMemberJoined = 'channels.members.joined';
  static const channelMemberLeft = 'channels.members.left';
  static const channelMessagePinned = 'channels.messages.pinned';
  static const channelMessageUnpinned = 'channels.messages.unpinned';

  ///RTC events
  static const rtHello = 'hello';
  static const rtMessageUpdated = 'message_updated';
  static const rtMessageDeleted = 'message_deleted';
  static const rtThreadFollowed = 'thread_followed';
  static const rtMemberNotificationsUpdated = 'notifications_updated';
  static const rtMemberUpdated = 'member_updated';
  static const rtMemberPhotoUpdated = 'member_photo_updated';
  static const rtMemberRoleUpdated = 'member_role_updated';
  static const rtTeamDisabled = 'team_disabled';
  static const rtTeamUpdated = 'team_updated';
  static const rtTeamThemeUpdated = 'theme_updated';
  static const rtTeamPhotoUpdated = 'team_photo_updated';
  static const rtMessagePinned = 'message_pinned';
  static const rtMessageUnpinned = 'message_unpinned';
  static const rtUserDeleted = 'user_deleted';
  static const rtTaskCreated = 'task:created';
  static const rtTaskUpdated = 'task:updated';
  static const rtUutDeleted = 'uut:deleted';
  static const rtAccountList = 'account_list';
  static const rtUserTyping = 'user_typing';
  static const rtTeamJoined = 'team_joined';
  static const rtPresenceChange = 'presence_change';
  static const rtMessage = 'message';
  static const rtChannelNotificationsUpdated = 'channel_notifications_updated';
  static const rtChannelMarked = 'channel_marked';
  static const rtChannelOpened = 'channel_opened';
  static const rtChannelRenamed = 'channel_renamed';
  static const rtChannelCreated = 'channel_created';
  static const rtChannelJoined = 'channel_joined';
  static const rtChannelLeft = 'channel_left';
  static const rtChannelDeleted = 'channel_deleted';
  static const rtChannelClosed = 'channel_closed';
  static const rtFolderRenamed = 'folder_renamed';
  static const rtFolderDeleted = 'folder_deleted';
  static const rtFileDeleted = 'file_deleted';
  static const rtFolderCreated = 'folder_created';
  static const rtFileCreated = 'file_created';
  static const rtMemberActivated = 'member_activated';
  static const rtMemberDisabled = 'member_disabled';
  static const rtActivityCreated = 'activity_created';
  static const rtActivityDeleted = 'activity_deleted';
  static const rtSignedIn = 'signed_in';
  static const rtSignedOut = 'signed_out';
  static const rtUnauthorized = 'unauthorized';
  static const rtWebRTC = 'webrtc';
  static const rtStatusSet = 'status_set';

  static const task_label_deleted = 'task_label_deleted';
  static const task_label_added = 'task_label_added';
  static const task_assignee_added = 'task_assignee_added';
  static const task_assignee_deleted = 'task_assignee_deleted';
  static const task_created = 'task_created';
  static const task_milestone_set = 'task_milestone_set';
  static const task_closed = 'task_closed';
  static const task_edited = 'task_edited';
  static const task_due_updated = 'task_due_updated';
  static const task_comment_deleted = 'task_comment_deleted';
  static const task_comment_edited = 'task_comment_edited';
  static const task_comment_added = 'task_comment_added';
  static const task_reopened = 'task_reopened';
  static const task_title_edited = 'task_title_edited';
  static const label_created = 'label:created';
  static const label_updated = 'label:updated';
  static const label_deleted = 'label:deleted';
  static const milestone_updated = 'milestone:updated';
  static const milestone_created = 'milestone:created';
  static const cname_status_enabled = "ENABLED";

  ///zendesk
  static const integration_zendesk_ticket_updated = "integrations.zendesk.ticket.updated";

  ///github
  static const integration_github_issue_unassigned = 'integrations.github.issue.unassigned';
  static const integration_github_push = 'integrations.github.push';

  ///trello
  static const integration_trello_card_create = 'integrations.trello.card.create';
  static const integration_trello_card_rename = 'integrations.trello.card.rename';
  static const integration_trello_card_description_change = 'integrations.trello.card.description.change';
  static const integration_trello_card_moveToOtherList = 'integrations.trello.card.moveToOtherList';
  static const integration_trello_card_archive = 'integrations.trello.card.archive';

  ///Folder subtypes
  static const folder_share = 'folder_share';
  static const folder_link = 'folder_link';
  static const folder_upload = 'folder_upload';

  ///activity types
  static const activity_message_sent = 'message_sent';
  static const activity_mentioned = 'mentioned';
  static const activity_task_created = 'task_created';
  static const activity_task_assigned = 'task_assigned';
  static const activity_task_assigned_deleted = 'task_assigned_deleted';
  static const activity_file_uploaded = 'file_uploaded';
  static const activity_file_downloaded = 'file_downloaded';
  static const activity_signed_in = 'signed_in';

  ///Roles
  static const role_admin = "administrator";
  static const role_member = "member";
  static const role_guest = "guest";
  static const role_robot = "robot";
  static const role_integration = "integration";

  ///Search user poge types
  static const searchIms = "im.open";
  static const searchSearch = "search";
  static const searchGroupInvite = "group.invite";
  static const searchHumans = "humans";

  ///tehemes
  static const defaultTheme = 'default';
  static const bluejeansTheme = 'bluejeans';
  static const blackboardTheme = 'blackboard';
  static const lightTheme = 'light';
  static const greenbeansTheme = 'greenbeans';
}

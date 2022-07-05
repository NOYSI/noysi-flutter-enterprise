enum Environment { PROD, DEV }
enum HomeDrawerItemType {
  None,
  Divider,
  ThreadHeader,
  ThreadChild,
  OpenChannelHeader,
  OpenChannelChild,
  DirectMessageHeader,
  DirectMessageChild,
  PrivateGroupHeader,
  PrivateGroupChild
}

enum OTPType { totp, hotp }

enum BulkLoadMessages { last, previous, next}

enum ConnectivityAppStatus { mobile, wifi, none }

enum BackNavigationAction { Logout, TeamCreated, Reload }

enum DrawerNavigationOption { MyFiles, MyTasks, Meeting, InvitePeople, MyTeams, ActivityLog, Calendar }

enum DrawerHeaderChatType { Thread, Channel, Message1x1, PrivateGroup, Favorite }

enum UserStatus { None, Active, Inactive, Idle }

enum UserRol { Admin, Member, Guest, Integration, Robot, None }

enum FileViewMode { grid, list }

enum SortFileMode { newest, oldest, a_z, z_a }

enum MessageStatus { Sent, Sending, Failed, Updated, Deleted }

enum TaskSort { newest, oldest, dueDateEarly, dueDateFar }

enum UserPresence { online, offline, out }

enum UserGroupBy { team, channel }

enum RTCMessageType { message, messageThread }

enum NotificationType {message, general }

enum MenuTaskAction {created, assigned, tags, milestones }

enum CommonSort {asc, desc }

enum profileNotificationSound { all, mentions, never }

enum DrawerMenuAction {
  SetState,
  Preferences,
  Authenticator,
  Downloads,
  Help,
  Integrations,
  EditTeam,
  Plans,
  Members,
  Logout
}

enum MenuChatAction {
  SeeFiles,
  AddToFavorites,
  SeeLinks,
  TaskManager,
  // VideoCall,
  // ChannelInfo,
  ChannelPreferences,
  Mentions,
  ChannelMembers,
  InviteMember,
  LeaveChannel1x1,
  LeaveChannel,
  CloseChannel,
  RenameChannel,
  DeleteChannel
}

enum LocalSyncOperation{
  Add,
  Remove,
  Update,
}

enum MessageExtraTypes { link, rich }

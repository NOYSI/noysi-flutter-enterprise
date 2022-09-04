import 'dart:ui';

import 'package:code/_res/values/text/strings_base.dart';
import 'package:code/data/api/remote/endpoints.dart';

import '../../R.dart';

class StringsEn implements StringsBase {
  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Noysi";

  @override
  String get yourTeams => "Your teams";

  @override
  String get channel => "Channel";

  @override
  String get channels => "Channels";

  @override
  String get directMessagesAbr => "DMs";

  @override
  String get email => "Email";

  @override
  String get home => "Home";

  @override
  String get member => "Member";

  @override
  String get administrator => "Administrator";

  @override
  String get guest => "Guest";

  @override
  String get guests => "Guests";

  @override
  String get members => "Members";

  @override
  String get inactiveMember => "Member deactivated";

  @override
  String get message => "Message";

  @override
  String get messages => "Messages";

  @override
  String get password => "Password";

  @override
  String get register => "Sign up";

  @override
  String get search => "Search";

  @override
  String get signIn => "Sign in";

  @override
  String get task => "Task";

  @override
  String get tasks => "Tasks";

  @override
  String get createTask => "Create Task";

  @override
  String get newTask => "New Task";

  @override
  String get description => "Description";

  @override
  String get team => "Team";

  @override
  String get thread => "Thread";

  @override
  String get threads => "Threads";

  @override
  String get createTeam => "Create team";

  @override
  String get confirmIsCorrectEmailAddress => "Yes! That's the correct Email";

  @override
  String get createTeamIntro =>
      "You're about to set-up your new team at Noysi.";

  @override
  String get isCorrectEmailAddress => "Is this the correct email address?";

  @override
  String get welcome => "Welcome!";

  @override
  String get invitationSentAt => "Your invitation will be sent to:";

  @override
  String get next => "Next";

  @override
  String get startNow => "Start now!";

  @override
  String get charsRemaining => "Characters remaining:";

  @override
  String get teamNameOrgCompany =>
      "Enter your Team Name, Organization or Company Name.";

  @override
  String get teamNameOrgCompanyLabel => "Ex. My Company Name";

  @override
  String get yourTeam => "Your team";

  @override
  String get noysiServiceNewsletters =>
      "It's ok to receive (very occasionally) emails about NOYSI service.";

  @override
  String get userNameIntro =>
      "Your username is how you appear to others on your team.";

  @override
  String get userNameLabel => "Ex. ackerman";

  @override
  String get addAnother => "Add another";

  @override
  String get byProceedingAcceptTerms =>
      "* By proceeding you accept our <b>Terms of services</b>";

  @override
  String get invitations => "Invitations";

  @override
  String get invitePeople => "Invite people";

  @override
  String get noysiIsTeamWorkInvite =>
      "Noysi is a teamwork tool. Invite at least one person";

  @override
  String get userName => "Username";

  @override
  String get fieldMax18 => "18 chars maximum";

  @override
  String get fieldMax25 => "25 chars maximum";

  @override
  String get fieldPassword => "Password required";

  @override
  String get fieldRequired => "Field required";

  @override
  String get missingEmailFormat => "Wrong email";

  @override
  String get back => "Back";

  @override
  String get channelBrowser => "Channel browser";

  @override
  String get help => "Help";

  @override
  String get preferences => "Preferences";

  @override
  String get signOutOf => "Sign out of";

  @override
  String get closed => "Closed";

  @override
  String get closedMilestone => "Closed";

  @override
  String get close => "Close";

  @override
  String get opened => "Open";

  @override
  String get chat => "Chat";

  @override
  String get allThreads => "All threads";

  @override
  String get inviteMorPeople => "Invite more people";

  @override
  String get meeting => "Meeting";

  @override
  String get myFiles => "My files";

  @override
  String get myTasks => "My tasks";

  @override
  String get myTeams => "My teams";

  @override
  String get openChannels => "Open channels";

  @override
  String get privateGroups => "Private groups";

  @override
  String get favorites => "Favorites";

  @override
  String get message1x1 => "Messages 1 to 1";

  @override
  String get acceptedTitle => "Accepted";

  @override
  String get date => "Date";

  @override
  String get invitationLanguageTitle => "Language";

  @override
  String get invitationMessage => "Invitation message";

  @override
  String get revokeInvitation => "Revoke invitation";

  @override
  String get revoke => "Revoke";

  @override
  String get revokeInvitationWarning =>
      "Take care, this action is not reversible";

  @override
  String get revokeInvitationDelete => "Invitation delete";

  @override
  String get resendInvitationBefore24hrs =>
      "Invitation resending it is not allowed until 24 hours past since last sending.";

  @override
  String get resendInvitationSuccess => "Invitations sent successfully.";

  @override
  String get resendInvitation => "Resend invitation";

  @override
  String get invitationMessageDefault =>
      "Hi! Here you have an invitation to join";

  @override
  String get inviteManyAsOnce => "Invite many as once";

  @override
  String get inviteMemberTitle =>
      "Team members have full access to open channels, person-to-person messages, and groups.";

  @override
  String get inviteMemberWarningTitle =>
      "To invite new members you must be the team administrator.";

  @override
  String get inviteNewMemberWarningTitle =>
      "Any member of the team can add guests unlimitedly.";

  @override
  String get inviteSubtitle =>
      "Noysi is a tool to work better with your Team. Invite them now!";

  @override
  String get inviteTitle => "Invite other people";

  @override
  String get inviteToAGroup => "Invite to a group (required)";

  @override
  String get inviteToAGroupNotRequired => "Invite to a group (optional)";

  @override
  String get inviteMemberWarning =>
      "New members will join the #general channel automatically. Optionally, you can also add them to a private group now.";

  @override
  String get inviteToThisTeam => "Invite to this team";

  @override
  String get invitationsSent => "Invitations sent";

  @override
  String get name => "Name";

  @override
  String get noPendingInvitations =>
      "There is no invitations to send in this team.";

  @override
  String get pendingTitle => "Pending";

  @override
  String get chooseTitle => "Choose";

  @override
  String get seePendingAcceptedInvitations =>
      "See pending and accepted invitations";

  @override
  String get sendInvitations => "Send invitations";

  @override
  String get typeEmail => "Type an email";

  @override
  String get typeEmailComaSeparated => "Type emails by coma separated";

  @override
  String get atNoysi => "at Noysi";

  @override
  String get inviteNewMemberTitle =>
      "Guests do not pay and you can invite as many as you want, but they will only have access to one group within this Team.";

  @override
  String get invited => "Invited";

  @override
  String get thisNameAlreadyExist =>
      "Seems like this name is already in use.";

  @override
  String get emptyList => "Empty list";

  @override
  String get ok => "OK";

  @override
  String get byNameFirst => "By name A-Z";

  @override
  String get byNameInvertedFirst => "By name Z-A";

  @override
  String get download => "Download";

  @override
  String get files => "Files";

  @override
  String get folders => "Folders";

  @override
  String get newTitle => "New";

  @override
  String get newestFirst => "Newest first";

  @override
  String get oldestFirst => "Oldest first";

  @override
  String get see => "See";

  @override
  String get share => "Share";

  @override
  String get moreInfo => "More information";

  @override
  String get assigned => "Assigned";

  @override
  String get author => "Author";

  @override
  String get created => "Created";

  @override
  String get earlyDeliverDate => "Early delivery date";

  @override
  String get farDeliverDate => "Far delivery date";

  @override
  String get filterAuthor => "Filter by author";

  @override
  String get searchUsers => "Search users";

  @override
  String get sort => "Sort";

  @override
  String get sortBy => "Sort by";

  @override
  String get cancel => "Cancel";

  @override
  String get exit => "Exit";

  @override
  String get exitWarning => "Are you sure?";

  @override
  String get deleteChannelWarning =>
      "Are you sure you want to leave this channel?";

  @override
  String get typeMessage => "Type a message...";

  @override
  String get addChannelToFavorites => "Add to favorites";

  @override
  String get removeFromFavorites => "Remove from favorites";

  @override
  String get channelInfo => "Channel info";

  @override
  String get channelMembers => "Channel members";

  @override
  String get channelPreferences => "Channel preferences";

  @override
  String get closeChatVisibility => "Close 1 to 1";

  @override
  String get inviteToGroup => "Invite member to this channel";

  @override
  String get leaveChannel => "Leave channel";

  @override
  String get mentions => "Mentions";

  @override
  String get seeFiles => "See files";

  @override
  String get seeLinks => "See links";

  @override
  String get links => "Links";

  @override
  String get taskManager => "Task manager";

  @override
  String get videoCall => "Video call";

  @override
  String get addReaction => "Add reaction";

  @override
  String get addTag => "Add tag";

  @override
  String get addMilestone => "Add milestone";

  @override
  String get copyMessage => "Copy message";

  @override
  String get copyPermanentLink => "Copy link";

  @override
  String get createThread => "Start a thread";

  @override
  String get edit => "Edit";

  @override
  String get favorite => "Favorite";

  @override
  String get remove => "Remove";

  @override
  String get tryAgain => "Try again";

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
      "Are you sure you want to delete this message? This cannot be undone.";

  @override
  String get deleteMessageTitle => "Delete message";

  @override
  String get edited => "Edited";

  @override
  String get seeAll => "See all";

  @override
  String get copiedToClipboard => "Copied to clipboard!";

  @override
  String get underConstruction => "Under construction";

  @override
  String get reactions => "Reactions";

  @override
  String get all => "All";

  @override
  String get users => "Users";

  @override
  String get documents => "Documents";

  @override
  String get fromLocalStorage => "From local storage";

  @override
  String get photoGallery => "Photo gallery";

  @override
  String get recordVideo => "Record a video";

  @override
  String get takePhoto => "Take a photo";

  @override
  String get useCamera => "From camera";

  @override
  String get videoGallery => "Video gallery";

  @override
  String get changeName => "Change name";

  @override
  String get createFolder => "Create folder";

  @override
  String get createNameWarning =>
      "Names should have maximum of 18 characters, without punctuation marks.";

  @override
  String get newName => "New name";

  @override
  String get rename => "Rename";

  @override
  String get renameFile => "Rename file";

  @override
  String get renameFolder => "Rename folder";

  @override
  String get deleteFile => "Delete file";

  @override
  String get deleteFolder => "Delete folder";

  @override
  String get deleteFileWarning => "The folder will be permanently deleted and cannot be recovered. The folder will be inaccessible from any link.";

  @override
  String get delete => "Delete";

  @override
  String get open => "Open";

  @override
  String get addCommentOptional => "Add comment(optional)";

  @override
  String get shareFile => "Share file";

  @override
  String get groups => "Groups";

  @override
  String get to1_1 => "1 to 1";

  @override
  String get day => "day";

  @override
  String get days => "Days";

  @override
  String get hour => "hour";

  @override
  String get hours => "hours";

  @override
  String get minute => "minute";

  @override
  String get minutes => "minutes";

  @override
  String get month => "Month";

  @override
  String get months => "Months";

  @override
  String get year => "year";

  @override
  String get years => "years";

  @override
  String get by => "by";

  @override
  String get deliveryDateIn => "Due date in";

  @override
  String get ago => "Ago";

  @override
  String get taskOpened => "Open";

  @override
  String get assignees => "Assignees";

  @override
  String get assigneeBy => "Assigned by";

  @override
  String get closeTask => "Close task";

  @override
  String get comment => "Comment";

  @override
  String get deliveryDate => "Due date";

  @override
  String get leaveAComment => "Leave a comment";

  @override
  String get milestone => "Milestone";

  @override
  String get milestones => "Milestones";

  @override
  String get color => "Color";

  @override
  String get milestoneAdded => "Added to milestone";

  @override
  String get participants => "Participants";

  @override
  String get reopen => "Reopen";

  @override
  String get completed => "Completed";

  @override
  String get dueDateUpdated => "Due date updated";

  @override
  String get dueDate => "Due date";

  @override
  String get lastDueDate => "Last due date";

  @override
  String get commented => "Commented";

  @override
  String get tagAdded => "Tag added";

  @override
  String get tagRemoved => "Tag removed";

  @override
  String get tags => "Tags";

  @override
  String get update => "Update";

  @override
  String get details => "Details";

  @override
  String get timeline => "Timeline";

  @override
  String get aboutMe => "About me";

  @override
  String get acceptNews => "Receive news";

  @override
  String get allActive => "All active";

  @override
  String get changePhoto => "Change photo";

  @override
  String get changeYourPassword => "Change your password";

  @override
  String get changeYourPasswordAdvice =>
      "The password must have at least eight characters including a number, a capital letter and a lowercase letter, you can use special characters like @#\$%^&+= and ten or more characters to improve the security of your password";

  @override
  String get charge => "Charge";

  @override
  String get country => "Country";

  @override
  String get disabled => "Disabled";

  @override
  String get emailNotification => "Email notifications";

  @override
  String get language => "Language";

  @override
  String get lastName => "Last name";

  @override
  String get maxEveryHour => "Every hour";

  @override
  String get maxHalfDay => "Every 12 hours";

  @override
  String get messages1x1AndMentions => "Messages 1x1 and @mentions";

  @override
  String get myProfile => "My profile";

  @override
  String get never => "Never";

  @override
  String get newPassword => "New password";

  @override
  String get newsLetters => "Newsletter";

  @override
  String get notReceiveNews => "Do not receive news";

  @override
  String get notifications => "Notifications";

  @override
  String get passwordRequirements =>
      "Change your password periodically to increase your security and protection";

  @override
  String get phoneNotifications => "Phone notifications";

  @override
  String get phoneNumber => "Phone number";

  @override
  String get photoSizeRestrictions =>
      "Use a square photo with a maximum width of 400px(small)";

  @override
  String get repeatNewPassword => "Repeat new password";

  @override
  String get security => "Security";

  @override
  String get skypeUserName => "Skype user";

  @override
  String get sounds => "Sounds";

  @override
  String get yourUserName => "Your username";

  @override
  String get saveChanges => "Save changes";

  @override
  String get profileEmailUsesWarning =>
      "This email is used only for notifications on this team.";

  @override
  String get pushMobileNotifications => "Push mobile notifications";

  @override
  String get saveNotificationChanges => "Save notification changes";

  @override
  String get updatePassword => "Update password";

  @override
  String get updateProfileInfo => "Update profile info";

  @override
  String get password8CharsRequirement =>
      "Password must have at least 8 characters.";

  @override
  String get passwordAtLeast1CapitalLetter =>
      "Password must contains at least 1 capital letter.";

  @override
  String get passwordAtLeast1LowerCaseLetter =>
      "Password must contains at least 1 lowercase letter.";

  @override
  String get passwordAtLeast1Number =>
      "Password must contains at least 1 number.";

  @override
  String get passwordMustMatch => "Password must match.";

  @override
  String get notificationUpdatedSuccess => "Notification changes updated.";

  @override
  String get passwordUpdatedSuccess => "Password updated.";

  @override
  String get profileUpdatedSuccess => "Profile updated";

  @override
  String get enablePermissions => "Enable permissions";

  @override
  String get permissionDenied => "Permission denied";

  @override
  String get savePreferences => "Save preferences";

  @override
  String get turnOffChannelEmails => "Do not receive channel emails";

  @override
  String get turnOffChannelSounds => "Turn off channel sounds";

  @override
  String get chatMessageUnavailable =>
      "Chat messages is unavailable with for this user";

  @override
  String get createChannel => "Create channel";

  @override
  String get createNewChannel => "Create a new channel";

  @override
  String get isTyping => "is typing...";

  @override
  String get createPrivateGroup => "Create Private Group";

  @override
  String get createPrivateGroupWarning =>
      "You are going to create a new GROUP, you can add people to this group if they are already part of your team, if not, create the group first and invite them later.";

  @override
  String get createNewPrivateGroup => "Create a new private group";

  @override
  String get createNewChannelAction =>
      "You are about to create a new Open Channel.";

  @override
  String get createNewChannelForAdminsOnly => "Only admins access to write.";

  @override
  String get openChannelAllMemberAccess => "All team members have read access.";

  @override
  String get and => "And";

  @override
  String get userIsInactiveToChat =>
      "You cannot chat with this user because it's inactive.";

  @override
  String get selectChannel => "Select channel";

  @override
  String get needToSelectChannel => "You need to select a channel";

  @override
  String get fileAlreadyShared =>
      "This file is already shared with the same name in the channel you selected.";

  @override
  String get inChannel => "in channel";

  @override
  String seeAnswerMessages(int count) => "See $count messages";

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
    return "User $name has joined the channel";
  }

  @override
  String userHasLeft(String name) {
    return "User $name has left the channel";
  }

  @override
  String invitedBy(String name) {
    return "Invited by $name";
  }

  @override
  String get answers => "Answers";

  @override
  String get publishIn => "publish in";

  @override
  String get hasCommentedOnThread => "Has commented on a thread:";

  @override
  String get unReadMessages => "Unread messages";

  @override
  String get hasAddedTag => "Has added the tag";

  @override
  String get hasAssignedUser => "Has assigned the user";

  @override
  String get hasClosedTask => "Has closed the task";

  @override
  String get hasCommentedTask => "Has added a comment";

  @override
  String get hasCreatedTask => "Has created the task";

  @override
  String get hasCreatedTaskAssignedTo => "Has created a new task assigned to";

  @override
  String get hasDeleteTag => "Has deleted the tag";

  @override
  String get hasDeletedCommentTask => "Has deleted a comment";

  @override
  String get hasEditedCommentTask => "Has edited a comment";

  @override
  String get hasEditedTask => "Has edited the task";

  @override
  String get hasRemovedEndDateTask => "Has deleted the end date of";

  @override
  String get hasReopenedTask => "Has reopen the task";

  @override
  String get hasSetMilestone => "Has set the milestone";

  @override
  String get hasUnAssignedUser => "Has unassigned the user";

  @override
  String get hasUpdatedDateTask => "Has updated the end date of";

  @override
  String get inTheTask => "In the task";

  @override
  String get to => "to";

  @override
  String get hasAssignedNewDueDateFor => "Has assigned a new due date for";

  @override
  String get createNewTag => "Create new tag";

  @override
  String get createNewMilestone => "Create new milestone";

  @override
  String get editMilestone => "Edit milestone";

  @override
  String get editTag => "Edit tag";

  @override
  String get openTasks => "Open tasks";

  @override
  String get newPersonalNote => "New personal note";

  @override
  String get createNewPersonalNote => "Create personal note";

  @override
  String get filterBy => "Filter by";

  @override
  String hereStartsYourMessagesWith(String name) =>
      "Here start your messages with @$name";

  @override
  String thisChannelIsManagedBy(String name) =>
      "This channels is managed by @$name, if need help contact administrator.";

  @override
  String newPush(String user, String repository, String repositoryUrl) {
    String part1 = "New push of";
    String part2 = "in the repository";
    String part3 = R.string.viewDetails;

    return "<p>$part1 <span class='link-mention'>@$user</span> $part2 <span><a href='$repositoryUrl'>$repository. $part3</a></span></p>";
  }

  @override
  String unassignedTask(
    String repository,
    String repositoryUrl,
  ) {
    String part1 = "Unassigned task in the repository";
    String part2 = R.string.viewDetails;
    return "<p>$part1 <a href='$repositoryUrl'>$repository. $part2</a></p>";
  }

  @override
  String cardTrelloCreate(
      String board, String boardUrl, String card, String cardUrl, String list) {
    String part1 = "Card created";
    String part2 = "in the list";
    String part3 = "of board";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 $list $part3 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloRename(String board, String boardUrl, String oldName,
      String newName, String list) {
    String part1 = "In the list";
    String part2 = "of board";
    String part3 = "the card has been renamed";
    String part4 = "to";
    return "<p>$part1 '$list' $part2 <a href='$boardUrl'>$board</a> $part3 '$oldName' $part4 '$newName'</p>";
  }

  @override
  String cardTrelloDescriptionChange(String board, String boardUrl, String card,
      String cardUrl, String list, String description) {
    String part1 = "The card";
    String part2 = "of the list";
    String part3 = "of the board";
    String part4 = "has changed its description to";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4 '$description'</p>";
  }

  @override
  String cardTrelloMoveToOtherList(String board, String boardUrl, String card,
      String cardUrl, String oldList, String newList) {
    String part1 = "The card";
    String part2 = "has been moved from the list";
    String part3 = "to the list";
    String part4= "in the board";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$oldList' $part3 '$newList' $part4 <a href='$boardUrl'>$board</a></p>";
  }

  @override
  String cardTrelloArchive(String board, String boardUrl, String card,
      String cardUrl, String list) {
    String part1 = "The card";
    String part2 = "of the list";
    String part3 = "of the board";
    String part4 = "has been archived";
    return "<p>$part1 <a href='$cardUrl'>$card</a> $part2 '$list' $part3 <a href='$boardUrl'>$board</a> $part4</p>";
  }

  @override
  String get comments => "Comments";

  @override
  String get addComment => "Add comment";

  @override
  String get editComment => "Edit Comment";

  @override
  String get downloadAppsAndSynchronizer =>
      "<a href = 'https://noysi.com/a/#/downloads'>DOWNLOAD THE APPS NOW!</a>";

  @override
  String get welcomeToNoysiFirstName => "Welcome! This is your personal channel, no one else will see it, it does not not have communication with anyone else, it is your personal channel for you to leave personal notes and upload files that no one else will see. What is your name?";

  @override
  String get welcomeToNoysiTimeout =>
      "You have not answered me! If you need help click <a href='${Endpoint.helpUrl}'>here.</a>";

  @override
  String get wrongUsernamePassword => "Wrong Username or Password";

  @override
  String get userInUse => "This user is already in use";

  @override
  String get invite => "Invite";

  @override
  String get groupRequired => "Group required";

  @override
  String get uploading => "Uploading";

  @override
  String get downloading => "Downloading";

  @override
  String get inviteGuestsWarning => "Guests join only one group in this team.";

  @override
  String get addMembers => "Add members";

  @override
  String get enterEmailsByComma =>
      "Enter emails by separating them with commas:";

  @override
  String get firstName => "Firstname";

  @override
  String get inviteFewMorePersonal => "Invite a few and be more personal";

  @override
  String get inviteManyAtOnce => "Invite many at once";

  @override
  String get addGuests => "Add guests";

  @override
  String get followThread => "Follow this thread";

  @override
  String get markThreadAsRead => "Mark as read";

  @override
  String get stopFollowingThread => "Stop following this thread";

  @override
  String get needToVerifyAccountToInvite =>
      "You need to verify the email account in order to invite members.";

  @override
  String get createANewTeam => "Create a new team";

  @override
  String get createNewTeam => "Create new team!";

  @override
  String get enterIntoYourAccount => "Enter into your account";

  @override
  String get forgotPassword => "Forgot your password?";

  @override
  String get goAhead => "Go ahead!";

  @override
  String get passwordRestriction => "The password must have at least eight characters including a number, an uppercase letter and a lowercase letter, you can use special characters like @ # \$% ^ & + = and ten or more characters to improve the security of your password.";

  @override
  String get recoverYorPassword => "Recover your password";

  @override
  String get recoverYorPasswordWarning => "To restore your password, enter the email address you use to sign in to noysi.com";

  @override
  String recoverPasswordResponse(String email) {
    return "We've sent you an email to $email";
  }

  @override
  String get recoverPasswordResponse1 =>
      "Check your inbox and follow instructions there to create your new password";

  @override
  String get continueStr => "Continue";

  @override
  String get passwordAtLeast1SpecialChar => "The password must include at least 1 special character @#\$%^&+=";

  @override
  String welcomeToNoysiLastName(String name) => "Hello $name. What is your surname?";

  @override
  String get welcomeToNoysiDescription => "Very well. Everything is correct. I will proceed to update your profile.";

  @override
  String get welcomeToNoysiInvite => "<a href = '#'>Invite your team members now!</a>";

  @override
  String get activeFilter => "Active filter";

  @override
  String get newFileComment => "New comment on the file";

  @override
  String get removed => "Removed";

  @override
  String get sharedOn => "Shared on";

  @override
  String get notifyAllInThisChannel => "notify everyone in this channel";

  @override
  String get notifyAllMembers => "notify all members";

  @override
  String get keepPressingToRecord => "Please press and hold the button to record";

  @override
  String get slideToCancel => "Swipe to cancel";

  @override
  String get chooseASecurePasswordText => "Choose a secure password that you can remember";

  @override
  String get confirmPassword => "Repeat password";

  @override
  String get yourPassword => "Password";

  @override
  String get passwordDontMatch => "Passwords do not match";

  @override
  String get changeCreateTeamMail => "No, I want to change the email";

  @override
  String step(int number) => "Step $number";

  @override
  String get user => "User";

  @override
  String get deleteFolderWarning => "The folder will be permanently deleted and cannot be recovered";

  @override
  String get calendar => "Calendar";

  @override
  String get week => "Week";

  @override
  String get folderIsNotInCurrentTeam => "The folder is not associated with the current Team";

  @override
  String get folderIsNotInAvailableChannel => "The referenced folder is not in an available channel in file explorer";

  @override
  String get folderLinked => "Folder linked in channel";

  @override
  String get folderShared => "The folder has been shared to the channel";

  @override
  String get folderUploaded => "The folder has been uploaded to the channel";

  @override
  String get folderNotFound => "Folder not found";

  @override
  String get folderNameIncorrect => "The folder name is not valid";

  @override
  String get cloneFolder => "Clone folder";

  @override
  String get cloneFolderInfo => "Cloning a folder creates a new folder in the destination channel with the same status and content as the selected folder at this time.";

  @override
  String get folderDeleted => "You cannot access to a deleted folder";

  @override
  String get youWereInADeletedFolder => "You were in a folder that was deleted";

  @override
  String get dateFormat6 => "MM/dd/yyyy";

  @override
  String get activityZone => "Activity Zone";

  @override
  String get categories => "Categories";

  @override
  String get category => "Category";

  @override
  String get clearAll => "Clear All";

  @override
  String get createdTask => "Task Created";

  @override
  String get errorFetchingData => "Error fetching data";

  @override
  String get filters => "Filters";

  @override
  String get loggedIn => "Logged In";

  @override
  String get mention => "Mention";

  @override
  String get messageSent => "Message Sent";

  @override
  String get messageUnavailable => "Message Unavailable";

  @override
  String get openSessions => "Open Sessions";

  @override
  String get taskAssigned => "Assigned Task";

  @override
  String get taskUnassigned => "Unassigned Task";

  @override
  String get uploadedFile => "File Uploaded";

  @override
  String get uploadedFileFolder => "File/Folder Uploaded";

  @override
  String get uploadedFolder => "Folder Uploaded";

  @override
  String get downloadedFile => "File Downloaded";

  @override
  String get downloadedFileFolder => "File/Folder Downloaded";

  @override
  String get downloadedFolder => "Folder Downloaded";

  @override
  String activityFileFolderUploadedDownloaded(String user, String name, String channel, {bool download = false, bool isDirect = false, isFolder = false}) {
    String part1 = "You have ${download ? "downloaded" : "uploaded"}${isFolder ? " the folder " : " the file "}";
    String part2 = download ? "from the channel" : "on the channel";
    return "$part1 <i class=\"mention-generic\">$name</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMentioned(String user, String channel, {bool isDirect = false}) {
    String part1 = "You have been mentioned on the channel";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityMessageSent(String user, String channel, {bool isDirect = false}) {
    String part1 = "You have sent a message on the channel";
    return "$part1 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activitySignedIn(String sessionInfo, String ip) {
    return "You have logged in <i class=\"mention-generic\">$sessionInfo</i> IP: <i class=\"mention-generic\">$ip</i>";
  }

  @override
  String activityTaskAssigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "You have been assigned to the task";
    String part2 = "on the channel";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskCreated(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "You have created the task";
    String part2 = "on the channel";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String activityTaskUnassigned(String user, String title, String channel, {bool isDirect = false}) {
    String part1 = "You have been deallocated from the task";
    String part2 = "on the channel";
    return "$part1 <i class=\"mention-generic\">$title</i> $part2 <i class=\"mention-generic\">${isDirect ? "@$channel" : channel}</i>";
  }

  @override
  String get activityZoneHeader => "Here starts the Activity Zone";

  @override
  String get selectEvent => "Select Event";

  @override
  String get googleCalendar => "Google";

  @override
  String get outlookCalendar => "Outlook";

  @override
  String get noysiCalendar => "Noysi";

  @override
  String get autogenerateRoomNameQuestion => "Do you want to generate the room name automatically?";

  @override
  String get createMeetingEvent => "Create Event-Meeting";

  @override
  String get externalGuests => "External guests";

  @override
  String get internalGuests => "Internal guests";

  @override
  String get newMeetingEvent => "New Event-Meeting";

  @override
  String get roomName => "Room name";

  @override
  String get eventMeeting => "Event-Meeting";

  @override
  String get personalNote => "Personal note";

  @override
  String get updateExternalGuests => "Update external guests";

  @override
  String get nameTextWarning => "The text refers to an alphanumeric string of 1-25 characters. You can also use spaces and the characters _ -";

  @override
  String get nameTextWarningWithoutSpaces => "The text corresponds to an alphanumeric string of 1-18 characters without spaces. You can also use the characters _ -";

  @override
  String get today => "Today";

  @override
  String get location => "Location";

  @override
  String get sessions => "Sessions";

  @override
  String get appVersion => "App Version";

  @override
  String get browser => "Browser";

  @override
  String get device => "Device";

  @override
  String get logout => "Log Out";

  @override
  String get manufacturer => "Manufacturer";

  @override
  String get no => "No";

  @override
  String get operativeSystem => "Operative System";

  @override
  String get yes => "Yes";

  @override
  String get allDay => "All Day";

  @override
  String get endDate => "End Date";

  @override
  String get noTitle => "No Title";

  @override
  String get currentSession => "Current Session";

  @override
  String get logOutAllExceptForThisOne => "Log out all devices except for this one";

  @override
  String get terminateAllOtherSessions => "Terminate all other sessions";

  @override
  String get closeAllSessionsConfirmation => "Do you want to terminate all other sessions?";

  @override
  String get closeSessionConfirmation => "Do you want to terminate the session?";

  @override
  String get connectionLost => "Oops, it seems that there is no connection";

  @override
  String get connectionEstablished => "You are back online";

  @override
  String get connectionStatus => "Connection Status";

  @override
  String get anUserIsCalling => "An user is calling you...";

  @override
  String get answer => "Answer";

  @override
  String get hangDown => "Decline";

  @override
  String get incomingCall => "Incoming Call";

  @override
  String isCallingYou(String user) => "$user is calling you...";

  @override
  String get callCouldNotBeInitialized => "The call could not be initialized";

  @override
  String get sentMessages => "Sent Messages";

  @override
  String sentMessagesCount(String count) => "$count of 10000";

  @override
  String get teamDataUsage => "Team Data Usage";

  @override
  String get usedStorage => "Used Storage";

  @override
  String usedStorageText(String used) => used + "GB of 5GB";

  @override
  String get userDataUsage => "User Data Usage";

  @override
  String get audioEnabled => "Audio Enabled";

  @override
  String get meetingOptions => "Meeting Options";

  @override
  String get videoEnabled => "Video Enabled";

  @override
  String get dontShowThisMessage => "Don't show again";

  @override
  String get showDialogEveryTime => "Show dialog every time a meeting starts";

  @override
  String get micAndCameraRequiredAlert => "Camera and microphone access permissions are required, please make sure you have granted the necessary permissions. Do you want to go to the permission settings?";

  @override
  String get connectWith => "Sign in with";

  @override
  String get or => "or";

  @override
  String get noEvents => "No events, tasks or personal notes";

  @override
  String get viewDetails => "View Details";

  @override
  String zendeskTicketUpdated(String user, String status, String type, String title, String url) {
    String part1 = R.string.user;
    String part2 = "updated the ticket";
    String part3 = "of type";
    String part4 = "to status";
    String part5 = R.string.viewDetails;
    return "<p>$part1 '$user' $part2 '$title' $part3 '$type' $part4 '$status'. <span><a href='$url'>$part5</a></span></p>";
  }

  @override
  String get accept => "Accept";

  @override
  String get busy => "Busy";

  @override
  String get configuration => "Configuration";

  @override
  String get downloads => "Downloads";

  @override
  String get editTeam => "Edit Team";

  @override
  String get general => "General";

  @override
  String get integrations => "Integrations";

  @override
  String get noRecents => "No Recents";

  @override
  String get noRecommendations => "No Recommendations";

  @override
  String get inAMeeting => "In a Meeting";

  @override
  String get onFire => "On Fire";

  @override
  String get plans => "Plans";

  @override
  String get setAStatus => "Set a Status";

  @override
  String get sick => "Sick";

  @override
  String get signOut => "Sign Out";

  @override
  String get suggestions => "Suggestions";

  @override
  String get teams => "Teams";

  @override
  String get traveling => "Traveling";

  @override
  String get whatsYourStatus => "What's your status?";

  @override
  String get sendAlwaysAPush => "Send always a push notification";

  @override
  String get robot => "Robot";

  @override
  String get deactivateUserWarning => "Team members will not be able to communicate with a member while it is disabled. However, all activity performed by the deactivated member in Noysi will remain intact and messages (open channels, 1 to 1 messages and private groups), files and tasks will be accessible.";

  @override
  String get activateUserWarning => "Once the member is reactivated, he will recover the access to the same channels, groups, files and tasks he had before being deactivated.";

  @override
  String get changeRole => "Change role";

  @override
  String get userStatus => "User status";

  @override
  String get deactivateMyAccount => "Deactivate my account";

  @override
  String get deactivateMyAccountWarning => "If you deactivate your account, you'll be deactivated in all your teams, conversations, files, tasks, and any activities that you have managed through Noysi until an admin reactivates you again.";

  @override
  String get deactivateMyUserInThisTeam => "Deactivate my user in this team";

  @override
  String get deactivateMyUserInThisTeamWarning => "When you deactivate yourself in a team everything you own in that team will remain until you get activated again. If you are the only team admin, the team will not be deleted.";

  @override
  String get operationConfirmation => "Are you sure of this operation?";

  @override
  String get formatNotSupported => "This format or extension is not supported by the Operative System";

  @override
  String get invitePrivateGroupLink => "Invite a member to the group using this link";

  @override
  String get invalidPhoneNumber => "Invalid phone number";

  @override
  String get searchByCountryName => "Search by country name or dial code";

  @override
  String get kick => "Kick";

  @override
  String get deleteAll => "Delete All";

  @override
  String get enterKeyManually => "Enter key manually";

  @override
  String get noysiAuthenticator => "Noysi Authenticator";

  @override
  String get qrScanner => "QR";

  @override
  String get otpLabelWarning => "OTP label is an alphanumeric string without spaces :@.,;()\$% are also allowed";

  @override
  String get invalidBase32Chars => "Invalid base32 characters";

  @override
  String get label => "Label";

  @override
  String get secretCode => "Secret key";

  @override
  String get labelTextWarning => "Label is empty, please check this value";

  @override
  String missedCallFrom(String user) => "Missed call from $user";

  @override
  String get activeItemBackgroundColor => "Active item background";

  @override
  String get activeItemTextColor => "Active item text";

  @override
  String get activePresenceColor => "Active presence";

  @override
  String get adminsCanDeleteMessage => "Admins can delete messages";

  @override
  String get allForAdminsOnly => "@all for Administrators only";

  @override
  String get channelForAdminsOnly => "@channel only for Administrators and Channel Creators";

  @override
  String get chooseTheme => "Choose a theme for your team";

  @override
  String get enablePushAllChannels => "Enable push notifications on all channels";

  @override
  String get inactivePresenceColor => "Inactive presence";

  @override
  String get leaveTeam => "Leave this team";

  @override
  String get leaveTeamWarning => "When you leave a team everything you own in that team will be deleted. If you are the only team admin, the team will be deleted.";

  @override
  String get notificationBadgeBackgroundColor => "Badge background";

  @override
  String get notificationBadgeTextColor => "Badge Text";

  @override
  String get onlyAdminInvitesAllowed => "Guests only authorized by Administrators";

  @override
  String get reset => "Reset";

  @override
  String get settings => "Settings";

  @override
  String get sidebarColor => "Sidebar color";

  @override
  String get taskUpdateProtected => "Modification of Tasks reserved for Creators and Administrators";

  @override
  String get teamName => "Team name";

  @override
  String get textColor => "Text color";

  @override
  String get theme => "Theme";

  @override
  String get updateUsernameBlocked => "Block username when sending invitation";

  @override
  String get fileNotFound => "File not found";

  @override
  String get messageNotFound => "Message not found, please check if the message you are looking for is available in the current team.";

  @override
  String get taskNotFound => "Task not found";

  @override
  String userHasPinnedMessage(String name) => "$name has pinned a message to the channel";

  @override
  String userHasUnpinnedMessage(String name) => "$name has unpinned the message from this channel";

  @override
  String get pinMessage => "Pin message";

  @override
  String get unpinMessage => "Unpin message";

  @override
  String get pinnedMessage => "Pinned message";

  @override
  String get deleteMyAccount => "Delete my account";

  @override
  String get yourDeleteRequestIsInProcess => "Your account deletion request is in process";

  @override
  String get deleteMyAccountWarning => "If you delete your account the action will be irreversible. If you manage a team and there is no other administrator, the team will be deleted.";

  @override
  String get lifetimeDeal => "Lifetime Deals";

  @override
  String get showEmails => "Show user emails";

  @override
  String get showPhoneNumbers => "Show user phone numbers";

  @override
  String get addChannel => "Add Channel";

  @override
  String get addPrivateGroup => "Add Private Group";

  @override
  String get selectUserFromTeam => "Select user from this team";

  @override
  String get selectUsersFromChannelGroup => "Select users from channel or group";

  @override
  String get memberDeleted => "Member deleted";
}

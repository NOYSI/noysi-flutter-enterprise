import 'dart:io';

import 'package:code/_di/injector.dart';
import 'package:code/data/api/remote/endpoints.dart';
import 'package:code/data/api/remote/remote_constants.dart';

import '../_res/R.dart';
import '../domain/user/user_model.dart';

class CommonUtils {
  static String getDefLang() {
    try {
      return Platform.localeName.split("_").first;
    } catch (_) {
      return RemoteConstants.defLang;
    }
  }

  static String getUsernameFromLink(String link) {
    final currentTeamName = Injector.instance.inMemoryData.currentTeam?.name ?? "";
    return link.startsWith(
            "#${Endpoint.teams}/$currentTeamName${Endpoint.channels}/")
        ? link
            .split('/')[link.split('/').length - 2]
            .replaceFirst('@', '')
            .toLowerCase()
            .trim()
        : "";
  }

  static String? getMemberName(MemberModel? memberModel) {
    final isEnterprise = Injector.instance.inMemoryData.currentWhiteBrandConfig != null;
    if ((memberModel?.id) == RemoteConstants.noysiRobot && isEnterprise) {
      return Injector.instance.inMemoryData.currentTeam?.titleFixed;
    } else if ((memberModel?.id) == RemoteConstants.noysiRobot) {
      return 'Noysi';
    } else if (memberModel?.isDeletedUser == true) {
      return R.string.memberDeleted;
    }
    String? name = memberModel?.profile?.fullNameWithUsername;
    return name?.trim().isNotEmpty == true ? name : memberModel?.profile?.name;
  }

  static String? getMemberNameSingle(MemberModel? memberModel) {
    final isEnterprise = Injector.instance.inMemoryData.currentWhiteBrandConfig != null;
    if ((memberModel?.id) == RemoteConstants.noysiRobot && isEnterprise) {
      return Injector.instance.inMemoryData.currentTeam?.titleFixed;
    } else if ((memberModel?.id) == RemoteConstants.noysiRobot) {
      return 'Noysi';
    } else if (memberModel?.isDeletedUser == true) {
      return R.string.memberDeleted;
    }
    String? name = memberModel?.profile?.fullName;
    return name?.trim().isNotEmpty == true ? name : memberModel?.profile?.name;
  }

  static String? getMemberUsername(MemberModel? memberModel) {
    final isEnterprise = Injector.instance.inMemoryData.currentWhiteBrandConfig != null;
    if ((memberModel?.id) == RemoteConstants.noysiRobot && isEnterprise) {
      return Injector.instance.inMemoryData.currentTeam?.name;
    } else if ((memberModel?.id) == RemoteConstants.noysiRobot) {
      return RemoteConstants.noysiUsername;
    } else if (memberModel?.isDeletedUser == true) {
      return R.string.memberDeleted;
    }
    return memberModel?.profile?.name.trim();
  }

  static String getMemberPhoto(MemberModel? memberModel) {
    final isEnterprise = Injector.instance.inMemoryData.currentWhiteBrandConfig != null;
    if ((memberModel?.id) == RemoteConstants.noysiRobot && isEnterprise) {
      return Injector.instance.inMemoryData.currentTeam?.photo ?? R.image.logo;
    } else if((memberModel?.id) == RemoteConstants.noysiRobot) {
      return R.image.logo;
    }
    return memberModel?.photo ?? "";
  }
}

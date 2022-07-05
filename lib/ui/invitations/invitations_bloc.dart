import 'package:code/_res/R.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/team/i_team_repository.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

class InvitationsBloC extends BaseBloC with ErrorHandlerBloC {
  final ITeamRepository _iTeamRepository;
  final SharedPreferencesManager _prefs;

  InvitationsBloC(this._iTeamRepository, this._prefs);

  @override
  void dispose() {
    disposeErrorHandlerBloC();
    _invitationsPendingController.close();
    _invitationsAcceptedController.close();
    _pageTabController.close();
    _sortController.close();
  }

  BehaviorSubject<int> _sortController = new BehaviorSubject();

  Stream<int> get sortResult => _sortController.stream;

  BehaviorSubject<List<InvitationPendingAcceptedModel>?>
      _invitationsPendingController = new BehaviorSubject();

  Stream<List<InvitationPendingAcceptedModel>?> get invitationsPendingResult =>
      _invitationsPendingController.stream;

  BehaviorSubject<List<InvitationPendingAcceptedModel>?>
      _invitationsAcceptedController = new BehaviorSubject();

  Stream<List<InvitationPendingAcceptedModel>?> get invitationsAcceptedResult =>
      _invitationsAcceptedController.stream;

  BehaviorSubject<int> _pageTabController = new BehaviorSubject();

  Stream<int> get pageTabResult => _pageTabController.stream;

  String teamId = "";
  List<InvitationPendingAcceptedModel> allPending = [];
  List<InvitationPendingAcceptedModel> allAccepted = [];

  void initData() async {
    teamId = await _prefs.getStringValue(_prefs.currentTeamId);
    _pageTabController.sinkAddSafe(1);
    loadInvitations("pending");
  }

  void changePageTab(int tab) async {
    _pageTabController.sinkAddSafe(tab);
    if (tab == 2 && (_invitationsAcceptedController.valueOrNull ?? []).isEmpty)
      loadInvitations("accepted");
    if (tab == 1 && (_invitationsPendingController.valueOrNull ?? []).isEmpty)
      loadInvitations("pending");
  }

  int offsetPending = 0, offsetAccepted = 0, totalPending = 0, totalAccepted = 0, max = 50;
  Future<void> loadInvitations(String status, {bool refresh = false}) async {
    if(refresh) {
      if(status == "pending") {
        offsetPending = 0;
        totalPending = 0;
        allPending.clear();
      } else {
        offsetAccepted = 0;
        totalAccepted = 0;
        allAccepted.clear();
      }
    }
    if(status == "pending" && (offsetPending < totalPending || totalPending == 0)) {
      final toLoad = (totalPending - offsetPending >= max) || offsetPending == 0 ? max : totalPending - offsetPending;
      final res = await _iTeamRepository.getPendingAcceptedInvitations(teamId,
          query: "", status: status, offset: offsetPending, max: toLoad, dateOrder: 1);
      if(res is ResultSuccess<InvitationPendingAcceptedWrappedModel>) {
        if(totalPending == 0) totalPending = res.value.total;
        offsetPending += res.value.list.length;
        allPending.addAll(res.value.list);
        _invitationsPendingController.sinkAddSafe(allPending);
      }
    } else if (status == "accepted" && (offsetAccepted < totalAccepted || totalAccepted == 0)) {
      final toLoad = (totalAccepted - offsetAccepted >= max) || offsetAccepted == 0 ? max : totalAccepted - offsetAccepted;
      final res = await _iTeamRepository.getPendingAcceptedInvitations(teamId,
          query: "", status: status, offset: offsetAccepted, max: toLoad, dateOrder: 1);
      if(res is ResultSuccess<InvitationPendingAcceptedWrappedModel>) {
        if(totalAccepted == 0) totalAccepted = res.value.total;
        offsetAccepted += res.value.list.length;
        allAccepted.addAll(res.value.list);
        _invitationsAcceptedController.sinkAddSafe(allAccepted);
      }
    }
  }

  void resendInvitation(String invitationId) async {
    final res = await _iTeamRepository.resendInvitation(teamId, invitationId);
    if (res is ResultSuccess<bool>) {
      Fluttertoast.showToast(
          msg: R.string.resendInvitationSuccess,
          toastLength: Toast.LENGTH_LONG,
          textColor: R.color.whiteColor,
          backgroundColor: R.color.primaryColor);
    } else {
      if ((res as ResultError).code == 403) {
        Fluttertoast.showToast(
            msg: R.string.resendInvitationBefore24hrs,
            textColor: R.color.whiteColor,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.redAccent);
      } else
        showErrorMessage(res);
    }
  }

  void revokeInvitation(String invitationId) async {
    final res = await _iTeamRepository.revokeInvitation(teamId, invitationId);
    if (res is ResultSuccess<bool>) {
      loadInvitations("pending");
    } else {
      showErrorMessage(res);
    }
  }

  int dateOrder = 1;

  void sortByDate() {
    if (dateOrder == 1) {
      dateOrder = 2;
      if (allPending.length >= 2) {
        allPending.sort((v1, v2) => v2.sendDate!.compareTo(v1.sendDate!));
        _invitationsPendingController.sinkAddSafe(allPending);
      }
      if (allAccepted.length >= 2) {
        allAccepted
            .sort((v1, v2) => v2.acceptedDate!.compareTo(v1.acceptedDate!));
        _invitationsAcceptedController.sinkAddSafe(allAccepted);
      }
    } else {
      dateOrder = 1;
      if (allPending.length >= 2) {
        allPending.sort((v1, v2) => v1.sendDate!.compareTo(v2.sendDate!));
        _invitationsPendingController.sinkAddSafe(allPending);
      }
      if (allAccepted.length >= 2) {
        allAccepted
            .sort((v1, v2) => v1.acceptedDate!.compareTo(v2.acceptedDate!));
        _invitationsAcceptedController.sinkAddSafe(allAccepted);
      }
    }
    _sortController.sinkAddSafe(dateOrder);
  }

  void query(String query) async {
    if(_pageTabController.valueOrNull != null) {
      if (_pageTabController.value == 1) {
        final pending = query.trim().isEmpty
            ? allPending
            : allPending
            .where(
                (element) => element.to!.contains(query.trim().toLowerCase()))
            .toList();
        if (pending.length >= 2) {
          if (dateOrder == 1) {
            pending.sort((v1, v2) {
              if(v1.sendDate == null) return -1;
              else if(v2.sendDate == null) return 1;
              return v1.sendDate!.compareTo(v2.sendDate!);
            });
          } else {
            pending.sort((v1, v2) {
              if(v1.sendDate == null) return 1;
              else if(v2.sendDate == null) return -1;
              return v2.sendDate!.compareTo(v1.sendDate!);
            });
          }
        }
        _invitationsPendingController.sinkAddSafe(pending);
      } else {
        final accepted = query.trim().isEmpty
            ? allAccepted
            : allAccepted
            .where(
                (element) => element.to!.contains(query.trim().toLowerCase()))
            .toList();
        if (accepted.length >= 2) {
          if (dateOrder == 1) {
            accepted.sort((v1, v2) {
              if(v1.acceptedDate == null) return -1;
              else if(v2.acceptedDate == null) return 1;
              return v1.acceptedDate!.compareTo(v2.acceptedDate!);
            });
          } else {
            accepted.sort((v1, v2) {
              if(v1.acceptedDate == null) return 1;
              else if(v2.acceptedDate == null) return -1;
              return v2.acceptedDate!.compareTo(v1.acceptedDate!);
            });
          }
        }
        _invitationsAcceptedController.sinkAddSafe(accepted);
      }
    }
  }
}

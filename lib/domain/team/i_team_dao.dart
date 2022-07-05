import 'package:code/domain/team/team_model.dart';

abstract class ITeamDao {
  Future<List<TeamJoinedModel>> getJoinedTeams();

  Future<TeamJoinedModel?> getJoinedTeam(String teamId);

  Future<bool> saveJoinedTeam(TeamJoinedModel model);

  Future<bool> saveJoinedTeams(List<TeamJoinedModel> models);

  Future<List<TeamModel>> getTeams();

  Future<TeamModel?> getTeam(String teamId);

  Future<bool> saveTeam(TeamModel model);

  Future<bool> saveTeams(List<TeamModel> models);

  Future<void> removeTeams();

  Future<void> removeTeam(String teamId);
}

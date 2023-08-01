import 'package:hack_the_thon/util/date_time_extensions.dart';

class HackathonListModel {
  String? sId;
  String? name;
  String? description;
  String? startDate;
  String? endDate;
  String? applicationDeadline;
  String? applicationOpen;
  String? venue;
  int? minTeamSize;
  int? maxTeamSize;
  String? theme;

  HackathonListModel(
      {this.sId,
      this.name,
      this.description,
      this.startDate,
      this.endDate,
      this.applicationDeadline,
      this.applicationOpen,
      this.venue,
      this.minTeamSize,
      this.maxTeamSize,
      this.theme});

  HackathonListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'] ?? '';
    startDate = DateTime.parse(json['start_date']).dayMonthYear();
    endDate = DateTime.parse(json['end_date']).dayMonthYear();
    applicationDeadline = json['application_deadline'] != null
        ? DateTime.parse(json['application_deadline']).dayMonthYear()
        : '';
    applicationOpen = json['application_open'] != null
        ? DateTime.parse(json['application_open']).dayMonthYear()
        : '';
    venue = json['venue'];
    minTeamSize = json['min_team_size'];
    maxTeamSize = json['max_team_size'];
    theme = json['theme'];
  }
}

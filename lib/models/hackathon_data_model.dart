import 'package:hack_the_thon/util/date_time_extensions.dart';

class HackathonDataModel {
  String? sId;
  String? name;
  String? description;
  String? startDate;
  String? endDate;
  String? applicationDeadline;
  String? applicationOpen;
  List<Partners>? partners;
  String? venue;
  String? imageUrl;
  int? minTeamSize;
  int? maxTeamSize;
  String? theme;
  Admin? admin;
  List<Teams>? teams;
  List<Judges>? judges;
  List<Prizes>? prizes;
  List<Faqs>? faqs;
  int? iV;
  List<Winners>? winners;
  List<Announcements>? announcements;

  HackathonDataModel(
      {this.sId,
      this.name,
      this.description,
      this.startDate,
      this.imageUrl,
      this.endDate,
      this.applicationDeadline,
      this.applicationOpen,
      this.partners,
      this.venue,
      this.minTeamSize,
      this.maxTeamSize,
      this.theme,
      this.admin,
      this.teams,
      this.judges,
      this.prizes,
      this.faqs,
      this.iV,
      this.winners,
      this.announcements});

  HackathonDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    startDate = json['start_date'] != null
        ? DateTime.parse(json['start_date']).dayMonthYear()
        : '';
    endDate = json['end_date'] != null
        ? DateTime.parse(json['end_date']).dayMonthYear()
        : '';
    applicationDeadline = json['application_deadline'] != null
        ? DateTime.parse(json['application_deadline']).dayMonthYear()
        : '';
    applicationOpen = json['application_open'] != null
        ? DateTime.parse(json['application_open']).dayMonthYear()
        : '';
    if (json['partners'] != null) {
      partners = <Partners>[];
      json['partners'].forEach((v) {
        partners!.add(Partners.fromJson(v));
      });
    }
    venue = json['venue'];
    minTeamSize = json['min_team_size'];
    maxTeamSize = json['max_team_size'];
    theme = json['theme'];
    imageUrl = json['imgUrl'];
    print('iMGA E UR : ${json['imgUrl']}');
    admin = json['admin'] != null ? Admin.fromJson(json['admin']) : null;
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(Teams.fromJson(v));
      });
    }
    if (json['judges'] != null) {
      judges = <Judges>[];
      json['judges'].forEach((v) {
        judges!.add(Judges.fromJson(v));
      });
    }
    if (json['prizes'] != null) {
      prizes = <Prizes>[];
      json['prizes'].forEach((v) {
        prizes!.add(Prizes.fromJson(v));
      });
    }
    if (json['faqs'] != null) {
      faqs = <Faqs>[];
      json['faqs'].forEach((v) {
        faqs!.add(Faqs.fromJson(v));
      });
    }
    iV = json['__v'];
    if (json['winners'] != null) {
      winners = <Winners>[];
      json['winners'].forEach((v) {
        winners!.add(Winners.fromJson(v));
      });
    }
    if (json['announcements'] != null) {
      announcements = <Announcements>[];
      json['announcements'].forEach((v) {
        announcements!.add(Announcements.fromJson(v));
      });
    }
  }
}

class Partners {
  String? name;
  String? logo;
  String? website;
  String? sId;

  Partners({this.name, this.logo, this.website, this.sId});

  Partners.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'];
    website = json['website'];
    sId = json['_id'];
  }
}

class Admin {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;

  Admin({this.sId, this.firstName, this.lastName, this.email});

  Admin.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
  }
}

class Teams {
  String? sId;
  String? name;
  List<Members>? members;

  Teams({this.sId, this.name, this.members});

  Teams.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
  }
}

class Prizes {
  String? name;
  int? amount;
  String? sId;

  Prizes({this.name, this.amount, this.sId});

  Prizes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['_id'] = this.sId;
    return data;
  }
}

class Faqs {
  String? question;
  String? answer;
  String? sId;

  Faqs({this.question, this.answer, this.sId});

  Faqs.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
    sId = json['_id'];
  }
}

class Announcements {
  String? title;
  String? description;
  String? time;
  String? sId;

  Announcements({this.title, this.description, this.time, this.sId});

  Announcements.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    time = DateTime.parse(json['time']).dayMonthYear();
    sId = json['_id'];
  }
}

class Winners {
  String? sId;
  String? name;
  List<Members>? members;

  Winners({this.sId, this.name, this.members});

  Winners.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
  }
}

class Members {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;

  Members({this.sId, this.firstName, this.lastName, this.email});

  Members.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
  }
}

class Judges {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;

  Judges({this.sId, this.firstName, this.lastName, this.email});

  Judges.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
  }
}

class Activity {
  int? activityId;
  String? activityName;
  String? activityPrice;
  String? activityCity;
  String? activityDescription;
  String? activityPic;
  int? personNumber;
  List<ActivityDuration>? activityDuration;

  Activity({
    this.activityId,
    this.activityName,
    this.activityPrice,
    this.activityCity,
    this.activityDescription,
    this.activityPic,
    this.personNumber,
    this.activityDuration,
  });

  Activity.fromJson(Map<String, dynamic> json) {
    activityId = json['id'];
    activityName = json['activity_name'];
    activityPrice = json['activity_price'];
    activityCity = json['activity_city'];
    activityDescription = json['activity_description'];
    activityPic = json['activity_pic'];
    personNumber = json['person_number'];
    if (json['activity_duration'] != null) {
      activityDuration = <ActivityDuration>[];
      json['activity_duration'].forEach((v) {
        activityDuration!.add(ActivityDuration.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = activityId;
    data['activity_name'] = activityName;
    data['activity_price'] = activityPrice;
    data['activity_city'] = activityCity;
    data['activity_description'] = activityDescription;
    data['activity_pic'] = activityPic;
    data['person_number'] = personNumber;
    if (activityDuration != null) {
      data['activity_duration'] =
          activityDuration!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class ActivityDuration {
  String? activityDate;
  String? activityStartTime;
  String? activityEndTime;

  ActivityDuration(
      {this.activityDate, this.activityStartTime, this.activityEndTime});

  ActivityDuration.fromJson(Map<String, dynamic> json) {
    activityDate = json['activity_date'];
    activityStartTime = json['activity_start_time'];
    activityEndTime = json['activity_end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activity_date'] = activityDate;
    data['activity_start_time'] = activityStartTime;
    data['activity_end_time'] = activityEndTime;
    return data;
  }
}

class notification_model {
  int? status;
  String? message;
  List<notification>? info;

  notification_model({this.status, this.message, this.info});

  notification_model.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    if (json['info'] != null) {
      info = <notification>[];
      json['info'].forEach((v) {
        info!.add(new notification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.info != null) {
      data['info'] = this.info!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class notification {
  int? notificationId;
  int? notificationBy;
  int? notificationTo;
  int? notificationStatus;
  String? notificationText;
  int? notificationType;
  String? createdAt;
  var firstName;
  var lastName;
  var profilePic;
  var carImage;

  notification({this.notificationId, this.carImage, this.notificationBy, this.notificationTo, this.notificationStatus, this.notificationText, this.notificationType, this.createdAt, this.firstName, this.lastName, this.profilePic});

  notification.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    notificationBy = json['notification_by'];
    notificationTo = json['notification_to'];
    notificationStatus = json['notification_status'];
    notificationText = json['notification_text'];
    notificationType = json['notification_type'];
    createdAt = json['created_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePic = json['to_profile_pic'];
    carImage = json['car_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_id'] = this.notificationId;
    data['notification_by'] = this.notificationBy;
    data['notification_to'] = this.notificationTo;
    data['notification_status'] = this.notificationStatus;
    data['notification_text'] = this.notificationText;
    data['notification_type'] = this.notificationType;
    data['created_at'] = this.createdAt;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['to_profile_pic'] = this.profilePic;
    data['car_image'] = this.carImage;
    return data;
  }
}

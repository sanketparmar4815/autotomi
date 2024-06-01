class get_car_condition_model {
  int? status;
  String? message;
  List<getCarCondition>? info;

  get_car_condition_model({this.status, this.message, this.info});

  get_car_condition_model.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    if (json['info'] != null) {
      info = <getCarCondition>[];
      json['info'].forEach((v) {
        info!.add(new getCarCondition.fromJson(v));
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

class getCarCondition {
  int? reportId;
  int? userId;
  int? carId;
  int? bookingId;
  String? reportText;
  var information;
  String? reportImage;
  String? reportThumbnail;
  String? createdAt;
  var tapCount;
  var reportType;
  var tapDy;
  var tapDx;
  var isUpdate;

  getCarCondition({this.reportId, this.isUpdate, this.reportType, this.tapCount, this.tapDy, this.tapDx, this.userId, this.carId, this.bookingId, this.reportText, this.information, this.reportImage, this.reportThumbnail, this.createdAt});

  getCarCondition.fromJson(Map<String, dynamic> json) {
    reportId = json['report_id'];
    userId = json['user_id'];
    carId = json['car_id'];
    bookingId = json['booking_id'];
    reportText = json['report_text'];
    information = json['information'];
    reportImage = json['report_image'];
    reportThumbnail = json['report_thumbnail'];
    createdAt = json['created_at'];
    tapCount = json['tap_count'];
    tapDx = json['tap_dx'];
    tapDy = json['tap_dy'];
    reportType = json['report_type'];
    isUpdate = json['is_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['report_id'] = this.reportId;
    data['user_id'] = this.userId;
    data['car_id'] = this.carId;
    data['booking_id'] = this.bookingId;
    data['report_text'] = this.reportText;
    data['information'] = this.information;
    data['report_image'] = this.reportImage;
    data['report_thumbnail'] = this.reportThumbnail;
    data['created_at'] = this.createdAt;
    data['tap_count'] = this.tapCount;
    data['tap_dy'] = this.tapDy;
    data['tap_dx'] = this.tapDx;
    data['report_type'] = this.reportType;
    data['is_update'] = this.isUpdate;
    return data;
  }
}

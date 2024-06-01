class roming_city_model {
  int? status;
  String? message;
  List<romingCity>? info;

  roming_city_model({this.status, this.message, this.info});

  roming_city_model.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    if (json['info'] != null) {
      info = <romingCity>[];
      json['info'].forEach((v) {
        info!.add(new romingCity.fromJson(v));
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

class romingCity {
  int? cityId;
  String? cityName;
  String? createdAt;

  romingCity({this.cityId, this.cityName, this.createdAt});

  romingCity.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    cityName = json['city_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    data['created_at'] = this.createdAt;
    return data;
  }
}

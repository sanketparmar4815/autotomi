class list_car_model {
  int? status;
  String? message;
  List<car>? info;

  list_car_model({this.status, this.message, this.info});

  list_car_model.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    if (json['info'] != null) {
      info = <car>[];
      json['info'].forEach((v) {
        info!.add(new car.fromJson(v));
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

class car {
  int? categoryId;
  String? categoryName;
  String? categoryImage;
  String? createdAt;

  car({this.categoryId, this.categoryName, this.categoryImage, this.createdAt});

  car.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['category_image'] = this.categoryImage;
    data['created_at'] = this.createdAt;
    return data;
  }
}

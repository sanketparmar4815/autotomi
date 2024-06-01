class availabale_car_model {
  int? status;
  String? message;
  int? totalPage;
  List<availbaleCar>? info;

  availabale_car_model({this.status, this.message, this.totalPage, this.info});

  availabale_car_model.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    totalPage = json['total_page'];
    if (json['info'] != null) {
      info = <availbaleCar>[];
      json['info'].forEach((v) {
        info!.add(new availbaleCar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    data['total_page'] = this.totalPage;
    if (this.info != null) {
      data['info'] = this.info!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class availbaleCar {
  int? carId;
  String? carName;
  int? pricePerDay;
  int? pricePerWeek;
  String? fuelType;
  String? categoryName;
  int? isLikeByMe;
  List<CarImage>? carImage;

  availbaleCar({this.carId, this.pricePerWeek, this.carName, this.pricePerDay, this.fuelType, this.categoryName, this.isLikeByMe, this.carImage});

  availbaleCar.fromJson(Map<String, dynamic> json) {
    carId = json['car_id'];
    carName = json['car_name'];
    pricePerDay = json['price_per_day'];
    pricePerWeek = json['price_per_week'];
    fuelType = json['fuel_type'];
    categoryName = json['category_name'];
    isLikeByMe = json['is_like_by_me'];
    if (json['car_image'] != null) {
      carImage = <CarImage>[];
      json['car_image'].forEach((v) {
        carImage!.add(new CarImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_id'] = this.carId;
    data['car_name'] = this.carName;
    data['price_per_day'] = this.pricePerDay;
    data['price_per_week'] = this.pricePerWeek;
    data['fuel_type'] = this.fuelType;
    data['category_name'] = this.categoryName;
    data['is_like_by_me'] = this.isLikeByMe;
    if (this.carImage != null) {
      data['car_image'] = this.carImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarImage {
  int? imageId;
  int? carId;
  String? image;
  String? createdAt;

  CarImage({this.imageId, this.carId, this.image, this.createdAt});

  CarImage.fromJson(Map<String, dynamic> json) {
    imageId = json['image_id'];
    carId = json['car_id'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_id'] = this.imageId;
    data['car_id'] = this.carId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}

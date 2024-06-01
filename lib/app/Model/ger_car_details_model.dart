class get_car_details_model {
  int? status;
  String? message;
  Info? info;

  get_car_details_model({this.status, this.message, this.info});

  get_car_details_model.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    return data;
  }
}

class Info {
  int? carId;
  int? userId;
  String? carName;
  int? pricePerDay;
  int? pricePerWeek;
  String? exteriorVideo;
  String? exteriorThumbnail;
  String? interiorVideo;
  String? interiorThumbnail;
  int? categoryId;
  String? engine;
  int? seats;
  String? fuelType;
  String? exteriorColor;
  String? interiorColor;
  String? isAc;
  String? isReverseCamera;
  String? isPushToStartKey;
  String? isInfotainmentDisplay;
  String? createdAt;
  String? categoryName;
  int? isLikeByMe;
  var starCount;
  var reviewCount;
  var securityDeposite;
  int? isLuxury;
  List<CarImage>? carImage;
  List<CarBenefit>? carBenefit;

  Info({this.carId, this.isLuxury, this.securityDeposite, this.userId, this.carName, this.pricePerDay, this.pricePerWeek, this.exteriorVideo, this.exteriorThumbnail, this.interiorVideo, this.interiorThumbnail, this.categoryId, this.engine, this.seats, this.fuelType, this.exteriorColor, this.interiorColor, this.isAc, this.isReverseCamera, this.isPushToStartKey, this.isInfotainmentDisplay, this.createdAt, this.categoryName, this.isLikeByMe, this.starCount, this.reviewCount, this.carImage, this.carBenefit});

  Info.fromJson(Map<String, dynamic> json) {
    carId = json['car_id'];
    userId = json['user_id'];
    carName = json['car_name'];
    pricePerDay = json['price_per_day'];
    pricePerWeek = json['price_per_week'];
    exteriorVideo = json['exterior_video'];
    exteriorThumbnail = json['exterior_thumbnail'];
    interiorVideo = json['interior_video'];
    interiorThumbnail = json['interior_thumbnail'];
    categoryId = json['category_id'];
    engine = json['engine'];
    seats = json['seats'];
    fuelType = json['fuel_type'];
    exteriorColor = json['exterior_color'];
    interiorColor = json['interior_color'];
    isAc = json['is_ac'];
    isReverseCamera = json['is_reverse_camera'];
    isPushToStartKey = json['is_push_to_start_key'];
    isInfotainmentDisplay = json['is_infotainment_display'];
    createdAt = json['created_at'];
    categoryName = json['category_name'];
    isLikeByMe = json['is_like_by_me'];
    starCount = json['star_count'];
    isLuxury = json['is_luxury'];
    reviewCount = json['review_count'];
    securityDeposite = json['security_deposite'];
    if (json['car_image'] != null) {
      carImage = <CarImage>[];
      json['car_image'].forEach((v) {
        carImage!.add(new CarImage.fromJson(v));
      });
    }
    if (json['car_benefit'] != null) {
      carBenefit = <CarBenefit>[];
      json['car_benefit'].forEach((v) {
        carBenefit!.add(new CarBenefit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_id'] = this.carId;
    data['user_id'] = this.userId;
    data['car_name'] = this.carName;
    data['price_per_day'] = this.pricePerDay;
    data['price_per_week'] = this.pricePerWeek;
    data['exterior_video'] = this.exteriorVideo;
    data['exterior_thumbnail'] = this.exteriorThumbnail;
    data['interior_video'] = this.interiorVideo;
    data['interior_thumbnail'] = this.interiorThumbnail;
    data['category_id'] = this.categoryId;
    data['engine'] = this.engine;
    data['seats'] = this.seats;
    data['fuel_type'] = this.fuelType;
    data['exterior_color'] = this.exteriorColor;
    data['interior_color'] = this.interiorColor;
    data['is_ac'] = this.isAc;
    data['is_reverse_camera'] = this.isReverseCamera;
    data['is_push_to_start_key'] = this.isPushToStartKey;
    data['is_infotainment_display'] = this.isInfotainmentDisplay;
    data['created_at'] = this.createdAt;
    data['category_name'] = this.categoryName;
    data['is_like_by_me'] = this.isLikeByMe;
    data['star_count'] = this.starCount;
    data['review_count'] = this.reviewCount;
    data['is_luxury'] = this.isLuxury;
    data['security_deposite'] = this.securityDeposite;
    if (this.carImage != null) {
      data['car_image'] = this.carImage!.map((v) => v.toJson()).toList();
    }
    if (this.carBenefit != null) {
      data['car_benefit'] = this.carBenefit!.map((v) => v.toJson()).toList();
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

class CarBenefit {
  int? carBenefitId;
  int? benefitId;
  int? carId;
  String? createdAt;
  String? benefitText;
  String? benefitImage;
  String? benefitDescription;

  CarBenefit({this.carBenefitId, this.benefitDescription, this.benefitId, this.carId, this.createdAt, this.benefitText, this.benefitImage});

  CarBenefit.fromJson(Map<String, dynamic> json) {
    carBenefitId = json['car_benefit_id'];
    benefitId = json['benefit_id'];
    carId = json['car_id'];
    createdAt = json['created_at'];
    benefitText = json['benefit_text'];
    benefitImage = json['benefit_image'];
    benefitDescription = json['benefit_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_benefit_id'] = this.carBenefitId;
    data['benefit_id'] = this.benefitId;
    data['car_id'] = this.carId;
    data['created_at'] = this.createdAt;
    data['benefit_text'] = this.benefitText;
    data['benefit_image'] = this.benefitImage;
    data['benefit_description'] = this.benefitDescription;
    return data;
  }
}

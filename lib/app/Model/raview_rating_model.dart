class review_rating_model {
  int? status;
  String? message;
  Info? info;

  review_rating_model({this.status, this.message, this.info});

  review_rating_model.fromJson(Map<String, dynamic> json) {
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
  int? bookingId;
  String? uniqueId;
  int? bookingBy;
  int? carId;
  String? country;
  String? city;
  String? startDate;
  String? endDate;
  String? pickupTime;
  String? pickupLocation;
  double? pickupLat;
  double? pickupLong;
  String? dropoffTime;
  String? dropoffLocation;
  double? dropoffLat;
  double? dropoffLong;
  String? countryCode;
  String? phoneNumber;
  String? otherCountryCode;
  String? otherPhoneNumber;
  int? bookingStatus;
  int? totalFare;
  int? fareUnlimitedKmsAmount;
  int? damageProtectionFee;
  int? convenienceFee;
  int? securityDeposit;
  var finalFare;
  int? transactionId;
  String? createdAt;
  String? carName;
  int? pricePerDay;
  int? pricePerWeek;
  int? reviewCount;
  var starCount;
  List<CarImage>? carImage;

  Info({this.bookingId, this.uniqueId, this.bookingBy, this.carId, this.country, this.city, this.startDate, this.endDate, this.pickupTime, this.pickupLocation, this.pickupLat, this.pickupLong, this.dropoffTime, this.dropoffLocation, this.dropoffLat, this.dropoffLong, this.countryCode, this.phoneNumber, this.otherCountryCode, this.otherPhoneNumber, this.bookingStatus, this.totalFare, this.fareUnlimitedKmsAmount, this.damageProtectionFee, this.convenienceFee, this.securityDeposit, this.finalFare, this.transactionId, this.createdAt, this.carName, this.pricePerDay, this.pricePerWeek, this.reviewCount, this.starCount, this.carImage});

  Info.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    uniqueId = json['unique_id'];
    bookingBy = json['booking_by'];
    carId = json['car_id'];
    country = json['country'];
    city = json['city'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    pickupTime = json['pickup_time'];
    pickupLocation = json['pickup_location'];
    pickupLat = json['pickup_lat'];
    pickupLong = json['pickup_long'];
    dropoffTime = json['dropoff_time'];
    dropoffLocation = json['dropoff_location'];
    dropoffLat = json['dropoff_lat'];
    dropoffLong = json['dropoff_long'];
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
    otherCountryCode = json['other_country_code'];
    otherPhoneNumber = json['other_phone_number'];
    bookingStatus = json['booking_status'];
    totalFare = json['total_fare'];
    fareUnlimitedKmsAmount = json['fare_unlimited_kms_amount'];
    damageProtectionFee = json['damage_protection_fee'];
    convenienceFee = json['convenience_fee'];
    securityDeposit = json['security_deposit'];
    finalFare = json['final_fare'];
    transactionId = json['transaction_id'];
    createdAt = json['created_at'];
    carName = json['car_name'];
    pricePerDay = json['price_per_day'];
    pricePerWeek = json['price_per_week'];
    reviewCount = json['review_count'];
    starCount = json['star_count'];
    if (json['car_image'] != null) {
      carImage = <CarImage>[];
      json['car_image'].forEach((v) {
        carImage!.add(new CarImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['unique_id'] = this.uniqueId;
    data['booking_by'] = this.bookingBy;
    data['car_id'] = this.carId;
    data['country'] = this.country;
    data['city'] = this.city;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['pickup_time'] = this.pickupTime;
    data['pickup_location'] = this.pickupLocation;
    data['pickup_lat'] = this.pickupLat;
    data['pickup_long'] = this.pickupLong;
    data['dropoff_time'] = this.dropoffTime;
    data['dropoff_location'] = this.dropoffLocation;
    data['dropoff_lat'] = this.dropoffLat;
    data['dropoff_long'] = this.dropoffLong;
    data['country_code'] = this.countryCode;
    data['phone_number'] = this.phoneNumber;
    data['other_country_code'] = this.otherCountryCode;
    data['other_phone_number'] = this.otherPhoneNumber;
    data['booking_status'] = this.bookingStatus;
    data['total_fare'] = this.totalFare;
    data['fare_unlimited_kms_amount'] = this.fareUnlimitedKmsAmount;
    data['damage_protection_fee'] = this.damageProtectionFee;
    data['convenience_fee'] = this.convenienceFee;
    data['security_deposit'] = this.securityDeposit;
    data['final_fare'] = this.finalFare;
    data['transaction_id'] = this.transactionId;
    data['created_at'] = this.createdAt;
    data['car_name'] = this.carName;
    data['price_per_day'] = this.pricePerDay;
    data['price_per_week'] = this.pricePerWeek;
    data['review_count'] = this.reviewCount;
    data['star_count'] = this.starCount;
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

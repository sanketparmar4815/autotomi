// class list_my_car_model {
//   int? status;
//   String? message;
//   int? totalPage;
//   List<listMyCar>? info;
//
//   list_my_car_model({this.status, this.message, this.totalPage, this.info});
//
//   list_my_car_model.fromJson(Map<String, dynamic> json) {
//     status = json['Status'];
//     message = json['Message'];
//     totalPage = json['total_page'];
//     if (json['info'] != null) {
//       info = <listMyCar>[];
//       json['info'].forEach((v) {
//         info!.add(new listMyCar.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Status'] = this.status;
//     data['Message'] = this.message;
//     data['total_page'] = this.totalPage;
//     if (this.info != null) {
//       data['info'] = this.info!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class listMyCar {
//   int? bookingId;
//   String? uniqueId;
//   int? bookingBy;
//   int? carId;
//   String? country;
//   String? city;
//   String? startDate;
//   String? endDate;
//   String? pickupTime;
//   String? pickupLocation;
//   double? pickupLat;
//   double? pickupLong;
//   String? dropoffTime;
//   String? dropoffLocation;
//   double? dropoffLat;
//   double? dropoffLong;
//   String? countryCode;
//   String? phoneNumber;
//   String? otherCountryCode;
//   String? otherPhoneNumber;
//   int? bookingStatus;
//   int? totalFare;
//   int? fareUnlimitedKmsAmount;
//   int? damageProtectionFee;
//   int? convenienceFee;
//   int? securityDeposit;
//   int? finalFare;
//   String? createdAt;
//   String? carName;
//   int? totalData;
//   var reviewCount;
//   var starCount;
//   var pricePerDay;
//   var pricePerWeek;
//   List<CarImage>? carImage;
//
//   listMyCar({this.bookingId, this.pricePerDay, this.pricePerWeek, this.uniqueId, this.bookingBy, this.carId, this.country, this.city, this.startDate, this.endDate, this.pickupTime, this.pickupLocation, this.pickupLat, this.pickupLong, this.dropoffTime, this.dropoffLocation, this.dropoffLat, this.dropoffLong, this.countryCode, this.phoneNumber, this.otherCountryCode, this.otherPhoneNumber, this.bookingStatus, this.totalFare, this.fareUnlimitedKmsAmount, this.damageProtectionFee, this.convenienceFee, this.securityDeposit, this.finalFare, this.createdAt, this.carName, this.totalData, this.reviewCount, this.starCount, this.carImage});
//
//   listMyCar.fromJson(Map<String, dynamic> json) {
//     bookingId = json['booking_id'];
//     uniqueId = json['unique_id'];
//     bookingBy = json['booking_by'];
//     carId = json['car_id'];
//     country = json['country'];
//     city = json['city'];
//     startDate = json['start_date'];
//     endDate = json['end_date'];
//     pickupTime = json['pickup_time'];
//     pickupLocation = json['pickup_location'];
//     pickupLat = json['pickup_lat'];
//     pickupLong = json['pickup_long'];
//     dropoffTime = json['dropoff_time'];
//     dropoffLocation = json['dropoff_location'];
//     dropoffLat = json['dropoff_lat'];
//     dropoffLong = json['dropoff_long'];
//     countryCode = json['country_code'];
//     phoneNumber = json['phone_number'];
//     otherCountryCode = json['other_country_code'];
//     otherPhoneNumber = json['other_phone_number'];
//     bookingStatus = json['booking_status'];
//     totalFare = json['total_fare'];
//     fareUnlimitedKmsAmount = json['fare_unlimited_kms_amount'];
//     damageProtectionFee = json['damage_protection_fee'];
//     convenienceFee = json['convenience_fee'];
//     securityDeposit = json['security_deposit'];
//     finalFare = json['final_fare'];
//     createdAt = json['created_at'];
//     carName = json['car_name'];
//     totalData = json['total_data'];
//     reviewCount = json['review_count'];
//     starCount = json['star_count'];
//     pricePerDay = json['price_per_day'];
//     pricePerWeek = json['price_per_week'];
//     if (json['car_image'] != null) {
//       carImage = <CarImage>[];
//       json['car_image'].forEach((v) {
//         carImage!.add(new CarImage.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['booking_id'] = this.bookingId;
//     data['unique_id'] = this.uniqueId;
//     data['booking_by'] = this.bookingBy;
//     data['car_id'] = this.carId;
//     data['country'] = this.country;
//     data['city'] = this.city;
//     data['start_date'] = this.startDate;
//     data['end_date'] = this.endDate;
//     data['pickup_time'] = this.pickupTime;
//     data['pickup_location'] = this.pickupLocation;
//     data['pickup_lat'] = this.pickupLat;
//     data['pickup_long'] = this.pickupLong;
//     data['dropoff_time'] = this.dropoffTime;
//     data['dropoff_location'] = this.dropoffLocation;
//     data['dropoff_lat'] = this.dropoffLat;
//     data['dropoff_long'] = this.dropoffLong;
//     data['country_code'] = this.countryCode;
//     data['phone_number'] = this.phoneNumber;
//     data['other_country_code'] = this.otherCountryCode;
//     data['other_phone_number'] = this.otherPhoneNumber;
//     data['booking_status'] = this.bookingStatus;
//     data['total_fare'] = this.totalFare;
//     data['fare_unlimited_kms_amount'] = this.fareUnlimitedKmsAmount;
//     data['damage_protection_fee'] = this.damageProtectionFee;
//     data['convenience_fee'] = this.convenienceFee;
//     data['security_deposit'] = this.securityDeposit;
//     data['final_fare'] = this.finalFare;
//     data['created_at'] = this.createdAt;
//     data['car_name'] = this.carName;
//     data['total_data'] = this.totalData;
//     data['review_count'] = this.reviewCount;
//     data['star_count'] = this.starCount;
//     data['price_per_day'] = this.pricePerDay;
//     data['price_per_week'] = this.pricePerWeek;
//     if (this.carImage != null) {
//       data['car_image'] = this.carImage!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class CarImage {
//   int? imageId;
//   int? carId;
//   String? image;
//   String? createdAt;
//
//   CarImage({this.imageId, this.carId, this.image, this.createdAt});
//
//   CarImage.fromJson(Map<String, dynamic> json) {
//     imageId = json['image_id'];
//     carId = json['car_id'];
//     image = json['image'];
//     createdAt = json['created_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['image_id'] = this.imageId;
//     data['car_id'] = this.carId;
//     data['image'] = this.image;
//     data['created_at'] = this.createdAt;
//     return data;
//   }
// }

class list_my_car_model {
  int? status;
  String? message;
  int? totalPage;
  List<listMyCar>? info;

  list_my_car_model({this.status, this.message, this.totalPage, this.info});

  list_my_car_model.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    totalPage = json['total_page'];
    if (json['info'] != null) {
      info = <listMyCar>[];
      json['info'].forEach((v) {
        info!.add(new listMyCar.fromJson(v));
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

class listMyCar {
  int? bookingId;
  String? uniqueId;
  int? bookingBy;
  int? carId;
  var country;
  var city;
  int? countryId;
  int? cityId;
  String? startDate;
  String? endDate;
  String? pickupTime;
  String? pickupLocation;
  int? pickupAirportId;
  String? pickupAddress;
  String? pickupCountryCode;
  String? pickupPhoneNumber;
  String? pickupAdditionalInfo;
  double? pickupLat;
  double? pickupLong;
  String? dropoffTime;
  String? dropoffLocation;
  int? dropoffAirportId;
  String? dropoffAddress;
  String? dropoffCountryCode;
  String? dropoffPhoneNumber;
  String? dropoffAdditionalInfo;
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
  int? totalData;
  int? isReserve;
  var reviewCount;
  var starCount;
  var reservedDatetime;
  var bringCarMe;
  var comePickupCar;
  var extraDays;
  var extraPrice;
  var discountAmount;
  var couponId;
  var isAdminApprove;
  var carBookingId;

  List<CarImage>? carImage;
  List<Review>? review;

  listMyCar({this.bookingId, this.carBookingId, this.isAdminApprove, this.couponId, this.extraPrice, this.discountAmount, this.extraDays, this.isReserve, this.bringCarMe, this.comePickupCar, this.reservedDatetime, this.uniqueId, this.bookingBy, this.carId, this.country, this.city, this.countryId, this.cityId, this.startDate, this.endDate, this.pickupTime, this.pickupLocation, this.pickupAirportId, this.pickupAddress, this.pickupCountryCode, this.pickupPhoneNumber, this.pickupAdditionalInfo, this.pickupLat, this.pickupLong, this.dropoffTime, this.dropoffLocation, this.dropoffAirportId, this.dropoffAddress, this.dropoffCountryCode, this.dropoffPhoneNumber, this.dropoffAdditionalInfo, this.dropoffLat, this.dropoffLong, this.countryCode, this.phoneNumber, this.otherCountryCode, this.otherPhoneNumber, this.bookingStatus, this.totalFare, this.fareUnlimitedKmsAmount, this.damageProtectionFee, this.convenienceFee, this.securityDeposit, this.finalFare, this.transactionId, this.createdAt, this.carName, this.pricePerDay, this.pricePerWeek, this.totalData, this.reviewCount, this.starCount, this.carImage, this.review});

  listMyCar.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    uniqueId = json['unique_id'];
    bookingBy = json['booking_by'];
    carId = json['car_id'];
    country = json['country'];
    city = json['city'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    pickupTime = json['pickup_time'];
    pickupLocation = json['pickup_location'];
    pickupAirportId = json['pickup_airport_id'];
    pickupAddress = json['pickup_address'];
    pickupCountryCode = json['pickup_country_code'];
    pickupPhoneNumber = json['pickup_phone_number'];
    pickupAdditionalInfo = json['pickup_additional_info'];
    pickupLat = json['pickup_lat'];
    pickupLong = json['pickup_long'];
    dropoffTime = json['dropoff_time'];
    dropoffLocation = json['dropoff_location'];
    dropoffAirportId = json['dropoff_airport_id'];
    dropoffAddress = json['dropoff_address'];
    dropoffCountryCode = json['dropoff_country_code'];
    dropoffPhoneNumber = json['dropoff_phone_number'];
    dropoffAdditionalInfo = json['dropoff_additional_info'];
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
    totalData = json['total_data'];
    reviewCount = json['review_count'];
    starCount = json['star_count'];
    isReserve = json['is_reserve'];
    bringCarMe = json['bring_car_me'];
    comePickupCar = json['come_pickup_car'];
    reservedDatetime = json['reserved_datetime'];
    extraPrice = json['extra_price'];
    extraDays = json['extra_days'];
    discountAmount = json['discount_amount'];
    couponId = json['coupon_id'];
    isAdminApprove = json['is_admin_approve'];
    carBookingId = json['car_booking_id'];
    if (json['car_image'] != null) {
      carImage = <CarImage>[];
      json['car_image'].forEach((v) {
        carImage!.add(new CarImage.fromJson(v));
      });
    }
    if (json['review'] != null) {
      review = <Review>[];
      json['review'].forEach((v) {
        review!.add(new Review.fromJson(v));
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
    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['pickup_time'] = this.pickupTime;
    data['pickup_location'] = this.pickupLocation;
    data['pickup_airport_id'] = this.pickupAirportId;
    data['pickup_address'] = this.pickupAddress;
    data['pickup_country_code'] = this.pickupCountryCode;
    data['pickup_phone_number'] = this.pickupPhoneNumber;
    data['pickup_additional_info'] = this.pickupAdditionalInfo;
    data['pickup_lat'] = this.pickupLat;
    data['pickup_long'] = this.pickupLong;
    data['dropoff_time'] = this.dropoffTime;
    data['dropoff_location'] = this.dropoffLocation;
    data['dropoff_airport_id'] = this.dropoffAirportId;
    data['dropoff_address'] = this.dropoffAddress;
    data['dropoff_country_code'] = this.dropoffCountryCode;
    data['dropoff_phone_number'] = this.dropoffPhoneNumber;
    data['dropoff_additional_info'] = this.dropoffAdditionalInfo;
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
    data['total_data'] = this.totalData;
    data['review_count'] = this.reviewCount;
    data['star_count'] = this.starCount;
    data['is_reserve'] = this.isReserve;
    data['reserved_datetime'] = this.reservedDatetime;
    data['bring_car_me'] = this.bringCarMe;
    data['come_pickup_car'] = this.comePickupCar;
    data['extra_days'] = this.extraDays;
    data['extra_price'] = this.extraPrice;
    data['discount_amount'] = this.discountAmount;
    data['coupon_id'] = this.couponId;
    data['is_admin_approve'] = this.isAdminApprove;
    data['car_booking_id'] = this.carBookingId;
    if (this.carImage != null) {
      data['car_image'] = this.carImage!.map((v) => v.toJson()).toList();
    }
    if (this.review != null) {
      data['review'] = this.review!.map((v) => v.toJson()).toList();
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

class Review {
  int? reviewId;
  int? reviewBy;
  int? carId;
  int? bookingId;
  var noOfStar;
  String? reviewText;
  String? createdAt;
  String? firstName;
  String? lastName;
  String? profilePic;

  Review({this.reviewId, this.reviewBy, this.carId, this.bookingId, this.noOfStar, this.reviewText, this.createdAt, this.firstName, this.lastName, this.profilePic});

  Review.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    reviewBy = json['review_by'];
    carId = json['car_id'];
    bookingId = json['booking_id'];
    noOfStar = json['no_of_star'];
    reviewText = json['review_text'];
    createdAt = json['created_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review_id'] = this.reviewId;
    data['review_by'] = this.reviewBy;
    data['car_id'] = this.carId;
    data['booking_id'] = this.bookingId;
    data['no_of_star'] = this.noOfStar;
    data['review_text'] = this.reviewText;
    data['created_at'] = this.createdAt;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}

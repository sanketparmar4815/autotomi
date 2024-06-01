class all_review_rating_model {
  int? status;
  String? message;
  int? totalPage;
  List<allRatingReview>? info;

  all_review_rating_model({this.status, this.message, this.totalPage, this.info});

  all_review_rating_model.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    totalPage = json['total_page'];
    if (json['info'] != null) {
      info = <allRatingReview>[];
      json['info'].forEach((v) {
        info!.add(new allRatingReview.fromJson(v));
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

class allRatingReview {
  int? reviewId;
  int? reviewBy;
  int? carId;
  int? bookingId;
  int? noOfStar;
  String? reviewText;
  String? createdAt;
  String? firstName;
  String? lastName;
  String? profilePic;

  allRatingReview({this.reviewId, this.reviewBy, this.carId, this.bookingId, this.noOfStar, this.reviewText, this.createdAt, this.firstName, this.lastName, this.profilePic});

  allRatingReview.fromJson(Map<String, dynamic> json) {
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

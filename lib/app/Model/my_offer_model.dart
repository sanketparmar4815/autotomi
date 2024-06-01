class my_offer_model {
  int? status;
  String? message;
  List<myOffer>? info;

  my_offer_model({this.status, this.message, this.info});

  my_offer_model.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    if (json['info'] != null) {
      info = <myOffer>[];
      json['info'].forEach((v) {
        info!.add(new myOffer.fromJson(v));
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

class myOffer {
  int? couponId;
  String? couponCode;
  int? discount;
  int? userId;
  int? isUsed;
  String? createdAt;

  myOffer({this.couponId, this.couponCode, this.discount, this.userId, this.isUsed, this.createdAt});

  myOffer.fromJson(Map<String, dynamic> json) {
    couponId = json['coupon_id'];
    couponCode = json['coupon_code'];
    discount = json['discount'];
    userId = json['user_id'];
    isUsed = json['is_used'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_id'] = this.couponId;
    data['coupon_code'] = this.couponCode;
    data['discount'] = this.discount;
    data['user_id'] = this.userId;
    data['is_used'] = this.isUsed;
    data['created_at'] = this.createdAt;
    return data;
  }
}

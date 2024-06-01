class edit_profile_model {
  int? status;
  String? message;
  Info? info;

  edit_profile_model({this.status, this.message, this.info});

  edit_profile_model.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  int? userRole;
  String? firstName;
  String? lastName;
  String? emailId;
  String? password;
  String? countryCode;
  String? phoneNumber;
  String? profilePic;
  var tempPass;
  int? isEmailVerified;
  int? loginType;
  var thirdpartyId;
  String? residenceCountry;
  String? homeCountry;
  int? isAccountSetup;
  int? isProfile;
  int? isDelete;
  int? isBlock;
  int? isProfileVerified;
  String? createdAt;

  Info({this.userId, this.userRole, this.isProfileVerified, this.firstName, this.lastName, this.emailId, this.password, this.countryCode, this.phoneNumber, this.profilePic, this.tempPass, this.isEmailVerified, this.loginType, this.thirdpartyId, this.residenceCountry, this.homeCountry, this.isAccountSetup, this.isProfile, this.isDelete, this.isBlock, this.createdAt});

  Info.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userRole = json['user_role'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    emailId = json['email_id'];
    password = json['password'];
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
    profilePic = json['profile_pic'];
    tempPass = json['temp_pass'];
    isEmailVerified = json['is_email_verified'];
    loginType = json['login_type'];
    thirdpartyId = json['thirdparty_id'];
    residenceCountry = json['residence_country'];
    homeCountry = json['home_country'];
    isAccountSetup = json['is_account_setup'];
    isProfile = json['is_profile'];
    isDelete = json['is_delete'];
    isBlock = json['is_block'];
    isProfileVerified = json['is_profile_verified'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_role'] = this.userRole;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email_id'] = this.emailId;
    data['password'] = this.password;
    data['country_code'] = this.countryCode;
    data['phone_number'] = this.phoneNumber;
    data['profile_pic'] = this.profilePic;
    data['temp_pass'] = this.tempPass;
    data['is_email_verified'] = this.isEmailVerified;
    data['login_type'] = this.loginType;
    data['thirdparty_id'] = this.thirdpartyId;
    data['residence_country'] = this.residenceCountry;
    data['home_country'] = this.homeCountry;
    data['is_account_setup'] = this.isAccountSetup;
    data['is_profile'] = this.isProfile;
    data['is_delete'] = this.isDelete;
    data['is_block'] = this.isBlock;
    data['is_profile_verified'] = this.isProfileVerified;
    data['created_at'] = this.createdAt;
    return data;
  }
}

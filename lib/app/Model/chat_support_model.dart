class chat_support_model {
  int? status;
  String? message;
  int? totalPage;
  List<chatSupport>? info;

  chat_support_model({this.status, this.message, this.totalPage, this.info});

  chat_support_model.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    totalPage = json['total_page'];
    if (json['info'] != null) {
      info = <chatSupport>[];
      json['info'].forEach((v) {
        info!.add(new chatSupport.fromJson(v));
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

class chatSupport {
  int? requestId;
  int? requestBy;
  int? requestTo;
  String? messageText;
  int? messageStatus;
  int? ticketId;
  int? replyId;
  String? readAt;
  String? createdAt;
  String? firstName;
  String? lastName;
  String? profilePic;

  chatSupport({this.requestId, this.requestBy, this.requestTo, this.messageText, this.messageStatus, this.ticketId, this.replyId, this.readAt, this.createdAt, this.firstName, this.lastName, this.profilePic});

  chatSupport.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    requestBy = json['request_by'];
    requestTo = json['request_to'];
    messageText = json['message_text'];
    messageStatus = json['message_status'];
    ticketId = json['ticket_id'];
    replyId = json['reply_id'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_id'] = this.requestId;
    data['request_by'] = this.requestBy;
    data['request_to'] = this.requestTo;
    data['message_text'] = this.messageText;
    data['message_status'] = this.messageStatus;
    data['ticket_id'] = this.ticketId;
    data['reply_id'] = this.replyId;
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}

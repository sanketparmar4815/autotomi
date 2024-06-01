class support_model {
  int? status;
  String? message;
  int? totalPage;
  List<support>? info;

  support_model({this.status, this.message, this.totalPage, this.info});

  support_model.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    totalPage = json['total_page'];
    if (json['info'] != null) {
      info = <support>[];
      json['info'].forEach((v) {
        info!.add(new support.fromJson(v));
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

class support {
  int? ticketId;
  int? ticketCreatedBy;
  int? ticketCreatedTo;
  String? subject;
  String? message;
  int? isComplete;
  String? createdAt;
  int? totalData;

  support({this.ticketId, this.ticketCreatedBy, this.ticketCreatedTo, this.subject, this.message, this.isComplete, this.createdAt, this.totalData});

  support.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    ticketCreatedBy = json['ticket_created_by'];
    ticketCreatedTo = json['ticket_created_to'];
    subject = json['subject'];
    message = json['message'];
    isComplete = json['is_complete'];
    createdAt = json['created_at'];
    totalData = json['total_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['ticket_created_by'] = this.ticketCreatedBy;
    data['ticket_created_to'] = this.ticketCreatedTo;
    data['subject'] = this.subject;
    data['message'] = this.message;
    data['is_complete'] = this.isComplete;
    data['created_at'] = this.createdAt;
    data['total_data'] = this.totalData;
    return data;
  }
}

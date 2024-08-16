class NotifictionModel {
  int? id;
  int? orderId;
  String? body;
  String? title;
  String? type;
  String? usertype;
  String? createdAt;
  String? updatedAt;

  NotifictionModel(
      {this.id,
      this.orderId,
      this.body,
      this.title,
      this.type,
      this.usertype,
      this.createdAt,
      this.updatedAt});

  NotifictionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    body = json['body'];
    title = json['title'];
    type = json['type'];
    usertype = json['usertype'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['body'] = this.body;
    data['title'] = this.title;
    data['type'] = this.type;
    data['usertype'] = this.usertype;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

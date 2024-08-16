class WalletModel {
  String? success;
  List<Transactions>? transactions;
  int? wallet;
  String? taxOwed;

  WalletModel({this.success, this.transactions, this.wallet, this.taxOwed});

  WalletModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
    wallet = json['wallet'];
    taxOwed = json['tax_owed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    data['wallet'] = this.wallet;
    data['tax_owed'] = this.taxOwed;
    return data;
  }
}

class Transactions {
  int? operationId;
  int? userId;
  String? userName;
  int? amount;
  String? type;
  Null? recipientUserId;
  String? recipientName;
  Null? orderId;

  Transactions(
      {this.operationId,
      this.userId,
      this.userName,
      this.amount,
      this.type,
      this.recipientUserId,
      this.recipientName,
      this.orderId});

  Transactions.fromJson(Map<String, dynamic> json) {
    operationId = json['operation_id'];
    userId = json['user_id'];
    userName = json['user_name'];
    amount = json['amount'];
    type = json['type'];
    recipientUserId = json['recipient_user_id'];
    recipientName = json['recipient_name'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['operation_id'] = this.operationId;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['recipient_user_id'] = this.recipientUserId;
    data['recipient_name'] = this.recipientName;
    data['order_id'] = this.orderId;
    return data;
  }
}

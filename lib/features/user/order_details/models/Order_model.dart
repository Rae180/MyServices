import 'dart:io';

class Order {
  int? providerId;
  List<File?> image = [];
  String? type;
  String? scheduleDate;
  String? notes;
  String? paymentMethod;
  String? address;
  String? longitude;
  String? latitude;

  Order({
    required this.image,
    this.providerId,
    this.type,
    this.scheduleDate,
    this.notes,
    this.paymentMethod,
    this.address,
    this.longitude,
    this.latitude,
  });

  Order.fromJson(Map<String, dynamic> json) {
    image = (json["images"] as List<dynamic>?)
            ?.map((item) => item as File?)
            .toList() ??
        [];
    providerId = json["provider_id"];
    type = json["type"];
    scheduleDate = json["schedule_date"];
    notes = json["notes"];
    paymentMethod = json["payment_method"];
    address = json["address"];
    longitude = json["longitude"];
    latitude = json["latitude"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["provider_id"] = providerId;
    _data["images"] = image;
    _data["type"] = type;
    _data["schedule_date"] = scheduleDate;
    _data["notes"] = notes;
    _data["payment_method"] = paymentMethod;
    _data["address"] = address;
    _data["longitude"] = longitude;
    _data["latitude"] = latitude;
    return _data;
  }
}

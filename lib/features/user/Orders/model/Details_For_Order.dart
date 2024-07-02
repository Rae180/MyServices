
class DetailsForOrder {
    int? id;
    int? userId;
    int? providerId;
    String? type;
    String? scheduleDate;
    String? status;
    String? notes;
    String? paymentMethod;
    String? address;
    String? longitude;
    String? latitude;
    dynamic createdAt;
    dynamic updatedAt;
    List<dynamic>? imageUrls;

    DetailsForOrder({this.id, this.userId, this.providerId, this.type, this.scheduleDate, this.status, this.notes, this.paymentMethod, this.address, this.longitude, this.latitude, this.createdAt, this.updatedAt, this.imageUrls});

    DetailsForOrder.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        userId = json["user_id"];
        providerId = json["provider_id"];
        type = json["type"];
        scheduleDate = json["schedule_date"];
        status = json["status"];
        notes = json["notes"];
        paymentMethod = json["payment_method"];
        address = json["address"];
        longitude = json["longitude"];
        latitude = json["latitude"];
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
        imageUrls = json["image_urls"] ?? [];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["user_id"] = userId;
        _data["provider_id"] = providerId;
        _data["type"] = type;
        _data["schedule_date"] = scheduleDate;
        _data["status"] = status;
        _data["notes"] = notes;
        _data["payment_method"] = paymentMethod;
        _data["address"] = address;
        _data["longitude"] = longitude;
        _data["latitude"] = latitude;
        _data["created_at"] = createdAt;
        _data["updated_at"] = updatedAt;
        if(imageUrls != null) {
            _data["image_urls"] = imageUrls;
        }
        return _data;
    }
}
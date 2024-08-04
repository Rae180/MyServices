
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
        longitude = json["longitude"].toString();
        latitude = json["latitude"].toString();
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
        imageUrls = json["image_urls"] ?? [];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["id"] = id;
        data["user_id"] = userId;
        data["provider_id"] = providerId;
        data["type"] = type;
        data["schedule_date"] = scheduleDate;
        data["status"] = status;
        data["notes"] = notes;
        data["payment_method"] = paymentMethod;
        data["address"] = address;
        data["longitude"] = longitude;
        data["latitude"] = latitude;
        data["created_at"] = createdAt;
        data["updated_at"] = updatedAt;
        if(imageUrls != null) {
            data["image_urls"] = imageUrls;
        }
        return data;
    }
}

class ProviderService {
    int? providerId;
    String? firstName;
    String? lastName;
    String? status;
    int? hourlyRate;
    String? image;
    int? averageRating;
    bool? isFav;

    ProviderService({this.providerId, this.firstName, this.lastName, this.status, this.hourlyRate, this.image, this.averageRating, this.isFav});

    ProviderService.fromJson(Map<String, dynamic> json) {
        providerId = json["provider_id"];
        firstName = json["first_name"];
        lastName = json["last_name"];
        status = json["status"];
        hourlyRate = json["hourly_rate"];
        image = json["image"];
        averageRating = json["average_rating"];
        isFav = json["is_Fav"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["provider_id"] = providerId;
        _data["first_name"] = firstName;
        _data["last_name"] = lastName;
        _data["status"] = status;
        _data["hourly_rate"] = hourlyRate;
        _data["image"] = image;
        _data["average_rating"] = averageRating;
        _data["is_Fav"] = isFav;
        return _data;
    }
}
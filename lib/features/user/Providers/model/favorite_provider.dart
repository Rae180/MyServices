
class FavoriteProvideres {
    int? providerId;
    String? providerFirstName;
    String? providerLastName;
    String? status;
    int? hourlyRate;
    String? providerImage;

    FavoriteProvideres({this.providerId, this.providerFirstName, this.providerLastName, this.status, this.hourlyRate, this.providerImage});

    FavoriteProvideres.fromJson(Map<String, dynamic> json) {
        providerId = json["provider_id"];
        providerFirstName = json["provider_first_name"];
        providerLastName = json["provider_last_name"];
        status = json["status"];
        hourlyRate = json["hourly_rate"];
        providerImage = json["provider_image"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["provider_id"] = providerId;
        _data["provider_first_name"] = providerFirstName;
        _data["provider_last_name"] = providerLastName;
        _data["status"] = status;
        _data["hourly_rate"] = hourlyRate;
        _data["provider_image"] = providerImage;
        return _data;
    }
}
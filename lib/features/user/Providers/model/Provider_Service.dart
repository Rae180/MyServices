
class ProviderService {
    int? providerId;
    String? firstName;
    String? lastName;
    String? status;
    String? image;

    ProviderService({this.providerId, this.firstName, this.lastName, this.status, this.image});

    ProviderService.fromJson(Map<String, dynamic> json) {
        providerId = json["provider_id"];
        firstName = json["first_name"];
        lastName = json["last_name"];
        status = json["status"];
        image = json["image"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["provider_id"] = providerId;
        _data["first_name"] = firstName;
        _data["last_name"] = lastName;
        _data["status"] = status;
        _data["image"] = image;
        return _data;
    }
}
class SearchResults {
  int? providerId;
  String? firstName;
  String? lastName;
  String? status;
  int? hourlyRate;
  String? service;
  String? image;
  int? averageRating;

  SearchResults(
      {this.providerId,
      this.firstName,
      this.lastName,
      this.status,
      this.hourlyRate,
      this.service,
      this.image,
      this.averageRating});

  SearchResults.fromJson(Map<String, dynamic> json) {
    providerId = json["provider_id"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    status = json["status"];
    hourlyRate = json["hourly_rate"];
    service = json["service"];
    image = json["image"];
    averageRating = json["average_rating"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["provider_id"] = providerId;
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    _data["status"] = status;
    _data["hourly_rate"] = hourlyRate;
    _data["service"] = service;
    _data["image"] = image;
    _data["average_rating"] = averageRating;
    return _data;
  }
}

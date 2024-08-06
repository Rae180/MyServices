class ProviderDetails {
  int? id;
  int? userId;
  int? serviceId;
  String? jobDescription;
  String? birthDate;
  String? status;
  int? accStatus;
  int? hourlyRate;
  dynamic address;
  dynamic longitude;
  dynamic latitude;
  String? createdAt;
  String? updatedAt;
  int? age;
  User? user;
  Service? service;
  List<Posts>? posts;

  ProviderDetails(
      {this.id,
      this.userId,
      this.serviceId,
      this.jobDescription,
      this.birthDate,
      this.status,
      this.accStatus,
      this.hourlyRate,
      this.address,
      this.longitude,
      this.latitude,
      this.createdAt,
      this.updatedAt,
      this.age,
      this.user,
      this.service,
      this.posts});

  ProviderDetails.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    serviceId = json["service_id"];
    jobDescription = json["job_description"];
    birthDate = json["birth_date"];
    status = json["status"];
    accStatus = json["acc_status"];
    hourlyRate = json["hourly_rate"];
    address = json["address"];
    longitude = json["longitude"];
    latitude = json["latitude"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    age = json["age"];
    user = json["user"] == null ? null : User.fromJson(json["user"]);
    service =
        json["service"] == null ? null : Service.fromJson(json["service"]);
    posts = json["posts"] == null
        ? null
        : (json["posts"] as List).map((e) => Posts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["service_id"] = serviceId;
    _data["job_description"] = jobDescription;
    _data["birth_date"] = birthDate;
    _data["status"] = status;
    _data["acc_status"] = accStatus;
    _data["hourly_rate"] = hourlyRate;
    _data["address"] = address;
    _data["longitude"] = longitude;
    _data["latitude"] = latitude;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["age"] = age;
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    if (service != null) {
      _data["service"] = service?.toJson();
    }
    if (posts != null) {
      _data["posts"] = posts?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Posts {
  int? id;
  int? providerId;
  String? description;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? imagePaths;

  Posts(
      {this.id,
      this.providerId,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.imagePaths});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    providerId = json["provider_id"];
    description = json["description"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    imagePaths = json["image_paths"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["provider_id"] = providerId;
    _data["description"] = description;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    if (imagePaths != null) {
      _data["image_paths"] = imagePaths;
    }
    return _data;
  }
}

class Service {
  int? id;
  int? catogryId;
  String? name;
  String? image;
  double? price;
  String? createdAt;
  String? updatedAt;

  Service(
      {this.id,
      this.catogryId,
      this.name,
      this.image,
      this.price,
      this.createdAt,
      this.updatedAt});

  Service.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    catogryId = json["catogry_id"];
    name = json["name"];
    image = json["image"];
    price = json["price"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["catogry_id"] = catogryId;
    _data["name"] = name;
    _data["image"] = image;
    _data["price"] = price;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic emailVerifiedAt;
  String? phoneNum;
  String? gender;
  String? image;
  String? mainAddress;
  int? wallet;
  String? taxOwed;
  int? isProvider;
  int? block;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.emailVerifiedAt,
      this.phoneNum,
      this.gender,
      this.image,
      this.mainAddress,
      this.wallet,
      this.taxOwed,
      this.isProvider,
      this.block,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    email = json["email"];
    emailVerifiedAt = json["email_verified_at"];
    phoneNum = json["phone_num"];
    gender = json["gender"];
    image = json["image"];
    mainAddress = json["main_address"];
    wallet = json["wallet"];
    taxOwed = json["tax_owed"];
    isProvider = json["is_provider"];
    block = json["Block"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    _data["email"] = email;
    _data["email_verified_at"] = emailVerifiedAt;
    _data["phone_num"] = phoneNum;
    _data["gender"] = gender;
    _data["image"] = image;
    _data["main_address"] = mainAddress;
    _data["wallet"] = wallet;
    _data["tax_owed"] = taxOwed;
    _data["is_provider"] = isProvider;
    _data["Block"] = block;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}

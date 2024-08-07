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
  double? longitude;
  double? latitude;
  int? duration;
  int? notificationSent;
  String? createdAt;
  String? updatedAt;
  List<String>? imageUrls;
  Provider? provider;

  DetailsForOrder(
      {this.id,
      this.userId,
      this.providerId,
      this.type,
      this.scheduleDate,
      this.status,
      this.notes,
      this.paymentMethod,
      this.address,
      this.longitude,
      this.latitude,
      this.duration,
      this.notificationSent,
      this.createdAt,
      this.updatedAt,
      this.imageUrls,
      this.provider});

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
    longitude = json["longitude"].toDouble();
    latitude = json["latitude"].toDouble();
    duration = json["duration"];
    notificationSent = json["notification_sent"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    imageUrls = json["image_urls"] == null
        ? null
        : List<String>.from(json["image_urls"]);
    provider =
        json["provider"] == null ? null : Provider.fromJson(json["provider"]);
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
    data["duration"] = duration;
    data["notification_sent"] = notificationSent;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    if (imageUrls != null) {
      data["image_urls"] = imageUrls;
    }
    if (provider != null) {
      data["provider"] = provider?.toJson();
    }
    return data;
  }
}

class Provider {
  int? id;
  int? userId;
  int? serviceId;
  String? jobDescription;
  String? birthDate;
  String? status;
  int? accStatus;
  int? hourlyRate;
  String? address;
  double? longitude;
  int? latitude;
  dynamic createdAt;
  dynamic updatedAt;
  Service? service;
  User? user;

  Provider(
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
      this.service,
      this.user});

  Provider.fromJson(Map<String, dynamic> json) {
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
    service =
        json["service"] == null ? null : Service.fromJson(json["service"]);
    user = json["user"] == null ? null : User.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["user_id"] = userId;
    data["service_id"] = serviceId;
    data["job_description"] = jobDescription;
    data["birth_date"] = birthDate;
    data["status"] = status;
    data["acc_status"] = accStatus;
    data["hourly_rate"] = hourlyRate;
    data["address"] = address;
    data["longitude"] = longitude;
    data["latitude"] = latitude;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    if (service != null) {
      data["service"] = service?.toJson();
    }
    if (user != null) {
      data["user"] = user?.toJson();
    }
    return data;
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
  dynamic image;
  String? mainAddress;
  int? wallet;
  String? taxOwed;
  int? isProvider;
  int? block;
  dynamic createdAt;
  dynamic updatedAt;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["first_name"] = firstName;
    data["last_name"] = lastName;
    data["email"] = email;
    data["email_verified_at"] = emailVerifiedAt;
    data["phone_num"] = phoneNum;
    data["gender"] = gender;
    data["image"] = image;
    data["main_address"] = mainAddress;
    data["wallet"] = wallet;
    data["tax_owed"] = taxOwed;
    data["is_provider"] = isProvider;
    data["Block"] = block;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["catogry_id"] = catogryId;
    data["name"] = name;
    data["image"] = image;
    data["price"] = price;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}

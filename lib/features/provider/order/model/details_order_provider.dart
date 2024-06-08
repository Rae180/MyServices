class DetailsOrderProvider {
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
  String? createdAt;
  String? updatedAt;
  List<String>? imageUrls;
  User? user;

  DetailsOrderProvider(
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
      this.createdAt,
      this.updatedAt,
      this.imageUrls,
      this.user});

  DetailsOrderProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    providerId = json['provider_id'];
    type = json['type'];
    scheduleDate = json['schedule_date'];
    status = json['status'];
    notes = json['notes'];
    paymentMethod = json['payment_method'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageUrls = json['image_urls'].cast<String>();
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? emailVerifiedAt;
  String? phoneNum;
  String? gender;
  String? image;
  String? mainAddress;
  int? wallet;
  int? isProvider;
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
      this.isProvider,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phoneNum = json['phone_num'];
    gender = json['gender'];
    image = json['image'];
    mainAddress = json['main_address'];
    wallet = json['wallet'];
    isProvider = json['is_provider'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

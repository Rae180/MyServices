class DetailsOrderProvider {
  int? id;
  int? userId;
  int? providerId;
  String? type;
  String? scheduleDate;
  String? status;
  String? inprogressstatus;
  String? notes;
  String? paymentMethod;
  String? address;
  String? longitude;
  String? latitude;
  int? duration;
  String? createdAt;
  String? updatedAt;
  List<String>? imageUrls;
  User? user;
  Provider? provider;
  Completeorder? complateOrder;

  DetailsOrderProvider(
      {this.id,
      this.userId,
      this.providerId,
      this.type,
      this.scheduleDate,
      this.status,
      this.inprogressstatus,
      this.notes,
      this.paymentMethod,
      this.address,
      this.longitude,
      this.latitude,
      this.duration,
      this.createdAt,
      this.updatedAt,
      this.imageUrls,
      this.user,
      this.provider,
      this.complateOrder});

  DetailsOrderProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    providerId = json['provider_id'];
    type = json['type'];
    scheduleDate = json['schedule_date'];
    status = json['status'];
    inprogressstatus = json['inprogress_status'];
    notes = json['notes'];
    paymentMethod = json['payment_method'];
    address = json['address'];
    longitude = json['longitude'].toString();
    latitude = json['latitude'].toString();
    duration = json['duration'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['image_urls'] != null) {
      imageUrls = json['image_urls'].cast<String>();
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    complateOrder = json['completeorder'] != null
        ? Completeorder.fromJson(json['completeorder'])
        : null;
    provider =
        json['provider'] != null ? Provider.fromJson(json['provider']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['provider_id'] = providerId;
    data['type'] = type;
    data['schedule_date'] = scheduleDate;
    data['status'] = status;
    data['inprogress_status'] = inprogressstatus;
    data['notes'] = notes;
    data['payment_method'] = paymentMethod;
    data['address'] = address;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['duration'] = duration;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['image_urls'] = imageUrls;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (complateOrder != null) {
      data['completeorder'] = complateOrder!.toJson();
    }
    if (provider != null) {
      data['provider'] = provider!.toJson();
    }
    return data;
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
    taxOwed = json['tax_owed'];
    isProvider = json['is_provider'];
    block = json['Block'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['phone_num'] = phoneNum;
    data['gender'] = gender;
    data['image'] = image;
    data['main_address'] = mainAddress;
    data['wallet'] = wallet;
    data['tax_owed'] = taxOwed;
    data['is_provider'] = isProvider;
    data['Block'] = block;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
  String? longitude;
  String? latitude;
  String? createdAt;
  String? updatedAt;
  Service? service;

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
      this.service});

  Provider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    jobDescription = json['job_description'];
    birthDate = json['birth_date'];
    status = json['status'];
    accStatus = json['acc_status'];
    hourlyRate = json['hourly_rate'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['service_id'] = serviceId;
    data['job_description'] = jobDescription;
    data['birth_date'] = birthDate;
    data['status'] = status;
    data['acc_status'] = accStatus;
    data['hourly_rate'] = hourlyRate;
    data['address'] = address;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (service != null) {
      data['service'] = service!.toJson();
    }
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
    id = json['id'];
    catogryId = json['catogry_id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['catogry_id'] = catogryId;
    data['name'] = name;
    data['image'] = image;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}



class Completeorder {
  int? id;
  int? orderId;
  String? startWork;
  String? pauseWork;
  String? resumeWork;
  String? endWork;
  int? totalWorkHours;
  Null rate;
  Null comment;
  Null complaint;
  String? createdAt;
  String? updatedAt;
  Bill? bill;

  Completeorder(
      {this.id,
      this.orderId,
      this.startWork,
      this.pauseWork,
      this.resumeWork,
      this.endWork,
      this.totalWorkHours,
      this.rate,
      this.comment,
      this.complaint,
      this.createdAt,
      this.updatedAt,
      this.bill});

  Completeorder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    startWork = json['start_work'];
    pauseWork = json['pause_work'];
    resumeWork = json['resume_work'];
    endWork = json['end_work'];
    totalWorkHours = json['total_work_hours'];
    rate = json['rate'];
    comment = json['comment'];
    complaint = json['complaint'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bill = json['bill'] != null ? Bill.fromJson(json['bill']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['start_work'] = startWork;
    data['pause_work'] = pauseWork;
    data['resume_work'] = resumeWork;
    data['end_work'] = endWork;
    data['total_work_hours'] = totalWorkHours;
    data['rate'] = rate;
    data['comment'] = comment;
    data['complaint'] = complaint;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (bill != null) {
      data['bill'] = bill!.toJson();
    }
    return data;
  }
}

class Bill {
  int? id;
  int? completedOrderId;
  int? workHours;
  double? total;
  double? totalWithItem;
  String? createdAt;
  String? updatedAt;
 List<Item>? items;

  Bill({
    this.id,
    this.completedOrderId,
    this.workHours,
    this.total,
    this.totalWithItem,
    this.createdAt,
    this.updatedAt,
    this.items
  });

  Bill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    completedOrderId = json['completed_order_id'];
    workHours = json['work_hours'];
    total = json['total'].toDouble();
    totalWithItem = json['total_with_item'].toDouble();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['items'] != null) {
      items = <Item>[];
      json['items'].forEach((v) {
        items!.add( Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['completed_order_id'] = completedOrderId;
    data['work_hours'] = workHours;
    data['total'] = total;
    data['total_with_item'] = totalWithItem;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  int? id;
  String? item;
  String? price;
  Item(this.item, this.price,this.id);

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = json['item'];
    price = json['price'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item'] = item;
    data['price'] = price;
    return data;
  }
}




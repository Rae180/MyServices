
import 'dart:ffi';

class DetailsForOrder {
    int? id;
    int? userId;
    int? providerId;
    String? type;
    String? scheduleDate;
    String? status;
    String? inprogressStatus;
    String? notes;
    String? paymentMethod;
    String? address;
    double? longitude;
    double? latitude;
    int? duration;
    int? notificationSent;
    int? cashConfirmed;
    String? unpaidTax;
    int? postponementRejectedShown;
    String? createdAt;
    String? updatedAt;
    List<String>? imagePaths;
    Provider? provider;
    Completeorder? completeorder;

    DetailsForOrder({this.id, this.userId, this.providerId, this.type, this.scheduleDate, this.status, this.inprogressStatus, this.notes, this.paymentMethod, this.address, this.longitude, this.latitude, this.duration, this.notificationSent, this.cashConfirmed, this.unpaidTax, this.postponementRejectedShown, this.createdAt, this.updatedAt, this.imagePaths, this.provider, this.completeorder});

    DetailsForOrder.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        userId = json["user_id"];
        providerId = json["provider_id"];
        type = json["type"];
        scheduleDate = json["schedule_date"];
        status = json["status"];
        inprogressStatus = json["inprogress_status"];
        notes = json["notes"];
        paymentMethod = json["payment_method"];
        address = json["address"];
        longitude = json["longitude"].toDouble();
        latitude = json["latitude"].toDouble();
        duration = json["duration"];
        notificationSent = json["notification_sent"];
        cashConfirmed = json["cash_confirmed"];
        unpaidTax = json["unpaid_tax"];
        postponementRejectedShown = json["postponement_rejected_shown"];
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
        imagePaths = json["image_paths"] == null ? null : List<String>.from(json["image_paths"]);
        provider = json["provider"] == null ? null : Provider.fromJson(json["provider"]);
        completeorder = json["completeorder"] == null ? null : Completeorder.fromJson(json["completeorder"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["id"] = id;
        data["user_id"] = userId;
        data["provider_id"] = providerId;
        data["type"] = type;
        data["schedule_date"] = scheduleDate;
        data["status"] = status;
        data["inprogress_status"] = inprogressStatus;
        data["notes"] = notes;
        data["payment_method"] = paymentMethod;
        data["address"] = address;
        data["longitude"] = longitude;
        data["latitude"] = latitude;
        data["duration"] = duration;
        data["notification_sent"] = notificationSent;
        data["cash_confirmed"] = cashConfirmed;
        data["unpaid_tax"] = unpaidTax;
        data["postponement_rejected_shown"] = postponementRejectedShown;
        data["created_at"] = createdAt;
        data["updated_at"] = updatedAt;
        if(imagePaths != null) {
            data["image_paths"] = imagePaths;
        }
        if(provider != null) {
            data["provider"] = provider?.toJson();
        }
        if(completeorder != null) {
            data["completeorder"] = completeorder?.toJson();
        }
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
    int? rate;
    String? comment;
    String? complaint;
    int? rateShown;
    int? complaintShown;
    dynamic createdAt;
    dynamic updatedAt;
    Bill? bill;

    Completeorder({this.id, this.orderId, this.startWork, this.pauseWork, this.resumeWork, this.endWork, this.totalWorkHours, this.rate, this.comment, this.complaint, this.rateShown, this.complaintShown, this.createdAt, this.updatedAt, this.bill});

    Completeorder.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        orderId = json["order_id"];
        startWork = json["start_work"];
        pauseWork = json["pause_work"];
        resumeWork = json["resume_work"];
        endWork = json["end_work"];
        totalWorkHours = json["total_work_hours"];
        rate = json["rate"];
        comment = json["comment"];
        complaint = json["complaint"];
        rateShown = json["rate_shown"];
        complaintShown = json["complaint_shown"];
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
        bill = json["bill"] == null ? null : Bill.fromJson(json["bill"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["id"] = id;
        data["order_id"] = orderId;
        data["start_work"] = startWork;
        data["pause_work"] = pauseWork;
        data["resume_work"] = resumeWork;
        data["end_work"] = endWork;
        data["total_work_hours"] = totalWorkHours;
        data["rate"] = rate;
        data["comment"] = comment;
        data["complaint"] = complaint;
        data["rate_shown"] = rateShown;
        data["complaint_shown"] = complaintShown;
        data["created_at"] = createdAt;
        data["updated_at"] = updatedAt;
        if(bill != null) {
            data["bill"] = bill?.toJson();
        }
        return data;
    }
}

class Bill {
    int? id;
    int? completedOrderId;
    int? workHours;
    int? total;
    int? totalWithItem;
    dynamic createdAt;
    dynamic updatedAt;
    List<Items>? items;

    Bill({this.id, this.completedOrderId, this.workHours, this.total, this.totalWithItem, this.createdAt, this.updatedAt, this.items});

    Bill.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        completedOrderId = json["completed_order_id"];
        workHours = json["work_hours"];
        total = json["total"];
        totalWithItem = json["total_with_item"];
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
        items = json["items"] == null ? null : (json["items"] as List).map((e) => Items.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["id"] = id;
        data["completed_order_id"] = completedOrderId;
        data["work_hours"] = workHours;
        data["total"] = total;
        data["total_with_item"] = totalWithItem;
        data["created_at"] = createdAt;
        data["updated_at"] = updatedAt;
        if(items != null) {
            data["items"] = items?.map((e) => e.toJson()).toList();
        }
        return data;
    }
}

class Items {
    int? id;
    int? billId;
    String? item;
    int? price;
    dynamic createdAt;
    dynamic updatedAt;

    Items({this.id, this.billId, this.item, this.price, this.createdAt, this.updatedAt});

    Items.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        billId = json["bill_id"];
        item = json["item"];
        price = json["price"];
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["id"] = id;
        data["bill_id"] = billId;
        data["item"] = item;
        data["price"] = price;
        data["created_at"] = createdAt;
        data["updated_at"] = updatedAt;
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
    dynamic address;
    dynamic longitude;
    dynamic latitude;
    String? createdAt;
    String? updatedAt;
    Service? service;
    User? user;

    Provider({this.id, this.userId, this.serviceId, this.jobDescription, this.birthDate, this.status, this.accStatus, this.hourlyRate, this.address, this.longitude, this.latitude, this.createdAt, this.updatedAt, this.service, this.user});

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
        service = json["service"] == null ? null : Service.fromJson(json["service"]);
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
        if(service != null) {
            data["service"] = service?.toJson();
        }
        if(user != null) {
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
    String? image;
    String? mainAddress;
    int? wallet;
    String? taxOwed;
    int? isProvider;
    int? block;
    String? createdAt;
    String? updatedAt;

    User({this.id, this.firstName, this.lastName, this.email, this.emailVerifiedAt, this.phoneNum, this.gender, this.image, this.mainAddress, this.wallet, this.taxOwed, this.isProvider, this.block, this.createdAt, this.updatedAt});

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

    Service({this.id, this.catogryId, this.name, this.image, this.price, this.createdAt, this.updatedAt});

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

class ProfileModel {
  int? providerId;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNum;
  String? mainAddress;
  String? birthDate;
  String? gender;
  String? status;
  int? hourlyRate;
  String? jobDescription;
  String? image;

  ProfileModel(
      {this.providerId,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNum,
      this.mainAddress,
      this.birthDate,
      this.gender,
      this.status,
      this.hourlyRate,
      this.jobDescription,
      this.image});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    providerId = json['provider_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNum = json['phone_num'];
    mainAddress = json['main_address'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    status = json['status'];
    hourlyRate = json['hourly_rate'];
    jobDescription = json['job_description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
   if(providerId!=null) data['provider_id'] = providerId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone_num'] = phoneNum;
    data['main_address'] = mainAddress;
    data['birth_date'] = birthDate;
    data['gender'] = gender;
   if(status!= null) data['status'] = status;
    data['hourly_rate'] = hourlyRate;
    data['job_description'] = jobDescription;
    if (image != null) data['image'] = image;
    return data;
  }
}

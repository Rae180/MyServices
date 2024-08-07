
class MyProfile {
    int? userId;
    String? firstName;
    String? lastName;
    String? email;
    String? phoneNum;
    String? mainAddress;
    String? gender;
    String? image;

    MyProfile({this.userId, this.firstName, this.lastName, this.email, this.phoneNum, this.mainAddress, this.gender, this.image});

    MyProfile.fromJson(Map<String, dynamic> json) {
        userId = json["user_id"];
        firstName = json["first_name"];
        lastName = json["last_name"];
        email = json["email"];
        phoneNum = json["phone_num"];
        mainAddress = json["main_address"];
        gender = json["gender"];
        image = json["image"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["user_id"] = userId;
        _data["first_name"] = firstName;
        _data["last_name"] = lastName;
        _data["email"] = email;
        _data["phone_num"] = phoneNum;
        _data["main_address"] = mainAddress;
        _data["gender"] = gender;
        _data["image"] = image;
        return _data;
    }
}
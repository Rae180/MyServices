class ServiceModel {
  int? id;
  int? catogryId;
  String? name;
  String? image;
  int? price;
  String? createdAt;
  String? updatedAt;

  ServiceModel(
      {this.id,
      this.catogryId,
      this.name,
      this.image,
      this.price,
      this.createdAt,
      this.updatedAt});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catogryId = json['catogry_id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}

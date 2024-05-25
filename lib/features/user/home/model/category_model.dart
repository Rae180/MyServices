class CategoryModel {
  int? id;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;

  CategoryModel(
      {this.id, this.name, this.image, this.createdAt, this.updatedAt});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Post {
  int? id;
  int? providerId;
  String? description;
  String? createdAt;
  String? updatedAt;
  List<String>? imagePaths;

  Post(
      {this.id,
      this.providerId,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.imagePaths});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imagePaths = json['image_paths'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_paths'] = this.imagePaths;
    return data;
  }
}

class StoreModel{
  String name;
  String slug;

  StoreModel({required this.name, required this.slug});

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      name: json["name"],
      slug: json["slug"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "slug": this.slug,
    };
  }
}
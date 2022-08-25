class ProfileModel {
  String? firstName;
  String? lastName;
  String? email;

  ProfileModel({
    this.firstName,
    this.lastName,
    this.email,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],);
  }

  Map<String, dynamic> toJson() {
    return {
      "first_name": this.firstName,
      "last_name": this.lastName,
      "email": this.email,
    };
  }


}
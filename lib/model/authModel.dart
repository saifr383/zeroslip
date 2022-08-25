class AuthModel{
  String access;
  String refresh;

  AuthModel({required this.access, required this.refresh});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      access: json["access"],
      refresh: json["refresh"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "access": this.access,
      "refresh": this.refresh,
    };
  }
}
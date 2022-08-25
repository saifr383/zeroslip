class HomeModel {
  int totalReceipts;
   double totalSpendings;
  int profileCompleted;
   int paperSaved;
  String customer;

  HomeModel({
    required this.totalReceipts,
    required this.totalSpendings,
    required this.profileCompleted,
    required this.paperSaved,
    required this.customer,
  });


   static  fromJson(Map<String, dynamic> json) {
    var home=HomeModel(customer: json["customer"],totalReceipts:json['total_receipts']??0,paperSaved: json['paper_saved']??0,profileCompleted:json['profile_completed']??0,totalSpendings: json['total_spendings']??0);
    return home;
  }

  Map<String, dynamic> toJson() => {
    'total_receipts' : totalReceipts,
    'total_spendings' : totalSpendings,
    'profile_completed' : profileCompleted,
    'paper_saved' : paperSaved,
    'customer' : customer
  };
}
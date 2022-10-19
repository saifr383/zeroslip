class HomeModel {
  int totalReceipts;
   double totalSpendings;
  int profileCompleted;
   int paperSaved;
  String customer;
  double maxspending;
  double minspending;

  HomeModel({
    required this.totalReceipts,
    required this.totalSpendings,
    required this.profileCompleted,
    required this.paperSaved,
    required this.customer,
    required this.maxspending,
    required this.minspending
  });


   static  fromJson(Map<String, dynamic> json) {
    var home=HomeModel(maxspending:json['max_spending'],minspending:json['min_spending'],customer: json["customer"],totalReceipts:json['total_receipts']??0,paperSaved: json['paper_saved']??0,profileCompleted:json['profile_completed']??0,totalSpendings: json['total_spendings']??0);
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
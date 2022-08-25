import 'package:intl/intl.dart';

class ReceiptModel {
  final String? receiptNumber;
  final DateTime createdAt;
  final double? total;
  final double? discount;
  final double? grandTotal;
  final int? posReceiptNumber;
  final double? salesTax;
  final double? vatTax;
  final double? change;
  final List<Items>? items;
  final Merchant? merchant;

  ReceiptModel({
    this.receiptNumber,
    required this.createdAt,
    this.total,
    this.discount,
    this.grandTotal,
    this.posReceiptNumber,
    this.salesTax,
    this.vatTax,
    this.change,
    this.items,
    this.merchant,
  });


  factory ReceiptModel.fromJson(Map<String, dynamic> json) {
    print('in functioooooooooooon');
    return ReceiptModel(
      receiptNumber: json["receipt_number"],
      createdAt: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(json["created_at"]),
      total: json["total"],
      discount: json["discount"],
      grandTotal: json["grand_total"],
      posReceiptNumber: json["pos_receipt_number"],
      salesTax: json["sales_tax"],
      vatTax: json["vat_tax"],
      change: json["change"],
      items: List.of(json["items"]??[])
          .map((i) => Items.fromJson(i))
          .toList() as List<Items>,
      merchant: Merchant.fromJson(json["merchant"]),
    );
  }

  Map<String, dynamic> toJson() => {
    'receipt_number' : receiptNumber,
    'created_at' : createdAt,
    'total' : total,
    'discount' : discount,
    'grand_total' : grandTotal,
    'pos_receipt_number' : posReceiptNumber,
    'sales_tax' : salesTax,
    'vat_tax' : vatTax,
    'change' : change,
    'items' : items?.map((e) => e.toJson()).toList(),
    'merchant' : merchant?.toJson()
  };
}

class Items {
  final String? name;
  final int? quantity;
  final double? price;
  final double? discount;
  final double? total;
  final String? barCode;

  Items({
    this.name,
    this.quantity,
    this.price,
    this.discount,
    this.total,
    this.barCode,
  });


  factory Items.fromJson(Map<String, dynamic> json) {
    print('in item function');
    return Items(
      name: json["name"],
      quantity: json["quantity"]??0,
      price: json["price"]??0,
      discount: json["discount"]??0,
      total: json["total"]??0,
      barCode: json["barCode"],
    );
  }

  Map<String, dynamic> toJson() => {
    'name' : name,
    'quantity' : quantity,
    'price' : price,
    'discount' : discount,
    'total' : total,
    'bar_code' : barCode
  };
}

class Merchant {
  final String? name;
  final String? logoUrl;

  Merchant({
    this.name,
    this.logoUrl,
  });

  Merchant.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        logoUrl = json['logo_url'] as String?;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'logo_url' : logoUrl
  };
}
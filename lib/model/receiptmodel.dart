import 'package:intl/intl.dart';
class ReceiptModel {
  final String? receiptNumber;
  final DateTime? createdAt;
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
    this.createdAt,
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
      items:  List.of(json["items"]??[])
        .map((i) => Items.fromJson(i))
        .toList() as List<Items>,
      merchant: Merchant.fromJson(json["merchant"]),
    );
  }
//

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
  final Country? country;
  final dynamic facebookUrl;
  final dynamic twitterUrl;
  final dynamic instagramUrl;
  final dynamic websiteUrl;
  final dynamic ntnNumber;
  final dynamic stnNumber;

  Merchant({
    this.name,
    this.logoUrl,
    this.country,
    this.facebookUrl,
    this.twitterUrl,
    this.instagramUrl,
    this.websiteUrl,
    this.ntnNumber,
    this.stnNumber,
  });

  Merchant.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        logoUrl = json['logo_url'] as String?,
        country = (json['country'] as Map<String,dynamic>?) != null ? Country.fromJson(json['country'] as Map<String,dynamic>) : null,
        facebookUrl = json['facebook_url'],
        twitterUrl = json['twitter_url'],
        instagramUrl = json['instagram_url'],
        websiteUrl = json['website_url'],
        ntnNumber = json['ntn_number']??0,
        stnNumber = json['stn_number'];

  Map<String, dynamic> toJson() => {
    'name' : name,
    'logo_url' : logoUrl,
    'country' : country?.toJson(),
    'facebook_url' : facebookUrl,
    'twitter_url' : twitterUrl,
    'instagram_url' : instagramUrl,
    'website_url' : websiteUrl,
    'ntn_number' : ntnNumber,
    'stn_number' : stnNumber
  };
}

class Country {
  final String? name;
  final String? slug;
  final Currency? currency;

  Country({
    this.name,
    this.slug,
    this.currency,
  });

  Country.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        slug = json['slug'] as String?,
        currency = (json['currency'] as Map<String,dynamic>?) != null ? Currency.fromJson(json['currency'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'slug' : slug,
    'currency' : currency?.toJson()
  };
}

class Currency {
  final String? name;
  final String? slug;
  final String? denotion;

  Currency({
    this.name,
    this.slug,
    this.denotion,
  });

  Currency.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        slug = json['slug'] as String?,
        denotion = json['denotion'] as String?;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'slug' : slug,
    'denotion' : denotion
  };
}
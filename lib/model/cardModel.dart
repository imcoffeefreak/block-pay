class CardModel {
  int? blockNumber;
  String? previousHash;
  String? timestamp;
  Data? data;
  String? userId;
  String? hash;

  CardModel({
    required this.blockNumber,
    required this.previousHash,
    required this.userId,
    required this.timestamp,
    required this.data,
    required this.hash,
  });

  CardModel.fromJson(Map<String, dynamic> json, String userId) {
    blockNumber = json['blockNumber'];
    previousHash = json['previousHash'];
    timestamp = json['timestamp'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
    hash = json['hash'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blockNumber'] = this.blockNumber;
    data['previousHash'] = this.previousHash;
    data['timestamp'] = this.timestamp;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['hash'] = this.hash;
    return data;
  }
}

class Data {
  String? holderName;
  String? cardNumber;
  int? amountAvailable;
  String? cardType;
  String? expiryDate;
  String? userId;

  Data({
    this.holderName,
    this.cardNumber,
    this.amountAvailable,
    this.cardType,
    this.expiryDate,
    this.userId,
  });

  Data.fromJson(Map<String, dynamic> json) {
    holderName = json['holder_name'];
    cardNumber = json['card_number'];
    amountAvailable = json['amount_available'];
    cardType = json['card_type'];
    expiryDate = json['expiry_date'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['holder_name'] = this.holderName;
    data['card_number'] = this.cardNumber;
    data['amount_available'] = this.amountAvailable;
    data['card_type'] = this.cardType;
    data['expiry_date'] = this.expiryDate;
    data['userId'] = this.userId;
    return data;
  }
}

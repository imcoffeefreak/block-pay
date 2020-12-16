class TransactionModel {
  int blockNumber;
  String previousHash;
  Data data;
  String timestamp;
  String hash;
  String userId;

  TransactionModel(
      {this.blockNumber,
        this.previousHash,
        this.data,
        this.userId,
        this.timestamp,
        this.hash});

  TransactionModel.fromJson(Map<String, dynamic> json,String userId) {
    if(json['userId'] == userId){
      blockNumber = json['blockNumber'];
      previousHash = json['previousHash'];
      data = json['data'] != null ? new Data.fromJson(json['data']) : null;
      timestamp = json['timestamp'];
      hash = json['hash'];
      userId = json['userId'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blockNumber'] = this.blockNumber;
    data['previousHash'] = this.previousHash;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['timestamp'] = this.timestamp;
    data['hash'] = this.hash;
    return data;
  }
}

class Data {
  int amount;
  String ifsc;
  String sentFrom;
  String sentTo;
  String holderName;
  String userId;
  bool isSuccess;
  bool isFailure;

  Data({this.amount, this.ifsc, this.sentFrom, this.sentTo, this.holderName,this.isFailure,this.isSuccess,this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    ifsc = json['ifsc'];
    sentFrom = json['sent_from'];
    sentTo = json['sent_to'];
    holderName = json['holder_name'];
    isFailure = json['isFailure'];
    isSuccess = json['isSuccess'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['ifsc'] = this.ifsc;
    data['sent_from'] = this.sentFrom;
    data['sent_to'] = this.sentTo;
    data['holder_name'] = this.holderName;
    data['isSuccess'] = this.isSuccess;
    data['isFailure'] = this.isFailure;
    data['userId'] = this.userId;
    return data;
  }
}

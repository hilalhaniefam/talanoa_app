class Reserve {
  String? userId;
  String? transactionId;
  String? name;
  String? phone;
  String? type;
  String? time;
  String? date;
  String? pax;
  String? status;
  String? createdAt;
  String? updatedAt;

  Reserve(
      {this.userId,
      this.transactionId,
      this.name,
      this.phone,
      this.type,
      this.time,
      this.date,
      this.pax,
      this.status,
      this.createdAt,
      this.updatedAt});

  Reserve.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    transactionId = json['transactionId'];
    name = json['name'];
    phone = json['phone'];
    type = json['type'];
    time = json['time'];
    date = json['date'];
    pax = json['pax'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['transactionId'] = transactionId;
    data['name'] = name;
    data['phone'] = phone;
    data['type'] = type;
    data['time'] = time;
    data['date'] = date;
    data['pax'] = pax;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

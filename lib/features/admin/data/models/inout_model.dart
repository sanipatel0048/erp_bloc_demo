class InOut {
  dynamic checkIn;
  dynamic checkOut;
  dynamic checkInWork;
  dynamic checkOutWork;
  dynamic photoPath;

  InOut({this.checkIn, this.checkOut});

  InOut.fromJson(Map<String, dynamic> json) {
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    checkInWork = json['checkInWork'];
    checkOutWork = json['checkOutWork'];
    photoPath = json['photoPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['checkIn'] = checkIn;
    data['checkOut'] = checkOut;
    data['checkInWork'] = checkInWork;
    data['checkOutWork'] = checkOutWork;
    data['photoPath'] = photoPath;
    return data;
  }
}

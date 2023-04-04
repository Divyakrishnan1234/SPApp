class UserModel {
  String name;
 String url;
  String createdAt;
  String service;
  String desc;
  String phoneNumber;
  String uid;

  List review;
  String rate;
  String location;



  UserModel({
    required this.name,
  required this.url,
    required this.createdAt,
    required this.service,
    required this.phoneNumber,
    required this.desc,
    required this.uid,
    required this.location,
    required this.rate,
    required this.review,

  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
     url: map['url'] ?? '',

      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
      service: map['service'] ?? '',
      desc: map['desc'] ?? '',
      location: map['location'] ?? '',
      rate: map['rate'] ?? '',
      review: map['review'] ?? '',
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "url": url,

      "uid": uid,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "service":service,
      "desc":desc,
    "review":review,
    "rate":rate,
    "location":location,
    };
  }
}

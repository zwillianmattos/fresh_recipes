class Account {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? profilePhoto;
  bool? isChef;
  String? token;

  Account({this.id, this.name, this.email, this.phoneNumber, this.profilePhoto, this.isChef, this.token});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    profilePhoto = json['profilePhoto'];
    isChef = json['isChef'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['profilePhoto'] = profilePhoto;
    data['isChef'] = isChef;
    data['token'] = token;
    return data;
  }
}

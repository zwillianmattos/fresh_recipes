class Photos {
  int? id;
  String? url;
  String? alt;

  Photos({this.id, this.url, this.alt});

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['alt'] = alt;
    return data;
  }
}

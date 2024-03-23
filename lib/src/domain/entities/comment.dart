import 'account.dart';

class Comments {
  int? id;
  String? message;
  Account? account;

  Comments({this.id, this.message, this.account});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    account = json['account'] != null ? Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    if (account != null) {
      data['account'] = account!.toJson();
    }
    return data;
  }
}

import 'package:fresh_recipes/src/domain/entities/account.dart';

class Chef {
  int? id;
  String? cpf;
  String? rg;
  Account? account;

  Chef({this.id, this.cpf, this.rg, this.account});

  Chef.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cpf = json['cpf'];
    rg = json['rg'];
    account = json['account'] != null ? Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cpf'] = cpf;
    data['rg'] = rg;
    return data;
  }
}

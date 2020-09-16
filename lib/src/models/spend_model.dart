import 'package:spends_app/src/models/spend_detail_model.dart';

import 'home_detail_model.dart';

class Spend {
  // ignore: unused_field
  String id;
  String date; //String date;
  String description;
  double amount;
  // ignore: non_constant_identifier_names
  List<HomeDetail> sd_homeDetail;
  // ignore: non_constant_identifier_names
  List<SpendDetail> sd_spendDetail;

  Spend(
      {this.id,
      this.date,
      this.description,
      this.amount,
      // ignore: non_constant_identifier_names
      this.sd_homeDetail,
      // ignore: non_constant_identifier_names
      this.sd_spendDetail});

  factory Spend.fromJson(Map<dynamic, dynamic> parsedJson) {
    
    var listHD = parsedJson['sd_homeDetail'] as List;
    print('tipo de dato en lista de sd_homeDetail: ${listHD.runtimeType}'); //returns List<dynamic>
    List<HomeDetail> sdHomeDetailList = listHD.map((i) => HomeDetail.fromJson(i)).toList();

    var listSD = parsedJson['sd_spendDetail'] as List;
    print('tipo de dato en lista de sd_spendDetail: ${listSD.runtimeType}'); //returns List<dynamic>
    List<SpendDetail> sdSpendDetailList = listSD.map((i) => SpendDetail.fromJson(i)).toList();

    return Spend(
      id: parsedJson['id'],
      date: parsedJson['date'],
      description: parsedJson['description'],
      amount: parsedJson['amount'],
      sd_homeDetail: sdHomeDetailList,
      sd_spendDetail: sdSpendDetailList,
    );
  }
}
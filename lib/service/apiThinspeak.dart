import 'dart:convert';

import 'package:dio/dio.dart';
import 'apiKey.dart';
import 'package:intl/intl.dart';

String apiKey =
    "https://api.thingspeak.com/channels/1144738/fields/1/last?key=X5I6AG6OA780BKVA";

class extractData {
  String voltage;
  String arus;

  extractData({this.voltage, this.arus});

  extractData.fromJson(Map<String, dynamic> json) {
    voltage = json['voltage'];
    arus = json['arus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['voltage'] = this.voltage;
    data['arus'] = this.arus;
    return data;
  }
}

void main() async {
  var dio = Dio();
  Response response = await dio.get(apiThinkspeak().baseUrl);
  print(response.data);
  // var dataJson = response.data.toString();
  String create = response.data['created_at'];
  var entry_id = response.data['entry_id'];
  var field1 = response.data['field1'];
  
  
  print(create.split("+")[0]);
  print(entry_id);
  print(field1);

  // var user = extractData(parsedJson);
  // print('${user.created_at}   ${user.entry_id}   ${user.field1}');
}

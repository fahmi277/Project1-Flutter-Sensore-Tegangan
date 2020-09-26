import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:skripsi_sinyal_efendi/service/apiKey.dart';

Future<String> ambilData(int bangunan, String pin) async {
  try {
    List dataReturn = List(4);
    String base = "http://blynk-cloud.com/";
    String path = "/get/" + pin;
    String token = "";

    if (bangunan == 1) {
      token = getApiKey().sinyal1;
    } else if (bangunan == 2) {
      token = getApiKey().sinyal2;
    } else if (bangunan == 3) {
      token = getApiKey().sinyal3;
    } else if (bangunan == 4) {
      token = getApiKey().sinyal4;
    }

    String link = base + token + path;

    var respon_json_tegangan = await http
        .get(Uri.encodeFull(link), headers: {'accept': 'application/json'});

    var dataBody = jsonDecode(respon_json_tegangan.body);
    print("Bangunan " +
        bangunan.toString() +
        " : " +
        dataBody.toString() +
        " pin : " +
        pin);
    dataReturn[0] = bangunan;
    // dataReturn[1] = dataBody[0];
    // dataReturn[2] = bangunan;
    // dataReturn[3] = bangunan;
    // return dataReturn;
    return dataBody[0].toString();
  } catch (e) {
    print("error");
    return ("0");
  }
}

Future<String> statusDevices(int bangunan) async {
  try {
    // http://blynk-cloud.com/auth_token/isHardwareConnected

    String base = "http://blynk-cloud.com/";
    String path = "/isHardwareConnected";
    String token = "";

    if (bangunan == 1) {
      token = getApiKey().sinyal1;
    } else if (bangunan == 2) {
      token = getApiKey().sinyal2;
    } else if (bangunan == 3) {
      token = getApiKey().sinyal3;
    } else if (bangunan == 4) {
      token = getApiKey().sinyal4;
    }

    String link = base + token + path;
    // print(link);

    var respon_json_tegangan = await http
        .get(Uri.encodeFull(link), headers: {'accept': 'application/json'});

    var dataBody = jsonDecode(respon_json_tegangan.body);

    print(dataBody);
    // print("object");
    return dataBody.toString();
    // dataReturn[1] = dataBody[0];
    // dataReturn[2] = bangunan;
    // dataReturn[3] = bangunan;
    // return dataReturn;
    // return dataBody[0].toString();

  } catch (e) {
    return ("false");
  }
}

getData() async {
  String base = "http://blynk-cloud.com/";
  String path = "/get/V0";
  // for (var i = 0; i < 4; i++) {
  //   if (i == 1) {
  String link = base + getApiKey().sinyal4 + path;
  var respon_json_tegangan = await http
      .get(Uri.encodeFull(link), headers: {'accept': 'application/json'});
  print(respon_json_tegangan.body);
  // }
  // }
}

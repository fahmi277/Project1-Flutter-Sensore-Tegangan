import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:skripsi_sinyal_efendi/service/apiKey.dart';

Future<String> ambilData(int bangunan, String pin) async {
  try {
    List dataReturn = List(4);
    String base = "http://188.166.206.43/";
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
    } else if (bangunan == 5) {
      token = getApiKey().sinyal5;
    }

    String link = base + token + path;

    var respon_json_tegangan = await http
        .get(Uri.encodeFull(link), headers: {'accept': 'application/json'});

    var dataBody = jsonDecode(respon_json_tegangan.body);
    // print("Bangunan " +
    //     bangunan.toString() +
    //     " : " +
    //     dataBody.toString() +
    //     " pin : " +
    //     pin);
    dataReturn[0] = bangunan;
    // dataReturn[1] = dataBody[0];
    // dataReturn[2] = bangunan;
    // dataReturn[3] = bangunan;
    // return dataReturn;
    return dataBody[0].toString();
  } catch (e) {
    print("error : " + bangunan.toString());
    print(e.toString());
    return ("0");
  }
}

Future<String> statusDevices(int bangunan) async {
  try {
    // http://blynk-cloud.com/auth_token/isHardwareConnected

    String base = "http://188.166.206.43/";
    String path = "/isHardwareConnected";
    String token = "";

    if (bangunan == 1) {
      token = getApiKey().sinyal1;
    } else if (bangunan == 2) {
      print("bangunnnnn");
      token = getApiKey().sinyal2;
    } else if (bangunan == 3) {
      token = getApiKey().sinyal3;
    } else if (bangunan == 4) {
      token = getApiKey().sinyal4;
    } else if (bangunan == 5) {
      token = getApiKey().sinyal5;
    }

    String link = base + token + path;

    if (bangunan == 2) {
      print("disini");
    }
    // print(link);
    var dataBody;
    int errorData = 0;
    var responJsonTegangan = await http.get(Uri.encodeFull(link));

    if (bangunan == 2) {
      print("disini1 : " + responJsonTegangan.toString());
    }
    if (responJsonTegangan.toString() != "") {
      dataBody = jsonDecode(responJsonTegangan.body);
    } else {
      dataBody = "false";
    }

    print("bangunan : " + bangunan.toString() + "  :" + dataBody.toString());
    // print("object");
    if (dataBody.toString() == "false") {
      return "Terputus";
    } else {
      return "Tersambung";
    }

    // dataReturn[1] = dataBody[0];
    // dataReturn[2] = bangunan;
    // dataReturn[3] = bangunan;
    // return dataReturn;
    // return dataBody[0].toString();

  } catch (e) {
    print("error .e opo : " + e.toString());
    return ("Terputus");
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

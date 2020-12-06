import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skripsi_sinyal_efendi/service/apiService.dart';

var titles = ["POS 1", "POS 2", "POS 3", "POS 4", "POS 5"];
var dataTegangan = ["0", "0", "0", "0", "0"];
var dataSinyal = ["0", "0", "0", "0", "0"];
var dataArus = ["0", "0", "0", "0", "0"];
var dataServer = ["0", "0", "0", "0", "0"];
var dataGangguan = [
  "Gangguan Terdeteksi",
  "Gangguan Terdeteksi",
  "Gangguan Terdeteksi",
  "Gangguan Terdeteksi",
  "Gangguan Terdeteksi"
];

var statushardware = [
  "Terputus",
  "Terputus",
  "Terputus",
  "Terputus",
  "Terputus"
];

final icons = [Icons.home];

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void startTimer() {
    Timer timer = Timer.periodic(Duration(seconds: 15), (Timer _) async {
      statushardware[0] = await statusDevices(1);
      statushardware[1] = await statusDevices(2);
      statushardware[2] = await statusDevices(3);
      statushardware[3] = await statusDevices(4);
      statushardware[4] = await statusDevices(5);
      dataTegangan[0] = await ambilData(1, "V0");
      dataTegangan[1] = await ambilData(2, "V0");
      dataTegangan[2] = await ambilData(3, "V0");
      dataTegangan[3] = await ambilData(4, "V0");
      dataTegangan[4] = await ambilData(5, "V0");

      dataArus[0] = await ambilData(1, "V1");
      dataArus[1] = await ambilData(2, "V1");
      dataArus[2] = await ambilData(3, "V1");
      dataArus[3] = await ambilData(4, "V1");
      dataArus[4] = await ambilData(5, "V1");

      dataSinyal[0] = await ambilData(1, "V2");
      dataSinyal[1] = await ambilData(2, "V2");
      dataSinyal[2] = await ambilData(3, "V2");
      dataSinyal[3] = await ambilData(4, "V2");
      dataSinyal[4] = await ambilData(5, "V2");

      setState(() {});
    });
  }

  void timer1() {
    Timer timer = Timer.periodic(Duration(seconds: 15), (Timer _) async {
      statushardware[0] = await statusDevices(1);
      dataTegangan[0] = await ambilData(1, "V0");
      dataArus[0] = await ambilData(1, "V1");
      dataSinyal[0] = await ambilData(1, "V2");
      setState(() {});
    });
  }

  void timer2() {
    Timer timer = Timer.periodic(Duration(seconds: 15), (Timer _) async {
      print("timer 2");
      statushardware[1] = await statusDevices(2);
      dataTegangan[1] = await ambilData(2, "V0");
      dataArus[1] = await ambilData(2, "V1");
      dataSinyal[1] = await ambilData(2, "V2");
    });
  }

  void timer3() {
    Timer timer = Timer.periodic(Duration(seconds: 15), (Timer _) async {
      statushardware[2] = await statusDevices(3);
      dataTegangan[2] = await ambilData(3, "V0");
      dataArus[2] = await ambilData(3, "V1");
      dataSinyal[2] = await ambilData(3, "V2");
    });
  }

  void timer4() {
    Timer timer = Timer.periodic(Duration(seconds: 15), (Timer _) async {
      statushardware[3] = await statusDevices(4);
      dataTegangan[3] = await ambilData(4, "V0");
      dataArus[3] = await ambilData(4, "V1");
      dataSinyal[3] = await ambilData(4, "V2");
    });
  }

  void timer5() {
    Timer timer = Timer.periodic(Duration(seconds: 15), (Timer _) async {
      statushardware[4] = await statusDevices(5);
      dataTegangan[4] = await ambilData(5, "V0");
      dataArus[4] = await ambilData(5, "V1");
      dataSinyal[4] = await ambilData(5, "V2");
    });
  }

  void timerUI() {
    Timer timer = Timer.periodic(Duration(seconds: 5), (Timer _) async {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    // startTimer(); //PANGGIL FUNGSI YANG TELAH DIBUAT SEBELUMNYA
    timer1();
    timer2();
    timer3();
    timer4();
    timer5();
    timerUI();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Sinyal Monitoring")),
          //  backgroundColor: Colors.blueGrey,
        ),
        body: Stack(
          children: <Widget>[
            _myListView(context),
            // Text("data")
            // _test(context)
          ],
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   backgroundColor:
        //       Colors.blue, // this will be set when a new tab is tapped
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Text(
        //         "Voltage Server",
        //         style: TextStyle(color: Colors.white),
        //       ),
        //       title: new Text(
        //         dataServer[0] + " V",
        //         style: TextStyle(color: Colors.white),
        //       ),
        //     ),
        //     // BottomNavigationBarItem(
        //     //   icon: Text(
        //     //     "Current Server",
        //     //     style: TextStyle(color: Colors.white),
        //     //   ),
        //     //   title: new Text(
        //     //     dataServer[1] + " A",
        //     //     style: TextStyle(color: Colors.white),
        //     //   ),
        //     // ),
        //     // BottomNavigationBarItem(
        //     //   icon: Text(
        //     //     "Signal Server",
        //     //     style: TextStyle(color: Colors.white),
        //     //   ),
        //     //   title: new Text(
        //     //     dataServer[2] + " %",
        //     //     style: TextStyle(color: Colors.white),
        //     //   ),
        //     // ),
        //   ],
        // ),
      ),
    );
  }

// Widget _myListView(BuildContext context) {
//     return ListView();
//   }

  Widget _myListView(BuildContext context) {
    if (statushardware[0] == "Terputus") {
      dataSinyal[0] = "0";
      dataTegangan[0] = "0";
      dataArus[0] = "0";
      dataGangguan[0] = "Gangguan Terdeteksi";
    } else {
      if (double.parse(dataSinyal[0]) < 30) {
        dataGangguan[0] = "Sinyal Buruk";
      } else {
        dataGangguan[0] = "Stabil";
      }
    }

    if (statushardware[1] == "Terputus") {
      dataSinyal[1] = "0";
      dataTegangan[1] = "0";
      dataArus[1] = "0";
      dataGangguan[1] = "Gangguan Terdeteksi";
    } else {
      if (double.parse(dataSinyal[1]) < 30) {
        dataGangguan[1] = "Sinyal Buruk";
      } else {
        dataGangguan[1] = "Stabil";
      }
    }

    if (statushardware[2] == "Terputus") {
      dataSinyal[2] = "0";
      dataTegangan[2] = "0";
      dataArus[2] = "0";
      dataGangguan[2] = "Gangguan Terdeteksi";
    } else {
      if (double.parse(dataSinyal[2]) < 30) {
        dataGangguan[2] = "Sinyal Buruk";
      } else {
        dataGangguan[2] = "Stabil";
      }
    }

    if (statushardware[3] == "Terputus") {
      dataSinyal[3] = "0";
      dataTegangan[3] = "0";
      dataArus[3] = "0";
      dataGangguan[3] = "Gangguan Terdeteksi";
    } else {
      if (double.parse(dataSinyal[3]) < 30) {
        dataGangguan[3] = "Sinyal Buruk";
      } else {
        dataGangguan[3] = "Stabil";
      }
    }

    if (statushardware[4] == "Terputus") {
      dataSinyal[4] = "0";
      dataTegangan[4] = "0";
      dataArus[4] = "0";
      dataGangguan[4] = "Gangguan Terdeteksi";
    } else {
      if (double.parse(dataSinyal[4]) < 30) {
        dataGangguan[4] = "Sinyal Buruk";
      } else {
        dataGangguan[4] = "Stabil";
      }
    }
    var dataMasuk = [
      "Sinyal: " +
          double.tryParse(dataSinyal[0]).toStringAsFixed(1).toString() +
          "%, Koneksi: " +
          statushardware[0] +
          "\nTegangan: " +
          double.tryParse(dataTegangan[0]).toStringAsFixed(1).toString() +
          "V, Arus: " +
          double.tryParse(dataArus[0]).toStringAsFixed(1).toString() +
          "A\nStatus : " +
          dataGangguan[0],
      "Sinyal: " +
          double.tryParse(dataSinyal[1]).toStringAsFixed(1).toString() +
          "%, Koneksi: " +
          statushardware[1] +
          "\nTegangan: " +
          double.tryParse(dataTegangan[1]).toStringAsFixed(1).toString() +
          "V, Arus: " +
          double.tryParse(dataArus[1]).toStringAsFixed(1).toString() +
          "A\nStatus : " +
          dataGangguan[1],
      "Sinyal: " +
          double.tryParse(dataSinyal[2]).toStringAsFixed(1).toString() +
          "%, Koneksi: " +
          statushardware[2] +
          "\nTegangan: " +
          double.tryParse(dataTegangan[2]).toStringAsFixed(1).toString() +
          "V, Arus: " +
          double.tryParse(dataArus[2]).toStringAsFixed(1).toString() +
          "A\nStatus : " +
          dataGangguan[2],
      "Sinyal: " +
          double.tryParse(dataSinyal[3]).toStringAsFixed(1).toString() +
          "%, Koneksi: " +
          statushardware[3] +
          "\nTegangan: " +
          double.tryParse(dataTegangan[3]).toStringAsFixed(1).toString() +
          "V, Arus: " +
          double.tryParse(dataArus[3]).toStringAsFixed(1).toString() +
          "A\nStatus : " +
          dataGangguan[3],
      "Sinyal: " +
          double.tryParse(dataSinyal[4]).toStringAsFixed(1).toString() +
          "%, Koneksi: " +
          statushardware[4] +
          "\nTegangan: " +
          double.tryParse(dataTegangan[4]).toStringAsFixed(1).toString() +
          "V, Arus: " +
          double.tryParse(dataArus[4]).toStringAsFixed(1).toString() +
          "A\nStatus : " +
          dataGangguan[4]
    ];
    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (context, index) {
        var warna = Colors.blue;
        if (statushardware[index] == "Terputus") {
          warna = Colors.red;
        } else if (double.parse(dataSinyal[index]) < 30) {
          warna = Colors.amber;
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: warna,
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icons[0],
                    color: Colors.white,
                  ),
                  Text(
                    titles[index],
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              title: Text(
                dataMasuk[index],
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}

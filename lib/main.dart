import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skripsi_sinyal_efendi/service/apiService.dart';

var titles = ["POS 1", "POS 2", "POS 3", "POS 4"];
var dataTegangan = ["0", "0", "0", "0"];
var dataSinyal = ["0", "0", "0", "0"];
var dataArus = ["0", "0", "0", "0"];
var dataServer = ["0", "0", "0"];
var dataGangguan = [
  "Gangguan Terdeteksi",
  "Gangguan Terdeteksi",
  "Gangguan Terdeteksi",
  "Gangguan Terdeteksi"
];

var statushardware = ["Terputus", "Terputus", "Terputus", "Terputus"];

final icons = [Icons.home];

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void startTimer() {
    // Start the periodic timer which prints something every 1 seconds
    Timer timer = Timer.periodic(Duration(seconds: 5), (Timer _) async {
      // Update something...
      // getData();
      statushardware[0] = await statusDevices(1);
      statushardware[1] = await statusDevices(2);
      statushardware[2] = await statusDevices(3);
      statushardware[3] = await statusDevices(4);
      dataTegangan[0] = await ambilData(1, "V0");
      // dataTegangan[1] = await ambilData(2, "V0");
      // dataTegangan[2] = await ambilData(3, "V0");
      // dataTegangan[3] = await ambilData(4, "V0");

      dataArus[0] = await ambilData(1, "V1");
      // dataArus[1] = await ambilData(2, "V1");
      // dataArus[2] = await ambilData(3, "V1");
      // dataArus[3] = await ambilData(4, "V1");

      dataSinyal[0] = await ambilData(1, "V2");
      // dataSinyal[1] = await ambilData(2, "V2");
      // dataSinyal[2] = await ambilData(3, "V2");
      // dataSinyal[3] = await ambilData(4, "V2");

      setState(() {});

      // ambilData(1,"V3");
      // ambilData(2,"V3");
      // ambilData(3,"V3");
      // ambilData(4,"V3");
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer(); //PANGGIL FUNGSI YANG TELAH DIBUAT SEBELUMNYA
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
            // _test(context)
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor:
              Colors.blue, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: Text(
                "Voltage Server",
                style: TextStyle(color: Colors.white),
              ),
              title: new Text(
                dataServer[0] + " V",
                style: TextStyle(color: Colors.white),
              ),
            ),
            BottomNavigationBarItem(
              icon: Text(
                "Current Server",
                style: TextStyle(color: Colors.white),
              ),
              title: new Text(
                dataServer[1] + " A",
                style: TextStyle(color: Colors.white),
              ),
            ),
            BottomNavigationBarItem(
              icon: Text(
                "Signal Server",
                style: TextStyle(color: Colors.white),
              ),
              title: new Text(
                dataServer[2] + " %",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _myListView(BuildContext context) {
  //     return ListView();
  //   }
  Widget _test(BuildContext context) {
    //var dataModbus =
    return Card(
      child: ListTile(
        title: Text("Address Modbus"),
        subtitle: Text(dataArus[0]),
      ),
    );
  }

  Widget _myListView(BuildContext context) {
    if (statushardware[0] == "Terputus") {
      dataSinyal[0] = "0";
      dataTegangan[0] = "0";
      dataArus[0] = "0";
      dataGangguan[0] = "Gangguan Terdeteksi";
    } else {
      dataGangguan[0] = "Stabil";
    }

    if (statushardware[1] == "Terputus") {
      dataSinyal[1] = "0";
      dataTegangan[1] = "0";
      dataArus[1] = "0";
      dataGangguan[1] = "Gangguan Terdeteksi";
    } else {
      dataGangguan[1] = "Stabil";
    }

    if (statushardware[2] == "Terputus") {
      dataSinyal[2] = "0";
      dataTegangan[2] = "0";
      dataArus[2] = "0";
      dataGangguan[2] = "Gangguan Terdeteksi";
    } else {
      dataGangguan[2] = "Stabil";
    }

    if (statushardware[3] == "Terputus") {
      dataSinyal[3] = "0";
      dataTegangan[3] = "0";
      dataArus[3] = "0";
      dataGangguan[3] = "Gangguan Terdeteksi";
    } else {
      dataGangguan[3] = "Stabil";
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
    ];
    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.blue,
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

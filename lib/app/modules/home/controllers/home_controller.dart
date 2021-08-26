import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ongkir_app/app/modules/home/courier_model.dart';

class HomeController extends GetxController {
  var hiddenKotaAsal = true.obs;
  var hiddenKotaTujuan = true.obs;
  var provAsalId = 0.obs;
  var kotaAsalId = 0.obs;
  var provTujuanId = 0.obs;
  var kotaTujuanId = 0.obs;
  var hiddenButton = true.obs;
  var kurir = "".obs;

  double berat = 0.0;
  String satuanBerat = "gram";

  late TextEditingController beratController;

  void ongkosKirim() async {
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
    String api_key = "0ef7a3102a289380a00c9da42cf0a952";

    try {
      final response = await http.post(
        url,
        body: {
          "origin": "$kotaAsalId",
          "destination": "$kotaTujuanId",
          "weight": "$berat",
          "courier": "$kurir",
        },
        headers: {
          "key": api_key,
          'content-type': 'application/x-www-form-urlencoded',
        },
      );
      var data = jsonDecode(response.body);

      var results = data['rajaongkir']['results'];
      var listAllCourier = CourierModel.fromJsonList(results);
      var dataCourier = listAllCourier[0];

      Get.defaultDialog(
        titlePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        title: dataCourier.name!,
        content: Column(
          children: dataCourier.costs!
              .map(
                (e) => ListTile(
                  title: Text("${e.service}"),
                  subtitle: Text("Rp. ${e.cost![0].value}"),
                  trailing: Text(dataCourier.code == "pos"
                      ? "${e.cost![0].etd}"
                      : "${e.cost![0].etd} HARI"),
                ),
              )
              .toList(),
        ),
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: e.toString(),
      );
    }
  }

  void showButton() {
    if (kotaAsalId != 0 && kotaTujuanId != 0 && berat > 0.0 && kurir != "") {
      hiddenButton.value = false;
    } else {
      hiddenButton.value = true;
    }
  }

  void ubahBerat(String value) {
    berat = double.tryParse(value) ?? 0.0;
    String cekSatuan = satuanBerat;

    switch (cekSatuan) {
      case "ton":
        berat = berat * 1000000;
        break;

      case "kwintal":
        berat = berat * 100000;
        break;

      case "ons":
        berat = berat * 100;
        break;

      case "lbs":
        berat = berat * 2204.62;
        break;

      case "pound":
        berat = berat * 2204.62;
        break;

      case "kg":
        berat = berat * 1000;
        break;

      case "hg":
        berat = berat * 100;
        break;

      case "dag":
        berat = berat * 10;
        break;

      case "gram":
        berat = berat;
        break;

      case "dg":
        berat = berat / 10;
        break;

      case "cg":
        berat = berat / 100;
        break;

      case "mg":
        berat = berat / 100;
        break;

      default:
        berat = berat;
    }
    showButton();
  }

  void ubahSatuan(String value) {
    berat = double.tryParse(beratController.text) ?? 0.0;
    switch (value) {
      case "ton":
        berat = berat * 1000000;
        break;

      case "kwintal":
        berat = berat * 100000;
        break;

      case "ons":
        berat = berat * 100;
        break;

      case "lbs":
        berat = berat * 2204.62;
        break;

      case "pound":
        berat = berat * 2204.62;
        break;

      case "kg":
        berat = berat * 1000;
        break;

      case "hg":
        berat = berat * 100;
        break;

      case "dag":
        berat = berat * 10;
        break;

      case "gram":
        berat = berat;
        break;

      case "dg":
        berat = berat / 10;
        break;

      case "cg":
        berat = berat / 100;
        break;

      case "mg":
        berat = berat / 100;
        break;

      default:
        berat = berat;
    }

    satuanBerat = value;
    showButton();
  }

  @override
  void onInit() {
    beratController = TextEditingController(text: "$berat");
    super.onInit();
  }

  @override
  void onClose() {
    beratController.dispose();
    super.onClose();
  }
}

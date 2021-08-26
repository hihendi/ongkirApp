import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ongkir_app/app/modules/home/controllers/home_controller.dart';

import '../../province_model_model.dart';

class Provinsi extends GetView<HomeController> {
  const Provinsi({
    required this.tipe,
    Key? key,
  }) : super(key: key);

  final String tipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<ProvinceModel>(
        label: tipe == "asal" ? "Provinsi Asal" : "Provinsi Tujuan",
        showClearButton: true,
        onFind: (String filter) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
          String api_key = "0ef7a3102a289380a00c9da42cf0a952";

          try {
            final response = await http.get(
              url,
              headers: {
                "key": api_key,
              },
            );

            var data = jsonDecode(response.body);

            var statusCode = data['rajaongkir']["status"]["code"];
            var listAllProvince = data["rajaongkir"]["results"];

            if (statusCode != 200) {
              throw data["rajaongkir"]["status"]["description"];
            }

            var models = ProvinceModel.fromJsonList(listAllProvince);
            return models;
          } catch (e) {
            print(e);
            return List<ProvinceModel>.empty();
          }
        },
        onChanged: (prov) {
          if (prov != null) {
            if (tipe == "asal") {
              controller.hiddenKotaAsal.value = false;
              controller.provAsalId.value = int.parse(prov.provinceId!);
            } else {
              controller.hiddenKotaTujuan.value = false;
              controller.provTujuanId.value = int.parse(prov.provinceId!);
            }
          } else {
            if (tipe == "asal") {
              controller.hiddenKotaAsal.value = true;
              controller.provAsalId.value = 0;
            } else {
              controller.hiddenKotaTujuan.value = true;
              controller.provTujuanId.value = 0;
            }
            controller.hiddenButton.value = true;
          }
        },
        showSearchBox: true,
        searchBoxDecoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            hintText: "Cari Provinsi ...",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
              "${item.province}",
              style: TextStyle(fontSize: 18),
            ),
          );
        },
        itemAsString: (item) => item.province!,
      ),
    );
  }
}

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ongkir_app/app/modules/home/city_model_model.dart';
import 'package:ongkir_app/app/modules/home/controllers/home_controller.dart';

class Kota extends GetView<HomeController> {
  const Kota({
    required this.provId,
    required this.tipe,
    Key? key,
  }) : super(key: key);
  final int provId;
  final String tipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<CityModel>(
        label: tipe == "asal"
            ? "Kota / Kabupaten Asal"
            : "Kota / Kabupaten Tujuan",
        showClearButton: true,
        onFind: (String filter) async {
          Uri url = Uri.parse(
              "https://api.rajaongkir.com/starter/city?province=$provId");
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
            var listAllCity = data["rajaongkir"]["results"];

            if (statusCode != 200) {
              throw data["rajaongkir"]["status"]["description"];
            }

            var models = CityModel.fromJsonList(listAllCity);
            return models;
          } catch (e) {
            print(e);
            return List<CityModel>.empty();
          }
        },
        onChanged: (city) {
          if (city != null) {
            if (tipe == "asal") {
              controller.kotaAsalId.value = int.parse(city.cityId!);
              print(
                  "Kota Asal : ${city.type} ${city.cityName} / ID : ${city.cityId}");
            } else {
              controller.kotaTujuanId.value = int.parse(city.cityId!);
              print(
                  "Kota Tujuan : ${city.type} ${city.cityName} / ID : ${city.cityId}");
            }
          } else {
            if (tipe == "asal") {
              controller.kotaAsalId.value = 0;
              print("Tidak memilih Kota / Kabupaten Asal apapun");
            } else {
              controller.kotaTujuanId.value = 0;
              print("Tidak memilih Kota / Kabupaten Tujuan apapun");
            }
          }
          controller.showButton();
        },
        showSearchBox: true,
        searchBoxDecoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            hintText: "Cari Kota / Kabupaten ...",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
              "${item.type} ${item.cityName}",
              style: TextStyle(fontSize: 18),
            ),
          );
        },
        itemAsString: (item) => "${item.type} ${item.cityName}",
      ),
    );
  }
}

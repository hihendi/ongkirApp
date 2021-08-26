import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir_app/app/modules/home/controllers/home_controller.dart';

class Courier extends GetView<HomeController> {
  const Courier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<Map<String, dynamic>>(
        mode: Mode.MENU,
        items: [
          {
            "code": "jne",
            "name": "Jalur Nugraha Ekakurir (JNE)",
          },
          {
            "code": "tiki",
            "name": "Titipan Kilat (TiKi)",
          },
          {
            "code": "pos",
            "name": "POS Indonesia",
          },
        ],
        label: "Pilih Kurir",
        hint: "Pilih Kurir",
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "${item["name"]}",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          );
        },
        itemAsString: (item) => "${item["name"]}",
        onChanged: (value) {
          if (value != null) {
            controller.kurir.value = value["code"];
            controller.showButton();
          } else {
            controller.hiddenButton.value = true;
            controller.kurir.value = "";
          }
        },
        showClearButton: true,
      ),
    );
  }
}

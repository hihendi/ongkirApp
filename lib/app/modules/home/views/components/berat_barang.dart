import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ongkir_app/app/modules/home/controllers/home_controller.dart';

class BeratBarang extends GetView<HomeController> {
  const BeratBarang({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: false,
              controller: controller.beratController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: "Berat Barang",
                hintText: "Berat Barang",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.ubahBerat(value),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 150,
            child: DropdownSearch<String>(
                mode: Mode.BOTTOM_SHEET,
                showSelectedItem: true,
                showSearchBox: true,
                searchBoxDecoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    hintText: "Satuan Berat",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                items: [
                  "ton",
                  "kwintal",
                  "ons",
                  'lbs',
                  "pound",
                  "kg",
                  "hg",
                  "dag",
                  "gram",
                  "dag",
                  "cg",
                  "mg",
                ],
                label: "Satuan Berat",
                onChanged: (value) => controller.ubahSatuan(value ?? "gram"),
                selectedItem: "gram"),
          )
        ],
      ),
    );
  }
}

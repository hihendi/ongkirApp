import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ongkir_app/app/modules/home/views/components/courier.dart';

import '../controllers/home_controller.dart';
import 'components/berat_barang.dart';
import 'components/kota_section.dart';
import 'components/provinsi_section.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Ongkos Kirim'),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Provinsi(
              tipe: "asal",
            ),
            Obx(
              () => controller.hiddenKotaAsal.value
                  ? SizedBox()
                  : Kota(
                      tipe: "asal",
                      provId: controller.provAsalId.value,
                    ),
            ),
            Provinsi(
              tipe: "tujuan",
            ),
            Obx(
              () => controller.hiddenKotaTujuan.value
                  ? SizedBox()
                  : Kota(
                      tipe: "tujuan",
                      provId: controller.provTujuanId.value,
                    ),
            ),
            BeratBarang(),
            Courier(),
            Obx(
              () => controller.hiddenButton.value
                  ? SizedBox()
                  : ElevatedButton(
                      onPressed: () => controller.ongkosKirim(),
                      child: Text("CEK ONGKOS KIRIM"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        primary: Colors.red[600],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

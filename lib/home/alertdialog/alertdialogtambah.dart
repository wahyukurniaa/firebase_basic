import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_basic/home/home_controller.dart';
import 'package:firebase_basic/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void addOrUpdateMahasiswaDialog(BuildContext context, {Mahasiswa? mahasiswa}) {
  final HomeController homeController = Get.put(HomeController());
  final userId = FirebaseAuth.instance.currentUser?.uid;

  final TextEditingController namaController =
      TextEditingController(text: mahasiswa?.nama ?? '');
  final TextEditingController jurusanController =
      TextEditingController(text: mahasiswa?.jurusan ?? '');
  final TextEditingController kampusController =
      TextEditingController(text: mahasiswa?.kampus ?? '');

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title:
            Text(mahasiswa == null ? 'Tambah Mahasiswa' : 'Update Mahasiswa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: jurusanController,
              decoration: const InputDecoration(labelText: 'Jurusan'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: kampusController,
              decoration: const InputDecoration(labelText: 'Kampus'),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final nama = namaController.text.trim();
              final jurusan = jurusanController.text.trim();
              final kampus = kampusController.text.trim();

              if (nama.isNotEmpty && jurusan.isNotEmpty && kampus.isNotEmpty) {
                if (mahasiswa == null) {
                  homeController.tambahMahasiswa(
                      nama, jurusan, kampus, userId ?? '');
                } else {
                  homeController.updateMahasiswa(
                    mahasiswa.id,
                    nama,
                    jurusan,
                    kampus,
                  );
                }
                Get.back();
              }
            },
            child: Text(mahasiswa == null ? 'Tambah' : 'Update'),
          ),
        ],
      );
    },
  );
}

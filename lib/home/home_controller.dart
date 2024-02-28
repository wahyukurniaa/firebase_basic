import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_basic/model/model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final CollectionReference _dataMahasiswa =
      FirebaseFirestore.instance.collection('DataSiswa');
  final Rx<List<Mahasiswa>> _mahasiswa = Rx<List<Mahasiswa>>([]);
  Stream<List<Mahasiswa>> get mahasiswaStream => _mahasiswa.stream;

  @override
  void onInit() {
    super.onInit();
    initializeFirebaseAndFetchData();
  }

  Future<void> initializeFirebaseAndFetchData() async {
    try {
      await Firebase.initializeApp();
      await tampilkanMahasiswa();
    } catch (e) {
      debugPrint('Error initializing Firebase: $e');
    }
  }

  Future<void> tampilkanMahasiswa() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        final snapshot =
            await _dataMahasiswa.where('userId', isEqualTo: userId).get();
        final mahasiswaList = snapshot.docs
            .map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              if (data.containsKey('userId')) {
                // Check if userId exists
                return Mahasiswa(
                  id: doc.id,
                  nama: data['nama'] ?? '', // Use default value if nama is null
                  jurusan: data['jurusan'] ??
                      '', // Use default value if jurusan is null
                  kampus: data['kampus'] ??
                      '', // Use default value if kampus is null
                  userId: data['userId'] ??
                      '', // Use default value if userId is null
                );
              } else {
                return null; // Return null if userId doesn't exist
              }
            })
            .where((mahasiswa) => mahasiswa != null)
            .toList(); // Remove null values
        _mahasiswa.value =
            mahasiswaList.cast<Mahasiswa>(); // Cast to Mahasiswa type
      } else {
        debugPrint('User is not authenticated');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }

  Future<void> updateMahasiswa(
    String id,
    String nama,
    String jurusan,
    String kampus,
  ) async {
    try {
      await _dataMahasiswa.doc(id).update({
        'nama': nama,
        'jurusan': jurusan,
        'kampus': kampus,
      });
      tampilkanMahasiswa();
    } catch (e) {
      debugPrint('Error updating data: $e');
    }
  }

  Future<void> tambahMahasiswa(
      String nama, String jurusan, String kampus, String userId) async {
    try {
      _dataMahasiswa.add(
        {'nama': nama, 'jurusan': jurusan, 'kampus': kampus, 'userId': userId},
      );
      tampilkanMahasiswa();
    } catch (e) {
      debugPrint('error create data:$e');
    }
  }

  Future<void> hapusMahasiswa(String id, String userId) async {
    try {
      await _dataMahasiswa.doc(id).delete();
      tampilkanMahasiswa();
    } catch (e) {
      debugPrint('Gagal Menghapus data $e');
    }
  }
}

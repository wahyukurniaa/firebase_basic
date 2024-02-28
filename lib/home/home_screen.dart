import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_basic/home/alertdialog/alertdialogtambah.dart';
import 'package:firebase_basic/home/home_controller.dart';
import 'package:firebase_basic/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    final TextEditingController namaController = TextEditingController();
    final TextEditingController jurusanController = TextEditingController();
    final TextEditingController kampusController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Get.offAllNamed('/SignIn');
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder(
        stream: homeController.mahasiswaStream,
        builder: (context, AsyncSnapshot<List<Mahasiswa>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final mahasiswaList = snapshot.data ?? [];
            return ListView.builder(
              itemCount: mahasiswaList.length,
              itemBuilder: (context, index) {
                final data = mahasiswaList[index];
                return ListTile(
                  title: Text(data.nama),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      homeController.hapusMahasiswa(data.id, data.userId);
                    },
                  ),
                  onTap: () {
                    namaController.text = data.nama;
                    jurusanController.text = data.jurusan;
                    kampusController.text = data.kampus;
                    addOrUpdateMahasiswaDialog(context, mahasiswa: data);
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addOrUpdateMahasiswaDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  final CollectionReference _dataCollection =
      FirebaseFirestore.instance.collection('Data');
  var dataList = <QueryDocumentSnapshot>[].obs;

  @override
  void onInit() {
    super.onInit();
    _getData();
  }

  // Create
  Future<void> addData(String value) async {
    await _dataCollection.add({'field_name': value});
  }

  // Read
  void _getData() {
    _dataCollection.snapshots().listen((snapshot) {
      dataList.value = snapshot.docs;
    });
  }

  // Update
  Future<void> updateData(String docId, String newValue) async {
    await _dataCollection.doc(docId).update({'field_name': newValue});
  }

  // Delete
  Future<void> deleteData(String docId) async {
    await _dataCollection.doc(docId).delete();
  }
}

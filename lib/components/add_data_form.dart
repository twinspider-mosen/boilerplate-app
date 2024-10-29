import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/general_controller.dart';

class AddDataForm extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final DataController dataController = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(labelText: 'Enter data'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              dataController.addData(_controller.text);
              _controller.clear();
            }
          },
          child: Text('Add Data'),
        ),
      ],
    );
  }
}

class DataList extends StatelessWidget {
  final DataController dataController = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (dataController.dataList.isEmpty) {
        return Center(child: Text('No data available'));
      }

      return ListView.builder(
        itemCount: dataController.dataList.length,
        itemBuilder: (context, index) {
          final doc = dataController.dataList[index];
          final data = doc.data() as Map<String, dynamic>;
          return ListTile(
            title: Text(data['field_name'] ?? 'No data'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    dataController.updateData(doc.id, 'Updated Value');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    dataController.deleteData(doc.id);
                  },
                ),
              ],
            ),
          );
        },
      );
    });
  }
}

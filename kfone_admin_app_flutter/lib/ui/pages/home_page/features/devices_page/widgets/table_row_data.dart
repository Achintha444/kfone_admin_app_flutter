import 'package:flutter/material.dart';
import 'package:kfone_admin_app_flutter/ui/widgets/common/resizable_image.dart';

DataRow tableRowData(String name, String imageUrl) {
  return DataRow(
    cells: <DataCell>[
      DataCell(Text(name)),
      DataCell(
        Image.network(
          imageUrl,
          height: 50,
          errorBuilder: (context, error, stackTrace) => const ResizableImage(
            fit: BoxFit.fitHeight,
            imageLocation: 'assets/images/no_image.jpeg',
            height: 50,
          ),
        ),
      ),
      const DataCell(
        Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.edit_outlined,
            color: Colors.black45,
          ),
        ),
      ),
    ],
  );
}

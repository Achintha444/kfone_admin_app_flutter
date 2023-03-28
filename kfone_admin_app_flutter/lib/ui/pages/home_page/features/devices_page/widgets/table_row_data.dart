import 'package:flutter/material.dart';

DataRow tableRowData(String name, String imageUrl) {
  return DataRow(
    cells: <DataCell>[
      DataCell(Text(name)),
      DataCell(
        Image.network(
          imageUrl,
          scale: 1,
          height: 50,
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

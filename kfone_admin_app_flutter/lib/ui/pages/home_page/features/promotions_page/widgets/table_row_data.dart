import 'package:flutter/material.dart';

DataRow tableRowData(String code, String discount) {
  return DataRow(
    cells: <DataCell>[
      DataCell(Text(code)),
      DataCell(Text(discount)),
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

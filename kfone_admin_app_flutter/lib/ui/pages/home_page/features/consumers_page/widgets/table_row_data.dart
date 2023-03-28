import 'package:flutter/material.dart';

import 'tier_chip.dart';

DataRow tableRowData(String name, TierChipType tierChipType) {
  return DataRow(
    cells: <DataCell>[
      DataCell(Text(name)),
      DataCell(TierChip(tierChipType: tierChipType)),
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

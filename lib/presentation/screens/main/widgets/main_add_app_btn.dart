import 'package:flutter/material.dart';
import 'package:private_store_admin/config/theme/cw_colors.dart';
import 'package:private_store_admin/presentation/screens/main/widgets/main_add_app_bottom_sheet.dart';

class MainAddAppBtn extends StatelessWidget {
  const MainAddAppBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return MainAddAppBottomSheet();
            });
      },
      child: Container(
        color: CwColors.color3,
        padding: EdgeInsets.all(10),
        child: Text(
          'Add new app',
        ),
      ),
    );
  }
}

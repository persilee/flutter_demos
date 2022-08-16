import 'package:flutter/material.dart';

import 'menu_data.dart';

class LocalDragIcon extends StatefulWidget {
  const LocalDragIcon({Key? key}) : super(key: key);

  @override
  State<LocalDragIcon> createState() => _LocalDragIconState();
}

class _LocalDragIconState extends State<LocalDragIcon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Drag Icon'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < 4; i++)
                  _buildIcon(
                    icon: MenuDataList.menuList[i].icon,
                    name: MenuDataList.menuList[i].name,
                  ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 4; i < 8; i++)
                  _buildIcon(
                    icon: MenuDataList.menuList[i].icon,
                    name: MenuDataList.menuList[i].name,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon({required IconData icon, required String name}) {
    return Column(
      children: [
        Container(
          width: (MediaQuery.of(context).size.width - 100) / 4,
          height: (MediaQuery.of(context).size.width - 100) / 4,
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: const Color(0xffF3F6F9),
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(14.0)),
            boxShadow: [
              const BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0.16,
                color: Color(0x0F000000),
              ),
              BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 2,
                spreadRadius: 0.1,
                color: const Color(0xFF000000).withOpacity(0.15),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 40.0,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 12.0)),
        SizedBox(
          width: (MediaQuery.of(context).size.width - 100) / 4,
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff686A7B),
              fontSize: 12.0,
              height: 1,
            ),
          ),
        )
      ],
    );
  }
}

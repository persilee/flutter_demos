import 'package:flutter/material.dart';

class MenuData {
  final IconData icon;
  final String name;

  MenuData({required this.icon, required this.name});
}

class MenuDataList {
  static List<MenuData> menuList = [
    MenuData(icon: Icons.agriculture_outlined, name: '交友'),
    MenuData(icon: Icons.hail_rounded, name: '户外'),
    MenuData(icon: Icons.kayaking_sharp, name: '一起看'),
    MenuData(icon: Icons.emoji_emotions, name: '二次元'),
    MenuData(icon: Icons.face, name: '颜值'),
    MenuData(icon: Icons.water, name: '新秀'),
    MenuData(icon: Icons.volunteer_activism_rounded, name: '唱歌'),
    MenuData(icon: Icons.mic_sharp, name: '音乐'),
    MenuData(icon: Icons.videocam_outlined, name: '电影'),
  ];
}

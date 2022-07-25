import 'package:flutter/material.dart';

import '../widget/gif.dart';

class NavBottomGif extends StatefulWidget {
  const NavBottomGif({Key? key}) : super(key: key);

  @override
  State<NavBottomGif> createState() => _NavBottomGifState();
}

class _NavBottomGifState extends State<NavBottomGif>
    with TickerProviderStateMixin {
  late GifController controller1, controller2, controller3, controller4;
  int _currentIndex = 0;

  @override
  void initState() {
    controller1 = GifController(vsync: this);
    controller1.duration = const Duration(milliseconds: 3600);
    controller1.forward();
    controller2 = GifController(vsync: this);
    controller3 = GifController(vsync: this);
    controller4 = GifController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation bottom gif'),
      ),
      body: _myBody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _myBody() {
    List<Widget> pages = [
      Container(
        alignment: Alignment.center,
        child: const Text(
          "Home",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: const Text(
          "Users",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: const Text(
          "Messages",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: const Text(
          "Settings",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }

  Widget _createIconButton(
      {required int index,
      required String name,
      required String icon,
      required String iconActive,
      double? iconSize,
      required GifController controller}) {
    return InkWell(
      onTap: () {
        if (index == 0) {
          controller1.forward();
          controller2.reset();
          controller3.reset();
          controller4.reset();
        } else if (index == 1) {
          controller1.reset();
          controller2.forward();
          controller3.reset();
          controller4.reset();
        } else if (index == 2) {
          controller2.reset();
          controller1.reset();
          controller3.forward();
          controller4.reset();
        } else if (index == 3) {
          controller2.reset();
          controller1.reset();
          controller3.reset();
          controller4.forward();
        }
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 5.0,
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gif(
              controller: controller,
              width: 26.0,
              image: AssetImage(
                icon,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 5)),
            Text(
              name,
              style: TextStyle(
                  fontSize: 12.0,
                  color: _currentIndex == index
                      ? const Color(0xffC30D23)
                      : Colors.black,
                  height: 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 55,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _createIconButton(
                      index: 0,
                      name: 'home',
                      icon: 'images/nav_gif_home.gif',
                      iconActive: 'images/nav_gif_home_active.gif',
                      controller: controller1,
                    ),
                    _createIconButton(
                      index: 1,
                      name: 'accounts',
                      icon: 'images/nav_gif_account.gif',
                      iconActive: 'images/nav_gif_account_active.gif',
                      controller: controller2,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 56,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _createIconButton(
                      index: 2,
                      name: 'card',
                      icon: 'images/nav_gif_card.gif',
                      iconActive: 'images/nav_gif_card_active.gif',
                      controller: controller3,
                    ),
                    _createIconButton(
                      index: 3,
                      name: 'mine',
                      icon: 'images/nav_gif_profile.gif',
                      iconActive: 'images/nav_gif_profile_active.gif',
                      controller: controller4,
                    ),
                  ],
                ),
              ),
            ],
            //   ),
            // ],
          ),
        ));
  }
}

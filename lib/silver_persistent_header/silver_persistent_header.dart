import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomSliverPersistentHeader extends StatefulWidget {
  const CustomSliverPersistentHeader({Key? key}) : super(key: key);

  @override
  State<CustomSliverPersistentHeader> createState() =>
      _CustomSliverPersistentHeaderState();
}

class _CustomSliverPersistentHeaderState
    extends State<CustomSliverPersistentHeader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _myBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        tooltip: 'Back',
        child: const Icon(
          Icons.keyboard_arrow_left,
        ),
      ),
    );
  }

  _myBody() {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: CustomSliverHeader(),
          pinned: true,
          floating: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 60.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  top:
                      BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
                ),
              ),
              child: Text(index.toString()),
            );
          }, childCount: 60),
        ),
      ],
    );
  }
}

class CustomSliverHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (kDebugMode) {
      print(shrinkOffset);
    }
    double maxShrinkOffset = maxExtent - minExtent;
    double t = (shrinkOffset / maxShrinkOffset).clamp(0.0, 1.0);
    double left = MediaQuery.of(context).size.width / 2.5;
    double imageLeft = Tween<double>(begin: 0, end: left).transform(t);
    double imageY = (MediaQuery.of(context).size.width - 100) / 2 + imageLeft;
    double imageX = Tween<double>(begin: 100, end: 36).transform(t);
    double imageSize = Tween<double>(begin: 100, end: 66).transform(t);
    return Stack(
      children: [
        Image.asset(
          shrinkOffset >= 150 ? 'images/bg_small.png' : 'images/bg.png',
          fit: BoxFit.fitWidth,
          width: MediaQuery.of(context).size.width,
        ),
        Column(
          children: [
            Container(
              height: kToolbarHeight + 60,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'images/icon_header.png',
                        width: 20.0,
                      ),
                      const Padding(padding: EdgeInsets.only(right: 10)),
                      const Text(
                        'User Settings',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0, top: 8.0),
                    child: Text(
                      'V6.6.99',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: imageX,
          left: imageY,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: imageSize,
                height: imageSize,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: PhysicalModel(
                  clipBehavior: Clip.antiAlias,
                  shadowColor: Colors.black.withOpacity(0.6),
                  elevation: 6,
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white,
                  child: Image.asset(
                    'images/avatar.jpg',
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 260;

  @override
  double get minExtent => kToolbarHeight + 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

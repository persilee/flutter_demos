import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demos/custom_circle/custom_circle_page.dart';
import 'package:flutter_demos/local_auth/local_auth_page.dart';
import 'package:flutter_demos/nav_bttom_gif/nav_bottom_gif.dart';
import 'package:flutter_demos/push_notification/push_notification_page.dart';
import 'package:flutter_demos/push_notification/push_notification_service.dart';
import 'package:flutter_demos/silver_persistent_header/silver_persistent_header.dart';
import 'package:flutter_demos/slider/custom_slider_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  PushNotificationService.onBackgroundMessage();
  PushNotificationService.getChannel();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    PushNotificationService.instance.initialise();
    PushNotificationService.instance.getToken();
  }

  getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (kDebugMode) {
      print('token: $token');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: createMaterialColor(const Color(0xFF3FC0D8)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    PushNotificationService.instance.getInitialMessage((message) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return PushNotificationPage(message: message);
          },
        ),
      );
    });
    PushNotificationService.onMessageOpenedApp((message) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return PushNotificationPage(message: message);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        automaticallyImplyLeading: false,
        title: const Text('Flutter Demos'),
      ),
      body: ListView(
        children: [
          // 底部导航栏Gif动画效果
          _buildListItem(
            context: context,
            name: 'Navigation bottom bar',
            icon: Icons.assistant_navigation,
            page: const NavBottomGif(),
          ),
          // 头像随滚动移效果
          _buildListItem(
            context: context,
            name: 'Custom Sliver Persistent Header',
            icon: Icons.aspect_ratio_rounded,
            page: const CustomSliverPersistentHeader(),
          ),
          // 自定义的滑动组件
          _buildListItem(
            context: context,
            name: 'Slider',
            icon: Icons.short_text_sharp,
            page: const CustomSliderPage(),
          ),
          // 自定义的圆圈
          _buildListItem(
            context: context,
            name: 'Custom circle',
            icon: Icons.vignette_rounded,
            page: const CustomCirclePage(),
          ),
          // google消息推送
          _buildListItem(
            context: context,
            name: 'Firebase Messaging',
            icon: Icons.announcement_sharp,
            page: const PushNotificationPage(),
          ),
          // 生物识别
          _buildListItem(
            context: context,
            name: 'Biometrics',
            icon: Icons.fingerprint,
            page: const LocalAuthPage(),
          ),
        ],
      ),
    );
  }

  Column _buildListItem(
      {required String name,
      required BuildContext context,
      required IconData icon,
      required Widget page}) {
    return Column(
      children: [
        ListTile(
          title: Text(name),
          leading: Icon(
            icon,
            color: const Color(0xff3FC0D8),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 14,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => page,
              ),
            );
          },
        ),
        const Divider(
          color: Colors.grey,
        )
      ],
    );
  }
}

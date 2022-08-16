import 'package:flutter/material.dart';
import 'package:flutter_demos/local_auth/local_auth.dart';

class LocalAuthPage extends StatefulWidget {
  const LocalAuthPage({Key? key}) : super(key: key);

  @override
  State<LocalAuthPage> createState() => _LocalAuthPageState();
}

class _LocalAuthPageState extends State<LocalAuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometrics'),
      ),
      body: _myBody(),
    );
  }

  _myBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              final isAvailable = await LocalAuth.hasBiometrics();
              final biometrics = await LocalAuth.getBiometrics();
              if (biometrics.isNotEmpty) {
                final isAuthenticated = await LocalAuth.authenticate();
                debugPrint('biometrics: $isAuthenticated');
              }
              debugPrint('isAvailable: $isAvailable');
              debugPrint('biometrics: $biometrics');
            },
            icon: const Icon(Icons.fingerprint_sharp),
            label: const Text('Authenticate'),
          ),
          Text(''),
          const Padding(padding: EdgeInsets.only(top: 20)),
        ],
      ),
    );
  }
}

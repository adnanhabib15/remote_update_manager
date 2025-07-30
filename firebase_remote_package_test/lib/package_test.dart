import 'package:firebase_remote_package/remote_package.dart';
import 'package:flutter/material.dart';

class PackageTest extends StatelessWidget {
  const PackageTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Package test', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FirebaseRemoteConfiguration(
            androidAppId: 'com.snapchat.android',
            iosAppId: 'com.example.firebaseRemotePackageTest',
          ),
        ],
      ),
    );
  }
}

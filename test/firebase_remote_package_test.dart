import 'package:flutter_test/flutter_test.dart';

import 'package:firebase_remote_package/firebase_remote_package.dart';

void main() {
   
  group('Version comparison tests', () {
  final FirebaseRemoteConfigurationSetting remoteConfig =
      FirebaseRemoteConfigurationSetting();

    test('1.2.3 > 1.2.2', () {
      expect(remoteConfig. isVersionGreater('1.2.3', '1.2.2'), true);
    });

    test('1.2.0 < 1.2.1', () {
      expect(remoteConfig.isVersionGreater('1.2.0', '1.2.1'), false);
    });

    test('1.3.0 > 1.2.9', () {
      expect(remoteConfig.isVersionGreater('1.3.0', '1.2.9'), true);
    });

    test('2.0.0 > 1.9.9', () {
      expect(remoteConfig.isVersionGreater('2.0.0', '1.9.9'), true);
    });

    test('1.0.0 == 1.0.0', () {
      expect(remoteConfig.isVersionGreater('1.0.0', '1.0.0'), false);
    });

    test('0.9.9 < 1.0.0', () {
      expect(remoteConfig.isVersionGreater('0.9.9', '1.0.0'), false);
    });

    test('10.0.0 > 9.9.9', () {
      expect(remoteConfig. isVersionGreater('10.0.0', '9.9.9'), true);
    });

    test('1.10.0 > 1.2.9', () {
      expect(remoteConfig.isVersionGreater('1.10.0', '1.2.9'), true);
    });
  });
}

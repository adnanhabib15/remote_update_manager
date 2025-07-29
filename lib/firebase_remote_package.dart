import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_remote_package/update_type.dart';
import 'package:flutter_app_info/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class FirebaseRemoteConfigurationSetting {
  String? versionAvailable;
  String? versionRequired;
  String? packageInfo;
  String? versionCurrent;
  late bool optional;
  late bool required;
  late final UpdateType updateType;

  Future getVersionConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    final packageInfo = await PackageInfo.fromPlatform();
    remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 3),
        minimumFetchInterval: const Duration(minutes: 4),
      ),
    );
    await remoteConfig.fetchAndActivate();

    versionAvailable = remoteConfig.getString('availableVersion');

    versionRequired = remoteConfig.getString('requiredVersion');
    optional = remoteConfig.getBool('optional');
    required = remoteConfig.getBool('required');

    updateType = getUpdateType(optional, required);
    versionCurrent = packageInfo.version;
  }

  bool isVersionGreater(String v1, String v2) {
    List<int> parts1 = v1.split('.').map(int.parse).toList();
    List<int> parts2 = v2.split('.').map(int.parse).toList();

    int maxLength =
        parts1.length > parts2.length ? parts1.length : parts2.length;

    for (int i = 0; i < maxLength; i++) {
      int p1 = i < parts1.length ? parts1[i] : 0;
      int p2 = i < parts2.length ? parts2[i] : 0;

      if (p1 > p2) return true;
      if (p1 < p2) return false;
    }
    return false;
  }

  Future<void> redirectToPlayStore(String packageName, String iOSAppId) async {
    if (Platform.isAndroid) {
      final Uri uri = Uri.parse("market://details?id=$packageName");
      final Uri fallbackUri = Uri.parse(
        "https://play.google.com/store/apps/details?id=$packageName",
      );

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
      }
    } else if (Platform.isIOS) {
      // ignore: unnecessary_null_comparison
      if (iOSAppId == null) {
        throw ArgumentError('iOSAppId is required for iOS platform');
      }

      final Uri iosUrl = Uri.parse("https://apps.apple.com/app/id$iOSAppId");
      await launchUrl(iosUrl, mode: LaunchMode.externalApplication);
    }
  }

  UpdateType getUpdateType(bool optional, bool required) {
    if (required == true) {
      return UpdateType.required;
    } else if (optional == true) {
      return UpdateType.optional;
    } else if (optional == false && required == false) {
      return UpdateType.none;
    } else {
      return UpdateType.invalid;
    }
  }
}

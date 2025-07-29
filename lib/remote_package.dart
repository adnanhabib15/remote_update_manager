import 'package:firebase_remote_package/firebase_remote_package.dart';
import 'package:firebase_remote_package/update_type.dart';

import 'package:flutter/material.dart';

class FirebaseRemoteConfiguration extends StatefulWidget {
  final String androidAppId;
  final String iosAppId;
  const FirebaseRemoteConfiguration({
    super.key,
    required this.androidAppId,
    required this.iosAppId,
  });

  @override
  State<FirebaseRemoteConfiguration> createState() => _ShowUpdateDialogState();
}

class _ShowUpdateDialogState extends State<FirebaseRemoteConfiguration> {
  final FirebaseRemoteConfigurationSetting _remoteConfig =
      FirebaseRemoteConfigurationSetting();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _remoteConfig.getVersionConfig();

      if (_remoteConfig.isVersionGreater(
        _remoteConfig.versionRequired ?? '',
        _remoteConfig.versionCurrent ?? '',
      )) {
        // ignore: use_build_context_synchronously
        showUpdateVersionDialog(context, false);
      } else if (_remoteConfig.isVersionGreater(
        _remoteConfig.versionAvailable ?? '',
        _remoteConfig.versionCurrent ?? '',
      )) {
        // ignore: use_build_context_synchronously
        showUpdateVersionDialog(
          // ignore: use_build_context_synchronously
          context,
          true,
          updateType: _remoteConfig.updateType,
        );
      } else {
        // ignore: avoid_print
        print('Update Not available');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  showUpdateVersionDialog(
    BuildContext context,
    bool isSkippable, {
    UpdateType? updateType,
  }) async {
  
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "New version available",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(221, 0, 0, 0),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  "Please update to the latest version of the app.",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            if (isSkippable == true) ...[
              if (updateType == UpdateType.optional) ...[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    _remoteConfig.redirectToPlayStore(
                      widget.androidAppId,
                      widget.iosAppId,
                    );
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(fontSize: 15, color: Colors.green),
                  ),
                ),
              ] else if (updateType == UpdateType.required) ...[
                TextButton(
                  onPressed: () {
                    _remoteConfig.redirectToPlayStore(
                      widget.androidAppId,
                      widget.iosAppId,
                    );
                  },
                  child: const Text(
                    'Update Now',
                    style: TextStyle(fontSize: 15, color: Colors.green),
                  ),
                ),
              ],
            ] else if (isSkippable == true) ...[
              TextButton(
                onPressed: () {
                  _remoteConfig.redirectToPlayStore(
                    widget.androidAppId,
                    widget.iosAppId,
                  );
                },
                child: const Text(
                  'Update Now',
                  style: TextStyle(fontSize: 15, color: Colors.green),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

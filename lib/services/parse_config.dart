import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

Future<void> initializeParse() async {
  const String applicationId = 'rLbOvlsgTAlUZC6iS55ZNineq46ffoNTGVCj1dxa';
  const String clientKey = 'HbBK3btYBO5ewDTXKKaKeNLfKT4pctXLFjXOObzF';
  const String serverUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(applicationId, serverUrl, clientKey: clientKey, autoSendSessionId: true);
}
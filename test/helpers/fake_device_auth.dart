import 'package:invest_young/features/profile/data/device_auth.dart';

/// [DeviceAuth] whose answers the test controls.
class FakeDeviceAuth implements DeviceAuth {
  FakeDeviceAuth({this.available = true, this.passes = true});

  bool available;
  bool passes;
  int prompts = 0;
  String? lastReason;

  @override
  bool get isSupported => true;

  @override
  Future<bool> isAvailable() async => available;

  @override
  Future<bool> authenticate(String reason) async {
    prompts++;
    lastReason = reason;
    return passes;
  }
}

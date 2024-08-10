import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String kCanceled = 'canceled';
const String kTerminated = 'terminated';
const String kUnknown = 'unknown';
const String kPending = 'pending';
const String kLocked = 'locked';
const String kUser = 'user';
const String kTopic = 'topic';

const String kSubscription = 'subscription';
const String kBacklog = 'backlog';
const String kReminder = 'reminder';
const String kWithdrawal = 'withdrawal';
const String kTransfer = 'transfer';

const String kFileName = 'file_name';
const String kLogoFilePath = 'logo_file_path';
const String kCache = 'cache';
const String kContractFilePath = 'contract_file_path';
const String kUseSystemDefaultTheme = 'Use system default theme';
const String kAppearance = 'Appearance';
const String kChangeServerAddress = 'Change server address';
const String kChangeServerPort = 'Change server port';
const String kChangeProductQuantity = 'Change product Quantity';
const String kRetry = 'Retry';
const String kPreferredThemeMode = 'themeMode';
const String kPreferredHost = 'host';
const String kNone = 'none';
const String kDowngrade = 'downgrade';
const String kFailed = 'failed';
const String kActive = 'active';
const String kInactive = 'inactive';
const String kSuccess = 'success';

const String kPersonalInfoSetup = 'personalInfoSetup';
const String kLongitude = 'longitude';
const String kHouseKeeperName = 'house_keeper_name';
const String kHouseKeeperPhoneNumber = 'house_keeper_phone_number';
const String kMessageToken = 'message_token';
const String kNeighborhood = 'neighborhood';
const String kLatitude = 'latitude';
const String kHouseKeeper = 'house_keeper';
const String kUid = 'uid';

typedef ValueCallback<T> = void Function(T value);
typedef DoubleValueCallback<T, U> = void Function(T value, U val);
typedef TripleValueCallback<T, U, V> = void Function(T value, U val, V);
typedef FutureCallback<T> = Future<void> Function(T value);
typedef VoidFutureCallback = Future<void> Function();

const BoxDecoration macDefaultRoundedBorderDecoration = BoxDecoration(
  color: CupertinoDynamicColor.withBrightness(
    color: CupertinoColors.white,
    darkColor: CupertinoColors.black,
  ),
  border: _kDefaultRoundedBorder,
  boxShadow: [
    BoxShadow(
      color: CupertinoDynamicColor.withBrightness(
        color: Color.fromRGBO(0, 0, 0, 0.1),
        darkColor: Color.fromRGBO(255, 255, 255, 0.1),
      ),
      offset: Offset(0, 1),
    ),
  ],
  borderRadius: BorderRadius.all(Radius.circular(7.0)),
);

const BoxDecoration macDefaultFocusedBorderDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(7.0)),
);

const BoxDecoration kDefaultRoundedBorderDecoration = BoxDecoration(
  color: CupertinoDynamicColor.withBrightness(
    color: CupertinoColors.inactiveGray,
    darkColor: CupertinoColors.black,
  ),
  border: _kDefaultRoundedBorder,
  boxShadow: [
    BoxShadow(
      color: CupertinoDynamicColor.withBrightness(
        color: Color.fromRGBO(0, 0, 0, 0.1),
        darkColor: Color.fromRGBO(255, 255, 255, 0.1),
      ),
      offset: Offset(0, 1),
    ),
  ],
  borderRadius: BorderRadius.all(Radius.circular(7.0)),
);

const Border _kDefaultRoundedBorder = Border(
  top: _kDefaultRoundedBorderSide,
  bottom: _kDefaultRoundedBorderSide,
  left: _kDefaultRoundedBorderSide,
  right: _kDefaultRoundedBorderSide,
);

const BorderSide _kDefaultRoundedBorderSide = BorderSide(
  color: CupertinoDynamicColor.withBrightness(
    color: Color(0x33000000),
    darkColor: Color(0x33FFFFFF),
  ),
  style: BorderStyle.solid,
  width: 0.1,
);

const MaterialColor recycleColor = MaterialColor(
  0xff293462,
  <int, Color>{
    50: Color(0xFFEDE7F6),
    100: Color(0xff898fa9),
    200: Color(0xff697191),
    300: Color(0xff545d81),
    400: Color(0xff3e4872),
    500: Color(0xff293462),
    600: Color(0xff293462),
    700: Color(0xff252f58),
    800: Color(0xff212a4e),
    900: Color(0xff191f3b),
  },
);

const MaterialColor recycleSColor = MaterialColor(
  0xFF3897f2,
  <int, Color>{
    50: Color(0xFFe7f3fd),
    100: Color(0xFFc3e0fb),
    200: Color(0xFF9ccbf9),
    300: Color(0xFF74b6f6),
    400: Color(0xFF56a7f4),
    500: Color(0xFF3897f2),
    600: Color(0xFF328ff0),
    700: Color(0xFF2b84ee),
    800: Color(0xFF247aec),
    900: Color(0xFF1769e8),
  },
);

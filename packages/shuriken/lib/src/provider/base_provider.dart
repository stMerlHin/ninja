import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../shuriken.dart';

abstract class BaseProvider {
  static late final FirebaseFirestore firestore;
  static late final FirebaseFunctions functions;
  static late final FirebaseAuth auth;
  static late final FirebaseMessaging messaging;
  static late final FirebaseStorage storage;
  static String? userId;
  static bool hasLinkedAccount = false;

  static void init({
    FirebaseFirestore? firestore,
    FirebaseFunctions? functions,
    FirebaseAuth? auth,
    FirebaseMessaging? messaging,
    FirebaseStorage? storage,
  }) {

    BaseProvider.firestore = firestore ?? FirebaseFirestore.instance;
    BaseProvider.functions = functions ?? FirebaseFunctions.instance;
    BaseProvider.auth = auth ?? FirebaseAuth.instance;
    BaseProvider.messaging = messaging ?? FirebaseMessaging.instance;
    BaseProvider.storage = storage ?? FirebaseStorage.instance;
    // hasLinkedAccount = BaseProvider.auth.currentUser != null
    //     && BaseProvider.isAnonymous == false;
  }

  static Future<void> signInAnonymously({
    required void Function() onSuccess,
    required void Function(FirebaseAuthException) onAuthError,
    required void Function(dynamic) onError,
  }) async {
    try {
      await BaseProvider.auth.signInAnonymously();
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onAuthError(e);
    } catch (e) {
      onError(e);
    }
  }

  static Future<void> loginWithGoogle({
    required void Function() onSuccess,
    required void Function(FirebaseAuthException) onAuthError,
    required void Function(dynamic) onError,
    bool link = false,
  }) async {
    try {
      final googleAccount = await GoogleSignIn().signIn();
      final googleAuth = await googleAccount?.authentication;
      if (googleAuth != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await BaseProvider.authenticate(
          credential: credential,
          onSuccess: onSuccess,
          onAuthError: onAuthError,
          onError: onError,
          login: true,
          link: link,
        );
        return;
      }
      onError('Process canceled');
    } on FirebaseAuthException catch (e) {
      onAuthError(e);
    } catch (e) {
      onError(e);
    }
  }

  static Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(PhoneAuthCredential) onVerificationCompleted,
    required void Function() onSuccess,
    required DoubleValueCallback<String, int?> onCodeSent,
    required void Function(FirebaseAuthException) onAuthError,
    required void Function(dynamic) onError,
    bool link = false,
    bool login = true,
  }) async {
    try {
      await BaseProvider.auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          onVerificationCompleted(credential);
          await BaseProvider.authenticate(
            credential: credential,
            onSuccess: onSuccess,
            onAuthError: onAuthError,
            onError: onError,
            login: login,
            link: link,
          );
        },
        verificationFailed: onAuthError,
        codeSent: (String verificationId, int? resendCode) {
          onCodeSent(verificationId, resendCode);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      onError(e);
    }
  }

  static Future<void> authenticate({
    required AuthCredential credential,
    required void Function() onSuccess,
    required void Function(FirebaseAuthException) onAuthError,
    required void Function(dynamic) onError,
    bool link = false,
    bool login = true,
  }) async {
    try {
      if (login) {
        if (link) {
          await BaseProvider.auth.currentUser!.linkWithCredential(credential);
          BaseProvider.hasLinkedAccount = true;
          onSuccess();
          return;
        }
        await BaseProvider.auth.signInWithCredential(credential);
        BaseProvider.hasLinkedAccount = true;
      }
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onAuthError(e);
    } catch (e) {
      onError(e);
    }
  }


  static bool? get isAnonymous {
    if (hasLinkedAccount) {
      return false;
    }
    return BaseProvider.auth.currentUser?.isAnonymous;
  }


  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await BaseProvider.auth.signOut();
    BaseProvider.hasLinkedAccount = false;
  }


  static List<UserInfo> get authProvidersData =>
      BaseProvider.auth.currentUser?.providerData ?? [];

  static UserInfo? get googleInfo {
    List<UserInfo> googleInfo = BaseProvider.authProvidersData
        .where(
          (info) => info.providerId == GoogleAuthProvider.GOOGLE_SIGN_IN_METHOD,
    )
        .toList();
    if (googleInfo.isEmpty) {
      return null;
    }
    return googleInfo.first;
  }

  static UserInfo? get phoneInfo {
    List<UserInfo> phoneInfo = BaseProvider.authProvidersData
        .where(
            (info) => info.providerId == PhoneAuthProvider.PHONE_SIGN_IN_METHOD)
        .toList();
    if (phoneInfo.isEmpty) {
      return null;
    }
    return phoneInfo.first;
  }

}

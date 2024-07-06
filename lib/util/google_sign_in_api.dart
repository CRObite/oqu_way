import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi{

  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  static Future<GoogleSignInAccount?> logOut() => _googleSignIn.signOut();




  // static List<String> scopes = <String>[
  //   'email',
  //   'profile',
  //   AppApiEndpoints.oauth2RedirectUrl,
  // ];
  //
  // final GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: scopes,
  // );
  //
  // Future<GoogleSignInAccount?> signInWithGoogle() async {
  //   try {
  //     GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser == null) {
  //       return null;
  //     }
  //
  //     GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //
  //     return googleUser;
  //
  //   } catch (error) {
  //     print('Ошибка при входе через Google: $error');
  //     return null;
  //   }
  // }

  //
  // Future<AccessTokenResponse> getItNow() async {
  //   AccessTokenResponse tknResp = await GoogleOAuth2Client(
  //     redirectUri: AppApiEndpoints.oauth2RedirectUrl,
  //     customUriScheme: 'com.example.oqu_way',
  //   ).getTokenWithAuthCodeFlow(
  //     clientId: '354960311472-tvgso0vlg2pgujv4cfr6a3hbq1gk1vd6.apps.googleusercontent.com',
  //     clientSecret: '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',
  //     scopes: ['email', 'profile'],
  //   );
  //
  //   return tknResp;
  // }


}
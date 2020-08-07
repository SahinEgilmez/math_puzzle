import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class Ads {
  static bool isShown = false;
  static bool isGoingToBeShown = false;

  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['math', 'puzzle', 'game', 'mathematics'],
    contentUrl: 'https://play.google.com/store/apps/details?id=com.segilmez.math_puzzle',
    childDirected: false,
    nonPersonalizedAds: false,
    testDevices: <String>["4211203736E79A4CD31B421563B99751"],
  );

  static BannerAd gameBanner;

  static InterstitialAd interstitialAd = InterstitialAd(
    adUnitId: "ca-app-pub-5102346463770175/9247186249",
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );

  static void initialize() {
    FirebaseAdMob.instance.initialize(appId: Constants.ADMOB_APP_ID);
    createGameBanner();
    interstitialAd.load();
  }

  static void showInterstitialAd() {
    interstitialAd.isLoaded().then((isLoaded) {
      if (isLoaded) {
        interstitialAd.show();
      } else
        print("BACK INTERSITIAL AD UNIT DID NOT LOAD!");
    });
  }

  static void createGameBanner() {
    gameBanner = BannerAd(
      adUnitId: "ca-app-pub-5102346463770175/3996304421",
      targetingInfo: targetingInfo,
      size: AdSize.banner,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.loaded) {
          isShown = true;
          isGoingToBeShown = false;
        } else if (event == MobileAdEvent.failedToLoad) {
          isShown = false;
          isGoingToBeShown = false;
        }
        print("BannerAd event is $event");
      },
    );
  }

  static void showGameBanner([State state]) {
    if (state != null && !state.mounted) return;
    if (gameBanner == null) createGameBanner();
    if (!isShown && !isGoingToBeShown) {
      isGoingToBeShown = true;
      gameBanner
        ..load()
        ..show(anchorType: AnchorType.bottom);
    }
  }

  static void hideGameBanner() {
    if (gameBanner != null && !isGoingToBeShown) {
      gameBanner.dispose().then((disposed) {
        isShown = !disposed;
      });
      gameBanner = null;
    }
  }
}

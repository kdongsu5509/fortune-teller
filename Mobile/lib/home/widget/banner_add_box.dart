import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAddBox extends StatefulWidget {
  const BannerAddBox(this.heightRatio, {super.key});

  final double heightRatio;

  @override
  State<BannerAddBox> createState() => _BannerAddBoxState();
}

class _BannerAddBoxState extends State<BannerAddBox> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      // adUnitId: 'ca-app-pub-4827130947989802/7205295885', <- 실재 광고 ID
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // 테스트 광고 ID
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => setState(() => _isLoaded = true),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('광고 로딩 실패: $error');
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    if (!_isLoaded || _bannerAd == null) {
      return Container(
        height: sw * widget.heightRatio,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        child: Text(
          '광고 로딩 중...',
          style: TextStyle(
            fontSize: sw * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return SizedBox(
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}

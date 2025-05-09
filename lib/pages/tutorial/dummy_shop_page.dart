import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/data/model/offer.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/figma/dimensions.dart';
import 'package:flutter_better_united/my_purchases_page.dart';
import 'package:flutter_better_united/pages/nav_page.dart';
import 'package:flutter_better_united/pages/shop/shop_provider.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:flutter_better_united/widgets/user_coins.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../buy_offer_modal.dart';
import '../../widgets/custom_tab_bar.dart';
import '../../widgets/fixed_button.dart';
import '../../widgets/offer_card.dart';

class DummyShopPage extends StatefulWidget {
  const DummyShopPage(
      {Key? key, this.withBackButton = false, this.unblurredShopSectionKey})
      : super(key: key);
  final bool withBackButton;
  final GlobalKey? unblurredShopSectionKey;

  @override
  State<DummyShopPage> createState() => _DummyShopPageState();

  static Route route({required bool withBackButton}) {
    return CupertinoPageRoute(
      builder: (_) => DummyShopPage(
        withBackButton: withBackButton,
      ),
    );
  }
}

class _DummyShopPageState extends State<DummyShopPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  static const offersTabIndex = 0;
  static const coinsTabIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegularAppBar(
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.withBackButton
                ? FixedButton(
                    onTap: () {
                      context.pop();
                    },
                    iconData: BetterUnited.triangle)
                : Icon(
                    BetterUnited.shop,
                    color: AppColors.primary,
                    size: 32,
                  ),
            const SizedBox(
              width: 16,
            ),
            Text(
              "shop".tr().toUpperCase(),
              style: context.titleH1White,
            ),
          ],
        ),
        suffixIcon: const UserCoins(
          backgroundColor: AppColors.secondary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            widget.withBackButton
                ? const SizedBox()
                : CustomTabBar(
                    key: widget.unblurredShopSectionKey,
                    backgroundColor: Colors.black,
                    firstTabText: "offers".tr(),
                    secondTabText: "coins".tr(),
                    tabController: _tabController,
                  ),
            const SizedBox(
              height: AppDimensions.shopTabBarBottomSpace,
            ),
            Expanded(
              child: widget.withBackButton
                  ? _CoinsTab(scrollController: _scrollController)
                  : TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        const _Offers(),
                        _CoinsTab(scrollController: _scrollController),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}

class _CoinsTab extends StatelessWidget {
  const _CoinsTab({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class _Offers extends StatelessWidget {
  const _Offers({super.key});

  @override
  Widget build(BuildContext context) {
    final offers = [
      Offer(
        id: 1,
        title: 'DISCOUNT COUPON - 20%',
        description: '',
        imageUrl: 'assets/images/tutorial/shop_tutorial_20_discount.png',
        validUntil: null,
        url: null,
        code: null,
        coins: 600,
        redeemedAt: null,
        isSoldOut: false,
      ),
      Offer(
        id: 2,
        title: 'DISCOUNT COUPON - 50%',
        description: '',
        imageUrl: 'assets/images/tutorial/shop_tutorial_50_discount.png',
        validUntil: DateTime.now()..add(const Duration(days: 3)),
        url: null,
        code: null,
        coins: 1200,
        redeemedAt: null,
        isSoldOut: false,
      ),
      Offer(
        id: 3,
        title: 'DISCOUNT COUPON - 50%',
        description: '',
        imageUrl: 'assets/images/tutorial/shop_tutorial_50_discount.png',
        validUntil: DateTime.now()..add(const Duration(days: 6)),
        url: null,
        code: null,
        coins: 1000,
        redeemedAt: null,
        isSoldOut: false,
      ),
    ];

    return Column(
      children: [
        Expanded(
          child: offers == null
              ? SizedBox()
              : ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final offer = offers[index];
                    return GestureDetector(
                      onTap: offer.isSoldOut
                          ? null
                          : () async {
                              final result = await BuyOfferModal.showDialog(
                                  context,
                                  offer: offer,
                                  provider: context.read<ShopProvider>());

                              if (result is BuyOfferModalResult) {
                                if (result == BuyOfferModalResult.purchased) {
                                  Navigator.of(context, rootNavigator: true)
                                      .push(MyPurchasesPage.route());
                                }
                              }
                            },
                      child: OfferCard(
                        title: offer.title,
                        validUntil: offer.validUntil,
                        coins: offer.coins,
                        isSoldOut: offer.isSoldOut,
                        imageUrl: offer.imageUrl,
                        imageLocal: true,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                  itemCount: offers.length),
        ),
        PrimaryButton(
          prefixIcon: Align(
            alignment: const Alignment(-0.95, 1),
            child: SizedBox(
              width: 42,
              height: 42,
              child: SvgPicture.asset(
                "assets/icons/ic-union.svg",
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          text: "viewMyPurchases".tr(),
          onPressed: () {
            Navigator.of(context, rootNavigator: true)
                .push(MyPurchasesPage.route());
          },
        ),
      ],
    );
  }
}

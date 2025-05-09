import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/figma/dimensions.dart';
import 'package:flutter_better_united/my_purchases_page.dart';
import 'package:flutter_better_united/pages/shop/purchase_manager.dart';
import 'package:flutter_better_united/pages/shop/shop_provider.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:flutter_better_united/widgets/user_coins.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../buy_offer_modal.dart';
import '../../data/model/purchasable_coins.dart';
import '../../widgets/custom_tab_bar.dart';
import '../../widgets/fixed_button.dart';
import '../../widgets/header_text.dart';
import '../../widgets/offer_card.dart';
import 'coin_card.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key, this.withBackButton = false}) : super(key: key);
  final bool withBackButton;
  static const routeName = "/shop_page";
  @override
  State<ShopPage> createState() => _ShopPageState();

  static Route route({required bool withBackButton}) {
    return CupertinoPageRoute(
      builder: (_) => ShopPage(
        withBackButton: withBackButton,
      ),
    );
  }
}

class _ShopPageState extends State<ShopPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final TabController _tabController =
      TabController(length: 2, vsync: this);
  late PurchaseManager purchaseManager;
  late List<PurchasableCoins> regularPurchasableCoins;
  late ShopProvider _shopProvider;
  static const offersTabIndex = 0;
  static const coinsTabIndex = 1;

  @override
  void initState() {
    super.initState();
    _shopProvider =
        ShopProvider(context.read(), context.read(), context.read());
    purchaseManager = context.read<PurchaseManager>();
    regularPurchasableCoins = purchaseManager.purchasableCoins;
    if (!purchaseManager.isStoreAvailable()) {
      purchaseManager.initStoreInfo();
    }
    if (!widget.withBackButton) {
      _shopProvider.fetchOffers();
    }
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      if (_tabController.index == offersTabIndex) {
        _shopProvider.fetchOffers();
      }
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
    return ChangeNotifierProvider(
      create: (context) => _shopProvider,
      child: Scaffold(
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
                  : const Icon(
                      BetterUnited.shop,
                      color: AppColors.primary,
                      size: 30,
                    ),
              const SizedBox(
                width: 16,
              ),
              HeaderText(text: "shop".tr()),
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
      ),
    );
  }
}

class _CoinsTab extends StatelessWidget {
  const _CoinsTab({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final purchaseManager = context.read<PurchaseManager>();
    final regularPurchasableCoins = purchaseManager.purchasableCoins;
    return purchaseManager.isStoreAvailable()
        ? GridView.builder(
            controller: scrollController,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisExtent: 213,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: regularPurchasableCoins.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () => context
                    .read<ShopProvider>()
                    .buyCoins(regularPurchasableCoins[index]),
                child: CoinCard(
                  amount: regularPurchasableCoins[index].amount,
                  coins: regularPurchasableCoins[index].coins,
                  currencyCode: regularPurchasableCoins[index].currencySymbol,
                ),
              );
            },
          )
        : _buildStoreNotAvailableWidget(context);
  }

  Widget _buildStoreNotAvailableWidget(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            "assets/icons/ic_info.svg",
            color: Colors.white,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "storeNotAvailable".tr(),
            style: context.labelSemiBold.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _Offers extends StatelessWidget {
  const _Offers({super.key});

  @override
  Widget build(BuildContext context) {
    final offers = context.watch<ShopProvider>().offers;

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
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: AppDimensions.shopOfferItemSeparatorSpace,
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

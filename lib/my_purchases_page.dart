import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/coupon_modal.dart';
import 'package:flutter_better_united/pages/shop/shop_provider.dart';
import 'package:flutter_better_united/widgets/custom_tab_bar.dart';
import 'package:flutter_better_united/widgets/offer_card.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:provider/provider.dart';

class MyPurchasesPage extends StatefulWidget {
  const MyPurchasesPage({super.key});

  @override
  State<MyPurchasesPage> createState() => _MyPurchasesPageState();

  static Route route() {
    return CupertinoPageRoute(
      fullscreenDialog: false,
      builder: (_) => const MyPurchasesPage(),
    );
  }
}

class _MyPurchasesPageState extends State<MyPurchasesPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);
  late ShopProvider _shopProvider;
  static const activeIndex = 0;
  static const historyIndex = 1;

  @override
  void initState() {
    super.initState();
    _shopProvider =
        ShopProvider(context.read(), context.read(), context.read());
    handleTabChange(_tabController.index);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      handleTabChange(_tabController.index);
    });
  }

  handleTabChange(int index) {
    if (index == activeIndex) {
      _shopProvider.fetchPurchasedOffers();
    } else {
      _shopProvider.fetchRedeemedOffers();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _shopProvider,
      builder: (context, child) => Scaffold(
          appBar: RegularAppBar.withBackButton(
            title: "myPurchases".tr(),
            onBackTap: () {
              context.pop();
            },
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                CustomTabBar(
                  backgroundColor: Colors.black,
                  firstTabText: "active".tr(),
                  secondTabText: "history".tr(),
                  tabController: _tabController,
                ),
                Expanded(
                    child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    _Active(
                      onRedeem: () {
                        _tabController.animateTo(
                          historyIndex,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                    ),
                    const _History()
                  ],
                ))
              ],
            ),
          )),
    );
  }
}

class _Active extends StatelessWidget {
  const _Active({required this.onRedeem});

  final Function onRedeem;

  @override
  Widget build(BuildContext context) {
    final offers = context.watch<ShopProvider>().purchasedOffers;
    return offers == null
        ? const SizedBox()
        : ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 14),
            itemBuilder: (context, index) {
              final offer = offers[index];
              return GestureDetector(
                onTap: () {
                  CouponModal.showDialog(context,
                      provider: context.read<ShopProvider>(),
                      offer: offer,
                      onRedeem: onRedeem);
                },
                child: OfferCard(
                  imageUrl: offer.imageUrl,
                  title: offer.title,
                  validUntil: offer.validUntil,
                  isExpired: offer.isExpired,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 16,
              );
            },
            itemCount: offers.length);
  }
}

class _History extends StatelessWidget {
  const _History();

  @override
  Widget build(BuildContext context) {
    final offers = context.watch<ShopProvider>().redeemedOffers;
    return offers == null
        ? const SizedBox()
        : ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 14),
            itemBuilder: (context, index) {
              final offer = offers[index];
              return GestureDetector(
                onTap: () {
                  CouponModal.showDialog(
                    context,
                    provider: context.read<ShopProvider>(),
                    offer: offer,
                  );
                },
                child: OfferCard(
                  imageUrl: offer.imageUrl,
                  title: offer.title,
                  validUntil: offer.validUntil,
                  isExpired: offer.isExpired,
                  isRedeemed: true,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 16,
              );
            },
            itemCount: offers.length);
  }
}

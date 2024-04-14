import 'package:auto_route/auto_route.dart';
import 'package:cash_ctrl/core/extensions.dart';
import 'package:cash_ctrl/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:random_avatar/random_avatar.dart';

@RoutePage()
class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  List<PageRouteInfo<dynamic>> pages = [
    const DashboardRoute(),
    const AnalyticsRoute(),
    const TransactionsRoute(),
  ];

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: pages,
      homeIndex: 0,
      animationCurve: Curves.linear,
      lazyLoad: true,
      appBarBuilder: (context, tabsRouter) => AppBar(
        title: Text(tabsRouter.current.name.split("Route").first),
        titleTextStyle: context.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
                onTap: () => context.pushRoute(ProfileRoute()),
                child: RandomAvatar('saytoonz', height: 35, width: 35)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushRoute(const NewExpenseRoute()),
        shape: const StadiumBorder(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        label: const Row(
          children: [
            Icon(Ionicons.add_outline),
            Gap(10),
            Text("Add Transaction")
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBuilder: (_, tabsRouter) {
        return NavigationBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          indicatorColor: Theme.of(context).colorScheme.primary,
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: (index) =>
              _handleBottomNavTap(context, index, tabsRouter),
          destinations: [
            NavigationDestination(
              icon: const Icon(Ionicons.cube_outline),
              label: 'Dashboard',
              selectedIcon: Icon(
                color: Theme.of(context).colorScheme.onPrimary,
                Ionicons.cube,
              ),
            ),
            NavigationDestination(
              icon: const Icon(Ionicons.pie_chart_outline),
              label: 'Analytics',
              selectedIcon: Icon(
                color: Theme.of(context).colorScheme.onPrimary,
                Ionicons.pie_chart,
              ),
            ),
            NavigationDestination(
              icon: const Icon(Ionicons.wallet_outline),
              label: 'Transactions',
              selectedIcon: Icon(
                Ionicons.wallet,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        );
      },
    );
  }

  _handleBottomNavTap(BuildContext context, int index, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(index);
  }
}

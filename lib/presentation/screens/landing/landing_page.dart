import 'package:auto_route/auto_route.dart';
import 'package:fit_sync_plus/presentation/screens/landing/accounts/accounts_page.dart';
import 'package:fit_sync_plus/presentation/screens/landing/analytics/analytics_page.dart';
import 'package:fit_sync_plus/presentation/screens/landing/home/home_page.dart';
import 'package:fit_sync_plus/presentation/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final String username = "Subhanu";

  int currentIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    AnalyticsPage(),
    const AccountsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi 👋, $username"),
        centerTitle: false,
        actions: const [
          CircleAvatar(
            child: MediumSemiBoldHeading(label: "SM"),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(onPressed: (){}, child: const Icon(Icons.add)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            tooltip: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: "Analytics",
            tooltip: "Analytics",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_outlined),
              label: "Accounts",
              tooltip: "Accounts"),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: "More",
            tooltip: "More",
          ),
        ],
        type: BottomNavigationBarType.fixed,
        onTap: (value) => setState(() {
          currentIndex = value;
        }),
      ),
      body: pages[currentIndex],
    );
  }
}

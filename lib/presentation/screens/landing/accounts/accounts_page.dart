import 'package:fit_sync_plus/presentation/widgets/button_widgets.dart';
import 'package:fit_sync_plus/presentation/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MediumSemiBoldHeading(label: "All Accounts"),
                RegularTextButton(label: "Add Account")
              ],
            ),
            Text(
                "Account balance is calculated by the transactions you enter actual account balance may vary you can edit their account balance in such cases."),
            const SizedBox(height: 20),
            MediumSemiBoldHeading(label: "Bank Accounts"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) => ListTile(
                  title: Text("SBI"),
                ),
              ),
            ),const SizedBox(height: 20),
            MediumSemiBoldHeading(label: "Credit Cards"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) => ListTile(
                  title: Text("SBI"),
                ),
              ),
            ),const SizedBox(height: 20),
            MediumSemiBoldHeading(label: "Wallets"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) => ListTile(
                  title: Text("SBI"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

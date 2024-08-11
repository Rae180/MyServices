import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:start/features/wallet/bloc/wallet_bloc.dart';
import 'package:start/features/wallet/view/widgets/transactions_widget_card.dart';
import 'package:start/features/wallet/view/widgets/wallet_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransactionPage extends StatelessWidget {


  TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.wallet),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) =>
            WalletBloc(client: NetworkApiServiceHttp())..add(GetWalletEvent()),
        child: BlocBuilder<WalletBloc, WalletState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const LoadingWidget();
            } else if (state is SuccessLoadedWallet) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Wallet and Tax Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WalletCard(
                        title: AppLocalizations.of(context)!.wallet,
                        amount: state.data.wallet.toString(),
                        color: Colors.green,
                      ),
                      WalletCard(
                        title: AppLocalizations.of(context)!.taxowed,
                        amount: state.data.taxOwed.toString(),
                        color: Colors.red,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Transaction List
                   Text(
                    AppLocalizations.of(context)!.transactions,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.data.transactions!.length,
                      itemBuilder: (context, index) {
                        var transaction = state.data.transactions![index];
                        return TransactionCard(transaction: transaction);
                      },
                    ),
                  ),
                ],
              ),
            );}
             else if (state is ErrorState) {
              return NetworkErrorWidget(
                message: state.error,
                onPressed: () {
                  BlocProvider.of<WalletBloc>(context).add(
                    (GetWalletEvent()),
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

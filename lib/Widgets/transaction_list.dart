import 'package:flutter/material.dart';
import '../Models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(
    this.transactions,
    this.deleteTx,
  );
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text('No transactions added yet...'),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.7,
                    child: Image.asset(
                      'assets/images/zzz.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView(
            children: transactions.map((tx) {
            return Card(
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5,
              ),
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: FittedBox(
                      child: Text('\$${tx.amount}'),
                    ),
                  ),
                ),
                title: Text(
                  tx.title,
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  DateFormat.yMMMd().format(tx.date),
                ),
                trailing: MediaQuery.of(context).size.width > 460
                    ? FlatButton.icon(
                        onPressed: () => deleteTx(tx.id),
                        icon: Icon(Icons.delete),
                        textColor: Theme.of(context).errorColor,
                        label: Text('Delete'))
                    : IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteTx(tx.id),
                      ),
              ),
            );
          }).toList());
  }
}

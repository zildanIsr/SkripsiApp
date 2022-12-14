import 'package:flutter/material.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {

  @override
  Widget build(BuildContext context) {
    //final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidht = MediaQuery.of(context).size.width;
    
    final myAppBar = AppBar (
      elevation: 0.0,
      title: const Text('Riwayat Transaksi'),
    );

    //final bodyHeight = mediaQueryHeight - myAppBar.preferredSize.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: myAppBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            
            Expanded(
              flex: 8,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: ((context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        debugPrint('ontap');
                      },
                      leading: const FlutterLogo(size: 72.0),
                      title: const Text('Three-line ListTile'),
                      subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'
                      ),
                      trailing: const Icon(Icons.more_vert),
                      isThreeLine: true,
                    ),
                  ); 
                })
                )
              )
          ],
        ),
      ),
    );
  }
}
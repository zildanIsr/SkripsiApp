import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/history_controller.dart';
import '../widgets/card_history.dart';
import '../widgets/skeleton.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HistoryContoller hc = Get.put(HistoryContoller());

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text('Pesanan Kamu'),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(width: 3.0, color: Colors.white),
                    insets: EdgeInsets.symmetric(horizontal: 32.0)),
                tabs: const <Tab>[
                  Tab(
                      child: Text(
                    'Berjalan',
                    style: TextStyle(fontSize: 16.0),
                  )),
                  Tab(
                      child: Text(
                    'Riwayat',
                    style: TextStyle(fontSize: 16.0),
                  )),
                ],
                controller: tabController,
              ),
            ),
          ];
        },
        body: Obx(() => TabBarView(
              controller: tabController,
              children: <Widget>[
                hc.isLoading.value
                    ? const HistoryCardSkeleton()
                    : hc.listHistory.isEmpty
                        ? RefreshIndicator(
                            onRefresh: () async {
                              hc.refreshData();
                            },
                            child: const Center(
                                child: Text('Belum ada history',
                                    style: TextStyle(fontSize: 18))),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              await hc.refreshData();
                            },
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const BouncingScrollPhysics(),
                                itemCount: hc.listHistory.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: ((context, index) {
                                  return ItemHistoryPasien(
                                    key: ValueKey(hc.listHistory[index].id),
                                    orderNumber: hc.listHistory[index].orderId,
                                    amountPrice: hc.listHistory[index].totprice,
                                    categoryId: hc
                                        .listHistory[index].product.categoryId,
                                    statusOrder: hc.listHistory[index].status,
                                    userId: hc.listHistory[index].userId,
                                    isFinished:
                                        hc.listHistory[index].isFinished,
                                    id: hc.listHistory[index].id,
                                    isRated: hc.listHistory[index].isRated,
                                    perawatId: hc.listHistory[index].perawatId,
                                  );
                                })),
                          ),
                hc.isLoading.value
                    ? const HistoryCardSkeleton()
                    : hc.listFinished.isEmpty
                        ? RefreshIndicator(
                            onRefresh: () async {
                              await hc.refreshData();
                            },
                            child: const Center(
                                child: Text('Belum ada history',
                                    style: TextStyle(fontSize: 18))),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              await hc.refreshData();
                            },
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                //physics: const BouncingScrollPhysics(),
                                itemCount: hc.listFinished.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: ((context, index) {
                                  return ItemHistoryPasien(
                                    key: ValueKey(hc.listFinished[index].id),
                                    orderNumber: hc.listFinished[index].orderId,
                                    amountPrice:
                                        hc.listFinished[index].totprice,
                                    categoryId: hc
                                        .listFinished[index].product.categoryId,
                                    statusOrder: hc.listFinished[index].status,
                                    userId: hc.listFinished[index].userId,
                                    isFinished:
                                        hc.listFinished[index].isFinished,
                                    id: hc.listFinished[index].id,
                                    isRated: hc.listFinished[index].isRated,
                                    perawatId: hc.listFinished[index].perawatId,
                                  );
                                })),
                          )
              ],
            )),
      ),
    );
  }
}

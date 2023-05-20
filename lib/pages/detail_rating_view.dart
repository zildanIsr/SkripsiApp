import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailRating extends StatefulWidget {
  const DetailRating({super.key});

  @override
  State<DetailRating> createState() => _DetailRatingState();
}

class _DetailRatingState extends State<DetailRating>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final myAppbar = AppBar(
      title: const Text('Ulasan Pasien'),
      elevation: 0.0,
    );

    final height = MediaQuery.of(context).size.height -
        myAppbar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            title: const Text('Ulasan Pasien'),
            pinned: true,
            floating: true,
            forceElevated: innerBoxIsScrolled,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 4.0,
            bottom: TabBar(
              indicatorColor: Colors.black26,
              tabs: <Tab>[
                Tab(
                  height: height * 0.12,
                  child: SizedBox(
                      //color: Colors.grey,
                      width: double.infinity,
                      //height: height * 0.15,
                      //padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.33,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star_rate_rounded,
                                    size: 45,
                                    color: Colors.amber,
                                  ),
                                  RichText(
                                    text: const TextSpan(
                                        text: '4.9',
                                        style: TextStyle(
                                          height: 1.5,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 32,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '/5.0',
                                            style: TextStyle(
                                              height: 1.5,
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ]),
                                  )
                                ],
                              )),
                          const SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                        text: '250 ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'pesanan layanan selesai',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ]),
                                  ),
                                  RichText(
                                    text: const TextSpan(
                                        text: '200 ',
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 16,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'ulasan dan rating',
                                            style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ]),
                                  )
                                ],
                              )),
                        ],
                      )),
                ),
              ],
              controller: _tabController,
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 10,
              itemBuilder: (context, index) {
                return const RatingCard();
              })
        ],
      ),
    ));
  }
}

class RatingCard extends StatelessWidget {
  const RatingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.album, color: Colors.cyan, size: 45),
            title: Text(
              "Zildan Isrezkinurahman",
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text('1 bulan yang lalu'),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 16.0),
            height: 30,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, i) {
                  return const Icon(
                    Icons.star,
                    color: Colors.amber,
                  );
                }),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Kategori: Rawat Jalan',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16, color: Colors.black45),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
            child: Text(
              'Labore fugiat voluptate reprehenderit esse id exercitation velit. Voluptate est elit veniam officia eu. Reprehenderit nisi ad qui occaecat nulla aliqua ipsum amet ad. Qui anim eiusmod eiusmod reprehenderit dolore veniam aliqua enim laboris excepteur. Cillum sunt velit aliquip Lorem elit. Deserunt laboris elit non enim magna dolore proident.',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}

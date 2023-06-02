import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/history_controller.dart';
import 'package:get/get.dart';

import '../widgets/bottom_navbar.dart';

class SpritePainter extends CustomPainter {
  final Animation<double> _animation;

  SpritePainter(this._animation) : super(repaint: _animation);

  void circle(Canvas canvas, Rect rect, double value) {
    double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    Color color = Color.fromRGBO(50, 205, 50, opacity);

    double size = rect.width / 2;
    double area = size * size;
    double radius = sqrt(area * value / 4);

    final Paint paint = Paint()..color = color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 2; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(SpritePainter oldDelegate) {
    return true;
  }
}

class OrderSuccessView extends StatefulWidget {
  const OrderSuccessView({super.key});

  @override
  OrderSuccessViewState createState() => OrderSuccessViewState();
}

class OrderSuccessViewState extends State<OrderSuccessView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller
      ..stop()
      ..reset()
      ..repeat(period: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    HistoryContoller hc = Get.find();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              painter: SpritePainter(_controller),
              child: const SizedBox(
                width: 250.0,
                height: 250.0,
                child: Icon(
                  Icons.check_circle_rounded,
                  size: 150,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'Pesanan Berhasil',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'Selamat pesanan kamu telah kami lanjutkan ke Perawat, silahkan menunggu konfirmasi lebih lanjut dari perawat kamu ya.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 64,
            ),
            ElevatedButton(
                onPressed: () {
                  hc.refreshData();
                  Get.off(() => const BottomNavbar());
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  child: Text('Kembali ke Halaman Utama'),
                ))
          ],
        ),
      ),
    );
  }
}

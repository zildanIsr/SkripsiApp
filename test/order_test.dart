import 'package:flutter_application_1/Controllers/orderconfirm_controller.dart';
import 'package:flutter_application_1/Models/costumerorder_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/testing.dart';

void main() {
  OrderConfirm oc = Get.put(OrderConfirm());
  test('Add New Order - Success', () async {
    // Mock data
    Order mockData = Order(
      orderId: "123",
      productId: 1,
      perawatId: 1,
      uAddressId: 1,
      totprice: 1000,
      pacientAmount: 1,
      jadwalPesanan: DateTime.now(),
      updatedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );

    // Mock response dari HTTP POST request
    http.Response mockResponse = http.Response(
      json.encode({'status': 'success', 'message': 'Order created'}),
      200,
    );

    // Mock HTTP client untuk mengembalikan response yang telah di-mock
    http.Client mockClient = MockClient((request) async {
      return mockResponse;
    });

    // Menjalankan fungsi addNewOrder dengan menggunakan mock client
    int statusCode = await oc.addNewOrder(mockData);

    // Memastikan bahwa status code yang dikembalikan sesuai dengan harapan
    expect(statusCode, 200);
  });

  test('Add New Order - Error', () async {
    // Mock data
    Order mockData = Order(
      orderId: "123",
      productId: 1,
      perawatId: 1,
      uAddressId: 1,
      totprice: 1000,
      pacientAmount: 1,
      jadwalPesanan: DateTime.now(),
      updatedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );

    // Mock response dari HTTP POST request
    http.Response mockResponse = http.Response(
      json.encode({'status': 'error', 'message': 'Failed to create order'}),
      500,
    );

    // Mock HTTP client untuk mengembalikan response yang telah di-mock
    http.Client mockClient = MockClient((request) async {
      return mockResponse;
    });

    // Menjalankan fungsi addNewOrder dengan menggunakan mock client
    int statusCode = await oc.addNewOrder(mockData);

    // Memastikan bahwa status code yang dikembalikan sesuai dengan harapan
    expect(statusCode, 500);
  });
}


//final order = 
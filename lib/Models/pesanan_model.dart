class Pesanan {
  Pesanan({
    required this.strNumber,
    required this.orderID,
    required this.dateTimePesanan,
    required this.amountPasient,
    required this.categoryName,
    required this.categoryId,
    required this.totprice,
    required this.price,
    required this.productId,
  });

  String orderID;
  DateTime dateTimePesanan;
  int amountPasient;
  String strNumber;
  String categoryName;
  int categoryId;
  int price;
  int totprice;
  int productId;
}

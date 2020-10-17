class Bid {
  final int id;
  final int auctionId;
  final int sellerId;
  final double price;

  Bid(
    this.id,
    this.auctionId,
    this.sellerId,
    this.price,
  );

  factory Bid.fromJson(Map<String, dynamic> json) {
    return Bid(
      json['id'],
      json['auctionId'],
      json['sellerId'],
      json['price'],
    );
  }
}
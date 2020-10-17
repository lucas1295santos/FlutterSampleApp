class Auction {
  final int id;
  final int clientId;
  final int productId;
  final int origin;
  final int destiny;
  final String deliveryDate;
  final String status;

  Auction(
    this.id,
    this.clientId,
    this.productId,
    this.origin,
    this.destiny,
    this.deliveryDate,
    this.status,
  );

  factory Auction.fromJson(Map<String, dynamic> json) {
    return Auction(
      json['id'],
      json['clientId'],
      json['productId'],
      json['origin'],
      json['destiny'],
      json['deliveryDate'],
      json['status'],
    );
  }

  Map<String, dynamic> toJson() =>
  {
    'id': id,
    'clientId': clientId,
    'productId': productId,
    'origin': origin,
    'destiny': destiny,
    'deliveryDate': deliveryDate,
    'status': status,
  };
}
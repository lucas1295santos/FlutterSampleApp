class Seller {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String cnpj;
  final String adress;

  Seller(
    this.id,
    this.name,
    this.email,
    this.phone,
    this.cnpj,
    this.adress,
  );

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      json['id'],
      json['name'],
      json['email'],
      json['phone'],
      json['cnpj'],
      json['adress'],
    );
  }
}
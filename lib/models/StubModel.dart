class StubModel {
  final String data;
  
  StubModel(this.data);

    factory StubModel.fromJson(Map<String, dynamic> json) {
    return StubModel(
      json['data'],
    );
  }
}
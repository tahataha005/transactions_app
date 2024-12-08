class TransactionEntity {
  final int id;
  final String title;
  final String description;
  final DateTime time;
  final bool income;
  final double price;

  TransactionEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.income,
    required this.price,
  });
}

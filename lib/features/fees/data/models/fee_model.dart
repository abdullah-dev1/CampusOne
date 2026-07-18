class FeeModel {
  final String title;
  final double amount;
  final bool isPaid;
  final String dueDate;

  const FeeModel({
    required this.title,
    required this.amount,
    required this.isPaid,
    required this.dueDate,
  });
}
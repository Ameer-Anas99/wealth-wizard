import 'package:hive/hive.dart';
part 'add_data.g.dart';

@HiveType(typeId: 1)
class TransactionModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String category;
  @HiveField(2)
  String explain;
  @HiveField(3)
  String amount;
  @HiveField(4)
  String type;
  @HiveField(5)
  DateTime datetime;

  TransactionModel(
      {required this.category,
      required this.amount,
      required this.datetime,
      required this.type,
      required this.explain,
      required this.id});
}

import 'package:hive/hive.dart';
part 'card.g.dart';

@HiveType()
class GradientCard extends HiveObject {
  @HiveField(0)
  final List<double> primaryColor;

  @HiveField(1)
  final List<double> secondaryColor;

  GradientCard(this.primaryColor, this.secondaryColor);
}
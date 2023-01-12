import 'package:objectbox/objectbox.dart';

@Entity()
class TodoEntity {
  @Id(assignable: true)
  int id;
  @Unique()
  String name;
  bool isDone;

  TodoEntity({this.id = 0, required this.name, required this.isDone});
}

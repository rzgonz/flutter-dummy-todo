import 'package:path_provider/path_provider.dart' as path_provider;
import '../../objectbox.g.dart';
import 'entity/todo_entity.dart';
import 'package:path/path.dart' as path;

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  late final Box<TodoEntity> todoBox;

  ObjectBox._create(this.store) {
    todoBox = store.box<TodoEntity>();
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await path_provider.getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store =
        await openStore(directory: path.join(docsDir.path, "obx-example"));
    return ObjectBox._create(store);
  }
}

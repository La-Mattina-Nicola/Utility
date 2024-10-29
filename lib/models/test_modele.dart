import 'package:flutter/foundation.dart';

   class ItemModel with ChangeNotifier {
     List<String> items;
     int draggingIndex;

     ItemModel(this.items, this.draggingIndex);

     void updateDraggingIndex(int newIndex) {
       draggingIndex = newIndex;
       notifyListeners();
     }

     void moveItem(int oldIndex, int newIndex) {
       final item = items.removeAt(oldIndex);
       items.insert(newIndex, item);
       notifyListeners();
     }
   }
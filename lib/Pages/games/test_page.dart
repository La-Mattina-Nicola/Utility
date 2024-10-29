import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utility/models/test_modele.dart';

   class DragDropGridView extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       final model = Provider.of<ItemModel>(context);

       
       return Scaffold(
         appBar: AppBar(
           title: Text('Drag and Drop GridView'),
         ),
         body: Column(
           children: [
             Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
                  itemCount: model.items.length,
                  itemBuilder: (context, index) {
                    return LongPressDraggable(
                      data: index,
                      feedback: DraggingItem(item: model.items[index]),
                      child: DragTarget<int>(
                        onAccept: (draggedIndex) {
                          model.moveItem(draggedIndex, index);
                        },
                        builder: (context, candidateData, rejectedData) {
                          return GridItem(item: model.items[index]);
                        },
                      ),
                    );
                  },
                ),
             ),
             Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
                  itemCount: model.items.length,
                  itemBuilder: (context, index2) {
                    return LongPressDraggable(
                      data: index2,
                      feedback: DraggingItem(item: model.items[index2]),
                      child: DragTarget<int>(
                        onAccept: (draggedIndex2) {
                          model.moveItem(draggedIndex2, index2);
                        },
                        builder: (context, candidateData, rejectedData) {
                          return GridItem(item: model.items[index2]);
                        },
                      ),
                    );
                  },
                ),
             ),
           ],
         ),
       );
     }
   }

   class GridItem extends StatelessWidget {
     final String item;

     GridItem({required this.item});

     @override
     Widget build(BuildContext context) {
       return Card(
         child: Center(
           child: Text(item),
         ),
       );
     }
   }

   class DraggingItem extends StatelessWidget {
     final String item;

     DraggingItem({required this.item});

     @override
     Widget build(BuildContext context) {
       return Opacity(
         opacity: 0.7,
         child: Card(
           child: Center(
             child: Text(item),
           ),
         ),
       );
     }
   }
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class PlaceholderWidget extends StatelessWidget {
  final Color color;
  PlaceholderWidget(this.color);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: color,
      child: new Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          //color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigoAccent,
              child: Text('3'),
              foregroundColor: Colors.white,
            ),
            title: Text('Tile n°3'),
            subtitle: Text('SlidableDrawerDelegate'),
          ),
        ),
        actions: <Widget>[
          IconSlideAction(
            caption: 'Archive',
            color: Colors.blue,
            icon: Icons.archive,

          ),
          IconSlideAction(
            caption: 'Share',
            color: Colors.indigo,
            icon: Icons.share,

          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'More',
            color: Colors.black45,
            icon: Icons.more_horiz,
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
          ),
        ],
      ),
    );
  }

}
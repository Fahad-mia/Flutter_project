import 'package:note_app/view_model/favorite_ViewModel.dart';
import 'package:note_app/view_model/loading_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'loading_screen.dart';

class Favorit_Screen extends StatefulWidget {
  Favorit_Screen({super.key});

  @override
  State<Favorit_Screen> createState() => _Favorit_ScreenState();
}

class _Favorit_ScreenState extends State<Favorit_Screen> {
  @override
  Widget build(BuildContext context) {
    final loading_Provider = Provider.of<Loading_view_model>(context);
    return loading_Provider.loading
        ? Loading_Screen(
      content: loading_Provider.content,
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("Favorite "),
              centerTitle: true,
              backgroundColor: Colors.cyan,
            ),
            body: Consumer<Favoriteprovider>(
                builder: (context, favoritePro, child) {
              return favoritePro.favoriteList.isEmpty
                  ? Center(child: Text("No Favorite Item"))
                  : ListView.builder(
                      itemCount: favoritePro.favoriteList.length,
                      itemBuilder: (context, index) {
                        final favnote = favoritePro.favoriteList[index];
                        return Card(
                          elevation: 11.5,
                          color: Color.fromRGBO(230, 100, 250, 1.0),
                          child: ListTile(
                            title: Text(favnote.title ?? "NO TITLE"),
                            subtitle:
                                Text(favnote.description ?? 'No Description'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(favnote.date ?? 'No date'),
                                //Delete the fav_item.
                                IconButton(
                                    onPressed: () {
                                      favoritePro.deletefavItem(index);
                                      refresh();
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                          ),
                        );
                      });
            }));
  }

  Future<void> refresh() async {
    Provider.of<Loading_view_model>(context, listen: false).setLoading(true);
    Provider.of<Loading_view_model>(context, listen: false).setContent('Deleting');
    await Future.delayed(Duration(seconds: 5));
    print("Setting loading to false"); // Debug statement
    Provider.of<Loading_view_model>(context, listen: false).setLoading(false);

  }
}

import 'package:fahad_note_app/model/Note_Model.dart';
import 'package:fahad_note_app/view/edit_update_screen.dart';
import 'package:fahad_note_app/view/favorite_screen.dart';
import 'package:fahad_note_app/view/loading_screen.dart';
import 'package:fahad_note_app/view_model/db_view_model.dart';
import 'package:fahad_note_app/view_model/favorite_ViewModel.dart';
import 'package:fahad_note_app/view_model/loading_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    final loading_Provider = Provider.of<Loading_view_model>(context);
    final dbProvider = Provider.of<DB_View_Model>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List of Notes',
          style: TextStyle(color: Colors.purpleAccent, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent,
        actions: [

          // this is the favorite icon.

          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=> Favorit_Screen()));
          }, icon: Icon(Icons.favorite))
        ],
      ),

      //for create new note
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_)=>EditUpdateScreen(note_model: Note_Model(),))).then((value){
            if(value == true){
              loading_Provider.setContent("Saving");
              loading_Provider.setLoading(true);
              refresh();
            }
            else{
              loading_Provider.setContent("Refreshing");
              loading_Provider.setLoading(true);
              refresh();

            }

          });
        },
        child: Icon(
          Icons.add,
          color: Colors.deepPurpleAccent,
        ),
      ),
      body: loading_Provider.loading
          ? Loading_Screen(content: loading_Provider.content,)
          : ListView.builder(
              itemCount: dbProvider.notes.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final note = dbProvider.notes[index];
                return Card(
                  elevation: 15.5,
                  color: Color.fromRGBO(230, 250, 050, 1.0),
                  child: ListTile(
                    title: Text(
                      note.title ?? 'No Title',
                      style: TextStyle(color: Colors.red),
                    ),
                    subtitle: Text(note.description ?? 'no description'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(note.date ?? ''),
                        //favorite icon for adding the item to the favorite list.
                        IconButton(onPressed: (){
                          _fav_function(note.id!);
                        }, icon:  Icon(Icons.favorite_border)) ,

                        //Deleting an item
                        IconButton(onPressed: (){
                          deleteData(note.id!);
                        }, icon: Icon(Icons.delete, color: Colors.red,)),


                        //edit Icon and for editing the existing note
                        IconButton(onPressed: ()async{
                          Note_Model note_model = Note_Model(id: note.id!);
                          Note_Model? newNote = await dbProvider.getSingleRow(note_model);
                          Navigator.push(context, MaterialPageRoute(builder: (_) => EditUpdateScreen(note_model: newNote!))).then((value){
                            if(value == true){
                            loading_Provider.setContent("Updating");
                            loading_Provider.setLoading(true);
                                refresh();
                            }
                            else{
                              loading_Provider.setContent("Refreshing");
                              loading_Provider.setLoading(true);
                              refresh();

                            }
                          });
                        }, icon: Icon(Icons.edit, color: Colors.purpleAccent,))
                      ],
                    ),
                  ),
                );
              }),
    );
  }

  Future<void> refresh() async {
    await Future.delayed(Duration(seconds: 5));
    print("Setting loading to false"); // Debug statement
    Provider.of<Loading_view_model>(context, listen: false).setLoading(false);
  }

  Future<void> _fetchData() async{
    Provider.of<DB_View_Model>(context, listen: false).fetchAllData();
  }

  void deleteData(int id) async{
    Note_Model note = Note_Model(id: id);
    Provider.of<DB_View_Model>(context, listen: false).deleteData(note);
    Provider.of<Loading_view_model>(context, listen: false).setLoading(true);
    Provider.of<Loading_view_model>(context, listen: false).setContent('Deleting');

    refresh();
  }

  void _fav_function(int id) async{
    Note_Model note_model = Note_Model(id: id);
    Note_Model? newNote = await Provider.of<DB_View_Model>(context, listen: false).getSingleRow(note_model);
    Provider.of<Favoriteprovider>(context, listen: false).addFavoriteItem(newNote!);
  }
}


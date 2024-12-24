import 'package:flutter/material.dart';
import 'package:note_app/Model/Note_Model.dart';
import 'package:note_app/view_model/db_view_model.dart';
import 'package:note_app/view_model/loading_view_model.dart';
import 'package:provider/provider.dart';

class EditUpdateScreen extends StatefulWidget {
  Note_Model note_model;
  EditUpdateScreen({super.key, required this.note_model});

  @override
  State<EditUpdateScreen> createState() => _EditUpdateScreenState();
}

class _EditUpdateScreenState extends State<EditUpdateScreen> {
  TextEditingController _titleText = TextEditingController();
  TextEditingController _description = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState-
    // this is method is called for get the information of an existing note
    super.initState();
    if(widget.note_model.id != null){
      _titleText.text = widget.note_model.title!;
      _description.text = widget.note_model.description!;
    }
  }

  void _saveData() async {
    if(widget.note_model.id == null)
      { //if id is null then saving operation occur
        String titleText = _titleText.text;
        String descriptionText = _description.text;
        Note_Model note_model =
        Note_Model(title: titleText, description: descriptionText);
        int insertedId = await Provider.of<DB_View_Model>(context, listen: false).insertData(note_model);
        print('Inserted id is : $insertedId');
        Provider.of<Loading_view_model>(context, listen: false).setContent('Saving');
        Navigator.pop(context, true);
      }
    else{//else update operation will perform
      int id = widget.note_model.id!;
      String titleText = _titleText.text;
      String descriptionText = _description.text;
      Note_Model note_model =
      Note_Model(id:id, title: titleText, description: descriptionText);
      int updateId = await Provider.of<DB_View_Model>(context, listen: false).updateData(note_model);
      print('update succesull : $updateId');
      Provider.of<Loading_view_model>(context, listen: false).setContent('Updating');
      Navigator.pop(context, true);
    }
  }
bool editmode() {
    bool edit = true;
    if(widget.note_model.id != null)
      {
        edit = false;
        return edit;
      }
    else
      return edit;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: editmode() ? Text("Edit") : Text("Update"),
            centerTitle: true,
            backgroundColor: Colors.purpleAccent,
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _titleText,
                  decoration: InputDecoration(
                    labelText: 'Enter your Title',
                    hintText: 'Enter Title',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.5),
                        borderSide:
                            BorderSide(color: Colors.lightBlueAccent, width: 3)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.purpleAccent, width: 3),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  maxLines: 8,
                  controller: _description,
                  decoration: InputDecoration(
                    labelText: 'Enter your Description',
                    hintText: 'Enter Description',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.5),
                        borderSide:
                            BorderSide(color: Colors.lightBlueAccent, width: 3)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.purpleAccent, width: 3),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    _saveData();
                  },
                  child: editmode() ? Text("Save") : Text("Update"),
                ),
              ],
            ),
          ),
      );

  }
}

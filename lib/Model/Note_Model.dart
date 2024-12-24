class Note_Model {
  int? id;
  String? title, description, date;

  Note_Model({this.id, this.date, this.title, this.description});

  factory Note_Model.fromMap(Map<String, dynamic> maps){
    return Note_Model(
        id: maps['id'],
        date: maps['date'],
        title: maps['title'],
        description: maps['description']
    );
  }
  void setDate(){
    DateTime now = DateTime.now();
    String ds = now.day.toString()+"-"+
        now.month.toString()+'-'+
        now.year.toString()+'-'+
        now.hour.toString()+'-'+
        now.minute.toString()+'-'+
        now.second.toString();
    date =ds;
  }
  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'id': id,
      'date': date,
      'title': title,
      'description': description
    };
  }

}
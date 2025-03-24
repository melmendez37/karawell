class Journal{
  final int journalID;
  final String uuID;
  final String message;
  final DateTime date;

  Journal({
    required this.journalID,
    required this.uuID,
    required this.message,
    required this.date,
  });

    //map -> Journal
    factory Journal.fromMap(Map<String, dynamic> map){
    return Journal(
        journalID: map['id'],
        uuID: map['user_id'] as String,
        message: map['message'] as String,
        date:  map['date'] != null
          ? DateTime.parse(map['date'] as String)
          : DateTime.now(),
    );
  }


  //Journal -> map
  Map<String, dynamic> toMap(){
    return {
      'id': journalID,
      'user_id': uuID,
      'message': message,
      'date': date.toIso8601String(),
    };
  }
}
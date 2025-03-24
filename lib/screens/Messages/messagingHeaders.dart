class MessagingHeaders {
  final DateTime date;
  final int count;
  final String kind;
  String? id;


  MessagingHeaders({
    required this.date,
    required this.count,
    required this.kind,
    this.id,
  }
  );
}
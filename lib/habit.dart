class Habit {
  int id;
  String name;
  String description;
  int time;
  int notifyId;

  Habit(
      {this.id,
        this.time,
        this.description,
        this.name,
        this.notifyId});

  Map<String, dynamic> habitToMap() {
    Map<String, dynamic> map = Map();
    map['id'] = this.id;
    map['name'] = this.name;
    map['amount'] = this.description;
    map['time'] = this.time;
    map['notifyId'] = this.notifyId;
    return map;
  }

  Habit habitMapToObject(Map<String, dynamic> habitMap) {
    return Habit(
        id: habitMap['id'],
        name: habitMap['name'],
        description: habitMap['amount'],
        time: habitMap['time'],
        notifyId: habitMap['notifyId']);
  }

}
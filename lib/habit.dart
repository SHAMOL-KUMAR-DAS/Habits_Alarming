class Habit {
  int id;
  String name;
  String description;
  int howManyWeeks;
  int time;
  int notifyId;

  Habit(
      {this.id,
        this.howManyWeeks,
        this.time,
        this.description,
        this.name,
        this.notifyId});


  Map<String, dynamic> habitToMap() {
    Map<String, dynamic> map = Map();
    map['id'] = this.id;
    map['name'] = this.name;
    map['amount'] = this.description;
    map['howManyWeeks'] = this.howManyWeeks;
    map['time'] = this.time;
    map['notifyId'] = this.notifyId;
    return map;
  }

  Habit habitMapToObject(Map<String, dynamic> pillMap) {
    return Habit(
        id: pillMap['id'],
        name: pillMap['name'],
        description: pillMap['amount'],
        howManyWeeks: pillMap['howManyWeeks'],
        time: pillMap['time'],
        notifyId: pillMap['notifyId']);
  }

}

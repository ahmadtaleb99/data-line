part of 'person_bloc.dart';


@immutable
abstract class PersonEvent {

}
class PersonAdded extends PersonEvent {

  Person person;

  PersonAdded({required this.person});
}


class PersonAgeChanged extends PersonEvent {

}

class PersonIsMarriedToggled extends PersonEvent {
  bool isMarried;

  PersonIsMarriedToggled(this.isMarried);
}


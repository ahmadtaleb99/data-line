import 'package:equatable/equatable.dart';

void main(){


 List<Person> p = [
   Person('ahmad'),
   Person('ahmad'),
   Person('ahmad'),
   Person('ahmad'),
   Person('ahmad'),
 ];

 List<Person> p1 = [
   Person('ahmad'),
   Person('ahmad'),
   Person('ahmad'),
   Person('ahmad'),
   Person('ahmad'),
 ];

 Person person = Person('ahmad');
 Person person1 = Person('ahmad');
 print((person == person1).toString());
 print((p == p1).toString());

}

class Person extends Equatable{

   String name = 'asd';

  Person(this.name);

  @override
  // TODO: implement props
  List<Object?> get props => [name];

}
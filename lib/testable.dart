void main () {


 var person = Person(name: 'ahmad');
 var person2 = Person(name: 'k');

person2 = person;

person.name = 'ss';
print(person2.name);

}


class Person {


  int ? age;
  String name;

  Person({
    this.age,
    required this.name,
  });


}

































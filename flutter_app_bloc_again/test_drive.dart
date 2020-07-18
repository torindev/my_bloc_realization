void main() {
  BasePerson p = Person('Di', 32);
  print(p is BasePerson);
  printAge(Person('Di', 32));
}

void printAge(BasePerson p) {
  if (p is Person) {
    print(p.age.toString());
  }
}

class Person extends BasePerson {
  final int age;
  Person(String name, this.age) : super(name);
}

abstract class BasePerson {
  final String name;

  BasePerson(this.name);
}

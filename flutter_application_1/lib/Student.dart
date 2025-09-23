
import 'package:flutter_application_1/Person.dart';

class Student extends Person{

  
  String studentId;

  final List<String> students=['Alumno1','Alumno2','Alumno3'];
  Student(String name,  this.studentId) :super(name);



}
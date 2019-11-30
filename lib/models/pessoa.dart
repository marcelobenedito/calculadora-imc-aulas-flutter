
import 'package:calculadora_imc/consts/female_imc.dart';
import 'package:calculadora_imc/consts/genre.dart';
import 'package:calculadora_imc/consts/male_imc.dart';

class Pessoa {

  double weight;
  double height;
  int genre;

  Pessoa({this.height, this.weight, this.genre});

  double calculateImc() {
    height = height / 100.0;
    return weight / (height * height);
  }

  String classificar(double imc) {
      if (this.genre == Genre.FEMALE) {
        if (imc < FemaleImc.ABAIXO_PESO)
          return "Abaixo do peso";
        else if (imc < FemaleImc.PESO_IDEAL)
          return "Peso ideal";
        else if (imc < FemaleImc.POUCO_ACIMA_PESO)
          return "Pouco acima do peso";
        else if (imc < FemaleImc.ACIMA_PESO)
          return "Acima do peso";
        else if (imc >= FemaleImc.OBESIDADE)
          return "Obesidade";
      } 
      if (this.genre == Genre.MALE) {
        if (imc < MaleImc.ABAIXO_PESO)
          return "Abaixo do peso";
        else if (imc < MaleImc.PESO_IDEAL)
          return "Peso ideal";
        else if (imc < MaleImc.POUCO_ACIMA_PESO)
          return "Pouco acima do peso";
        else if (imc < MaleImc.ACIMA_PESO)
          return "Acima do peso";
        else if (imc >= MaleImc.OBESIDADE)
          return "Obesidade";
      }
      return "";
  }

}
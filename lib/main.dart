import 'package:calculadora_imc/consts/female_imc.dart';
import 'package:calculadora_imc/consts/genre.dart';
import 'package:calculadora_imc/consts/male_imc.dart';
import 'package:calculadora_imc/models/pessoa.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var pessoa = Pessoa(height: 0.0, weight: 0.0);

  String _result;
  String _resultImc;
  Color _resultColor;
  int _radioValue = 0;

  @override
  void initState() {
    super.initState();
    resetFields();
  }

  void resetFields() {
    _weightController.text = '';
    _heightController.text = '';
    setState(() {
      _result = 'Informe seus dados';
      _resultImc = '';
    });
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  Color classificar(double imc) {
      if (pessoa.genre == Genre.FEMALE) {
        if (imc < FemaleImc.ABAIXO_PESO)
          return Colors.blue;
        else if (imc < FemaleImc.PESO_IDEAL)
          return Colors.greenAccent[700];
        else if (imc < FemaleImc.POUCO_ACIMA_PESO)
          return Colors.yellow[600];
        else if (imc < FemaleImc.ACIMA_PESO)
          return Colors.orange;
        else if (imc >= FemaleImc.OBESIDADE)
          return Colors.red;
      } 
      if (pessoa.genre == Genre.MALE) {
        if (imc < MaleImc.ABAIXO_PESO)
          return Colors.blue;
        else if (imc < MaleImc.PESO_IDEAL)
          return Colors.greenAccent[700];
        else if (imc < MaleImc.POUCO_ACIMA_PESO)
          return Colors.yellow[600];
        else if (imc < MaleImc.ACIMA_PESO)
          return Colors.orange;
        else if (imc >= MaleImc.OBESIDADE)
          return Colors.red;
      }
      return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                resetFields();
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Peso (kg)'),
                      controller: _weightController,
                      validator: (text) {
                        return text.isEmpty ? "Insira seu peso!" : null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Altura (cm)'),
                      controller: _heightController,
                      validator: (text) {
                        return text.isEmpty ? "Insira sua altura!" : null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 36.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            new Radio(
                              value: 0,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                            new Text('Feminino'),
                            new Radio(
                              value: 1,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                            new Text('Masculino'),
                          ],
                        ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Column(
                                children: <Widget>[
                                  Text(_resultImc, textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                                  Text(_result, textAlign: TextAlign.center, style: TextStyle(color: _resultColor)),
                                ]
                              )
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 36.0),
                        child: Container(
                            height: 50,
                            child: RaisedButton(
                              color: Colors.blueAccent,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    pessoa.weight = double.parse(_weightController.text);
                                    pessoa.height = double.parse(_heightController.text);
                                    pessoa.genre = _radioValue;
                                    double imc = pessoa.calculateImc();
                                    _resultColor = classificar(imc);
                                    _resultImc = "IMC = ${imc.toStringAsPrecision(3)}";
                                    _result = "${pessoa.classificar(imc)}";
                                  });
                                }
                              },
                              child: Text('CALCULAR', style: TextStyle(color: Colors.white)),
                            ))),
                            
                  ],
                ))));
  }
}

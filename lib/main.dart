import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    title: "Calculadora IMC",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _key_form = GlobalKey<FormState>();
  String _infoText = "";
  final textControllerALtura = TextEditingController();
  final textControllerPeso = TextEditingController();
  double _getImc() {
    double peso = double.parse(textControllerPeso.text);
    double altura = double.parse(textControllerALtura.text) / 100;
    return peso / altura * altura;
  }

  void restartForm() {
    setState(() {
      textControllerALtura.text = "";
      textControllerPeso.text = "";
      this._infoText = "";
      _key_form = GlobalKey<FormState>();
    });
  }

  void _getInfoPeso(double imc) {
    String formatImc = imc.toStringAsPrecision(3);
    setState(() {
      if (imc < 18.6) {
        _infoText = "Abaixo do peso! ($formatImc)";
      } else if (imc < 24.9) {
        _infoText = "Peso ideal! ($formatImc)";
      } else if (imc < 29.9) {
        _infoText = "Levemente acima do peso! ($formatImc)";
      } else if (imc < 34.9) {
        _infoText = "Obesidade grau I! ($formatImc)";
      } else if (imc < 39.9) {
        _infoText = "Obesidade grau II! ($formatImc)";
      } else {
        _infoText = "Obesidade grau III! ($formatImc)";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora IMC",
              style: TextStyle(color: Colors.white, fontSize: 20.0)),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                this.restartForm();
              },
              icon: Icon(Icons.refresh),
              color: Colors.white,
            )
          ],
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: _key_form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.person,
                    size: 120.4,
                    color: Colors.green,
                  ),
                  TextFormField(
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) return "Preecha este campo";
                    },
                    controller: textControllerPeso,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 18.5),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: Colors.green,
                            fontSize: 20.5,
                            fontWeight: FontWeight.bold),
                        labelText: "Peso(KG)"),
                  ),
                  TextFormField(
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) return "Preencha este campo";
                    },
                    controller: textControllerALtura,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 20.5),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: Colors.green,
                            fontSize: 18.5,
                            fontWeight: FontWeight.bold),
                        labelText: "Altura(cm)"),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.5),
                    height: 55.5,
                    child: RaisedButton(
                        onPressed: () {
                          if (_key_form.currentState.validate()) {
                            setState(() {
                              double imc = _getImc();
                              _getInfoPeso(imc);
                            });
                          }
                        },
                        color: Colors.green,
                        child: Text(
                          "Calcular",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.5,
                          ),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$_infoText",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 20.5,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}

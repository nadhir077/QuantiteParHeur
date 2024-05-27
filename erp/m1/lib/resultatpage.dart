import 'package:flutter/material.dart';

class ResultatPage extends StatefulWidget {
  final String refProduit;
  final String operationProduit;

  const ResultatPage(
      {required this.refProduit, required this.operationProduit, super.key});

  @override
  State<ResultatPage> createState() => _ResultatPageState();
}

class _ResultatPageState extends State<ResultatPage> {
  bool _isEnabled = false;
  final tempUnitaire = TextEditingController();
  final qteParHeure = TextEditingController();
  final qteProduit = TextEditingController();
  final TempDeRealisation = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void calcule() {
    double tempUnit = double.parse(tempUnitaire.text);
    double qte = double.parse(qteProduit.text);
    double resltat = (tempUnit * qte) / 3600; // Calcul du résultat décimal
    int hours = resltat.floor(); // Heures (partie entière du résultat)
    int minutes = ((resltat - hours) * 60)
        .round(); // Minutes (partie décimale convertie en minutes)

    String timeString =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
    print(timeString); // Affichage du résultat au format HH:mm
    setState(() {
      TempDeRealisation.text = timeString;
    });
  }

  final ButtonStyle styleed = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 40,
    ),
    disabledForegroundColor:
        const Color.fromARGB(255, 93, 243, 33).withOpacity(0.38),
    disabledBackgroundColor:
        const Color.fromARGB(255, 151, 196, 148).withOpacity(0.12),
    padding: const EdgeInsets.all(15),
    backgroundColor: const Color.fromARGB(255, 19, 84, 11),
    elevation: 20,
  );
  @override
  void dispose() {
    tempUnitaire.dispose();
    qteParHeure.dispose();
    qteProduit.dispose();
    TempDeRealisation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 254, 254, 254)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Quantité Par heure"),
        backgroundColor: const Color.fromARGB(255, 19, 84, 11),
      ),
      body: Form(
        key: _formkey,
        autovalidateMode: AutovalidateMode.always,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            margin: const EdgeInsets.all(10),
            width: double.maxFinite,
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(255, 93, 243, 33)
                          .withOpacity(0.38),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 20,
                                backgroundColor:
                                    const Color.fromARGB(255, 151, 196, 148)
                                        .withOpacity(0.12),
                              ),
                              children: [
                                const TextSpan(
                                    text: 'Réf Produit : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                TextSpan(
                                    text: widget.refProduit,
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 20,
                                backgroundColor:
                                    const Color.fromARGB(255, 151, 196, 148)
                                        .withOpacity(0.12),
                              ),
                              children: [
                                const TextSpan(
                                    text: 'Opération : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                TextSpan(
                                    text: widget.operationProduit,
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: tempUnitaire,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        double tempUnit = double.parse(tempUnitaire.text);
                        int resltat = (3600 / tempUnit).round();
                        setState(() {
                          qteParHeure.text = resltat.toString();
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Temps unitaire par Seconde",
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 19, 84, 11),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 19, 84, 11), width: 8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          width: 2.0,
                          color: Color.fromARGB(255, 19, 84, 11),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: qteParHeure,
                    decoration: InputDecoration(
                      labelText: "Quantité par Heure",
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 19, 84, 11),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          width: 2.0,
                          color: Color.fromARGB(255, 19, 84, 11),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  TextFormField(
                    validator: (value) {
                      // ignore: unnecessary_null_comparison

                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir la quantité ';
                      }
                      return null;
                    },
                    controller: qteProduit,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      // Remove non-numeric characters using a regular expression
                      String numericValue =
                          value.replaceAll(RegExp(r'[^0-9]'), '');

                      // Update the text field value with the numeric value
                      qteProduit.value = qteProduit.value.copyWith(
                        text: numericValue,
                        selection: TextSelection.collapsed(
                            offset: numericValue.length),
                      );
                      setState(() {
                        _isEnabled = qteProduit.text.isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Quantité ",
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 19, 84, 11),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          width: 2.0,
                          color: Color.fromARGB(255, 19, 84, 11),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: styleed,
                      onPressed: _isEnabled
                          ? () => {
                                if (_formkey.currentState!.validate())
                                  {
                                    _formkey.currentState!.save(),
                                    calcule(),
                                    FocusScope.of(context).unfocus(),
                                  },
                                print("Bouton calculer a etait clicker"),
                              }
                          : null,
                      child: Text(
                        "Calculer".toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: TempDeRealisation,
                    decoration: InputDecoration(
                      labelText: "Temps de réalisation",
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 19, 84, 11),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          width: 2.0,
                          color: Color.fromARGB(255, 19, 84, 11),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:m1/resultatpage.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class CustomSearchTextField extends StatefulWidget {
  const CustomSearchTextField({super.key});

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  GlobalKey<FormState> formkey = GlobalKey();

  List<String> OperationType = [
    "Coupe automatique",
    "Coupé Gaine",
    "dénudage de fil",
    "Thermistance de coupe",
    "Soudure à l’étain",
    "Etamage",
    "Brasatura",
    "Soudure laser",
    "Presse",
    "Sertissage",
    "Moletage",
    "Montage manuel",
    "Perforation",
    "Splice",
    "Marquage",
    "Activité Manuelle ",
    "Application de rétrécissement",
    "Moulage",
    "Nettoyage bav. moul.",
    "lissage",
    "Sablage",
    "Soudage plasma T/T",
    "lovage",
    "Résine",
    "Graissage manuel",
    "Dégainage (tctx)",
    "Test d’isolation",
    "Contrôle polarité ",
    "Cont. cont/préc ",
    "Contrôle électrique",
    "Contrôle Visuel",
    "Emballage",
  ];
  String valeur = "Contrôle électrique";
  String result = '';
  final txtctrl = TextEditingController();

  @override
  void dispose() {
    txtctrl.dispose();
    super.dispose();
  }

  bool _isEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quantité Par heure"),
        backgroundColor: Color.fromARGB(255, 19, 84, 11),
      ),
      body: Center(
        child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: txtctrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Il faut remplire ce champ";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _isEnabled = txtctrl.text.isNotEmpty;
                      });
                    },
                    onFieldSubmitted: (value) {
                      txtctrl.clear();
                    },
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 19, 84, 11),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Color.fromARGB(255, 19, 84, 11),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.barcode_reader,
                          color: Color.fromARGB(255, 19, 84, 11),
                        ),
                        onPressed: () async {
                          print("barecode is clicked");
                          var res = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SimpleBarcodeScannerPage(),
                              ));
                          setState(() {
                            if (res.startsWith("-1")) {
                              txtctrl.text = "";
                            } else {
                              _isEnabled = !_isEnabled;
                              result = res;
                              txtctrl.text = res;
                              print("le resultat est   " + result);
                            }
                          });
                        },
                      ),
                      labelText: "Référence Produit",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      elevation: 16,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Color.fromARGB(255, 19, 84, 11),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2.0,
                              color: Color.fromARGB(255, 19, 84, 11),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                      ),
                      value: valeur,
                      items: OperationType.map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )).toList(),
                      onChanged: (e) {
                        setState(() {
                          valeur = e.toString();
                          print(valeur);
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  MaterialButton(
                    color: const Color.fromARGB(255, 19, 84, 11),
                    textColor: Colors.white,
                    disabledColor:
                        Color.fromARGB(255, 117, 125, 113).withOpacity(0.38),
                    disabledTextColor:
                        Color.fromARGB(255, 5, 5, 5).withOpacity(0.12),
                    padding: const EdgeInsets.all(15),
                    onPressed: _isEnabled
                        ? () {
                            if (formkey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultatPage(
                                      refProduit: txtctrl.text,
                                      operationProduit: valeur),
                                ),
                              );

                              print("Valid");
                            } else
                              print("Invalid");
                          }
                        : null,
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 8, right: 8, top: 10, bottom: 10),
                      child: Text("CHERCHER", style: TextStyle(fontSize: 40)),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

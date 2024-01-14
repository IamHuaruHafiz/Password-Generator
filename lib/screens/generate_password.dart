import 'package:codegen/functions/password_gen.dart';
import 'package:flutter/material.dart';

class GeneratePasswordScreen extends StatefulWidget {
  const GeneratePasswordScreen({super.key});

  @override
  State<GeneratePasswordScreen> createState() => _GeneratePasswordScreenState();
}

class _GeneratePasswordScreenState extends State<GeneratePasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController numberController = TextEditingController();
  String code = "";
  bool generated = false;

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  void submitData() {
    if (formKey.currentState!.validate()) {
      String password =
          generatePassword(passwordLength: int.parse(numberController.text));
      setState(() {
        code = password;
        generated = true;
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color white = const Color(0xffF1F1F1);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green.shade900,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Password Generator",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 45,
                          color: white),
                    ),
                    Text(
                      "Enter a number between 6 and 32 to generate password",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          color: white),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Form(
                      key: formKey,
                      child: TextFormField(
                        onFieldSubmitted: (_) {
                          submitData();
                          FocusNode().unfocus();
                        },
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: white),
                        cursorColor: white,
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "field required";
                          }
                          if (!(int.parse(value) >= 6 &&
                              int.parse(value) <= 32)) {
                            return "Enter a number between 6 and 32";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: numberController,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: white),
                            hintText: "Enter number here",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: white)),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.red,
                            )),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                              width: 2,
                            )),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.green,
                              width: 2,
                            ))),
                      ),
                    ),
                    code.isEmpty
                        ? const SizedBox()
                        : Center(
                            child: SelectableText(code,
                                cursorColor: white,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color: Color(0xffF1F1F1))),
                          ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          textStyle: const MaterialStatePropertyAll<TextStyle>(
                              TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          )),
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(white),
                          foregroundColor: MaterialStatePropertyAll<Color>(
                              Colors.green.shade900),
                        ),
                        onPressed: () {
                          setState(() {
                            if (generated == false) {
                              submitData();
                              FocusNode().unfocus();
                            } else {
                              code = "";
                              numberController.clear();
                              setState(() {
                                generated = false;
                              });
                            }
                          });
                        },
                        child: Text(generated ? "Clear" : "Generate")),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

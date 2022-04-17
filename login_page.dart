import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  TextEditingController _emailControlor = TextEditingController();
  TextEditingController _passControlor = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey();
  bool _isobsiqure = true;
  late AnimationController animationController;
  late Animation animation;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    animationController.forward();
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceIn)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              animationController.reset();
              animationController.forward();
            }
          });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          CachedNetworkImage(
            height: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(animation.value, 0),
            imageUrl:
                "http://www.scieducationusa.org/new-theme/assets/images/login.gif",
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Form(
              key: _formkey,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _emailControlor,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter your email";
                          }
                          if (!value.contains('@gmail.com')) {
                            return "please enter valid emil";
                          }
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.tealAccent,
                            filled: true,
                            hintText: "Enter your email",
                            hintStyle: TextStyle(color: Colors.blue),
                            labelText: "Enter your email",
                            labelStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black,
                              size: 20,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _passControlor,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: _isobsiqure,
                        obscuringCharacter: "*",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "enter your name";
                          }
                          if (value.length < 4) {
                            return "your pass is to short";
                          }
                          if (value.length > 10) {
                            return "your pass word is to long";
                          }
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isobsiqure = !_isobsiqure;
                                  });
                                },
                                icon: Icon(_isobsiqure
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                            prefixIcon: Icon(
                              Icons.key,
                              color: Colors.black,
                              size: 20,
                            ),
                            fillColor: Colors.tealAccent,
                            filled: true,
                            hintText: "Enter your password",
                            hintStyle: TextStyle(color: Colors.blue),
                            labelText: "Enter your password",
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          print("okkkkkk");
                        } else {
                          print("something worng");
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text("Log In"),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/register_view.dart';

import 'package:get/get.dart';

class Login extends StatelessWidget {

  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //Header
            Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                //color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const <Widget> [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text('Selamat Datang Kembali', maxLines: 2, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text('Silahkan lakukan login dengan akun yang terdaftar' , maxLines: 2, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
                    )
                  ],
                ),
              )
            ),
            //Login_Form
            Expanded(
              flex: 2,
              child: SizedBox(
                width: double.infinity,
                //color: Colors.blueAccent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    elevation: 8.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget> [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text("Login", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                        ),
                        LoginForm(),
                      ],
                    )
                  ),
                ),
              )
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                //color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Tidak punya akun?' , maxLines: 2, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
                    TextButton(
                      onPressed: (){
                        Get.to(const RegisterView());
                      }, 
                      child: const Text('Register', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400), textAlign: TextAlign.center,)
                    )
                  ],
                )
              )
            ),
          ],
        ),
      )
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [
            TextFormField(
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "masukan email",
                labelText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              validator: (value) {
                if (value != null) {
                  return 'Email tidak boleh kosong';
                } else {
                  return null;
                }
              },
            ),
            const Divider(height: 16,),
            TextFormField(
              autofocus: true,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "masukan password",
                labelText: "Password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              validator: (value) {
                if (value != null) {
                  return 'Password tidak boleh kosong';
                } else {
                  return null;
                }
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,              
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() != null) {}
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(double.infinity, 42))
                ),
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
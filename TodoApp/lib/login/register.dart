//회원가입 페이지

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../navigationbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  //파이어베이스 시작
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  final _authentication = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color(0xffb936DFF),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context); //뒤로가기
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40.0, 120.0, 40.0, 0.0),
        child: Center(
          child: ListView(
            key: _formKey,
            children: <Widget>[
              const Text(
                '회원가입',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff5A5A5A)),
              ),
              const SizedBox(
                height: 20.0,),
              Container(
                padding: EdgeInsets.only(left: 8),
                height: 20.0,
              child: const Text('이메일',
              style: TextStyle(color: const Color(0xffb5A5A5A)),),),
              const SizedBox(
                height: 6.0,),
              Column(
                children: [
                  //이메일 입력

                  TextFormField(
                    key: const ValueKey(1),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return "Please enter at least 4 characters";
                      }
                      return null;
                    },
                    onSaved: (value) async {
                      userEmail = value!;
                    },
                    onChanged: (value) {
                      userEmail = value;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color:const Color(0xffbD5D5D5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color:const Color(0xffb936DFF)),
                        ),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: '이메일을 입력해주세요',
                      labelStyle: TextStyle(color: const Color(0xffD5D5D5))
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,),
              Container(
                padding: EdgeInsets.only(left: 8),
                height: 20.0,
                child: const Text('비밀번호',
                  style: TextStyle(color: const Color(0xffb5A5A5A)),),),
              const SizedBox(
                height: 6.0,),
              //비밀번호 입력
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color:const Color(0xffbD5D5D5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color:const Color(0xffb936DFF)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: '비밀번호를 입력해주세요',
                    labelStyle: TextStyle(color: const Color(0xffD5D5D5))
                ),
                key: const ValueKey(2),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "enter pw";
                  }
                  return null;
                },
                onSaved: (value) {
                  userPassword = value!;
                },
                onChanged: (value) {
                  userPassword = value;
                },
              ),
              //확인 버튼
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                  child: const Text('다음'),
                  textColor: Colors.white,
                  color: Color(0xff936DFF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () async {
                    //가입 정보 파이어베이스에 연결

                    print(userEmail);
                    print(userPassword);
                    try {
                      final userID = _authentication;
                      final newUser =
                          await _authentication.createUserWithEmailAndPassword(
                              email: userEmail, password: userPassword);
                      if (newUser.user != null) {
                        print(newUser.user!.uid);
                        firestore.collection(newUser.user!.uid).doc().set({
                          "Title": 'Study',
                          "priority": 1,
                          "category": "Study",
                          "time": 1.5,
                          "Completion": false
                        });
                        firestore.collection(newUser.user!.uid).doc().set({
                          "Title": 'Assignment',
                          "priority": 2,
                          "category": "Study",
                          "time": 2,
                          "Completion": false
                        });
                        firestore.collection(newUser.user!.uid).doc().set({
                          "Title": 'Pull-up',
                          "priority": 4,
                          "category": "Exercise",
                          "time": 0.5,
                          "Completion": false
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (NavigationPage())),
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

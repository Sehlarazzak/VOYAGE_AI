import 'package:first_project/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:first_project/views/homescreen.dart';
import 'package:first_project/widgets/custom_toggle.dart';
import 'package:first_project/widgets/custom_elevatedbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/viewmodels/saved_trip_service.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool islogin = true;
  bool isHidden = true;
  final TextEditingController confirmpasswordcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Column(
            children: [ 
              Container(
            height: 430,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage('assets/images/mountains.jpg'),
              fit: BoxFit.cover,
              ),
            ),
            
            child: Padding(padding: EdgeInsets.only(
              left: 24,
              top: 50,
              right: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                     CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/images/logo.jpg'),
          
                     ),
                
          
                const SizedBox(width: 20),
          
                Text(
                  'VoyageAI',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    )
                  ),
                  ],
                ),

                const SizedBox(height: 200),
        
                Text(
                  "Discover Pakistan's breathtaking beauty",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
          
                Text(
                  'Your next adventure\nstarts here',
                  style: TextStyle(
                    fontSize: 34,
                    height: 1.1,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  ),
                  
              ],
          
            ),
              ),
           
          ), 
        
          SizedBox(height: 20),

          Expanded(child: ClipRRect(
            borderRadius: const BorderRadiusGeometry.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: 320,
                      child: CustomToggle(islogin: islogin,
                      onChanged: (value) {
                        setState(() {
                          islogin = value;
                        });
                      },
                                      ),
                    ),
                  ),
                      
                if(islogin) ...[
                  const SizedBox(height: 30),
                  CustomTextfield(
                    controller: emailcontroller, 
                    hinttext: 'Email Address', 
                    prefixicon: Icons.email_outlined,
                    keyboardtype: TextInputType.emailAddress,
                      
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if(!value.contains('@') || !value.contains('.com')) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    ),
                      
                    const SizedBox(height: 30),
                      
                  CustomTextfield(
                   controller: passwordcontroller,
                    hinttext: 'Password', 
                    prefixicon: Icons.lock_outline,
                    suffixicon: isHidden? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    obscuretext: isHidden,
                    onSuffixPressed: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                      
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if(value!.length < 8) {
                        return 'Password must be atleast of 8 characters';
                      }
                      return null;
                    },
                    ),
                      
                    SizedBox(height: 20),
                      
                    Align(
                      alignment: AlignmentGeometry.bottomRight,
                      child: TextButton(
                        onPressed: () {},
                       child: Text('Forgot Password?',
                       style: TextStyle(
                        color: Color(0xFF1E6AE1),
                        fontSize: 14,
                       ),
                       ),
                       ),
                    ),
                      
                    SizedBox(height: 20),
                      
                    CustomElevatedbutton(
                      text: 'Sign In',
                     onPressed: () async {
                      if(!_formKey.currentState!.validate()) {
                      return;
                     }

                     try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailcontroller.text, 
                        password: passwordcontroller.text,
                        );

                        if(!context.mounted) return;

                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => HomeScreen(),
                        ),
                        );
                     } on FirebaseAuthException catch(e) {
                      if(!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.message ?? 'Login Failed'),
                        ),
                      );
                     }
                     },
                     icon: Icons.navigate_next,
                     ),
                ]
                      
                else ...[
                  const SizedBox(height: 30),
                  CustomTextfield(
                    controller: namecontroller,
                     hinttext: 'Full Name',
                    prefixicon: Icons.person,
                    keyboardtype: TextInputType.name,
                    ),
                      
                    const SizedBox(height: 30),
                      
                    CustomTextfield(
                      controller: emailcontroller, 
                      hinttext: 'Email Address', 
                      prefixicon: Icons.email_outlined,
                      keyboardtype: TextInputType.emailAddress,
                      validator: (value) {
                      if(value == null || value.isEmpty) {
                        print('EMAIL EMPTY');
                        return 'Email is required';
                      }
                      if(!value.contains('@') || !value.contains('.com')) {
                        print('EMAIL INVALID: $value');
                        return 'Enter a valid email';
                      }
                      print('EMAIL VALID');
                      return null;
                    },
                      ),
                      
                      const SizedBox(height: 30),
                      
                    CustomTextfield(
                      controller: passwordcontroller, 
                      hinttext: 'Password', 
                      prefixicon: Icons.lock_outline,
                      keyboardtype: TextInputType.text,
                      suffixicon: isHidden? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    obscuretext: isHidden,
                    onSuffixPressed: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        print('PASSWORD EMPTY');
                        return 'Password is required';
                      }
                      if(value!.length < 8) {
                        print('PASSWORD TOO SHORT');
                        return 'Password must be atleast of 8 characters';
                      }
                      print('PASSWORD VALID');
                      return null;
                    },
                    ),
                      
                    const SizedBox(height: 30),
                      
                    CustomTextfield(
                      controller: confirmpasswordcontroller, 
                      hinttext: 'Confirm Password', 
                      prefixicon: Icons.face_unlock_outlined,
                      keyboardtype: TextInputType.text,
                      suffixicon: isHidden? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    obscuretext: isHidden,
                    onSuffixPressed: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        print('CONFIRM PASSWORD EMPTY');
                        return 'Please Confirm your password';
                      }
                      if(value != passwordcontroller.text) {
                        print('PASSWORDS DO NOT MATCH');
                        return 'Passwords do not match';
                      }
                      print('CONFIRM PASSWORD VALID');
                      return null;
                    },
                    
                    ),
                      
                    const SizedBox(height: 20),
                    
                    CustomElevatedbutton(
                      text: 'Create Account', 
                      onPressed: () async {
                        print('CREATE ACCOUNT BUTTON PRESSED');
                        if(!_formKey.currentState!.validate()) {
                          print('FORM VALIDATION FAILED');
                         return;
                     }

                     print('FORM VALIDATION PASSED');

                     try {
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailcontroller.text, 
                        password: passwordcontroller.text,
                        );

                        if(!context.mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Account Created Successfully!'),
                          ),
                        );
                        setState(() {
                          islogin = true;
                        });
                     } on FirebaseAuthException catch(e) {
                      print('FIREBASE AUTH ERROR: ${e.code}');
    print('MESSAGE: ${e.message}');

                      if(!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.message ?? 'Account Creation Failed'),
                        ),
                      );
                     }
                      },
                      icon: Icons.navigate_next,
                      ),
                ]
                      
              ], 
              ),
            ),
          ),
          ),
          ),
          ), ], 
          ),
        ),
      ), 
      ); 

     
  
  }
}
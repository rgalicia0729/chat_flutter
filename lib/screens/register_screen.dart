import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_flutter/widgets/show_alert_widget.dart';
import 'package:chat_flutter/widgets/labels_widget.dart';
import 'package:chat_flutter/widgets/text_field_widget.dart';
import 'package:chat_flutter/widgets/logo_widget.dart';
import 'package:chat_flutter/widgets/elevated_button_widget.dart';
import 'package:chat_flutter/services/auth_service.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                LogoWidget(labelText: 'Registro'),
                _FormWidget(),
                LabelsWidget(
                  labelMessage: '¿Ya tienes una cuenta?',
                  labelPath: 'Ingresa ahora!',
                  path: 'login',
                ),
                Text(
                  'Términos y condiciones de uso',
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormWidget extends StatefulWidget {
  @override
  __FormWidgetState createState() => __FormWidgetState();
}

class __FormWidgetState extends State<_FormWidget> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40.0),
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: <Widget>[
          TextFieldWidget(
            prefixIcon: Icons.perm_identity,
            hintText: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameController,
          ),
          SizedBox(height: 20.0),
          TextFieldWidget(
            prefixIcon: Icons.mail_outline,
            hintText: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),
          SizedBox(height: 20.0),
          TextFieldWidget(
            prefixIcon: Icons.lock_outline,
            hintText: 'Contraseña',
            textController: passwordController,
            obscureText: true,
          ),
          SizedBox(height: 20.0),
          ElevatedButtonWidget(
            labelText: 'Ingresar',
            onPressed: authService.registering
                ? null
                : () async {
                    final registerResult = await authService.signup(
                      name: nameController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );

                    if (registerResult) {
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      showAlert(
                        context: context,
                        title: 'Registro Incorrecto',
                        content: 'Por favor revise sus datos nuevamente',
                      );
                    }
                  },
          )
        ],
      ),
    );
  }
}

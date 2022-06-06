// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'package:delivery_food/src/ui/global_widgets/custom_form.dart';
import 'package:delivery_food/src/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  //variables que pasaremos por parametros :D
  final Widget? prefixIcon;
  final String? Function(String)? validator;
  final bool obscureText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  // final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final String? labelText;

  const InputText({
    Key? key,
    this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.labelText,
    // this.textInputAction,
  }) : super(key: key);

  @override
  State<InputText> createState() => InputTextState(); //lo cambiamos a publico para poder ocuparlo en nuestro Form custom
}

class InputTextState extends State<InputText> {
  //variables que tendran un estado cambiante jeje
  String? _errorText = ''; //nombre medio confuso pero se entiende
  // bool _isOk = false;
  late bool _obscureText; //late, no puede ser nulo y su valor esta definido mas adelante en initstate
  CustomFormState? _formState; //gracias a q lo guardamos como variable se puede manipular mejor y deactivarlo

  String? get errorText => _errorText; //consiguiendo el valor de la variable privada

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;

    //pa que renderize con tiempo, cuando usamos esto en un stf nunca es nulo por eso !
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _formState = CustomForm.formState(context);
      if (_formState != null) {
        print("custom form");
        _formState?.register(this); //this ya que el valor que necesita es un InputTextState
      }
      //formState?.remove(this); opcion 2
    });
  }

  @override
  void deactivate() {
    //deactivate se activa antes de dispose,la principal diferencia es que se invoca cuando el widget va a ser eliminado del arbol widgets, dispose se invoca cuando ya fue eliminado
    // print("deactivate");
    // final formState = CustomForm.formState(context);
    print("deactivate ${_formState != null}");
    if (_formState != null) {
      _formState?.remove(this);
    }
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: _validate, //el texto insertado eso es onchanged
      obscureText: _obscureText, //*** */
      onSubmitted: widget.onSubmitted, //y con esto ahora con solo de enter en el teclado ira a submit
      // textInputAction: , //pa cambiar el boton de enter del teclado, no utilxd
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obscureText
            ? CupertinoButton(
                minSize: 26,
                padding: const EdgeInsets.all(10),
                child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: _onVisibleChanged,
              )
            : Icon(
                Icons.check_circle,
                color: _errorText == null ? primarycolor : Colors.grey,
                //osease si es nulo q tenga el colorsito verde, lo q queremos es que se mantenga nulo, si no es nulo es que tiene un error y no para la validacion
              ),
      ),
    );
  }

  //metodo que valide si esta bien entonces es isok
  void _validate(String text) {
    if (widget.validator != null) {
      _errorText = widget.validator!(text);
      //errorText va a tener lo q retorne el validator ,si validator es nulo pasa, sino no, y va a cambiar por el setState
      setState(() {});
    }
    if (widget.onChanged != null) {
      widget.onChanged!(text);
      //si onchanged  no es nulo  entonces que llamamos a nuestro onchanged y le pasamos el texto, para recuperar tanto el email como la contraseña
    }
  }

  //metodo pa el osbcure **
  void _onVisibleChanged() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}

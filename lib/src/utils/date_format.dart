// las extensiones de metodo son muy utiles cuando queremos agregar una funcionalidad idicional a una instancia de una clase
//
extension DateFormat on DateTime {
  // aqui vamos a crar una funcion que para recibir un dateTime como funcion

  String get format {
    final year = this.year;
    final month = this.month >= 10 ? "${this.month}" : "0${this.month}";
    final day = this.day >= 10 ? "${this.day}" : "0${this.day}"; // darle un mejor formato al dia

    return "$day/$month/$year";
  }

  // aqui en las extensiones no puedes definir aca un metodo que modifique el DateTime
  // update(DateTime date){
  //   this = date;
  // }
}

// la pruebas unitarias, son codigo que prueba otro codigo, prueba su funcionalidad

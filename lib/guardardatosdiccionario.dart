import 'claseempleado.dart';
import 'diccionarioempleado.dart';

class GuardarDatosDiccionario {
  // Id autonumérico inicializado en 1
  static int _siguienteId = 1;

  static void guardarEmpleado(String nombre, String puesto, double salario) {
    // Creamos el empleado con el id autonumérico
    Empleado nuevoEmpleado = Empleado(
      id: _siguienteId,
      nombre: nombre,
      puesto: puesto,
      salario: salario,
    );

    // Guardamos en el diccionario usando el id como llave
    datosEmpleado[_siguienteId] = nuevoEmpleado;

    // Incrementamos el id para el próximo empleado
    _siguienteId++;
  }
}

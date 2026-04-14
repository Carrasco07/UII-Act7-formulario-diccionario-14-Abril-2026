import 'dart:io';

void main() async {
  print('\n======================================================');
  print('        AGENTE REPOSITORIO (GITHUB MANAGER)           ');
  print('======================================================');
  print('Bienvenido. Este agente interactivo preparará y subirá');
  print('tu proyecto a un repositorio de GitHub.');
  print('------------------------------------------------------\n');

  // 1. Inicializar repositorio (ignora si ya está inicializado)
  await ejecutarComando('git', ['init']);

  // 2. Solicitar enlace del repositorio
  stdout.write('\n[Paso 1] Introduce el enlace del repositorio de GitHub\n(ej. https://github.com/usuario/repo.git): ');
  String? urlRepo = stdin.readLineSync();
  
  if (urlRepo == null || urlRepo.trim().isEmpty) {
    print('Error: El enlace no puede estar vacío. Abortando...');
    exit(1);
  }
  urlRepo = urlRepo.trim();

  // Configurar origen remoto
  var checkRemote = await Process.run('git', ['remote']);
  if (checkRemote.stdout.toString().contains('origin')) {
    print('El origen remoto ya existe. Se actualizará el enlace...');
    await ejecutarComandoOculto('git', ['remote', 'set-url', 'origin', urlRepo]);
  } else {
    print('Agregando un nuevo origen remoto...');
    await ejecutarComandoOculto('git', ['remote', 'add', 'origin', urlRepo]);
  }

  // Asegurar la rama principal
  await ejecutarComandoOculto('git', ['branch', '-M', 'main']);

  // 3. Establecer mensaje de commit
  await ejecutarComando('git', ['add', '.']);

  stdout.write('\n[Paso 2] Introduce un mensaje para el commit\n(Dejar en blanco para usar "Avance del proyecto"): ');
  String? commitMsg = stdin.readLineSync();
  if (commitMsg == null || commitMsg.trim().isEmpty) {
    commitMsg = "Avance del proyecto";
  }

  // Ejecutar commit
  var commitStatus = await Process.run('git', ['commit', '-m', commitMsg]);
  if (commitStatus.stdout.toString().contains('nothing to commit')) {
    print('No hay cambios nuevos para realizar el commit.');
  } else {
    if (commitStatus.stdout.toString().isNotEmpty) print(commitStatus.stdout.toString().trim());
    if (commitStatus.stderr.toString().isNotEmpty) print(commitStatus.stderr.toString().trim());
  }

  // 4. Seleccionar rama o usar 'main' por defecto
  stdout.write('\n[Paso 3] La rama por defecto es "main". ¿Deseas enviarlo a otra rama?\n(Dejar en blanco para usar "main", o escribe el nombre de la otra rama): ');
  String? ramaElegida = stdin.readLineSync();
  
  String ramaFinal = 'main';
  if (ramaElegida != null && ramaElegida.trim().isNotEmpty) {
    ramaFinal = ramaElegida.trim();
    print('Comprobando/creando la rama "$ramaFinal"...');
    await ejecutarComando('git', ['checkout', '-b', ramaFinal]);
  }

  // 5. Subir los cambios
  print('\n[Paso 4] Subiendo los cambios a la rama "$ramaFinal"...');
  var pushResult = await ejecutarComando('git', ['push', '-u', 'origin', ramaFinal]);

  if (pushResult == 0) {
    print('\n======================================================');
    print(' ¡ÉXITO! El proyecto se subió correctamente a GitHub.');
    print('======================================================');
  } else {
    print('\n[!] Hubo advertencias o errores al enviar el proyecto a GitHub.');
    print('Asegúrate de tener tus credenciales de Git configuradas o los permisos necesarios en este repositorio.');
  }
}

/// Función que ejecuta un comando en la terminal mostrando su salida al usuario en tiempo real
Future<int> ejecutarComando(String ejecutable, List<String> argumentos) async {
  var proceso = await Process.start(ejecutable, argumentos);
  
  stdout.addStream(proceso.stdout);
  stderr.addStream(proceso.stderr);
  
  return await proceso.exitCode;
}

/// Función que ejecuta un comando en segundo plano sin inundar la terminal, ideal para configuraciones rápidas
Future<void> ejecutarComandoOculto(String ejecutable, List<String> argumentos) async {
  await Process.run(ejecutable, argumentos);
}

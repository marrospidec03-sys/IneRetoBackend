# IneRetoBackend
Automatización de la API de Usuarios de ServeRest
Este proyecto contiene la automatización de pruebas para la API ServeRest, cubriendo el ciclo de vida completo (CRUD) de la entidad Usuarios utilizando el framework Karate DSL.

Requisitos del Sistema
 Java JDK 11 o superior.
 Visual Studio Code con las siguientes extensiones instaladas:
 Language Support for Java (by Red Hat).
 Karate Runner (by Kirk Slota).

Estructura del Proyecto
 El proyecto sigue la estructura estándar de Maven:
 src/test/java/users/users.feature: Definición de escenarios en lenguaje Gherkin.
 src/test/java/users/UsersRunner.java: Clase disparadora de las pruebas en Java.
 pom.xml: Gestión de dependencias de Karate y JUnit 5.

Instrucciones de Ejecución
 Abrir Visual Studio Code y situarse en la carpeta raíz del proyecto (INETUM).
 Navegar en el explorador de archivos hasta: src/test/java/users/UsersRunner.java.
 Hacer clic en el comando "Run" (flecha verde) que aparece sobre la definición del método o de la clase UsersRunner.
 Las pruebas se ejecutarán secuencialmente y los resultados se mostrarán en la consola de salida.

Reporte de Resultados
 Al finalizar la ejecución, se genera automáticamente un reporte detallado en formato HTML que puede consultarse en la siguiente ruta local: target/karate-reports/karate-summary.html

Escenarios Automatizados
GET - Listar usuarios: Validación de códigos de estado y esquemas de respuesta.
POST - Crear usuario: Implementación de datos dinámicos para evitar duplicidad de registros.
GET por ID: Validación de persistencia de datos tras la creación.
PUT - Actualizar usuario: Modificación integral de campos existentes.
DELETE - Eliminar usuario: Validación de eliminación exitosa y comprobación de estado 400 posterior.

Feature: Gestión de Usuarios en ServeRest

  Background:
    * url baseUrl

  Scenario: Listar todos los usuarios registrados
    Given path 'usuarios'
    When method GET
    Then status 200
    And match response.usuarios == '#[]' 
    And match each response.usuarios == 
    """
    {
      "nome": "#string",
      "email": "#string",
      "password": "#string",
      "administrador": "#string",
      "_id": "#string"
    }
    """

  Scenario: Registrar un nuevo usuario exitosamente
    # Generamos un número aleatorio para que el email nunca se repita
    * def randomId = java.lang.System.currentTimeMillis()
    * def userEmail = 'test_' + randomId + '@inetum.com'

    Given path 'usuarios'
    And request 
    """
    {
      "nome": "Usuario Prueba Inetum",
      "email": "#(userEmail)",
      "password": "password123",
      "administrador": "true"
    }
    """
    When method POST
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
    And match response._id == '#string'
  
  Scenario: Registrar y luego buscar ese mismo usuario
    * def randomId = java.lang.System.currentTimeMillis()
    * def userEmail = 'inetum_' + randomId + '@test.com'

    # 1. CREAR EL USUARIO
    Given path 'usuarios'
    And request { nome: "Test Inetum", email: "#(userEmail)", password: "123", administrador: "true" }
    When method POST
    Then status 201
    # Guardamos el ID que nos dio la API
    * def creadoId = response._id

    # 2. BUSCAR EL USUARIO CREADO POR SU ID
    Given path 'usuarios', creadoId
    When method GET
    Then status 200
    And match response.email == userEmail
    And match response._id == creadoId
  
  Scenario: Actualizar los datos de un usuario existente
    # Primero creamos un usuario para tener un ID real que actualizar
    * def randomId = java.lang.System.currentTimeMillis()
    * def initialEmail = 'update_' + randomId + '@test.com'
    
    Given path 'usuarios'
    And request { nome: "Usuario Original", email: "#(initialEmail)", password: "123", administrador: "true" }
    When method POST
    Then status 201
    * def userId = response._id

    # Ahora actualizamos el nombre de ese usuario
    Given path 'usuarios', userId
    And request 
    """
    {
      "nome": "Usuario Editado Inetum",
      "email": "#(initialEmail)",
      "password": "newpassword123",
      "administrador": "true"
    }
    """
    When method PUT
    Then status 200
    And match response.message == 'Registro alterado com sucesso'

Scenario: Eliminar un usuario del sistema
    # Creamos uno rápido para borrarlo
    * def randomId = java.lang.System.currentTimeMillis()
    * def deleteEmail = 'delete_' + randomId + '@test.com'
    
    Given path 'usuarios'
    And request { nome: "Usuario a Borrar", email: "#(deleteEmail)", password: "123", administrador: "true" }
    When method POST
    * def idToDelete = response._id

    # Ejecutamos la eliminación
    Given path 'usuarios', idToDelete
    When method DELETE
    Then status 200
    And match response.message == 'Registro excluído com sucesso'
    
    # Verificación extra: Intentar buscarlo y confirmar que ya no existe (404)
    Given path 'usuarios', idToDelete
    When method GET
    Then status 400  
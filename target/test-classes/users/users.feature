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
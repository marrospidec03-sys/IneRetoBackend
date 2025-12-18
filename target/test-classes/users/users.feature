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
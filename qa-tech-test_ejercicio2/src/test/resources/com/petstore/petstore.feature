Feature: Pruebas de Petstore API

  Background:
    * url 'https://petstore.swagger.io/v2'

  Scenario: Añadir mascota a la tienda
    * def petId = 12345
    Given path 'pet'
    And request { id: #(petId), name: 'firulais', status: 'available' }
    When method post
    Then status 200
    And match response.name == 'firulais'

  Scenario: Consultar mascota por ID
    * def petId = 12345
    Given path 'pet', petId
    When method get
    Then status 200
    And match response.id == petId

  Scenario: Actualizar nombre y estatus de mascota
    * def petId = 12345
    Given path 'pet'
    And request { id: #(petId), name: 'UpdatedName', status: 'sold' }
    When method put
    Then status 200
    And match response.name == 'UpdatedName'
    And match response.status == 'sold'

  Scenario: Consultar mascota modificada por estatus
    Given path 'pet/findByStatus'
    And param status = 'sold'
    When method get
    Then status 200
    And match response[*].status contains 'sold'


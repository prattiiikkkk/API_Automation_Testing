*** Settings ***
Library    RequestsLibrary
Library    String
Resource    ../variables/test_config.resource
Resource    ../resources/token_creation.resource

*** Test Cases ***
#Cover Create > GET > Update > Partial Update > Delete > Negative TCs | missing token, wrong ID, incorrect body
Case1
    Fetch Token
    
Auth
    &{body}    Create Dictionary    username=admin    password=password123
    ${Auth}    POST    ${Base_URL}auth    expected_status=200    json=${body}
    ${op}    Set Variable    ${Auth.json()}
    ${op}    Convert To String    ${op}
    Should Not Contain    ${op}    Bad credentials
    ${token}    Set Variable    ${Auth.json()}[token]
    Log    ${token}
    
Basic Verification
    ${verification}    GET    ${base_URL}/${booking}    expected_status=200
    ${value}    Set Variable    ${verification.json()}[status]
    ${value1}    Set Variable    ${verification.status()}
    Log    ${value}

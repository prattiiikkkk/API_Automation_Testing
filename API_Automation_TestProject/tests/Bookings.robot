*** Settings ***
Library    RequestsLibrary
Library    String
Resource    ../variables/test_config.resource
Resource    ../resources/creds.resource

*** Test Cases ***
#Cover Create > GET > Update > Partial Update > Delete > Negative TCs | missing token, wrong ID, incorrect body
Basic API Verification
    ${verification}    GET    ${base_URL}/${booking}    expected_status=200
    ${value}    Set Variable    ${verification.json()}
    Log    ${value}

Add New User
    ${token}    Create Token
    &{cookies}    Create Dictionary    token=${token}
    ${user}    POST    ${base_URL}/${booking}    expected_status=200    cookies=${cookies}    json=${BOOKING_DATA}
    ${value}    Set Variable    ${user.json()}
    ${id}    Set Variable    ${user.json()}[bookingid]
    Log    ${value}
    Log    ${id}
    

Auth
    &{body}    Create Dictionary    username=admin    password=password123
    ${Auth}    POST    ${Base_URL}auth    expected_status=200    json=${body}
    ${op}    Set Variable    ${Auth.json()}
    ${op}    Convert To String    ${op}
    Should Not Contain    ${op}    Bad credentials
    ${token}    Set Variable    ${Auth.json()}[token]
    Log    ${token}
    


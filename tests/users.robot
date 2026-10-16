*** Settings ***
Library    RequestsLibrary

*** Variables ***
${Base_URL}    https://jsonplaceholder.typicode.com

*** Test Cases ***
All User Request
    [Tags]    T1-01
    ${response}    GET    ${Base_URL}/users    expected_status=200
    Log    ${response}

Number of User
    [Tags]    T1-02
    ${response}    GET    ${Base_URL}/users    expected_status=200
    ${users}    Set Variable    ${response.json()}
    Length Should Be    ${users}    10
    Log    ${users}
    
Mandatory Fields
    [Tags]    T1-03
    ${response}    GET    ${Base_URL}/users    params=id_ne=0&name_like=.&email_like=@    expected_status=200
    ${users}    Set Variable    ${response.json()}
    Get Length    ${users}
    Log    ${users}

Company Check
    [Tags]    T1-04
    ${response}    GET    ${Base_URL}/users    params=company.name=Romaguera-Crona    expected_status=200
    ${users}    Set Variable    ${response.json()}
    Get Length    ${users}
    Log    ${users}
    

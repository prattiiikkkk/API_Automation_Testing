*** Settings ***
Library    RequestsLibrary

*** Variables ***
${FAST_API}    http://127.0.0.1:8000

*** Test Cases ***
Request All Devices
    [Tags]    T2-01
    ${response}    GET    ${FAST_API}/devices    expected_status=200
    ${devices}    Set Variable    ${response.json()}
    Get Length    ${devices}
    Log    ${devices}

Request Device PART1234
    [Tags]    T2-02
    ${response}    GET    ${FAST_API}/devices    params=device_id=PART1234&status=ACTIVE    expected_status=200
    ${devices}    Set Variable    ${response.json()}
    Length Should Be    ${devices}    1

Request An Unknown Device
    [Tags]    T2-03
    ${response}    GET    ${FAST_API}/devices    params=device_id=PART99   expected_status=404
    ${devices}    Set Variable    ${response.json()}

Add User
    [Tags]    T2-04
    ${dict}    Create Dictionary    device_id=PART111    status=ACTIVE
    ${add}    PUT    ${FAST_API}/devices    json=${dict}    expected_status=200

Delete User
    [Tags]    T2-05
    ${delete}    DELETE    ${FAST_API}/devices/PART111    expected_status=200
    
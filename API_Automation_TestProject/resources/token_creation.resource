*** Settings ***
Resource    ../variables/test_config.resource
Resource    ../data/user_creds.resource
Library    RequestsLibrary

*** Keywords ***
Fetch Token
    ${post}    POST    ${base_URL}/${auth}    expected_status=200    json=${auth_body}
    ${token}    Set Variable    ${post.json()}[token]
    Log    ${token}
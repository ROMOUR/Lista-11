*** Settings ***
Library    RequestsLibrary 

*** Variables ***
${url}    https://petstore.swagger.io/v2/user

${id}    3899963941 
${username}    Rodolfo 
${firstName}    test
${lastName}    Moura
${email}    rodolfo_itg@yahoocom.br
${password}    12345
${phone}    996394136
${userStatus}    1  

*** Test Cases ***

Post User
    ${body}    Create Dictionary    id=${id}    username=${username}    firstName=${firstName}    lastName=${lastName}    
    ...    email=${email}    password=${password}    phone=${phone}    userStatus=${userStatus} 

    ${response}    POST    url=${url}    json=${body}
    
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response.json()}    

    Status Should Be    200
    Should Be Equal    ${response_body}[code]    ${{(200)}}
    Should Be Equal    ${response_body}[type]    unknown
    Should Be Equal    ${response_body}[message]    14170026


Get User
    ${response}    GET    ${{$url + "/" + $username}}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]    ${{int($id)}}
    Should Be Equal    ${response_body}[username]    ${username}
    Should Be Equal    ${response_body}[firstName]    ${firstName}
    Should Be Equal    ${response_body}[lastName]    ${lastName}
    Should Be Equal    ${response_body}[email]    ${email}
    Should Be Equal    ${response_body}[password]    ${password}
    Should Be Equal    ${response_body}[phone]    ${phone}
    Should Be Equal    ${response_body}[userStatus]    ${{int($userStatus)}}


Put User
    ${body}    Evaluate    json.loads(open("./fixtures/json/user.json").read())
    
    ${response}    PUT    ${{$url + "/" + $username}}    json=${body}

    ${response_body}    Set Variable    ${response.json()}

    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]    ${{(200)}}
    Should Be Equal    ${response_body}[type]    unknown
    Should Be Equal    ${response_body}[message]    14170081 

Delete User    
    ${response}    DELETE    ${{$url + "/" + $username}}  

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]    ${{(200)}}
    Should Be Equal    ${response_body}[type]    unknown
    Should Be Equal    ${response_body}[message]    Lola
    
*** Keywords ***
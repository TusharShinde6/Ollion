*** Settings ***
Library  SeleniumLibrary
Library    Collections
Library    XML
Library    Process
Library    String

*** Keywords ***
Handle Cookie Popup
    [Documentation]  Close the cookie popup if it appears.
    Sleep    3S
    ${popup}=    Run Keyword And Return Status    Element Should Be Visible    xpath://*[@id='onetrust-banner-sdk']
    Run Keyword If    ${popup}    Click Button    Necessary cookies only
    Sleep    1 second

Browse Users
    Scroll Element Into View    //a[text()='Questions']
    Wait Until Element Is Visible    //a[text()='Questions']    timeout=5s
    Click Element    //a[text()='Questions']
    Page Should Contain    All Questions
    Click Element    //*[@id='nav-users']
    Page Should Contain    Users
    Sleep    2s

Browse Editors
    Click Element       //a[contains(text(), 'Editors')]
    Sleep    2s

Pagination on second page
    Scroll Element Into View    //a[@title='Go to page 2'][1]
    Wait Until Page Contains Element        //a[@title='Go to page 2'][1]
    Click Element       //a[@title='Go to page 2'][1]
    Sleep    2s

Get Element With Maximum Edits
    [Documentation]  Get user with max edits on the page and return user info.
    ${user_elements}=   SeleniumLibrary.Get Element Count   //div[contains(@class, 'user-info')]
    ${max_user_edit} =    Set Variable    ${EMPTY}

    ${highest_edits_user}=    Set Variable    ${EMPTY}
    ${highest_edit_count}=      Set Variable    -1

    FOR    ${element}    IN RANGE    1      ${user_elements }

        ${username}=    Get Text   (//div[contains(@class, 'user-info')]//*[@class="user-details"]//a)[${element}]
        ${location}=    Get Text    (//div[contains(@class, 'user-info')]//span)[${element}]
        ${edits}=    Get Text    (//div[contains(@class, 'user-info')]//*[@class='user-tags'])[${element}]

        ${split_edits}=     Split String    ${edits}    =
        ${edit_count} =     Get Substring     ${split_edits}[0]     0
        ${edit_count} =     Get Substring      ${edit_count}        0       -6

        Log    User: ${username} | Location: ${location} | Edits: ${edits}
        IF  ${edit_count} > ${highest_edit_count}
             ${highest_edit_count}=      Set Variable  ${edit_count}
             ${highest_edits_user}=      Set Variable    ${username}
             ${highest_edits_location}=      Set Variable    ${location}

        END

    END

    ${result}=      Set Variable   Highest edits user: ${highest_edits_user} with ${highest_edit_count} edits
    ${data_result}=     Set Variable    User: ${highest_edits_user} | Location: ${highest_edits_location} | Edits: ${highest_edit_count}
    Log    ${result}
    Log    ${data_result}






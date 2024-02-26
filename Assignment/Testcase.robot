*** Settings ***
Library  SeleniumLibrary
Resource    ${CURDIR}/../Assignment/Keywords.robot

*** Variables ***
${BROWSER}               Chrome
${STACKOVERFLOW_URL}     https://stackoverflow.com/

*** Test Cases ***
Open Browse StackOverflow
    [Documentation]  Open browser, navigate to StackOverflow.
    Open Browser    ${STACKOVERFLOW_URL}    ${BROWSER}
    Handle Cookie Popup
    Maximize Browser Window

Navigate To Users
    [Documentation]  Navigate to users section.
    Browse Users

Navigate To Editors
    [Documentation]  Navigate to editors section.
    Browse Editors

Get User With Max Edits
    [Documentation]  Get the user with the maximum number of edits on the second page.
    Pagination on second page
    Get Element With Maximum Edits
    Close Browser








*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${url}        https://www.amazon.com.br/
${browser}    chrome

${loc_menu_eletronicos}    //a[@data-csa-c-content-id="nav_cs_electronics"]
${loc_eletronicos}         //span[text() = "Eletrônicos e Tecnologia"]
${loc_campo_pesquisar}     twotabsearchtextbox
${loc_btn_pesquisar}       nav-search-submit-button


*** Keywords ***
Abrir o navegador
    Open Browser               browser=${browser}
    Maximize Browser Window

Fechar o novegador
    Capture Page Screenshot
    Close Browser

Acessar a home page do site Amazon.com.br
    Go To                            url=${url}
    Wait Until Element Is Visible    locator=${loc_menu_eletronicos}

Entrar no menu "Eletrônicos"
    Click Element    locator=${loc_menu_eletronicos}

Verificar se aparece a frase "${texto}"
    Wait Until Page Contains         text=${texto}
    Wait Until Element Is Visible    locator=${loc_eletronicos}

Verificar se o título da página ficar "${titulo_pagina}"
    Title Should Be    title=${titulo_pagina}

Verificar se aparece a categoria "${nome_categorias}"
    Element Should Be Visible    locator=//span[text() = "${nome_categorias}"]

Digitar o nome de produto "${produto}" no campo de pesquisa
    Input Text    locator=${loc_campo_pesquisar}    text=${produto}

Clicar no botão "pesquisar"
    Click Element    locator=${loc_btn_pesquisar}

Verificar o resultado da pesquisa, se está listando o produto "${produto}"
    Wait Until Element Is Visible    locator=//span[text() = "${produto}"]

Adicionar o produto "${produto}" no carrinho
    Click Element    locator=//span[text() = "${produto}"]
    Click Element    locator=submit.add-to-cart

Verificar se o produto "${produto}" foi adicionado com sucesso
    Wait Until Page Contains    text=Adicionado ao carrinho

Remover o produto "${produto}" do carrinho
    Click Element               locator=sw-gtc
    Wait Until Page Contains    text=Carrinho de compras
    Wait Until Page Contains    text=${produto}
    Click Element               locator=(//input[@value='Excluir'])[1]

Verificar se o carrinho fica vazio
    Wait Until Page Contains    text=Seu carrinho de compras da Amazon está vazio.


# Gherking Steps

Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br

Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletrônicos"

Então o título da página deve ficar "${titulo_pagina}"
    Verificar se o título da página ficar "${titulo_pagina}"

E o texto "${texto}" deve ser exibido na página
    Verificar se aparece a frase "${texto}"

E a categoria "${nome_categorias}" deve ser exibida na página
    Verificar se aparece a categoria "${nome_categorias}"

Quando pesquisar pelo produto "${produto}"
    Digitar o nome de produto "${produto}" no campo de pesquisa
    Clicar no botão "pesquisar"

E um produto da linha "Xbox Series S" deve ser mostrado na página
    Verificar o resultado da pesquisa, se está listando o produto "Console Xbox Series S"

Quando adicionar o produto "${produto}" no carrinho
    Quando acessar o menu "Eletrônicos"
    Quando pesquisar pelo produto "${produto}"
    Adicionar o produto "${produto}" no carrinho

Então o produto "${produto}" deve ser mostrado no carrinho
    Verificar se o produto "${produto}" foi adicionado com sucesso

E existe o produto "${produto}" no carrinho
    Quando adicionar o produto "${produto}" no carrinho

Quando remover o produto "Console Xbox Series S" do carrinho
    Remover o produto "Console Xbox Series S" do carrinho

Então o carrinho deve ficar vazio
    Verificar se o carrinho fica vazio
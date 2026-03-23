

# Customer CRUD Flutter Application
A Flutter application developed to manage customer registrations.

<details>
<summary>
<b>🇺🇸 Click here to see the details in English.</b> 
</summary>

## Features

* **CRUD Operations:** Create, Read, Update, and Delete customers. Data is persisted locally using **Hive**, a NoSQL database.

* **Advanced Field Validation:** Custom validations for Name (min 3 characters) and Email (Regex).

* **Custom Input Formatters:** Phone and CEP fields have a formatter responsible for adding special characters (masks).

* **ViaCEP API Integration:** Automatic address fetching when a valid Brazilian ZIP code (CEP) is entered.

* **Smart validation:** The CEP field is optional, but if the user chooses to fill it, it strictly requires 9 characters and must be a valid code found in the API.

* **Real-Time Search (SearchBar):** Dynamic filtering by name in the main list. It's possible to search for clients, with the interface reacting in real time.

* **State Management:** Built using **Riverpod** for reactive and scalable state management across the application.

## How to Run the Project

**Prerequisites:** You need to have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed on your machine.

1. **Clone the repository:**
   ```bash
   git clone <your-repository-url>
   cd crud_customer_flutter
2. **Install dependencies:**
    ```bash
    flutter pub get
3. **Generate Hive Models:**
    ```bash
    dart run build_runner build --delete-conflicting-outputs
4. **Run the app:**
    ```bash
    flutter run
</details>
<br>

# Aplicação CRUD de Clientes em Flutter

Um aplicativo Flutter desenvolvido para gerenciar cadastros de clientes.

<details>
<summary><b>🇧🇷 Clique aqui para ver os detalhes em Português</b></summary>

## Funcionalidades

* **Operações CRUD:** Criar, Ler, Atualizar e Excluir clientes. Os dados são persistidos localmente utilizando o **Hive**, um banco de dados NoSQL.

* **Validação Avançada de Campos:** Validações customizadas para Nome (mínimo de 3 caracteres) e E-mail (Regex).

* **Formatadores de Input Customizados:** Os campos de Telefone e CEP possuem formatadores próprios responsáveis por adicionar caracteres especiais (máscaras).

* **Integração com a API ViaCEP:** Busca automática de endereço quando um CEP brasileiro válido é inserido.

* **Validação Inteligente:** O campo de CEP é opcional, mas se o usuário escolher preenchê-lo, o sistema exige estritamente 9 caracteres e o código deve ser válido e encontrado na API.

* **Busca em Tempo Real (SearchBar):** Filtro dinâmico por nome na lista principal. É possível buscar clientes, com a interface reagindo em tempo real.

* **Gerenciamento de Estado:** Construído utilizando **Riverpod** para um gerenciamento de estado reativo e escalável em todo o aplicativo.

## Como Rodar o Projeto

**Pré-requisitos:** Você precisa ter o [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado na sua máquina.

1. **Clone o repositório:**
   ```bash
   git clone <url-do-seu-repositorio>
   cd crud_customer_flutter
   ```
2. **Instale as dependências:**
   ```bash
   flutter pub get
   ```
3. **Gere os Modelos do Hive:**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
4. **Rode o aplicativo:**
   ```bash
   flutter run
   ```
</details>
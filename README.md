# TaskFlow: A Modern Task Management App

TaskFlow is a full-stack, multi-user task management web application built from the ground up. It features a classic Java (Servlets/JSP) backend and a modern, dynamic JavaScript front-end, inspired by contemporary Kanban-style tools.

Users can register, log in, and manage their own private task lists. The interface features a drag-and-drop board, hover-actions, and a modal pop-up for creating new tasks, all communicating with the server in the background.


---

## 🚀 Key Features

* **Full User Authentication:** Secure registration, login, and logout flow.
* **Session Management:** Pages are protected. Users can only see and manage their own tasks.
* **Full CRUD:** **C**reate, **R**ead, **U**pdate, and **D**elete tasks.
* **Kanban Board:** A three-column layout (To Do, In Progress, Completed) to visualize task status.
* **Drag-and-Drop:** Dynamically update a task's status by dragging its card from one column to another. The change is saved to the database instantly.
* **Dynamic UI:**
    * **Floating Action Button:** A "+" button opens a modal to add new tasks.
    * **Blurred Background:** The main page blurs when the modal is active.
    * **Hover Actions:** Edit and Delete buttons appear on hover, matching modern UI patterns.
    * **Colored Cards:** Tasks have a colored border based on their status.
* **Modern Layout:** A clean, responsive design with a fixed sidebar and main content area, built with Bootstrap.

## 🛠️ Technology Stack

| Area | Technology |
| :--- | :--- |
| **Backend** | Java (JDK 21+), Servlets (Jakarta EE 10+), JDBC |
| **Database** | MySQL 8 |
| **Server** | Apache Tomcat 11 |
| **Build Tool** | Apache Maven |
| **Frontend** | JSP (JavaServer Pages), HTML5, CSS3, JavaScript (ES6+) |
| **UI/UX** | Bootstrap 5, Bootstrap Icons, Sortable.js (for drag-and-drop) |

---

## ⚙️ Setup and Installation

Follow these steps to run the project on your local machine (instructions are for macOS with Homebrew).

### 1. Prerequisites

* Git
* Homebrew
* Java (JDK 17 or higher)
* Apache Tomcat 11
* VS Code (or any Java IDE)

### 2. Install Dependencies

Install Maven (for building) and MySQL (for the database) via Homebrew.

```bash
brew install maven
brew install mysql
Here is the full text for your README.md file.

You can copy everything inside the box below and paste it into a new file named README.md in your project's root folder.

Markdown
# TaskFlow: A Modern Task Management App

TaskFlow is a full-stack, multi-user task management web application built from the ground up. It features a classic Java (Servlets/JSP) backend and a modern, dynamic JavaScript front-end, inspired by contemporary Kanban-style tools.

Users can register, log in, and manage their own private task lists. The interface features a drag-and-drop board, hover-actions, and a modal pop-up for creating new tasks, all communicating with the server in the background.

![TaskFlow App Screenshot](Screenshot%202025-11-10%20at%207.03.03%E2%80%AFPM.png)

---

## 🚀 Key Features

* **Full User Authentication:** Secure registration, login, and logout flow.
* **Session Management:** Pages are protected. Users can only see and manage their own tasks.
* **Full CRUD:** **C**reate, **R**ead, **U**pdate, and **D**elete tasks.
* **Kanban Board:** A three-column layout (To Do, In Progress, Completed) to visualize task status.
* **Drag-and-Drop:** Dynamically update a task's status by dragging its card from one column to another. The change is saved to the database instantly.
* **Dynamic UI:**
    * **Floating Action Button:** A "+" button opens a modal to add new tasks.
    * **Blurred Background:** The main page blurs when the modal is active.
    * **Hover Actions:** Edit and Delete buttons appear on hover, matching modern UI patterns.
    * **Colored Cards:** Tasks have a colored border based on their status.
* **Modern Layout:** A clean, responsive design with a fixed sidebar and main content area, built with Bootstrap.

## 🛠️ Technology Stack

| Area | Technology |
| :--- | :--- |
| **Backend** | Java (JDK 21+), Servlets (Jakarta EE 10+), JDBC |
| **Database** | MySQL 8 |
| **Server** | Apache Tomcat 11 |
| **Build Tool** | Apache Maven |
| **Frontend** | JSP (JavaServer Pages), HTML5, CSS3, JavaScript (ES6+) |
| **UI/UX** | Bootstrap 5, Bootstrap Icons, Sortable.js (for drag-and-drop) |

---

## ⚙️ Setup and Installation

Follow these steps to run the project on your local machine (instructions are for macOS with Homebrew).

### 1. Prerequisites

* Git
* Homebrew
* Java (JDK 17 or higher)
* Apache Tomcat 11
* VS Code (or any Java IDE)

### 2. Install Dependencies

Install Maven (for building) and MySQL (for the database) via Homebrew.

```bash
brew install maven
brew install mysql
3. Set Up the Database

Start the MySQL service:

Bash
brew services start mysql
Run the secure installation to set your root password:

Bash
mysql_secure_installation
Log in to MySQL and create the database and tables:

Bash
mysql -u root -p
Paste the following SQL commands:

SQL
-- Create the database
CREATE DATABASE task_db;

-- Use the database
USE task_db;

-- Create the users table
CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

-- Create the tasks table
CREATE TABLE tasks (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(50) NOT NULL,
    due_date DATE,
    user_id INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id)
);
4. Configure the Project (CRITICAL)

Clone this repository to your local machine.

Open the project in VS Code.

Navigate to src/main/java/com/taskmanager/util/DBUtil.java.

Find the PASS variable and update it with your MySQL root password.

Java
// Enter the username and password you set up
private static final String USER = "root"; 
private static final String PASS = "YOUR_MYSQL_PASSWORD"; // 👈 REPLACE THIS
5. Build the Project

Run the Maven package command from your terminal or using the VS Code Maven extension. This creates the .war file.

Bash
mvn clean package
This will create a taskmanager.war file inside a new target/ directory.

6. Deploy to Tomcat (Manual Clean Deploy)

This is the most reliable way to deploy:

Stop your Tomcat server.

Go to your Tomcat installation folder (e.g., ~/apache-tomcat-11.0.13/).

Open the webapps folder.

Delete any old taskmanager.war or taskmanager/ folder.

Go to your project's target folder and copy the new taskmanager.war.

Paste the .war file into Tomcat's webapps folder.

Start your Tomcat server.

7. Run the Application

Your application is now running. Open your browser and go to:

http://localhost:8080/taskmanager/

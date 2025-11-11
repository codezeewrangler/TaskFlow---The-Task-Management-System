<div align="center">

# 🎯 TaskFlow - The Task Management System

### A Modern, Full-Stack Task Management Application

[![Java](https://img.shields.io/badge/Java-21-orange.svg)](https://www.oracle.com/java/)
[![Maven](https://img.shields.io/badge/Maven-3.8+-blue.svg)](https://maven.apache.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-blue.svg)](https://www.mysql.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

[Features](#-key-features) • [Tech Stack](#️-technology-stack) • [Installation](#-installation) • [Usage](#-usage) • [API](#-api-endpoints) • [Contributing](#-contributing)

</div>

---

## 📖 Table of Contents

- [About](#-about)
- [Key Features](#-key-features)
- [Technology Stack](#️-technology-stack)
- [Architecture](#-architecture)
- [Installation](#-installation)
  - [Prerequisites](#prerequisites)
  - [Database Setup](#database-setup)
  - [Application Configuration](#application-configuration)
  - [Building and Deployment](#building-and-deployment)
- [Usage](#-usage)
- [API Endpoints](#-api-endpoints)
- [Project Structure](#-project-structure)
- [Configuration](#️-configuration)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [Security](#-security)
- [License](#-license)
- [Contact](#-contact)

---

## 🚀 About

**TaskFlow** is a comprehensive, full-stack web application for task management built with enterprise-grade Java technologies. Inspired by modern Kanban-style tools like Trello and Asana, TaskFlow combines a robust Java backend (Servlets/JSP) with a sleek, interactive JavaScript frontend.

Perfect for individuals and teams looking to organize their work efficiently, TaskFlow provides a seamless experience for creating, tracking, and completing tasks with an intuitive drag-and-drop interface.

### 🎥 Demo

> **Note:** This application demonstrates core concepts of:
> - Multi-tier architecture (MVC pattern)
> - RESTful servlet-based APIs
> - Session-based authentication
> - Dynamic UI with vanilla JavaScript
> - Database persistence with JDBC

---

## ✨ Key Features

### 🔐 **Authentication & Security**
- **User Registration & Login:** Secure account creation with password hashing
- **Session Management:** Protected routes ensuring users can only access their own data
- **Auto-logout:** Automatic session timeout for enhanced security

### 📋 **Task Management**
- **Full CRUD Operations:** Create, Read, Update, and Delete tasks with ease
- **Task Properties:** Title, description, status, due date, and user assignment
- **Status Tracking:** Three-column Kanban board (To Do, In Progress, Completed)
- **Due Date Management:** Track deadlines and prioritize work

### 🎨 **Modern User Interface**
- **Drag-and-Drop Functionality:** Instantly update task status by dragging cards between columns
- **Floating Action Button:** Quick task creation with a modal overlay
- **Hover Actions:** Edit and delete buttons appear on card hover for streamlined workflow
- **Visual Feedback:** Color-coded task cards based on status
- **Blur Effect:** Background blur when modal is active for better focus
- **Responsive Design:** Works seamlessly on desktop and tablet devices

### 🏗️ **Technical Excellence**
- **MVC Architecture:** Clean separation of concerns
- **Database Persistence:** All data stored securely in MySQL
- **AJAX Operations:** Asynchronous updates without page reloads
- **Real-time Updates:** Changes reflected immediately in the UI
- **Bootstrap 5:** Professional, consistent styling

---

## 🛠️ Technology Stack

<table>
<tr>
<td><strong>Category</strong></td>
<td><strong>Technology</strong></td>
<td><strong>Version</strong></td>
<td><strong>Purpose</strong></td>
</tr>
<tr>
<td><strong>Backend</strong></td>
<td>Java (JDK)</td>
<td>21+</td>
<td>Core application logic</td>
</tr>
<tr>
<td></td>
<td>Jakarta Servlets</td>
<td>6.0.0</td>
<td>HTTP request handling</td>
</tr>
<tr>
<td></td>
<td>Jakarta JSP</td>
<td>3.1.1</td>
<td>Dynamic page generation</td>
</tr>
<tr>
<td></td>
<td>JDBC</td>
<td>-</td>
<td>Database connectivity</td>
</tr>
<tr>
<td><strong>Database</strong></td>
<td>MySQL</td>
<td>8.0+</td>
<td>Data persistence</td>
</tr>
<tr>
<td></td>
<td>MySQL Connector/J</td>
<td>8.4.0</td>
<td>MySQL driver</td>
</tr>
<tr>
<td><strong>Server</strong></td>
<td>Apache Tomcat</td>
<td>11.0+</td>
<td>Servlet container</td>
</tr>
<tr>
<td><strong>Build Tool</strong></td>
<td>Apache Maven</td>
<td>3.8+</td>
<td>Dependency management & build</td>
</tr>
<tr>
<td><strong>Frontend</strong></td>
<td>HTML5/CSS3/JavaScript</td>
<td>ES6+</td>
<td>User interface</td>
</tr>
<tr>
<td></td>
<td>Bootstrap</td>
<td>5.3.3</td>
<td>UI framework</td>
</tr>
<tr>
<td></td>
<td>Bootstrap Icons</td>
<td>1.11.3</td>
<td>Icon library</td>
</tr>
<tr>
<td></td>
<td>Sortable.js</td>
<td>Latest</td>
<td>Drag-and-drop functionality</td>
</tr>
</table>

---

## 🏛️ Architecture

TaskFlow follows the **MVC (Model-View-Controller)** design pattern:

```
┌─────────────────────────────────────────────────────────┐
│                      Presentation Layer                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐ │
│  │   JSP Views  │  │  CSS Styles  │  │  JavaScript  │ │
│  └──────────────┘  └──────────────┘  └──────────────┘ │
└─────────────────────────────────────────────────────────┘
                            ▼
┌─────────────────────────────────────────────────────────┐
│                     Controller Layer                     │
│  ┌──────────────────────────────────────────────────┐  │
│  │  Servlets (TaskController, LoginServlet, etc.)  │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                            ▼
┌─────────────────────────────────────────────────────────┐
│                      Business Layer                      │
│  ┌──────────────┐           ┌──────────────┐          │
│  │  Task Model  │           │  User Model  │          │
│  └──────────────┘           └──────────────┘          │
└─────────────────────────────────────────────────────────┘
                            ▼
┌─────────────────────────────────────────────────────────┐
│                     Data Access Layer                    │
│  ┌──────────────┐           ┌──────────────┐          │
│  │   TaskDAO    │           │   UserDAO    │          │
│  └──────────────┘           └──────────────┘          │
└─────────────────────────────────────────────────────────┘
                            ▼
┌─────────────────────────────────────────────────────────┐
│                       Database Layer                     │
│              MySQL (tasks & users tables)               │
└─────────────────────────────────────────────────────────┘
```

**Key Components:**
- **Models:** `Task.java`, `User.java` - Data objects
- **DAOs:** `TaskDAO.java`, `UserDAO.java` - Database operations
- **Controllers:** Servlets handling HTTP requests
- **Views:** JSP pages for dynamic content rendering
- **Utilities:** `DBUtil.java` - Database connection management

---

## 📦 Installation

### Prerequisites

Before you begin, ensure you have the following installed:

| Software | Minimum Version | Download Link |
|----------|----------------|---------------|
| **Java JDK** | 21+ | [Oracle JDK](https://www.oracle.com/java/technologies/downloads/) or [OpenJDK](https://openjdk.org/) |
| **Apache Maven** | 3.8+ | [Maven Download](https://maven.apache.org/download.cgi) |
| **MySQL** | 8.0+ | [MySQL Download](https://dev.mysql.com/downloads/mysql/) |
| **Apache Tomcat** | 11.0+ | [Tomcat Download](https://tomcat.apache.org/download-11.cgi) |
| **Git** | Latest | [Git Download](https://git-scm.com/downloads) |

**Optional:**
- IDE (IntelliJ IDEA, Eclipse, VS Code with Java extensions)

---

### Database Setup

#### 1. Install and Start MySQL

**macOS (with Homebrew):**
```bash
# Install MySQL
brew install mysql

# Start MySQL service
brew services start mysql

# Secure installation (set root password)
mysql_secure_installation
```

**Linux (Ubuntu/Debian):**
```bash
# Install MySQL
sudo apt update
sudo apt install mysql-server

# Start MySQL service
sudo systemctl start mysql
sudo systemctl enable mysql

# Secure installation
sudo mysql_secure_installation
```

**Windows:**
- Download and run the MySQL Installer from [MySQL Downloads](https://dev.mysql.com/downloads/installer/)
- Follow the installation wizard
- Set a root password when prompted

#### 2. Create Database and Tables

Log in to MySQL:
```bash
mysql -u root -p
```

Execute the following SQL commands:
```sql
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
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Verify tables were created
SHOW TABLES;

-- Exit MySQL
EXIT;
```

---

### Application Configuration

#### 1. Clone the Repository

```bash
git clone https://github.com/codezeewrangler/TaskFlow---The-Task-Management-System.git
cd TaskFlow---The-Task-Management-System/taskmanager
```

#### 2. Configure Database Connection

**⚠️ CRITICAL:** Update the database credentials in the project.

Navigate to:
```
taskmanager/src/main/java/com/taskmanager/util/DBUtil.java
```

Update the following constants with your MySQL credentials:
```java
private static final String URL = "jdbc:mysql://localhost:3306/task_db";
private static final String USER = "root";
private static final String PASS = "YOUR_MYSQL_PASSWORD"; // 👈 REPLACE THIS
```

> **Security Note:** Never commit database passwords to version control. Consider using environment variables for production deployments.

---

### Building and Deployment

#### 1. Build the Project

From the `taskmanager` directory:
```bash
# Clean and build the project
mvn clean package

# This creates: target/taskmanager.war
```

**Expected output:**
```
[INFO] BUILD SUCCESS
[INFO] Total time: XX.XXX s
[INFO] Finished at: YYYY-MM-DDTHH:MM:SS
```

#### 2. Deploy to Tomcat

**Method 1: Manual Deployment (Recommended for Development)**

1. **Stop Tomcat** (if running)
   ```bash
   # Navigate to Tomcat bin directory
   cd /path/to/apache-tomcat-11.0.x/bin
   
   # Stop Tomcat
   ./shutdown.sh  # Linux/Mac
   shutdown.bat   # Windows
   ```

2. **Clean previous deployment**
   ```bash
   # Navigate to Tomcat webapps directory
   cd /path/to/apache-tomcat-11.0.x/webapps
   
   # Remove old deployment
   rm -rf taskmanager taskmanager.war
   ```

3. **Copy new WAR file**
   ```bash
   # Copy the new WAR file
   cp /path/to/project/taskmanager/target/taskmanager.war .
   ```

4. **Start Tomcat**
   ```bash
   # Navigate to Tomcat bin directory
   cd /path/to/apache-tomcat-11.0.x/bin
   
   # Start Tomcat
   ./startup.sh  # Linux/Mac
   startup.bat   # Windows
   ```

**Method 2: Tomcat Manager (Web Interface)**

1. Access Tomcat Manager: `http://localhost:8080/manager/html`
2. Scroll to "WAR file to deploy"
3. Choose the `taskmanager.war` file
4. Click "Deploy"

#### 3. Verify Deployment

Check Tomcat logs:
```bash
tail -f /path/to/apache-tomcat-11.0.x/logs/catalina.out
```

Look for messages indicating successful deployment.

---

## 🎯 Usage

### Accessing the Application

Once deployed, open your web browser and navigate to:
```
http://localhost:8080/taskmanager/
```

### Getting Started

#### 1. **Register a New Account**
- Click on "Register" or navigate to `/register.jsp`
- Enter a unique username and password
- Submit the form

#### 2. **Login**
- Use your credentials to log in
- You'll be redirected to the main dashboard

#### 3. **Create Your First Task**
- Click the **+** (Floating Action Button) in the bottom-right corner
- Fill in task details:
  - **Title:** Brief description of the task
  - **Description:** Additional details (optional)
  - **Status:** To Do, In Progress, or Completed
  - **Due Date:** Target completion date (optional)
- Click "Save"

#### 4. **Manage Tasks**
- **View:** Tasks are displayed in three columns based on status
- **Edit:** Hover over a task and click the edit icon
- **Delete:** Hover over a task and click the delete icon
- **Change Status:** Drag and drop tasks between columns

#### 5. **Logout**
- Click the logout button in the sidebar to end your session

---

## 🔌 API Endpoints

TaskFlow uses servlet-based endpoints for handling requests:

### Authentication Endpoints

| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| `GET` | `/register.jsp` | Registration page | - |
| `POST` | `/register` | Create new user | `username`, `password` |
| `GET` | `/login.jsp` | Login page | - |
| `POST` | `/login` | Authenticate user | `username`, `password` |
| `GET` | `/logout` | End session | - |

### Task Management Endpoints

| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| `GET` | `/tasks` | List all user tasks | - |
| `POST` | `/tasks` | Create new task | `title`, `description`, `status`, `dueDate` |
| `GET` | `/tasks?action=edit&id={id}` | Get task details | `id` |
| `POST` | `/tasks?action=update` | Update task | `id`, `title`, `description`, `status`, `dueDate` |
| `POST` | `/tasks?action=delete` | Delete task | `id` |
| `POST` | `/tasks?action=updateStatus` | Update task status (drag-drop) | `id`, `status` |

### Response Formats

**Success Response:**
```json
{
  "status": "success",
  "message": "Task created successfully",
  "taskId": 123
}
```

**Error Response:**
```json
{
  "status": "error",
  "message": "Invalid task ID"
}
```

---

## 📁 Project Structure

```
TaskFlow/
├── README.md                          # This file
├── taskmanager/                       # Main application directory
│   ├── pom.xml                        # Maven configuration
│   ├── CONTRIBUTING.md                # Contribution guidelines
│   ├── SECURITY.md                    # Security policy
│   ├── .gitignore                     # Git ignore rules
│   └── src/
│       └── main/
│           ├── java/
│           │   └── com/
│           │       └── taskmanager/
│           │           ├── controller/          # Servlet controllers
│           │           │   ├── LoginServlet.java
│           │           │   ├── RegisterServlet.java
│           │           │   ├── LogoutServlet.java
│           │           │   └── TaskController.java
│           │           ├── dao/                 # Data Access Objects
│           │           │   ├── UserDAO.java
│           │           │   └── TaskDAO.java
│           │           ├── model/               # Domain models
│           │           │   ├── User.java
│           │           │   └── Task.java
│           │           └── util/                # Utility classes
│           │               └── DBUtil.java      # Database connection
│           └── webapp/
│               ├── WEB-INF/
│               │   └── web.xml                  # Deployment descriptor
│               ├── index.jsp                    # Main dashboard
│               ├── login.jsp                    # Login page
│               ├── register.jsp                 # Registration page
│               └── edit-task-form.jsp           # Task edit form
└── target/                            # Build output (generated)
    └── taskmanager.war                # Deployable WAR file
```

### Key Files Description

- **`pom.xml`**: Maven project configuration with dependencies
- **`web.xml`**: Servlet mappings and application configuration
- **`DBUtil.java`**: Database connection pool management
- **`*DAO.java`**: Database operations for respective entities
- **`*Servlet.java`**: HTTP request handlers (controllers)
- **`*.jsp`**: JavaServer Pages (views)

---

## ⚙️ Configuration

### Environment Variables (Production)

For production deployments, use environment variables instead of hardcoding credentials:

```java
// DBUtil.java
private static final String URL = System.getenv("DB_URL");
private static final String USER = System.getenv("DB_USER");
private static final String PASS = System.getenv("DB_PASSWORD");
```

Set environment variables:
```bash
export DB_URL="jdbc:mysql://localhost:3306/task_db"
export DB_USER="root"
export DB_PASSWORD="your_password"
```

### Tomcat Configuration

#### Session Timeout

Edit `web.xml` to adjust session timeout:
```xml
<session-config>
    <session-timeout>30</session-timeout> <!-- minutes -->
</session-config>
```

#### Memory Settings

For large-scale deployments, adjust Tomcat JVM settings in `catalina.sh` (or `catalina.bat`):
```bash
export CATALINA_OPTS="$CATALINA_OPTS -Xms512m -Xmx1024m"
```

---

## 🔧 Troubleshooting

### Common Issues and Solutions

#### Issue 1: "Cannot connect to database"
**Symptoms:** Application fails to start, connection errors in logs

**Solutions:**
1. Verify MySQL is running:
   ```bash
   # macOS/Linux
   brew services list  # or: systemctl status mysql
   
   # Windows
   # Check Services app for MySQL
   ```

2. Check database credentials in `DBUtil.java`
3. Ensure `task_db` database exists:
   ```bash
   mysql -u root -p -e "SHOW DATABASES;"
   ```

4. Verify MySQL is listening on port 3306:
   ```bash
   netstat -an | grep 3306
   ```

#### Issue 2: "404 Not Found" after deployment
**Symptoms:** Tomcat running, but application not accessible

**Solutions:**
1. Check Tomcat logs for deployment errors:
   ```bash
   tail -f $TOMCAT_HOME/logs/catalina.out
   ```

2. Verify WAR file was deployed correctly:
   ```bash
   ls -l $TOMCAT_HOME/webapps/taskmanager.war
   ```

3. Ensure Tomcat fully extracted the WAR:
   ```bash
   ls -l $TOMCAT_HOME/webapps/taskmanager/
   ```

4. Clear browser cache and try again

#### Issue 3: "Session expired" or immediate logout
**Symptoms:** User gets logged out unexpectedly

**Solutions:**
1. Check session timeout in `web.xml` (increase if too short)
2. Ensure cookies are enabled in browser
3. Verify session management code in servlets

#### Issue 4: Maven build fails
**Symptoms:** `mvn clean package` returns errors

**Solutions:**
1. Verify Java version:
   ```bash
   java -version  # Should be 21 or higher
   ```

2. Clean Maven cache:
   ```bash
   mvn clean
   rm -rf ~/.m2/repository
   mvn package
   ```

3. Check for missing dependencies:
   ```bash
   mvn dependency:tree
   ```

#### Issue 5: Drag-and-drop not working
**Symptoms:** Cannot move tasks between columns

**Solutions:**
1. Check browser console for JavaScript errors
2. Verify Sortable.js is loaded correctly
3. Ensure JavaScript is enabled in browser
4. Check network tab for failed AJAX requests

### Getting Help

If you encounter issues not listed here:
1. Check the [Issues](https://github.com/codezeewrangler/TaskFlow---The-Task-Management-System/issues) page
2. Review Tomcat logs in `$TOMCAT_HOME/logs/`
3. Enable debug logging in `web.xml`
4. Create a new issue with:
   - Detailed error description
   - Steps to reproduce
   - Environment details (OS, Java version, etc.)
   - Relevant log excerpts

---

## 🤝 Contributing

We welcome contributions from the community! Whether it's bug fixes, new features, documentation improvements, or suggestions, your input is valuable.

### How to Contribute

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. **Make your changes**
4. **Test thoroughly**
   ```bash
   mvn clean package
   # Deploy and test manually
   ```
5. **Commit your changes**
   ```bash
   git commit -m "Add some AmazingFeature"
   ```
6. **Push to your fork**
   ```bash
   git push origin feature/AmazingFeature
   ```
7. **Open a Pull Request**

### Contribution Guidelines

Please read [CONTRIBUTING.md](taskmanager/CONTRIBUTING.md) for:
- Code style guidelines
- Commit message conventions
- PR submission process
- Code review process

### Development Setup

For contributors, additional setup:
```bash
# Run with Maven Tomcat plugin (development mode)
cd taskmanager
mvn tomcat7:run

# Access at http://localhost:8080/taskmanager
```

---

## 🔒 Security

Security is a top priority for TaskFlow. Please read our [SECURITY.md](taskmanager/SECURITY.md) for:
- Reporting vulnerabilities
- Security best practices
- Authentication implementation details

### Key Security Features
- ✅ Password hashing (recommended to use BCrypt)
- ✅ Session-based authentication
- ✅ SQL injection prevention (PreparedStatements)
- ✅ XSS protection in JSP
- ✅ Protected routes (session validation)

### Important Notes
- **Never commit passwords** or sensitive data to the repository
- Use environment variables for production credentials
- Regularly update dependencies for security patches
- Enable HTTPS in production environments

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

### MIT License Summary
- ✅ Commercial use
- ✅ Modification
- ✅ Distribution
- ✅ Private use

---

## 📞 Contact

**Project Maintainer:** [codezeewrangler](https://github.com/codezeewrangler)

**Repository:** [TaskFlow - The Task Management System](https://github.com/codezeewrangler/TaskFlow---The-Task-Management-System)

### Support Channels
- 🐛 **Bug Reports:** [GitHub Issues](https://github.com/codezeewrangler/TaskFlow---The-Task-Management-System/issues)
- 💡 **Feature Requests:** [GitHub Discussions](https://github.com/codezeewrangler/TaskFlow---The-Task-Management-System/discussions)
- 📧 **Email:** Create an issue for direct contact

---

## 🙏 Acknowledgments

- **Bootstrap Team** for the excellent UI framework
- **Apache Software Foundation** for Tomcat and Maven
- **MySQL** for the robust database system
- **SortableJS** for drag-and-drop functionality
- All contributors who have helped improve this project

---

## 🗺️ Roadmap

Future enhancements planned:

- [ ] **Task Categories/Tags** - Organize tasks by category
- [ ] **Task Priority Levels** - High, Medium, Low priority indicators
- [ ] **Search and Filter** - Find tasks quickly
- [ ] **User Profile Management** - Update profile, change password
- [ ] **Email Notifications** - Reminders for due dates
- [ ] **Collaborative Features** - Share tasks with other users
- [ ] **Mobile Responsive Improvements** - Better mobile experience
- [ ] **Dark Mode** - Theme switching
- [ ] **REST API** - JSON-based API for external integrations
- [ ] **Docker Support** - Containerized deployment
- [ ] **CI/CD Pipeline** - Automated testing and deployment

---

<div align="center">

### ⭐ If you find this project useful, please consider giving it a star!

**Built with ❤️ using Java, MySQL, and modern web technologies**

[Back to Top](#-taskflow---the-task-management-system)

</div>

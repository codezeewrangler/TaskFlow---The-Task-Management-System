# TaskFlow

A modern Java Servlet + JSP task manager application with a Kanban-style board.

![Java](https://img.shields.io/badge/Java-21-blue)
![Tomcat](https://img.shields.io/badge/Tomcat-11-green)
![License](https://img.shields.io/badge/License-MIT-yellow)

## Features

- 📋 **Kanban Board** - Drag-and-drop tasks between columns (To Do, In Progress, Completed)
- 🔐 **Secure Authentication** - BCrypt password hashing, CSRF protection
- 🛡️ **Security Headers** - XSS protection, Content Security Policy, Clickjacking prevention
- 📱 **Responsive Design** - Works on desktop and mobile devices
- 🗄️ **Multi-Database Support** - MySQL (local dev) and PostgreSQL (production)

## Tech Stack

- **Backend**: Java 21, Jakarta Servlet 6.0, JSP
- **Frontend**: Bootstrap 5, Sortable.js
- **Database**: MySQL / PostgreSQL
- **Server**: Apache Tomcat 11
- **Security**: BCrypt, CSRF tokens, Security headers

---

## Local Development

### Prerequisites

- Java 21+
- Maven 3.9+
- MySQL 8.0+ (or PostgreSQL 15+)

### Database Setup

1. Create a MySQL database:
   ```sql
   CREATE DATABASE task_db;
   ```

2. Create the tables:
   ```sql
   CREATE TABLE users (
       id INT AUTO_INCREMENT PRIMARY KEY,
       username VARCHAR(50) NOT NULL UNIQUE,
       password VARCHAR(255) NOT NULL
   );

   CREATE TABLE tasks (
       id INT AUTO_INCREMENT PRIMARY KEY,
       title VARCHAR(200) NOT NULL,
       description TEXT,
       status VARCHAR(20) DEFAULT 'Pending',
       due_date DATE NOT NULL,
       user_id INT NOT NULL,
       FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
   );
   ```

### Configuration

1. Copy the example properties file:
   ```bash
   cp src/main/resources/application.properties.example src/main/resources/application.properties
   ```

2. Edit with your database credentials:
   ```properties
   jdbc.driver=com.mysql.cj.jdbc.Driver
   jdbc.url=jdbc:mysql://localhost:3306/task_db?useSSL=false&serverTimezone=UTC
   jdbc.user=your_username
   jdbc.password=your_password
   ```

### Build & Run

```bash
# Build the WAR file
mvn clean package

# Deploy to Tomcat
cp target/taskmanager.war /path/to/tomcat/webapps/

# Or run with Docker
docker build -t taskflow .
docker run -p 8080:8080 \
  -e DATABASE_URL="mysql://user:pass@host:3306/task_db" \
  taskflow
```

Access the app at: http://localhost:8080/taskmanager

---

## 🚀 Deploy to Render

### Option 1: Blueprint (Recommended)

1. Fork this repository to your GitHub account

2. Go to [Render Dashboard](https://dashboard.render.com/)

3. Click **New** → **Blueprint**

4. Connect your GitHub account and select your fork

5. Render will automatically:
   - Create a PostgreSQL database
   - Build and deploy the Docker container
   - Inject the `DATABASE_URL` environment variable

### Option 2: Manual Setup

1. **Create PostgreSQL Database**
   - Go to Render Dashboard → **New** → **PostgreSQL**
   - Choose the **Free** plan
   - Copy the **External Database URL**

2. **Initialize Database Schema**
   - Connect to the database using the external URL
   - Run the schema from `schema-postgres.sql`:
     ```bash
     psql "your-external-database-url" -f schema-postgres.sql
     ```

3. **Create Web Service**
   - Go to Render Dashboard → **New** → **Web Service**
   - Connect your GitHub repository
   - Configure:
     - **Environment**: Docker
     - **Plan**: Free
   - Add environment variable:
     - `DATABASE_URL` = (copy Internal Database URL from PostgreSQL service)

4. Click **Create Web Service** and wait for deployment

### Accessing Your App

Once deployed, your app will be available at:
```
https://taskflow-xxxx.onrender.com
```

> ⚠️ **Note**: Free tier services spin down after 15 minutes of inactivity. First request after inactivity may take 30-60 seconds.

---

## Security Notes

- ✅ Passwords are hashed using BCrypt (cost factor 12)
- ✅ CSRF tokens protect all form submissions
- ✅ XSS protection via JSTL output escaping and CSP headers
- ✅ Security headers (X-Frame-Options, X-Content-Type-Options)
- ✅ Session fixation prevention on login
- ⚠️ `application.properties` is gitignored - never commit credentials

---

## Project Structure

```
taskmanager/
├── src/main/
│   ├── java/com/taskmanager/
│   │   ├── controller/     # Servlets (LoginServlet, TaskController, etc.)
│   │   ├── dao/            # Data Access Objects
│   │   ├── filter/         # Security filters
│   │   ├── model/          # Entity classes (User, Task)
│   │   └── util/           # Utilities (DBUtil, PasswordUtil, CSRFUtil)
│   ├── resources/
│   │   └── application.properties.example
│   └── webapp/
│       ├── WEB-INF/web.xml
│       ├── index.jsp       # Main dashboard
│       ├── login.jsp       # Login page
│       ├── register.jsp    # Registration page
│       └── edit-task-form.jsp
├── Dockerfile              # Docker build configuration
├── render.yaml             # Render Blueprint
├── schema-postgres.sql     # PostgreSQL schema
└── pom.xml                 # Maven configuration
```

---

## Troubleshooting

### Database Connection Issues

1. Check logs for connection errors:
   ```bash
   docker logs <container-id>
   # or on Render: check the Logs tab
   ```

2. Verify `DATABASE_URL` is set correctly

3. For local MySQL, ensure the server is running:
   ```bash
   mysql.server start  # macOS
   sudo systemctl start mysql  # Linux
   ```

### Build Failures

```bash
# Clean and rebuild
mvn clean package -DskipTests

# Check Java version
java -version  # Should be 21+
```

### Session/CSRF Errors

- Clear browser cookies and try again
- Check that the session is being maintained (cookies enabled)

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## Security

See [SECURITY.md](SECURITY.md) for reporting vulnerabilities.

## License

This project is open source. See LICENSE for details.
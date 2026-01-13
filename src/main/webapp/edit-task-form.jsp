<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.taskmanager.model.Task" %>
        <%@ page import="com.taskmanager.model.User" %>
            <%@ page import="com.taskmanager.util.CSRFUtil" %>
                <%@ taglib prefix="c" uri="jakarta.tags.core" %>
                    <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
                        <% User loggedInUser=(User) session.getAttribute("loggedInUser"); if (loggedInUser==null) {
                            response.sendRedirect("login.jsp"); return; } Task existingTask=(Task)
                            request.getAttribute("taskToEdit"); if (existingTask==null) {
                            response.sendRedirect("TaskController"); return; } String
                            csrfToken=CSRFUtil.getToken(session); %>
                            <!DOCTYPE html>
                            <html lang="en">

                            <head>
                                <meta charset="UTF-8">
                                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                <title>Edit Task - TaskFlow</title>
                                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
                                    rel="stylesheet">
                                <link
                                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
                                    rel="stylesheet">
                                <link
                                    href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                                    rel="stylesheet">
                                <style>
                                    :root {
                                        --primary-gradient: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
                                    }

                                    * {
                                        margin: 0;
                                        padding: 0;
                                        box-sizing: border-box;
                                    }

                                    body {
                                        font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
                                        min-height: 100vh;
                                        display: flex;
                                        align-items: center;
                                        justify-content: center;
                                        padding: 20px;
                                        background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
                                    }

                                    .edit-container {
                                        background: rgba(255, 255, 255, 0.9);
                                        backdrop-filter: blur(20px);
                                        border-radius: 20px;
                                        box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
                                        padding: 40px;
                                        width: 100%;
                                        max-width: 520px;
                                        animation: slideUp 0.5s cubic-bezier(0.16, 1, 0.3, 1);
                                    }

                                    @keyframes slideUp {
                                        from {
                                            opacity: 0;
                                            transform: translateY(20px);
                                        }

                                        to {
                                            opacity: 1;
                                            transform: translateY(0);
                                        }
                                    }

                                    .header {
                                        display: flex;
                                        align-items: center;
                                        gap: 16px;
                                        margin-bottom: 32px;
                                    }

                                    .header-icon {
                                        width: 56px;
                                        height: 56px;
                                        background: var(--primary-gradient);
                                        border-radius: 16px;
                                        display: flex;
                                        align-items: center;
                                        justify-content: center;
                                        box-shadow: 0 10px 15px -3px rgba(37, 99, 235, 0.3);
                                    }

                                    .header-icon i {
                                        font-size: 28px;
                                        color: white;
                                    }

                                    .header h1 {
                                        font-size: 24px;
                                        color: #1e293b;
                                        font-weight: 700;
                                        margin: 0;
                                    }

                                    .header p {
                                        color: #64748b;
                                        margin: 4px 0 0 0;
                                        font-size: 14px;
                                    }

                                    .form-group {
                                        margin-bottom: 24px;
                                    }

                                    .form-label {
                                        font-weight: 500;
                                        color: #475569;
                                        margin-bottom: 8px;
                                        display: block;
                                        font-size: 14px;
                                    }

                                    .form-control,
                                    .form-select {
                                        width: 100%;
                                        padding: 12px 16px;
                                        border: 2px solid #e2e8f0;
                                        border-radius: 12px;
                                        font-size: 15px;
                                        transition: all 0.2s ease;
                                        background: #f8fafc;
                                        font-family: inherit;
                                    }

                                    .form-control:focus,
                                    .form-select:focus {
                                        outline: none;
                                        border-color: #3b82f6;
                                        background: #fff;
                                        box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
                                    }

                                    textarea.form-control {
                                        resize: vertical;
                                        min-height: 120px;
                                    }

                                    .btn-group {
                                        display: flex;
                                        gap: 16px;
                                        margin-top: 32px;
                                    }

                                    .btn {
                                        flex: 1;
                                        padding: 14px 20px;
                                        border: none;
                                        border-radius: 12px;
                                        font-size: 15px;
                                        font-weight: 600;
                                        cursor: pointer;
                                        transition: all 0.2s ease;
                                        text-decoration: none;
                                        text-align: center;
                                        display: inline-flex;
                                        align-items: center;
                                        justify-content: center;
                                        gap: 8px;
                                        font-family: inherit;
                                    }

                                    .btn-primary {
                                        background: var(--primary-gradient);
                                        color: white;
                                        box-shadow: 0 4px 6px -1px rgba(37, 99, 235, 0.2);
                                    }

                                    .btn-primary:hover {
                                        transform: translateY(-2px);
                                        box-shadow: 0 10px 15px -3px rgba(37, 99, 235, 0.3);
                                    }

                                    .btn-secondary {
                                        background: #f1f5f9;
                                        color: #64748b;
                                    }

                                    .btn-secondary:hover {
                                        background: #e2e8f0;
                                        color: #334155;
                                    }

                                    @media (max-width: 480px) {
                                        .edit-container {
                                            padding: 24px;
                                        }

                                        .btn-group {
                                            flex-direction: column;
                                        }
                                    }
                                </style>
                            </head>

                            <body>
                                <div class="edit-container">
                                    <div class="header">
                                        <div class="header-icon"><i class="bi bi-pencil-square"></i></div>
                                        <div>
                                            <h1>Edit Task</h1>
                                            <p>Update task details below</p>
                                        </div>
                                    </div>

                                    <form action="TaskController" method="post">
                                        <input type="hidden" name="action" value="update" />
                                        <input type="hidden" name="csrfToken" value="<%= csrfToken %>" />
                                        <input type="hidden" name="id" value="<c:out value='${taskToEdit.id}'/>" />

                                        <div class="form-group">
                                            <label for="title" class="form-label">Title</label>
                                            <input type="text" class="form-control" id="title" name="title"
                                                value="<c:out value='${taskToEdit.title}'/>" maxlength="200" required>
                                        </div>

                                        <div class="form-group">
                                            <label for="description" class="form-label">Description</label>
                                            <textarea class="form-control" id="description" name="description" rows="3"
                                                maxlength="2000"><c:out value='${taskToEdit.description}'/></textarea>
                                        </div>

                                        <div class="form-group">
                                            <label for="status" class="form-label">Status</label>
                                            <select class="form-select" id="status" name="status">
                                                <option value="Pending" ${taskToEdit.status=='Pending' ? 'selected' : ''
                                                    }>To Do</option>
                                                <option value="In Progress" ${taskToEdit.status=='In Progress'
                                                    ? 'selected' : '' }>In Progress</option>
                                                <option value="Completed" ${taskToEdit.status=='Completed' ? 'selected'
                                                    : '' }>Completed</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="dueDate" class="form-label">Due Date</label>
                                            <input type="date" class="form-control" id="dueDate" name="dueDate"
                                                value="<c:out value='${taskToEdit.dueDate}'/>" required>
                                        </div>

                                        <div class="btn-group">
                                            <a href="TaskController" class="btn btn-secondary">
                                                <i class="bi bi-x-lg"></i> Cancel
                                            </a>
                                            <button type="submit" class="btn btn-primary">
                                                <i class="bi bi-check-lg"></i> Save Changes
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </body>

                            </html>
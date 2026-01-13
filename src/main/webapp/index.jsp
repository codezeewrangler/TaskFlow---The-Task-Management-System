<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.taskmanager.model.User" %>
        <%@ page import="com.taskmanager.util.CSRFUtil" %>
            <%@ page import="com.taskmanager.model.Task" %>
                <%@ page import="java.util.List" %>
                    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
                        <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
                            <% User loggedInUser=(User) session.getAttribute("loggedInUser"); if (loggedInUser==null) {
                                response.sendRedirect("login.jsp"); return; } String
                                csrfToken=CSRFUtil.getToken(session); %>
                                <!DOCTYPE html>
                                <html lang="en">

                                <head>
                                    <meta charset="UTF-8">
                                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                    <title>Dashboard - TaskFlow</title>
                                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
                                        rel="stylesheet">
                                    <link
                                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
                                        rel="stylesheet">
                                    <link
                                        href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                                        rel="stylesheet">
                                    <script
                                        src="https://cdn.jsdelivr.net/npm/sortablejs@latest/Sortable.min.js"></script>
                                    <style>
                                        :root {
                                            --primary-gradient: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
                                            --sidebar-bg: #ffffff;
                                            --main-bg: #f3f4f6;
                                            --text-primary: #1e293b;
                                            --text-secondary: #64748b;
                                            --card-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
                                            --card-hover-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
                                        }

                                        body {
                                            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
                                            background-color: var(--main-bg);
                                            margin: 0;
                                            color: var(--text-primary);
                                        }

                                        /* --- Sidebar --- */
                                        .sidebar {
                                            position: fixed;
                                            top: 0;
                                            left: 0;
                                            height: 100vh;
                                            width: 260px;
                                            padding: 24px;
                                            background-color: var(--sidebar-bg);
                                            border-right: 1px solid #e2e8f0;
                                            z-index: 100;
                                            display: flex;
                                            flex-direction: column;
                                        }

                                        .sidebar-header {
                                            font-size: 1.5rem;
                                            font-weight: 700;
                                            margin-bottom: 32px;
                                            display: flex;
                                            align-items: center;
                                            gap: 12px;
                                            color: #2563eb;
                                        }

                                        .sidebar-nav {
                                            list-style: none;
                                            padding: 0;
                                            margin: 0;
                                            flex-grow: 1;
                                        }

                                        .sidebar-nav .nav-item {
                                            margin-bottom: 8px;
                                        }

                                        .sidebar-nav .nav-link {
                                            display: flex;
                                            align-items: center;
                                            gap: 12px;
                                            padding: 12px 16px;
                                            border-radius: 12px;
                                            color: var(--text-secondary);
                                            text-decoration: none;
                                            font-weight: 500;
                                            transition: all 0.2s ease;
                                        }

                                        .sidebar-nav .nav-link:hover,
                                        .sidebar-nav .nav-link.active {
                                            background-color: #eff6ff;
                                            color: #2563eb;
                                        }

                                        .sidebar-nav .nav-link i {
                                            font-size: 1.2rem;
                                        }

                                        .user-info {
                                            margin-top: auto;
                                            padding-top: 20px;
                                            border-top: 1px solid #e2e8f0;
                                            display: flex;
                                            align-items: center;
                                            justify-content: space-between;
                                        }

                                        .user-name {
                                            font-weight: 600;
                                            font-size: 14px;
                                        }

                                        .logout-btn {
                                            color: #ef4444;
                                            text-decoration: none;
                                            font-size: 14px;
                                            font-weight: 500;
                                            display: flex;
                                            align-items: center;
                                            gap: 4px;
                                        }

                                        /* --- Main Content --- */
                                        .main-content {
                                            margin-left: 260px;
                                            padding: 32px 40px;
                                            min-height: 100vh;
                                        }

                                        .main-header {
                                            display: flex;
                                            justify-content: space-between;
                                            align-items: center;
                                            margin-bottom: 32px;
                                        }

                                        .main-header h2 {
                                            font-size: 24px;
                                            font-weight: 700;
                                            color: #1e293b;
                                            margin: 0;
                                        }

                                        .search-bar {
                                            width: 300px;
                                            position: relative;
                                        }

                                        .search-bar input {
                                            width: 100%;
                                            padding: 10px 16px 10px 40px;
                                            border: 1px solid #e2e8f0;
                                            border-radius: 99px;
                                            background: #fff;
                                            font-size: 14px;
                                            outline: none;
                                            transition: all 0.2s;
                                        }

                                        .search-bar input:focus {
                                            border-color: #3b82f6;
                                            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
                                        }

                                        .search-bar i {
                                            position: absolute;
                                            left: 14px;
                                            top: 50%;
                                            transform: translateY(-50%);
                                            color: #94a3b8;
                                        }

                                        /* --- Task Board --- */
                                        .task-board {
                                            display: flex;
                                            gap: 24px;
                                            align-items: flex-start;
                                            overflow-x: auto;
                                            padding-bottom: 20px;
                                        }

                                        .task-column {
                                            flex: 1;
                                            min-width: 300px;
                                            background: #f8fafc;
                                            /* slightly darker than main bg for contrast? actually transparent is better if main bg is colored, but here we stick to clean */
                                            border-radius: 16px;
                                            min-height: 500px;
                                        }

                                        .column-header {
                                            padding: 16px;
                                            border-radius: 16px 16px 0 0;
                                            margin-bottom: 16px;
                                            display: flex;
                                            align-items: center;
                                            justify-content: space-between;
                                            font-weight: 600;
                                            font-size: 15px;
                                        }

                                        .column-header h3 {
                                            margin: 0;
                                            font-size: 16px;
                                            font-weight: 700;
                                        }

                                        .count-badge {
                                            background: rgba(255, 255, 255, 0.25);
                                            padding: 2px 10px;
                                            border-radius: 99px;
                                            font-size: 12px;
                                        }

                                        /* Ambient Column Colors */
                                        .col-todo .column-header {
                                            background: linear-gradient(135deg, #64748b, #475569);
                                            color: white;
                                        }

                                        .col-progress .column-header {
                                            background: linear-gradient(135deg, #3b82f6, #2563eb);
                                            color: white;
                                        }

                                        .col-completed .column-header {
                                            background: linear-gradient(135deg, #10b981, #059669);
                                            color: white;
                                        }

                                        /* Card Styles */
                                        .card {
                                            background: #fff;
                                            border-radius: 12px;
                                            padding: 16px;
                                            margin: 0 16px 16px 16px;
                                            box-shadow: var(--card-shadow);
                                            border: 1px solid rgba(0, 0, 0, 0.02);
                                            transition: all 0.2s ease;
                                            cursor: grab;
                                            position: relative;
                                        }

                                        .card:hover {
                                            transform: translateY(-3px);
                                            box-shadow: var(--card-hover-shadow);
                                        }

                                        .card-title {
                                            font-size: 16px;
                                            font-weight: 600;
                                            margin-bottom: 8px;
                                            color: #334155;
                                        }

                                        .card-meta {
                                            display: flex;
                                            align-items: center;
                                            gap: 12px;
                                            font-size: 13px;
                                            color: #94a3b8;
                                            margin-bottom: 12px;
                                        }

                                        .card-meta i {
                                            font-size: 14px;
                                        }

                                        .card-desc {
                                            font-size: 14px;
                                            color: #64748b;
                                            line-height: 1.5;
                                            margin-bottom: 0;
                                            display: -webkit-box;
                                            -webkit-line-clamp: 3;
                                            -webkit-box-orient: vertical;
                                            overflow: hidden;
                                        }

                                        .card-actions {
                                            position: absolute;
                                            top: 12px;
                                            right: 12px;
                                            display: flex;
                                            gap: 6px;
                                            opacity: 0;
                                            transition: opacity 0.2s;
                                        }

                                        .card:hover .card-actions {
                                            opacity: 1;
                                        }

                                        .action-btn {
                                            width: 28px;
                                            height: 28px;
                                            border-radius: 6px;
                                            display: flex;
                                            align-items: center;
                                            justify-content: center;
                                            color: #64748b;
                                            background: #f1f5f9;
                                            transition: all 0.2s;
                                            text-decoration: none;
                                        }

                                        .action-btn:hover {
                                            background: #e2e8f0;
                                            color: #334155;
                                        }

                                        .action-btn.delete:hover {
                                            background: #fee2e2;
                                            color: #ef4444;
                                        }

                                        /* Drag Visuals */
                                        .sortable-ghost {
                                            opacity: 0.4;
                                            background: #f8fafc;
                                            border: 2px dashed #cbd5e1;
                                        }

                                        .sortable-chosen {
                                            cursor: grabbing;
                                        }

                                        .sortable-drag {
                                            cursor: grabbing;
                                            opacity: 1;
                                            background: white;
                                            transform: rotate(2deg);
                                            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
                                        }

                                        /* FAB */
                                        .fab {
                                            position: fixed;
                                            bottom: 32px;
                                            right: 32px;
                                            width: 56px;
                                            height: 56px;
                                            background: var(--primary-gradient);
                                            color: white;
                                            border-radius: 99px;
                                            display: flex;
                                            align-items: center;
                                            justify-content: center;
                                            font-size: 24px;
                                            box-shadow: 0 4px 14px rgba(37, 99, 235, 0.4);
                                            cursor: pointer;
                                            transition: transform 0.2s;
                                            text-decoration: none;
                                            z-index: 90;
                                        }

                                        .fab:hover {
                                            transform: scale(1.1);
                                            color: white;
                                        }

                                        /* Modal */
                                        .modal-backdrop {
                                            display: none;
                                            position: fixed;
                                            top: 0;
                                            left: 0;
                                            width: 100%;
                                            height: 100%;
                                            background: rgba(15, 23, 42, 0.4);
                                            backdrop-filter: blur(4px);
                                            z-index: 102;
                                        }

                                        .task-modal {
                                            display: none;
                                            position: fixed;
                                            top: 50%;
                                            left: 50%;
                                            transform: translate(-50%, -50%);
                                            background: #fff;
                                            padding: 32px;
                                            border-radius: 20px;
                                            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
                                            width: 90%;
                                            max-width: 500px;
                                            z-index: 103;
                                            animation: modalPop 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
                                        }

                                        @keyframes modalPop {
                                            from {
                                                opacity: 0;
                                                transform: translate(-50%, -40%) scale(0.95);
                                            }

                                            to {
                                                opacity: 1;
                                                transform: translate(-50%, -50%) scale(1);
                                            }
                                        }

                                        .modal-header h2 {
                                            margin: 0 0 24px 0;
                                            font-size: 20px;
                                            font-weight: 700;
                                        }

                                        .close-btn {
                                            position: absolute;
                                            top: 24px;
                                            right: 28px;
                                            font-size: 24px;
                                            color: #94a3b8;
                                            cursor: pointer;
                                            text-decoration: none;
                                        }

                                        .close-btn:hover {
                                            color: #1e293b;
                                        }

                                        .btn-primary {
                                            background: var(--primary-gradient);
                                            border: none;
                                            padding: 12px 24px;
                                            border-radius: 10px;
                                            font-weight: 600;
                                            width: 100%;
                                            box-shadow: 0 4px 6px -1px rgba(37, 99, 235, 0.2);
                                        }

                                        .btn-primary:hover {
                                            background: linear-gradient(135deg, #2563eb, #1d4ed8);
                                            transform: translateY(-1px);
                                        }
                                    </style>
                                </head>

                                <body>

                                    <!-- Sidebar -->
                                    <div class="sidebar">
                                        <div class="sidebar-header">
                                            <i class="bi bi-grid-1x2-fill"></i> TaskFlow
                                        </div>
                                        <ul class="sidebar-nav">
                                            <li class="nav-item">
                                                <a class="nav-link active" href="#">
                                                    <i class="bi bi-columns-gap"></i> Dashboard
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" href="#">
                                                    <i class="bi bi-folder"></i> Projects
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" href="#">
                                                    <i class="bi bi-people"></i> Team
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" href="#">
                                                    <i class="bi bi-gear"></i> Settings
                                                </a>
                                            </li>
                                        </ul>
                                        <div class="user-info">
                                            <span class="user-name">
                                                <%= loggedInUser.getUsername() %>
                                            </span>
                                            <a href="LogoutServlet" class="logout-btn">
                                                <i class="bi bi-box-arrow-right"></i> Logout
                                            </a>
                                        </div>
                                    </div>

                                    <!-- Main Content -->
                                    <div class="main-content" id="mainPageContent">
                                        <header class="main-header">
                                            <h2>My Tasks</h2>
                                            <div class="search-bar">
                                                <i class="bi bi-search"></i>
                                                <input type="text" placeholder="Search tasks...">
                                            </div>
                                        </header>

                                        <div class="task-board">
                                            <% List<Task> taskList = (List<Task>) request.getAttribute("taskList"); %>

                                                    <!-- Pending Column -->
                                                    <div id="column-pending" class="task-column col-todo"
                                                        data-status="Pending">
                                                        <div class="column-header">
                                                            <h3>To Do</h3>
                                                            <span class="count-badge">
                                                                <%= taskList !=null ? taskList.stream().filter(t ->
                                                                    "Pending".equals(t.getStatus())).count() : 0 %>
                                                            </span>
                                                        </div>
                                                        <% if (taskList !=null) { for (Task task : taskList) { if
                                                            ("Pending".equals(task.getStatus())) { %>
                                                            <div class="card" data-task-id="<%= task.getId() %>">
                                                                <div class="card-actions">
                                                                    <a href="TaskController?action=edit&id=<%= task.getId() %>"
                                                                        class="action-btn"><i
                                                                            class="bi bi-pencil-fill"></i></a>
                                                                    <a href="TaskController?action=delete&id=<%= task.getId() %>"
                                                                        class="action-btn delete"><i
                                                                            class="bi bi-trash-fill"></i></a>
                                                                </div>
                                                                <div class="card-title">
                                                                    <%= task.getTitle() %>
                                                                </div>
                                                                <div class="card-meta">
                                                                    <span><i class="bi bi-calendar"></i>
                                                                        <%= task.getDueDate() %>
                                                                    </span>
                                                                </div>
                                                                <div class="card-desc">
                                                                    <%= task.getDescription() %>
                                                                </div>
                                                            </div>
                                                            <% } } } %>
                                                    </div>

                                                    <!-- In Progress Column -->
                                                    <div id="column-inprogress" class="task-column col-progress"
                                                        data-status="In Progress">
                                                        <div class="column-header">
                                                            <h3>In Progress</h3>
                                                            <span class="count-badge">
                                                                <%= taskList !=null ? taskList.stream().filter(t -> "In
                                                                    Progress".equals(t.getStatus())).count() : 0 %>
                                                            </span>
                                                        </div>
                                                        <% if (taskList !=null) { for (Task task : taskList) { if ("In
                                                            Progress".equals(task.getStatus())) { %>
                                                            <div class="card" data-task-id="<%= task.getId() %>">
                                                                <div class="card-actions">
                                                                    <a href="TaskController?action=edit&id=<%= task.getId() %>"
                                                                        class="action-btn"><i
                                                                            class="bi bi-pencil-fill"></i></a>
                                                                    <a href="TaskController?action=delete&id=<%= task.getId() %>"
                                                                        class="action-btn delete"><i
                                                                            class="bi bi-trash-fill"></i></a>
                                                                </div>
                                                                <div class="card-title">
                                                                    <%= task.getTitle() %>
                                                                </div>
                                                                <div class="card-meta">
                                                                    <span><i class="bi bi-calendar"></i>
                                                                        <%= task.getDueDate() %>
                                                                    </span>
                                                                </div>
                                                                <div class="card-desc">
                                                                    <%= task.getDescription() %>
                                                                </div>
                                                            </div>
                                                            <% } } } %>
                                                    </div>

                                                    <!-- Completed Column -->
                                                    <div id="column-completed" class="task-column col-completed"
                                                        data-status="Completed">
                                                        <div class="column-header">
                                                            <h3>Completed</h3>
                                                            <span class="count-badge">
                                                                <%= taskList !=null ? taskList.stream().filter(t ->
                                                                    "Completed".equals(t.getStatus())).count() : 0 %>
                                                            </span>
                                                        </div>
                                                        <% if (taskList !=null) { for (Task task : taskList) { if
                                                            ("Completed".equals(task.getStatus())) { %>
                                                            <div class="card" data-task-id="<%= task.getId() %>">
                                                                <div class="card-actions">
                                                                    <a href="TaskController?action=edit&id=<%= task.getId() %>"
                                                                        class="action-btn"><i
                                                                            class="bi bi-pencil-fill"></i></a>
                                                                    <a href="TaskController?action=delete&id=<%= task.getId() %>"
                                                                        class="action-btn delete"><i
                                                                            class="bi bi-trash-fill"></i></a>
                                                                </div>
                                                                <div class="card-title">
                                                                    <%= task.getTitle() %>
                                                                </div>
                                                                <div class="card-meta">
                                                                    <span><i class="bi bi-calendar"></i>
                                                                        <%= task.getDueDate() %>
                                                                    </span>
                                                                </div>
                                                                <div class="card-desc">
                                                                    <%= task.getDescription() %>
                                                                </div>
                                                            </div>
                                                            <% } } } %>
                                                    </div>
                                        </div>
                                    </div>

                                    <!-- Details/Add Modal -->
                                    <div class="modal-backdrop" id="modalBackdrop"></div>
                                    <div class="task-modal" id="addTaskModal">
                                        <a href="#" class="close-btn" id="closeModalBtn">&times;</a>
                                        <div class="modal-header">
                                            <h2>Add New Task</h2>
                                        </div>
                                        <form action="TaskController" method="post">
                                            <input type="hidden" name="action" value="insert" />
                                            <input type="hidden" name="csrfToken" value="<%= csrfToken %>" />

                                            <div class="mb-3">
                                                <label for="title" class="form-label"
                                                    style="font-weight: 500; font-size: 14px; color: #475569;">Title</label>
                                                <input type="text" class="form-control" id="title" name="title" required
                                                    style="border-radius: 8px; padding: 10px;">
                                            </div>
                                            <div class="mb-3">
                                                <label for="description" class="form-label"
                                                    style="font-weight: 500; font-size: 14px; color: #475569;">Description</label>
                                                <textarea class="form-control" id="description" name="description"
                                                    rows="3" style="border-radius: 8px; padding: 10px;"></textarea>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6 mb-3">
                                                    <label for="status" class="form-label"
                                                        style="font-weight: 500; font-size: 14px; color: #475569;">Status</label>
                                                    <select class="form-select" id="status" name="status"
                                                        style="border-radius: 8px; padding: 10px;">
                                                        <option value="Pending">To Do</option>
                                                        <option value="In Progress">In Progress</option>
                                                        <option value="Completed">Completed</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label for="dueDate" class="form-label"
                                                        style="font-weight: 500; font-size: 14px; color: #475569;">Due
                                                        Date</label>
                                                    <input type="date" class="form-control" id="dueDate" name="dueDate"
                                                        required style="border-radius: 8px; padding: 10px;">
                                                </div>
                                            </div>

                                            <button type="submit" class="btn btn-primary">Create Task</button>
                                        </form>
                                    </div>

                                    <a href="#" id="fab" class="fab"><i class="bi bi-plus-lg"></i></a>

                                    <script>
                                        // --- Modal Logic ---
                                        const fab = document.getElementById("fab");
                                        const modal = document.getElementById("addTaskModal");
                                        const backdrop = document.getElementById("modalBackdrop");
                                        const closeBtn = document.getElementById("closeModalBtn");

                                        function openModal() {
                                            modal.style.display = "block";
                                            backdrop.style.display = "block";
                                        }
                                        function closeModal() {
                                            modal.style.display = "none";
                                            backdrop.style.display = "none";
                                        }
                                        fab.onclick = (e) => { e.preventDefault(); openModal(); };
                                        closeBtn.onclick = (e) => { e.preventDefault(); closeModal(); };
                                        backdrop.onclick = closeModal;

                                        // --- Drag & Drop Logic ---
                                        const columns = document.querySelectorAll(".task-column");

                                        function updateTaskStatus(taskId, newStatus, cardElement) {
                                            const body = 'action=dragUpdate&taskId=' + encodeURIComponent(taskId) + '&newStatus=' + encodeURIComponent(newStatus);
                                            return fetch("TaskController", {
                                                method: "POST",
                                                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                                                body: body
                                            })
                                                .then(response => {
                                                    if (!response.ok) throw new Error("Server error");
                                                    return response.text().then(txt => {
                                                        try { return JSON.parse(txt); } catch (e) { return {}; } // ignore json errors for simple ok check
                                                    });
                                                })
                                                .then(data => {
                                                    if (data && data.status === "success") {
                                                        console.log("Updated status");
                                                    } else {
                                                        console.error("Update failed");
                                                    }
                                                })
                                                .catch(err => {
                                                    console.error("Fetch error", err);
                                                });
                                        }

                                        columns.forEach(column => {
                                            new Sortable(column, {
                                                group: 'shared',
                                                animation: 150,
                                                ghostClass: 'sortable-ghost',
                                                chosenClass: 'sortable-chosen',
                                                dragClass: 'sortable-drag',
                                                delay: 0,
                                                filter: '.column-header, .card-actions',
                                                preventOnFilter: true,
                                                onEnd: function (evt) {
                                                    const item = evt.item;
                                                    const newStatus = evt.to.getAttribute('data-status');
                                                    const taskId = item.getAttribute('data-task-id');
                                                    updateTaskStatus(taskId, newStatus, item);
                                                }
                                            });
                                        });
                                    </script>
                                </body>

                                </html>
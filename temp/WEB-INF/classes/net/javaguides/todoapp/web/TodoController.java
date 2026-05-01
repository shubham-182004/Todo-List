package net.javaguides.todoapp.web;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.javaguides.todoapp.dao.TodoDao;
import net.javaguides.todoapp.dao.TodoDaoImpl;
import net.javaguides.todoapp.model.Todo;

@WebServlet("/")
public class TodoController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TodoDao todoDAO;

    public void init() {
        todoDAO = new TodoDaoImpl();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
            case "/new":
                showNewForm(request, response);
                break;
            case "/insert":
                insertTodo(request, response);
                break;
            case "/delete":
                deleteTodo(request, response);
                break;
            case "/edit":
                showEditForm(request, response);
                break;
            case "/update":
                updateTodo(request, response);
                break;
            case "/list":
                listTodo(request, response);
                break;
            // FIX: Added logout handler (was referenced in JSPs but never handled)
            case "/logout":
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate();
                }
                response.sendRedirect(request.getContextPath() + "/login/login.jsp");
                break;
            default:
                RequestDispatcher dispatcher = request.getRequestDispatcher("login/login.jsp");
                dispatcher.forward(request, response);
                break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listTodo(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Todo> listTodo = todoDAO.selectAllTodos();
        request.setAttribute("listTodo", listTodo);
        RequestDispatcher dispatcher = request.getRequestDispatcher("todo/todo-list.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("todo/todo-form.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Todo existingTodo = todoDAO.selectTodo(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("todo/todo-form.jsp");
        request.setAttribute("todo", existingTodo);
        dispatcher.forward(request, response);
    }

    private void insertTodo(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String title = request.getParameter("title");
        // FIX: Get username from session if not provided in form
        String username = request.getParameter("username");
        if (username == null || username.isEmpty()) {
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("user") != null) {
                username = (String) session.getAttribute("user");
            } else {
                username = "anonymous";
            }
        }
        String description = request.getParameter("description");
        boolean isDone = Boolean.valueOf(request.getParameter("isDone"));
        // FIX: Use targetDate from form if provided, otherwise today
        String targetDateParam = request.getParameter("targetDate");
        LocalDate targetDate = (targetDateParam != null && !targetDateParam.isEmpty())
                ? LocalDate.parse(targetDateParam)
                : LocalDate.now();
        Todo newTodo = new Todo(title, username, description, targetDate, isDone);
        todoDAO.insertTodo(newTodo);
        response.sendRedirect("list");
    }

    private void updateTodo(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        // FIX: Get username from session if not in form
        String username = request.getParameter("username");
        if (username == null || username.isEmpty()) {
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("user") != null) {
                username = (String) session.getAttribute("user");
            } else {
                username = "anonymous";
            }
        }
        String description = request.getParameter("description");
        // FIX: Handle null/empty targetDate gracefully
        String targetDateParam = request.getParameter("targetDate");
        LocalDate targetDate = (targetDateParam != null && !targetDateParam.isEmpty())
                ? LocalDate.parse(targetDateParam)
                : LocalDate.now();
        boolean isDone = Boolean.valueOf(request.getParameter("isDone"));
        Todo updateTodo = new Todo(id, title, username, description, targetDate, isDone);
        todoDAO.updateTodo(updateTodo);
        response.sendRedirect("list");
    }

    private void deleteTodo(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        todoDAO.deleteTodo(id);
        response.sendRedirect("list");
    }
}

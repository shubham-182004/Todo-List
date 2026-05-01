package net.javaguides.todoapp.model;

import java.time.LocalDate;

/**
 * Todo.java - model class representing a Todo entity
 */
public class Todo {

    private Long id;
    private String title;
    private String username;
    private String description;
    private LocalDate targetDate;
    private boolean status;

    protected Todo() {}

    public Todo(long id, String title, String username, String description, LocalDate targetDate, boolean isDone) {
        this.id = id;
        this.title = title;
        this.username = username;
        this.description = description;
        this.targetDate = targetDate;
        this.status = isDone;
    }

    public Todo(String title, String username, String description, LocalDate targetDate, boolean isDone) {
        this.title = title;
        this.username = username;
        this.description = description;
        this.targetDate = targetDate;
        this.status = isDone;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public LocalDate getTargetDate() { return targetDate; }
    public void setTargetDate(LocalDate targetDate) { this.targetDate = targetDate; }
    public boolean getStatus() { return status; }
    public void setStatus(boolean status) { this.status = status; }

    // FIX: Null-safe hashCode and equals for Long id field
    @Override
    public int hashCode() {
        return (id == null) ? 0 : id.hashCode();
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null) return false;
        if (getClass() != obj.getClass()) return false;
        Todo other = (Todo) obj;
        if (id == null) return other.id == null;
        return id.equals(other.id);
    }
}

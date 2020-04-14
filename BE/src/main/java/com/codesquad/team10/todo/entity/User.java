package com.codesquad.team10.todo.entity;

import org.springframework.data.annotation.Id;

import java.util.Objects;

public class User {

    @Id
    private Integer id;

    private String name;

    private String password;

    private Integer boardKey;

    public User(Integer id, String name, String password, Integer boardKey) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.boardKey = boardKey;
    }

    public String getName() {
        return name;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return id == user.id &&
                name.equals(user.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name);
    }
}

package com.blog.service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface UserService {
    void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    void getAllUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    void getProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    void updateProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    void updateProfilePic(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
}

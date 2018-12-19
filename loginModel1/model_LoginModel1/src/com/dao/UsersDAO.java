package com.dao;
import com.po.Users;

// 用户的业务逻辑类
public class UsersDAO {
    public boolean userLogin(Users user) {
        if(user.getUsername().equals("admin") && user.getPassword().equals("admin")) {
            return true;
        }
        else {
            return false;
        }
    }
}

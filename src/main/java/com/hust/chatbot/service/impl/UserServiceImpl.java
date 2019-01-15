package com.hust.chatbot.service.impl;

import com.hust.chatbot.mapper.UserMapper;
import com.hust.chatbot.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userMapper;
}

package com.hust.chatbot.service.impl;

import com.hust.chatbot.mapper.ManagerMapper;
import com.hust.chatbot.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ManagerServiceImpl implements ManagerService {

    @Autowired
    ManagerMapper managerMapper;
}

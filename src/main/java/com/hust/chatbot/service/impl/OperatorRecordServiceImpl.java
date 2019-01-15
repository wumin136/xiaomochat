package com.hust.chatbot.service.impl;

import com.hust.chatbot.mapper.OperatorRecordMapper;
import com.hust.chatbot.service.OperatorRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OperatorRecordServiceImpl implements OperatorRecordService {

    @Autowired
    OperatorRecordMapper operatorRecordMapper;
}

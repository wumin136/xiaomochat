package com.hust.chatbot.domain;

import java.util.Date;

public class OperatorRecord {

    public String getOperatorRecordId() {
        return operatorRecordId;
    }

    public String getUserId() {
        return userId;
    }

    public Date getActionTime() {
        return actionTime;
    }

    public String getActionName() {
        return actionName;
    }
    private String operatorRecordId;

    public void setOperatorRecordId(String operatorRecordId) {
        this.operatorRecordId = operatorRecordId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public void setActionTime(Date actionTime) {
        this.actionTime = actionTime;
    }

    public void setActionName(String actionName) {
        this.actionName = actionName;
    }

    private String userId;
    private Date actionTime;
    private String actionName;

    /**
     @roseuid 5C3C535F02A3
     */
    public OperatorRecord()
    {

    }
}

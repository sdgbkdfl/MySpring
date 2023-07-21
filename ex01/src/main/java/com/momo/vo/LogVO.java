package com.momo.vo;

import lombok.Data;

@Data
public class LogVO {
    private String classname; 
    private String methodname; 
    private String param;
    private String errmsg;
    private String regdate;
}

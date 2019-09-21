package com.ww.crud.pojo;
import java.util.HashMap;
import java.util.Map;

/**
 * @Author: wangwei
 * @Description: 数据传输对象
 * @Time: 2019/9/19 星期四 21:11
 **/
public class InfoDTO {
    
    private String msg;
    private String code;
    private Map<String, Object> dataMap = new HashMap<>();
    
    // 操作成功时，返回一个存储了成功信息的传输对象
    public static InfoDTO success(){
        InfoDTO infoDTO = new InfoDTO();
        infoDTO.setCode("200");
        infoDTO.setMsg("操作成功");
        return infoDTO;
    }

    // 操作失败时，返回一个存储了失败信息的传输对象
    public static InfoDTO fail(){
        InfoDTO infoDTO = new InfoDTO();
        infoDTO.setCode("100");
        infoDTO.setMsg("操作失败");
        return infoDTO;
    }
    
    // 用于添加数据的方法，并使其可以链式操作
    public InfoDTO addData(String key, Object value){
        this.getDataMap().put(key, value);
        return this;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Map<String, Object> getDataMap() {
        return dataMap;
    }

    public void setDataMap(Map<String, Object> dataMap) {
        this.dataMap = dataMap;
    }
}

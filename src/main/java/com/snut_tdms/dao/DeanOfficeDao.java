package com.snut_tdms.dao;

import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * 教务处DAO层
 * Created by huankai on 2018/3/27.
 */
@Repository
public interface DeanOfficeDao extends UserDao{

    Integer selectDataCountByParams(Map<String,Object> map);

}

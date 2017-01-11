# 待解决

* 注册失败后不应该跳转到另一个页面而是利用类似弹窗的形式告之注册失败；
* 在后期需要配置一个登录过滤器；
* 在一些关联关系的查询上，看是否只需要按需取部分字段的值，而不是整个对象？
    * 如LabRoom与User；

* 利用hibernate的拦截器实现分页与不分布的统一；

# 备查

## EasyUI 控件

* layout    home.jsp;
* form  dictionary/list.jsp
      
* tree  dictionary/list.jsp
* textarea  dictionary/list.jsp
    备注之类的设置为不超过 120个字符，简介之类的可以适当增大；
    
* combobox  menu/list.jsp
* combobox  menu/list.jsp
* datagrid  user/list.jsp
* show  university/list.jsp
* dialog    university/list.jsp
* layout    home.jsp

## 实体关系
* 单个实体：University,User;
* 单向多对一：LabRoom-User、College-University
* 自身多对一：Menu、Parent;
* 单向一对一：College-User(一个学院只能有一个院长)


# hibernate常见异常

* org.hibernate.exception.ConstraintViolationException  —— 一对一关联中，多个对象关联一个一对
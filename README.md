# 待解决

* 注册失败后不应该跳转到另一个页面而是利用类似弹窗的形式告之注册失败；
* 在后期需要配置一个登录过滤器；
* 在一些关联关系的查询上，看是否只需要按需取部分字段的值，而不是整个对象？
    * 如LabRoom与User；

* 利用hibernate的拦截器实现分页与不分布的统一；

# 备查

* layout见home.jsp;
* tree、combobox的使用见menu/list.jsp
* datagrid见user/list.jsp


* 单个实体：University;
* 单向多对一：LabRoom-User、College-University
* 自身多对一：Menu、Parent;
* 单向一对一：College-User(一个学院只能有一个院长)



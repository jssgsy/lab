# 重要备忘
* menu表中的menuId字段是无用字段，暂且不管;
* 需要为删除操作也提供异常处理操作，如为某个角色分配了“实验室管理”权限，则此时删除对应的“实验室管理”菜单时将抛异常，要么设置级联删除;
* 在新增用户时缺少设置用户所属角色的下拉框；点击修改用户信息时没有正确显示用户的角色；

* 所有需要审核的模块，新增时都默认为待审核；

* user模块中的“所学专业”与“教育背景”在下拉框中的valueField应该是id，而不是code，借鉴training模块；

# TODO

* 注册失败后不应该跳转到另一个页面而是利用类似弹窗的形式告之注册失败；
* 在后期需要配置一个登录过滤器；
* 在一些关联关系的查询上，看是否只需要按需取部分字段的值，而不是整个对象？
    * 如LabRoom与User；

* 实验室和User应该建立联系，应该双向一对多。
    实验室和负责人的单向多对一已经完成，也就是说实验室即和user是双向的一对多关系，还与User(负责人)是单向多对一关系！
    
* 用户的角色需要完善，角色放在数据字典中；

# 备查

## EasyUI 控件

* layout    home.jsp;
* form  dictionary/list.jsp
* numberspinner     dictionary/list.jsp     使用默认值
* tree  dictionary/list.jsp
* textarea  dictionary/list.jsp
    备注之类的设置为不超过 120个字符，简介之类的可以适当增大；
    
* combobox  academicPaper/list
    * valueField使用默认值id，
    * valueField使用非默认值，academicPaper/list

* combotree menu/list.jsp

* datagrid  user/list.jsp
* show  university/list.jsp
* dialog    university/list.jsp
* linkbutton     university/list.jsp
* datebox   academicPaper/list  使用默认值
* tabs
    使用tabs要注意，如果是利用href加载内容，则新增tab时只会导入body中的标签(html，head等都会被忽略)，
    更重要的是，所有tab中的方法名不要一致，id不要一致，使用href形式的tabs对编码能力要求很大(多利用匿名函数)。


## 实体关系
* 单个实体：University,User;
* 单向多对一：User-LabRoom、College-University
`重点：User和LabRoom既是单向的多对一(多个用户可以是同一个实验室),同时，LabRoom和User也是单向的多对一(多个实验室可以有同一个负责人)，interesting.`

* 自身多对一：Menu、Parent;
* 单向一对一：College-User(一个学院只能有一个院长)
* 单向多对多：AcademicPaper-User(一篇论文可以有多个作者)
    * 注意，这里使用了list而不是来配置多对多(一对多也应该类似，注意借鉴)
    * 注意根据作者名查询论文的逻辑，dao中实现的不够优雅，因为这里配置的是单向多对多，好像也没有其它的好方法

## 代码
* academicPaper根据作者名查询,在datagrid初始化时也传递查询参数，和点击搜索按钮保持一致，也可以防止后台有的对象可能为null;


# hibernate常见异常

* org.hibernate.exception.ConstraintViolationException  —— 一对一关联中，多个对象关联一个一对

# 设计

* 数据字典的使用：AcademicPaper中的level字段与User中的speciality和education虽然取自数据字典，但并没有与这关联，注意这里academicPaper/list.jsp的显示逻辑；
重点在于将combobox中valueField设为字典项的code，而不是id！

# 心得

* 不论是什么关联关系，每个实体都是一个独立的模块；
    * 多对一(包括双向)关联中，应该在多方的搜索框中设置根据多方(名称)查找；

* 开发完一个模块(或者两三个模块，只有一个模块可能不足以发现重复的地方)后应该将其各方面尽可能优化好，因为其它模块都类似；


# 不足
* 权限设计中，没有完成不同角色的用户显示不同页面，比如学校管理员页面有某个查询按钮，但学院管理员没有
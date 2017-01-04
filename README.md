# 示例
示例Action为SshExampleAction

# Dao层设计上的一些考虑
之前设想将save、delete、update、get和load等抽象到一个基接口IAbstractBaseDao中，然后让具体的dao接口继承自此接口(根据需求扩展功能)，
如此可以利用IDE的自动提示功能让具体的Dao实现基本方法和扩展方法。但还是没有采取此方法，
主要考虑是虽然有些dao可能确实都会有增删改查等基本方法，但毕竟dao之间的相似程序没有如此之大，不能为了设计而设计。
这也能使得dao层和service层的设计保持一致的风格。

# 说明
* 具体的知识点可到具体的文件中查看；
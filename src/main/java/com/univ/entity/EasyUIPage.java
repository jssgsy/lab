package com.univ.entity;

/**
 * Univ
 * 2017/1/14 15:07
 */

/**
 * 结合EasyUI datagrid 附带的分页组件使用的分页实体
 * 注意，此实体特定于在EasyUI的分页组件中使用。
 *
 * 注意：这样设计可能不太好，因为与EasyUI绑定在一起了，action、service、dao层都与之耦合。
 */
public class EasyUIPage {

    private int whichPage;//对应于datagrid向后台请求数据时发送的请求参数page，表示第几页,默认值为1

    private int pageSize;//对应于datagrid向后台请求数据时发送的请求参数page，表示一页多少记录，默认值为10

    public EasyUIPage() {

    }

    public EasyUIPage(int whichPage, int pageSize) {
        this.whichPage = whichPage;
        this.pageSize = pageSize;
    }

    public int getWhichPage() {
        return whichPage;
    }

    public void setWhichPage(int whichPage) {
        this.whichPage = whichPage;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
}

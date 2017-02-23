//供easyui-datagrid显示时间时使用
function getDate(value){
    if(value){
        var date = new Date(value);
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        var d = date.getDate();
        return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
    }
}


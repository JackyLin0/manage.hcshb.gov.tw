//系統權限設定使用
Ext.onReady(function() {
	//Ext.QuickTips.init();
	
	var Tree = Ext.tree;
	//定議根節點的Loader
    var treeloader = new Tree.TreeLoader({
    });
 
    //建立一个樹形面板
    var treepanel = new Tree.TreePanel({
        el : 'entrymng',       //將樹放在一個指定的div中,需跟div之id對應
        //region : 'west',
        title : '人員組織樹',        
        width : 190,
        minSize : 180,
        maxSize : 250,
        split : true,
        height : 470,
        frame : true,                      //美化界面
        autoScroll : true,                 //自動滾動
        enableDD : false,                  //是否支持拖拉效果
        containerScroll : true,            //是否支持滾動條
        rootVisible : true,                //是否隐藏根節點,很多情况下，我们選擇隐藏根節點增加美觀性
        border : true,                     //邊框
        animate : true,                    //動畫效果
        loader : treeloader                //使用TreeLoader取得資料
     });
       
    //建立根節點
    var rootnode = new Tree.AsyncTreeNode({    //宣告為AsyncTreeNode，才能達到非同步載入
    	id : '1',
    	text : '桃園市政府',
    	draggable : false,    //根節點不容許拖動
    	expanded : true,     
    	//href : 'node_upd.jsp?mdn=ou=376440000a,ou=300000000a,c=tw',
        //hrefTarget : 'right',
    	iconCls: 'x-tree-node-icon1', 
    	font: '15px 微軟正黑體, arial, tahoma, helvetica, sans-serif'
    });

    //為Tree設置跟節點
    treepanel.setRootNode(rootnode);
 
    treepanel.on('beforeload', function(node) {
    	treepanel.loader.dataUrl = 'department.jsp?parentId=' + node.id;
    });
    
    treepanel.render();
    
    //第一個參數表示是否遞迴展開所有子節點，第二個參數表示是否動畫效果
    rootnode.expand(false,true);
    

    //增加右键點擊事件
    treepanel.on('contextmenu', function(node, event) {    //Menu事件
    	event.preventDefault();                            //防止瀏覽器彈出自身預設的功能表
    	//rightClick.showAt(event.getXY());                  //取得自訂Menu
    });

});


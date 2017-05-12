
Ext.onReady(function() {
	//Ext.QuickTips.init();
	
	var Tree = Ext.tree;
	//定議根節點的Loader
    var treeloader = new Tree.TreeLoader({
    });
 
    //建立一个樹形面板
    var treepanel = new Tree.TreePanel({
        el : 'leftmenu',       //將樹放在一個指定的div中,需跟div之id對應
        //region : 'west',
        //title : '應用系統樹',        
        width : 180,
        minSize : 180,
        maxSize : 180,
        split : true,
        height : 455,
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
    	text : '中文版管理端',
    	draggable : false,    //根節點不容許拖動
    	expanded : true,
    	iconCls: 'x-tree-node-icon-ch',
    	font: '15px 微軟正黑體, arial, tahoma, helvetica, sans-serif'
    });

    //為Tree設置跟節點
    treepanel.setRootNode(rootnode);
 
    var flag = '';
    treepanel.on('beforeload', function(node) {
    	treepanel.loader.dataUrl = 'leftmenu.jsp?parentId=' + node.id + '&language=chinese';    	
    });

    treepanel.render();
    
    rootnode.expand(false,true);
    
    treepanel.on('contextmenu', function(node, event) {    
    	event.preventDefault();                            
    	//rightClick.showAt(event.getXY());                 
    });

});


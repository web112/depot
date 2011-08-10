//click the item and search
function chooseItem(item){
	document.getElementById("name").value=item.innerHTML;
	document.getElementById("search_form").submit();
}

//keyboard down,keyborad up
var row=-1;
var newInput;
var inputValueChanged;
function keypress(evt){
	var k=window.event?evt.keyCode:evt.which;
	var searchAjaxTable=document.getElementById("searchAjaxTable");

	if( k>40 || k<37 && k!=13)
		inputValueChanged = true;
	else
		inputValueChanged = false;

	if(searchAjaxTable.getElementsByTagName("tr").length != 0 ){
    	if(inputValueChanged==true){
    		 row=-1;
		}
    	if (k == 38){
			if(row!=-1)
				row--;
			else 
				row=searchAjaxTable.getElementsByTagName("tr").length-1;
    	}
    	if (k == 40){
			if(row!=searchAjaxTable.getElementsByTagName("tr").length-1)
				row++;
			else 
	 			row=-1;
    	}
    	if(k == 13){
    		if(row!=-1){
    			document.getElementById("name").value=searchAjaxTable.getElementsByTagName("tr")[row].getElementsByTagName("td")[0].innerHTML;
				document.getElementById("search_form").submit();
				
    		}
    		else{
    			document.getElementById("search_form").submit();
    		}
    			
    	}
    	
    	for(i=0;i<searchAjaxTable.getElementsByTagName("tr").length;i++)
    			searchAjaxTable.getElementsByTagName("tr")[i].className=" ";
    	if(row!=-1){
    		searchAjaxTable.getElementsByTagName("tr")[row].className="selectedRow";
    	}
    	
	}
	
	if(k==13)
		document.getElementById("search_form").submit();
}

function form_submit(){
	document.getElementById("search_form").submit();
}

function search_recommend(ele){
	document.getElementById("name").value=ele.innerHTML;
	document.getElementById("search_form").submit();
}

function search_highlight(){
	var keyStr = document.getElementById("name").value;
	var keyArr = keyStr.split(" ");
	var titles = document.getElementsByClassName("product_title");
	var regString="("+keyArr[0]+")";
	var keyString="";
	for(i=1;i<keyArr.length;i++){
		regString = regString+"|("+keyArr[i]+")";
	}
	for(i=1;i<keyArr.length+1;i++){
		keyString=keyString+"<span class='highlight'>$"+[i]+"</span>";
	}
	for(j=0;j<titles.length;j++){
		var reg = eval("/"+regString+"/ig");
		titles[j].getElementsByTagName("a")[0].innerHTML=titles[j].getElementsByTagName("a")[0].innerHTML.replace(reg,keyString);
	}
}

function checkCheckBox(){
	var checkBoxs = document.getElementsByClassName("checkbox");
	var checked = 0;
	for(i=0;i<checkBoxs.length;i++){
		if(checkBoxs[i].checked==true)
			checked++;
	}
	if(checked>3||checked<1){
		alert("Type nums should be 1,2 or 3!");
		return false;
		}
	else
		return true;
}

/* image autochange*/

function prepareList(){
	
    listId = document.getElementById("list");
    links = listId.getElementsByTagName("a");
}

function imgAutoChange(){
	
    prepareList();

    links[0].className = "current";

    links[0].onmouseover = function(){
        moveElement("placeholder",-40,-13,10);
        changeTitle(this);
        return addClass(this);
    }
    links[1].onmouseover = function(){
        moveElement("placeholder",-485,-13,10);
        changeTitle(this);
        return addClass(this);
    }
    links[2].onmouseover = function(){
        moveElement("placeholder",-930,-13,10);
        changeTitle(this);
        return addClass(this);
    }
    links[3].onmouseover = function(){
        moveElement("placeholder",-1375,-13,10);
        changeTitle(this);
        return addClass(this);
    }
    
}

function moveElement(elementId,final_x,final_y,interval){
    var elem = document.getElementById(elementId);  //先获得传过来的elementId对象
    
    if(!elem.style.left){    //检查对象是否有left和top属性，没有则置0
        elem.style.left = -40+"px";
    }
    if(!elem.style.top){
        elem.style.top = -13+"px";
    }
    if(elem.movement){       //检查是否运行过setTimeout对象，有则用clearTimeout清除
        clearTimeout(elem.movement);
    }
    
    var xpos = parseInt(elem.style.left);    //把left和top值赋给变量，注意转换成整型
    var ypos = parseInt(elem.style.top);

    if(xpos == final_x && ypos == final_y) return;
    if(xpos < final_x){
        var dist = Math.ceil((final_x - xpos)/10);
        xpos += dist;
    }
    if(xpos > final_x){
        var dist = Math.ceil((xpos - final_x)/10);
        xpos -= dist;
    }
    if(ypos < final_y){
        var dist = Math.ceil((final_y - ypos)/10);
        ypos += dist;
    }
    if(xpos > final_x){
        var dist = Math.ceil((ypos - final_y)/10);
        ypos -= dist;
    }

    elem.style.left = xpos + "px";
    elem.style.top = ypos + "px";

    var repeat = "moveElement('"+elementId+"',"+final_x+","+final_y+","+interval+")";
    elem.movement = setTimeout(repeat,interval);
}

function changeTitle(whichList){
    var title = whichList.getAttribute("title");
    var titleId = document.getElementById("title");
    titleId.lastChild.nodeValue = title;
}

setInterval("autoMoveElement()",3000);
var autoKey = false;
function autoMoveElement(){
    prepareList();
    
    listId.onmouseover = function(){
        autoKey = true; 
    }
    listId.onmouseout = function(){
        autoKey = false;
    }
    if(autoKey) return;

    for(var i = 0; i < links.length; i++){
        if(links[i].className == "current"){
            var currentNum = i;
        }
    }

    if(currentNum == 0){
        moveElement("placeholder",-485,-13,10);
        addClass(links[1]);
        changeTitle(links[1]);
    }
    if(currentNum == 1){
        moveElement("placeholder",-930,-13,10);
        addClass(links[2]);
        changeTitle(links[2]);
    }
    if(currentNum == 2){
        moveElement("placeholder",-1375,-13,10);
        addClass(links[3]);
        changeTitle(links[3]);
    }
    if(currentNum == 3){
        moveElement("placeholder",-40,-13,10);
        addClass(links[0]);
        changeTitle(links[0]);
    }
}

function addClass(whichLink){
    for(var i=0;i<links.length;i++){
        if(whichLink == links[i]){
            whichLink.className = "current";
        }else{
            links[i].className = "";
        }
    }
    return;
}

//推荐书目一张一张切换

function changeImgsByImgs(next,prev,v_content,v_list){
  //  var next = document.getElementsByClassName("next")[0];
  //  var prev = document.getElementsByClassName("prev")[0];
  //  var v_content = document.getElementById("content_list");
  //  var v_list = document.getElementById("content_list_items");
    var v_width = v_content.clientWidth;
    var i = 4;
    var len = v_list.getElementsByTagName("li").length;
    var pageCount = Math.ceil(len/i);
    var page = 0;
    var t;

    next.onclick = function(){    	
        if(t){
            clearInterval(t);
        }
        if(page == pageCount - 1){
            t = animate(v_list,{left:v_list.offsetLeft},{left:-v_list.offsetLeft - 0},500,Quad);
            page = 0;
        }else{
            page++;
            t = animate(v_list,{left:v_list.offsetLeft},{left:(-page * v_width - v_list.offsetLeft)},500,Quad);
        }
        for(var i = 0,l = v_span.length; i < l; i++){
            v_span[i].className = '';
        }
        v_span[page].className = "current";
    }

    prev.onclick = function(){
        if(t){
            clearInterval(t);
        }
        if(page == 0){
            t = animate(v_list,{left:v_list.offsetLeft},{left:(-pageCount + 1) * v_width},500,Quad);
            page = 2;
        }else{
            page--;
            t = animate(v_list,{left:v_list.offsetLeft},{left:(-page * v_width - v_list.offsetLeft)},500,Quad);
        }
        for(var i = 0,l = v_span.length; i < l; i++){
            v_span[i].className = '';
        }
        v_span[page].className = "current";
    }
}


function Quad(start,alter,curTime,dur){
  return start+Math.pow(curTime/dur,2)*alter;
}
function animate(obj,start,alter,dur,fx){
   var curTime = 0;
   var interval = setInterval(function(){
       if(curTime >= dur){
           clearInterval(interval);
       }
       for(var i in start){
           obj.style[i] = fx(start[i],alter[i],curTime,dur) + "px";
       }
       curTime += 50;
   },50);
   return interval;
}

//加载dom后立即执行
if(document.addEventListener){
  document.addEventListener("DOMContentLoaded",function(){
  		if(document.getElementById("placeholder")){
  			document.getElementById("placeholder").style.left = -40+"px";
  			document.getElementById("placeholder").style.top = -13+"px";
  		}
  		search_highlight();
  		}, false);
}

window.onload = function(){imgAutoChange();
							changeImgsByImgs(document.getElementsByClassName("next")[0],document.getElementsByClassName("prev")[0],document.getElementById("content_list_hot"),document.getElementById("content_list_items_hot"));
							changeImgsByImgs(document.getElementsByClassName("next")[1],document.getElementsByClassName("prev")[1],document.getElementById("content_list_recommend"),document.getElementById("content_list_items_recommend"));
							}

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

window.onload = search_highlight;

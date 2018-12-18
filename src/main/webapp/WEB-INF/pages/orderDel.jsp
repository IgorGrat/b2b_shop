<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=windows-1251" language="java" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<script type="text/javascript" src="../resources/javaScript/jquery-1.8.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/tableScroll.css"/>
<link rel="stylesheet" type="text/css" href="../resources/css/basketTable.css"/>
<link rel="stylesheet" type="text/css" href="../resources/css/stockTable.css"/>
<link rel="stylesheet" type="text/css" href="../resources/css/myStyle.css"/>
<link rel="stylesheet" type="text/css" href="../resources/css/innerWindow.css"/>
<link rel="stylesheet" type="text/css" href="../resources/css/selectedRow.css"/>

	<title>Формирование заказа</title>
</head>

<body bgcolor="#c0c0c0">
<p class="title nowrap">Форма заказов</p>

 
<div class="block"><span> Форма заказа товаров </span></div> 
<div class= "topLine"></div>
	
	<div id="wrap" onclick=show("none")></div>
    <div id="window"></div>

<p class="title nowrap"> Выбор валюты : </p>
	<select style="width: 160px" size = "1" id="pay" name="val">
	</select> <br style="hight:150px">
<p class="title nowrap">Выбор категории  :</p>
    <select style="width: 160px"  size = "1" id="category" name="val">
	</select>
<p class="title nowrap"> Группа товаров : </p>
    <select style="width: 160px" size = "1" id="group" name="val">
	</select>

    <script>fill("category")</script>
    <script>fill("group", "")</script> 
    <script>fill("pay")</script>

<table class="scroll stockTable">
    <thead>
    <tr>
        <th> п/п </th>
        <th> Индекс </th>
        <th> Бренд </th>
        <th> Наименование товара </th>
        <th> Кол-во </th>
        <th> Цена </th>
        <th>Вид</th>
    </tr>

	</thead>

    <tbody id="tbody">

	</tbody>
</table>

<table align="left"></table>
<p	class="text">Заказанный товар покупателем </p> 
<p	align="left">
<table  class="scroll basketTable">
    <thead>
    <tr>
        <th> п/п </th>
        <th> Индекс </th>
        <th> Бренд </th>
        <th> Наименование товара </th>
        <th> Заказ </th>
        <th> Цена </th>
        <th>Сумма</th>
        <th>Удалить</th>

		</tr>
    </thead>
    <tbody id="basket">
    </tbody>
</table>
</p>

<form class="formtable" method="post" action="../registrationOrder"
       name="information" id="information">
       <span>Общая сумма заказа</span>
       <span align="left" class="nowrap" id="result"></span>
	<br><br>
	Реквизиты заказчика <input type="text" name="customer" size="15" maxlength="20">
    
	Реквизиты получателя <input type="text" name="receiver" size="15" maxlength="20">
    <br><br>
    Телефон <input type="text" name="phone" size="15" maxlength="20">
    Способ доставки:
    <select size = "1" name="sheepedCompany">
        <option value = 0>Самовывоз с нашего склада</option>
        <option value = 1>Доставка нашим транспортом</option>
    </select>
    <br><br>
	Коментарий <input type="text" name="comment" size="80" maxlength="100">
	<br><br>
Доверенность:
    <input type="text" name="warrantName" size="15" maxlength="20" placeholder="доверенное лицо">
    <input type="text" name="warrantNumb" size="15" maxlength="20" placeholder="номер">
    <input type="text" name="warrantDate" size="15" maxlength="20" placeholder="дата">
    <input type="hidden" name="index" value="old" id="hiddenField">
    <input type="submit"  name="btnSubmit" value="добавить заказ" width="20">

	
</form>

</body>
<script>

    var resultSum=0;
    var nodeArray=[];

    function round(num){
        num*=100; num=Math.round(num); num/=100;
        return num;
    }
    function changeResult(){
        resultSum=0;
        for(i=0;  i<nodeArray.length;  i++ ){
            var row = nodeArray[i];
            row.childNodes[1].innerHTML=i+1;
            if(row.childNodes[13].innerHTML!=''){
                resultSum+=parseFloat(row.childNodes[13].innerHTML);
            }
        }var result= document.getElementById("result");
        result.innerHTML=round(resultSum);
    }
    function delGoodInBasket(row) {
        var num=row.childNodes[1].innerHTML;
        nodeArray[ parseInt(num)-1]
        var element= parseInt(num)-1;
        nodeArray.splice(element, 1);
        row.remove();
        changeResult();
    }
    function addGoodInBasket(row) {
        var basket= document.getElementById("basket");
        var input = document.createElement('input');
        input.setAttribute("type" , "text");
        input.setAttribute("name", "input");
        input.setAttribute("style", "width:100%; text-align:right");
        input.setAttribute("maxlength","10");
        $(input).focusin(function(){
            this.style.background = "white";});
        $(input).focusout(function(){
            var parent=this.parentNode;
            parent=parent.parentNode;
            parent.childNodes[13].innerHTML='';

            if (isNaN(this.value)|| parseInt(this.value)!=this.value || this.value=='0') {
                this.style.background = "red";
            }
            else{
                this.style.background = "white";
                var val = parseInt(this.value);
                var cell=parent.childNodes[11].innerHTML;
                var price= parseFloat(cell);
                sum=val*price;
                sum=round(sum);
                parent.childNodes[13].innerHTML=sum;
            }changeResult();
        });
        var chaild=row.childNodes[9];
        chaild.replaceChild(input, chaild.childNodes[0]);
        var text=document.createTextNode("");
        chaild=row.childNodes[13];
        chaild.replaceChild(text, chaild.childNodes[0]);
        var td=document.createElement('td');
        var del_image = document.createElement('input');
        del_image.setAttribute("type" , "image");
        del_image.setAttribute("style", "width:100%");
        del_image.setAttribute("src", "../resources/image/del.png");
        td.appendChild(del_image);
        row.appendChild(td);
        nodeArray[nodeArray.length]=row;
        basket.appendChild(row); $(input).focus();
    }
    function fill(name, id) {
        $.ajax({
            type: "POST",
            url: "../goods/"+name,
            cache: false,
            data: "id="+id,
            success: function(html){
                $("#"+name).html(html);
            }
        });
    }
    function fillTable(idg , idc) {
        $.ajax({
            type: "POST",
            url: "../stock",
            cache: false,
            data: "gr_id="+idg+"&cs_id="+idc,
            success: function(html){
                $('#tbody').html(html);
            }
        });
    }
    function selectedRow(row) {
        $(row).addClass("selected").siblings().removeClass("selected");
    }

    function clear(id) {
        var element=document.getElementById(id);
        element.innerHTML='';
    }
    function show(state){
        document.getElementById('window').style.display = state;
        document.getElementById('wrap').style.display = state;
    }
    $(document).ready(function(){
        $('#basket').on('click', function(event){
            if(event.target.getAttribute("type")==="checkbox"){
                var cell = event.target.parentNode;
                delGoodInBasket(cell.parentNode);
            }
        });
        $('#tbody').on('click', function(event){
            var target = event.target;
            var parent=target.parentNode;
            if (target.tagName === 'BUTTON') {
                var row=parent.parentNode;
                show("block");
                $.ajax({
                    type: "GET",
                    url: "../advance/"+row.getAttribute("id"),
                    cache: false,
                    success: function(html){
                        $("#window").html(html);
                    }
                });
            }else{addGoodInBasket(parent.cloneNode(true)); selectedRow(parent);};
        });
        $('#category').change(function () {
            var id=$(this).val();
            fill("group", id);
            clear("tbody");
        });
        $('#group').change(function () {
            var idx=$(this).val();
            var idc=$("#pay").val();
            if(idc==''){return;}
            fillTable(idx, idc);
        });
        $('#pay').change(function () {// Пока так, в дальнейшем сделать через извлечение слушателя
            if(nodeArray.length!=0){
                alert("Корзина не пустая"); return false;
            }
            var idx=$("#group").val();
            var idc=$(this).val();
            if(idx==''){return false;}
            fillTable(idx, idc);
        });
        $('#information').on('submit', function(event){
            event.preventDefault();
            if(nodeArray.length==0){return false;}
            var form = this;
            var message='';
            var  orderArray = new Array();
            orderArray[orderArray.length]=$("#pay").val();
            for(var i=0; i<nodeArray.length; i++ ){
                var node=nodeArray[i];
                if(node.childNodes[13].innerHTML==''){
                    message+='\n номер  # '+node.childNodes[1].innerHTML; continue;}
                var id=node.getAttribute("id");
                var price=node.childNodes[11].innerHTML;
                var qu=node.childNodes[9].childNodes[0].value;
                orderArray[orderArray.length]=id;
                orderArray[orderArray.length]=qu;
                orderArray[orderArray.length]=price;
            }
            if(message=='' || confirm((message+="\n В этих позициях " +
                            "отсутсвует количество продолжить ?"))){
                $.ajax({
                    type: "POST",
                    url: "../sendBasket",
                    cache: false,
                    //	data: {'orderArray':orderArray},
                    data: "orderArray="+orderArray,
                    dataType: "text",
                    async: true,
                    success: function(html){
                    },
                }).done(function(html) {
                    var index = $(form).find("input:hidden[name=index]")[0];
                    index.value=html;
                    $(form).unbind('submit');
                    $(form).trigger('submit');
                }).fail(function() {
                    alert( "Нет ответа от сервера" );
                }).always(function() {
                });
            }
        });
    });
</script>
</html>

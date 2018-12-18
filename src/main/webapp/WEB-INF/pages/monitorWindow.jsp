<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=windows-1251" language="java" %>
<html>
<head>
    <title>Статус Заказов</title>
    <script type="text/javascript" src="../resources/javaScript/jquery-1.8.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../resources/css/tableScroll.css"/>
    <link rel="stylesheet" type="text/css" href="../resources/css/monitorWindow.css"/>
    <link rel="stylesheet" type="text/css" href="../resources/css/selectedRow.css"/>
    <link rel="stylesheet" type="text/css" href="../resources/css/freezeRow.css"/>
    <link rel="stylesheet" type="text/css" href="../resources/css/buttonStack.css"/>
    <link rel="stylesheet" type="text/css" href="../resources/css/styleStack.css"/>
</head>
<body background="../resources/image/foneMonitor.png">
<div class="freezeRow">Форма состояния заказов</div>
<div class="list" style="margin-top:80px">

    <div style="margin-bottom: 10px;"align="center">
        <h1 align="center" class="style_2"> Текущие заказы </h1>
        <table class="scroll stampTable">
            <thead>
            <tr>
                <th> п/п </th>
                <th> штамп </th>
                <th> счет # </th>
                <th> дата </th>
                <th> сумма </th>
                <th> тип </th>
                <th> коментарий </th>
                <th> менеджер </th>
                <th> статус </th>
                <th> этап </th>
            </tr>
            </thead>
            <tbody id="tStamps" style="height: 100px;  background: white">
            <tr>
                <td> 1 </td>
                <td>XAAA-576</td>
                <td> 123456789 </td>
                <td> 03.10.2015 </td>
                <td> 67.65 </td>
                <td> USD </td>
                <td> Отгрузить </td>
                <td> Степанов В.В </td>
                <td> обработка </td>
                <td><input type="image"  src="../resources/image/up.png"></td>
            </tr>
            </tbody>
        </table>
    </div>

    <form id="info_box" style="float: left; border: 2px dashed; padding: 10px 5px 5px 5px">
        <h3 style="color: navy" align="center">Расширенная информация</h3>
        <div style="border : 3px double grey; padding: 5px">
            <input type="hidden" value="" name="index">
            <div align="right" style="padding: 5px 0px 5px 0px"> Заказчик <input type="text" name="customer" size="20" maxlength="20"></div>
            <div style="padding: 5px 0px 5px 0px">Получатель <input type="text" name="receiver" size="20" maxlength="20"></div>
            <div align="right" style="padding: 5px 0px 5px 0px">Телефон <input type="text" name="phone" size="20" maxlength="20"></div></div>
        <div style="padding: 5px 0px 5px 0px">

            Доставка:<select size = "1" name="sheepedCompany">
            <option value = 0>Самовывоз с нашего склада</option>
            <option value = 1>Доставка нашим транспортом</option>
        </select>
        </div>
        <div style="padding: 5px 0px 5px 0px">Коментарий <textarea style="vertical-align: bottom" rows="3" cols="20px" name="coment"></textarea></div>
        <h4 style="color: navy" align="center">Данные доверенности</h4>
        <div style="padding: 5px 0px 5px 0px">Доверенное лицо <input type="text" name="warrantName" size="15" maxlength="50"></div>
        <div style="padding: 5px 0px 5px 0px">Номер <input type="text" name="warrantNumb" size="15" maxlength="16"></div>
        <div style="padding: 5px 0px 5px 0px">Дата <input type="text" name="warrantDate" size="15" maxlength="20"></div>
        <div align="right"> <input type="submit" id="btn_save_info_box"  name="btnSubmit" class="button_2" value="Сохранить изменения" width="20"></div>
    </form>

    <div  style="float: right" align="center" >
        <h2 class="style_2">Состав заказа</h2>
        <table class="scroll goodsTable">
            <thead>
            <tr>
                <th> п/п </th>
                <th> индекс </th>
                <th> найменование </th>
                <th> к-во </th>
                <th> V(м3) </th>
                <th> W(кг) </th>
                <th> ячейка </th>
                <th> ок </th>
            </tr>
            </thead>
            <tbody id="tGoods" style="height: 300px; background: white">
            </tbody>
        </table>
    </div>
    <div  style="clear: both"></div>

</div>
</body>


<script>
    var ok=document.createElement("img");
    ok.setAttribute('src', '../resources/image/ok.png');
    var cancel=document.createElement("img");
    cancel.setAttribute('src', '../resources/image/cancel.png');
    var selected_stamp="";

    $(document).ready(function(){
        $('#tStamps').on('click', function(event){
            var target = event.target;
            var row=target.parentNode;
            var stamp=$(row).attr("id");
            selectedRow(row);
            fillGoodsTable(stamp);
            fillInfoBox(stamp);
            repaint(stamp);
        });
        fillStampTable();
        setInterval('updateForm()',  600000);
    });
    function updateForm(){
        fillStampTable();
        setDefoultRow(selected_stamp);
    }
    function repaint(stamp){
        if(stamp==""){return;}
        var mask=getStatusOrder(stamp);
        if(mask==""){return;}
        var stock=new Array();
        for(var i=0; i<12; i++){
            var num=mask>>2*i & 3;
            stock[i]=num;
        }
        var table=window.document.getElementById("tGoods");
        var nodes=table.childNodes;
        for(var i=0; i<nodes.length; i++){
            var row=nodes[i];
            if(row.nodeType!=1){continue;}
            var cell=row.childNodes[13];
            var num=parseInt(cell.innerHTML);
            cell=row.lastElementChild;
            var last=cell.firstChild;
            var picture=stock[num]==null || stock[num]<3? cancel.cloneNode(true) : ok.cloneNode(true);
            if(last==null){cell.appendChild(picture);
            }else{cell.replaceChild(picture, cell.firstChild);}
        }
    }
    function setDefoultRow(stamp){
        var table=window.document.getElementById('tStamps');
        var nodes=table.childNodes;
        for(var i=0; i<nodes.length; i++) {
            var row = nodes[i];
            if(row.nodeType!=1){continue;}
            if ($(row).attr("id") == stamp) {
                repaint(stamp); selectedRow(row);  return;
            }
        }clear_content('tGoods');
    }
    function clear_content(id){
        $(id ).innerHTML='';
    }
    function selectedRow(row) {
        selected_stamp=$(row).attr("id");
        $(row).addClass("selected").siblings().removeClass("selected");
    }
    function fillInfoBox(stamp){
        $.ajax({
            type: "POST",
            url: "../infoBox",
            async: true,
            dataType: "json",
            data: "stamp="+stamp,
            cache: false,
        }).done(function(data) {
            var  elements= $("#info_box").find("input, textarea, select");
            for(var val, i=0; i<data.length; i++){
                var elem=elements[i];
                val=data[i];
                if($(elem).prop("tagName")=="SELECT"){
                    $(elem[value=val]).attr("selected", "selected");
                }else{
                    $(elem).val(val);}
                }
        }).fail(function() {
            alert( "Нет ответа от сервера" );
        });
    }
    function fillStampTable () {
        $.ajax({
        type: "GET",
        url: "../ordersClient",
        async: false,
        dataType: "text",
        cache: false,
        timeout: 1000
        }).done(function(html) {
            $('#tStamps').html(html);
        }).fail(function(jqXHR, textStatus, errorThrown) {
            alert(errorThrown+" Нет ответа от сервера "+textStatus );
        });
    }
    function fillGoodsTable (stamp) {
        $.ajax({
            type: "POST",
            url: "../consistOrder",
            async: false,
            data: "stamp="+stamp,
            cache: false,
        }).done(function(html) {
            $('#tGoods').html(html);
        }).fail(function() {
            alert( "Нет ответа от сервера" );
        });
    }
    function  getStatusOrder (stamp) {
        var mask="";
        $.ajax({
            type: "POST",
            url: "../statusOrder",
            dataType: "text",
            async: false,
            data: "stamp="+stamp,
            cache: false,
        }).done(function(html) {
            mask=html;
        }).fail(function() {
            alert( "Нет ответа от сервера" );
        });
        return mask;
    }
</script>

</html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=windows-1251" language="java" %>
<html>
<head>
    <title>statusReady</title>
    <script type="text/javascript" src="../resources/javaScript/jquery-1.8.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../resources/css/tableScroll.css"/>
    <link rel="stylesheet" type="text/css" href="../resources/css/monitorWindow.css"/>
    <link rel="stylesheet" type="text/css" href="../resources/css/selectedRow.css"/>
    <link rel="stylesheet" type="text/css" href="../resources/css/buttonStack.css"/>

</head>
<body>
<table class="scroll stampTable">
    <thead>
    <tr>
        <th> п/п </th>
        <th> штамп </th>
        <th> счет # </th>
        <th> дата </th>
        <th> сумма </th>
        <th> остаток </th>
        <th> тип </th>
        <th> комент </th>
        <th> менеджер </th>
        <th> статус </th>
    </tr>
    </thead>
    <tbody id="tStamps">
    </tbody>
</table>

<table class="scroll goodsTable">
    <thead>
    <tr>
        <th> п/п </th>
        <th> индекс </th>
        <th> найменование </th>
        <th> к-во </th>
        <th> V(м3) </th>
        <th> M(кг) </th>
        <th> ячейка </th>
        <th> статус </th>
    </tr>
    </thead>
    <tbody id="tGoods">
    </tbody>
</table>

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
            repaint(stamp);
        });
        fillStampTable();
        setInterval('updateForm()',  20000);
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
        console.log("nodes.length="+nodes.length);

        for(var i=0; i<nodes.length; i++){
            var row=nodes[i];
            if(row.nodeType!=1){continue;}
            var cell=row.childNodes[13];
            var num=parseInt(cell.innerHTML);
            cell=row.lastElementChild;
            var last=cell.firstChild;
            var picture=stock[num]==null || stock[num]<3? cancel.cloneNode(true) : ok.cloneNode(true);
            if(last==null){cell.appendChild(picture); console.log("AppendChild");
            }else{cell.replaceChild(picture, cell.firstChild); console.log("replaceChild");}
        }
    }
    function setDefoultRow(stamp){
        var table=window.document.getElementById('tStamps');
        var nodes=table.childNodes;
        console.log("setDefoultRow selected="+selected_stamp);
        for(var i=0; i<nodes.length; i++) {
            var row = nodes[i];
            if(row.nodeType!=1){continue;}

            if ($(row).attr("id") == stamp) {

                console.log("setDefoultRow find="+selected_stamp);

                repaint(stamp); selectedRow(row);  return;
            }
        }clear_content('tGoods');
    }
    function clear_content(id){
        $(id ).innerHTML='';
    }
    function selectedRow(row) {
        console.log("selectedRow="+row);


        selected_stamp=$(row).attr("id");
        console.log("selectedRowIndex="+$(row).attr("id"));
        $(row).addClass("selected").siblings().removeClass("selected");
    }

    function fillStampTable () {
        $.ajax({
        type: "GET",
        url: "../ordersClient",
        async: false,
        dataType: "text",
        cache: false,
        }).done(function(html) {
            $('#tStamps').html(html);
        }).fail(function() {
            alert( "Нет ответа от сервера" );
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

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=windows-1251" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<script type="text/javascript" src="resources/javaScript/jquery.js"></script>

<html>
<head>
	<title>Registration</title>
</head>

<body>

<script>

    $(document).ready(function(){

        $("#form_regic").submit(function(){

            var name = $("#login").val();
            var password  = $("#password").val();
            var succes='';
            if (name =='') {
                alert ("Заполните имя пользователя !");
                return false;
            }
            if (password =='') {
                alert ("Введите пароль !");
                return false;
            }

            $.ajax({
                type: "POST",
                url: "controlUserSession",
                data: "login="+name+"&password="+password,
                dataType: "text",
                async: false,
                success: function(respon){
                    if(respon==''){succes='ok'; return true;}
                    $("#result").html("Проверьте правильность ввода данных");
                }
            });
            return succes=='ok';
        });
    });
</script>
<img src="resources/image/logo.png" alt="" border="0" align="left">

<span align="left"><strong><h1>Форма аутентификация пользователей</h1></strong></span>

<form action="mainWindow" name="form_regic" id="form_regic">

<strong>Login</strong> <input type='text' name='login' id='login' size='10' maxlength='20'>

<strong>Password</strong> <input type='password' name='password' id='password' size='10' maxlength='20'>

<input type="submit" name="submit" id="submit" value="registration" width="12" height="8">
<br>
<br>
Состояние выполнения запроса: <div id="result"></div>
</form>

</body>
</html>

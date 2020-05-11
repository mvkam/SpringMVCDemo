<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Prog.kiev.ua</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</head>

<body>
<div class="container">
    <h3><img height="50" width="55" src="<c:url value="/static/logo.png"/>"/><a href="/">Contacts List</a></h3>

    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul id="groupList" class="nav navbar-nav">
                    <li><button type="button" id="add_contact" class="btn btn-default navbar-btn">Add Contact</button></li>
                    <li><button type="button" id="add_group" class="btn btn-default navbar-btn">Add Group</button></li>
                    <li><button type="button" id="delete_contact" class="btn btn-default navbar-btn">Delete Contact</button></li>
                    <li><button type="button" id="delete_group" class="btn btn-default navbar-btn">Delete Group</button></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Groups <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="/">Default</a></li>
                            <c:forEach items="${groups}" var="group">
                                <li><a href="/group/${group.id}">${group.name}</a></li>
                            </c:forEach>
                        </ul>
                    </li>
                </ul>
                <form class="navbar-form navbar-left" role="search" action="/search" method="post">
                    <div class="form-group">
                        <input type="text" class="form-control" name="pattern" placeholder="Search">
                    </div>
                    <button type="submit" class="btn btn-default">Submit</button>
                </form>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>

    <table class="table table-striped">
        <thead>
        <tr>
            <td></td>
            <td><b>Name</b></td>
        </tr>
        </thead>
        <c:forEach items="${groups}" var="group">
            <tr>
                <td><input type="checkbox" name="toDelete[]" value="${group.id}" id="checkbox_${group.id}"/></td>
                <td>${group.name}</td>
            </tr>
        </c:forEach>
        <tr>
            <td><button type="button" id="del_groups" class="btn btn-default navbar-btn">Delete</button></td>
            <td><button type="button" id="back" class="btn btn-default navbar-btn" onclick="history.back();">Back</button></td>
        </tr>
    </table>
</div>

<script>
    $('.dropdown-toggle').dropdown();

    $('#add_contact').click(function(){
        window.location.href='/contact_add_page';
    });

    $('#add_group').click(function(){
        window.location.href='/group_add_page';
    });

    $('#delete_group').click(function(){
        window.location.href='/group_del';
    });

    $('#del_groups').click(function(){
        var data = { 'toDelete[]' : []};
        $(":checked").each(function() {
            data['toDelete[]'].push($(this).val());
        });
        $.post("/groups_del", data, function(data, status) {
            window.location.reload();
        });
    });
</script>

</body>
</html>
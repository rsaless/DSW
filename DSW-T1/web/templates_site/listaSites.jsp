<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!DOCTYPE html>
<f:bundle basename="i18n.sistema">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/DSW-T1/css/bootstrap.css">
        <link href="https://fonts.googleapis.com/css?family=Questrial" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="/DSW-T1/css/glyphicon.css"> <!-- adicionado pra usar ícones-->
        <title><f:message key="listaSites.title" /></title>
    </head>
    <style>
        body{
            font-family: 'Questrial', sans-serif;
        }
        h1{
            font-size: 2.5em;
        }
        p{
            padding-left: 30px;
            color: gray;
            font-size: 1.5em;
        }
    </style>
    <body>
        <div class="container">
            <nav class="navbar navbar-default">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <a href="/DSW-T1" class="btn btn-default btn-lg"><f:message key="index.pageTitle" /></a>
                        <a href="/DSW-T1/promocao/lista" class="btn btn-default btn-lg"><f:message key="index.promocoes" /></a>
                        <a href="/DSW-T1/site/lista" class="btn btn-default btn-lg"><f:message key="index.sites" /> </a>
                        <a href="/DSW-T1/teatro/lista" class="btn btn-default btn-lg"><f:message key="index.teatros" /></a>
                    </div>
                </div>
            </nav>
        </div>
        </br>
        <center>
            <h1><f:message key="listaSites.bigTitle" /></h1>
            </br> </br>
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <p>
                            Veja aqui a lista de sites que ofertam promoções no nosso sistema.
                        </p>
                    </div>
                    <div class="col-lg-6">
                        <h2>
                            <a href="/DSW-T1/site/cadastro" class="btn btn-success btn-lg"><f:message key="listaSites.goToAdd" /> <span class="glyphicon glyphicon-plus-sign"></span></a>
                        </h2>
                    </div>
                </div>
            </div>
        </center>
        </br> </br> 
        <div align="center">
            <h2><f:message key="listaSites.pageTitle" /></h2>
            </br>
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-md-offset-6">
                        <table class="table table-bordered table-striped table-hover">
                            <tr class="col-md-2">
                                <th class="text-center"><f:message key="listaSites.table.id" /></th>
                                <th class="text-center"><f:message key="listaSites.table.nome" /></th>
                                <th class="text-center"><f:message key="listaSites.table.email" /></th>
                                <th class="text-center"><f:message key="listaSites.table.senha" /></th>
                                <th class="text-center"><f:message key="listaSites.table.telefone" /></th>
                                <th class="text-center"><f:message key="listaSites.table.url" /></th>
                                <th class="text-center"><f:message key="listaSites.table.acoes" /></th>
                            </tr>
                            <c:forEach var="site" items="${requestScope.listaSites}">
                                <tr>
                                    <td class="text-center" ><c:out value="${site.id}" /></td>
                                    <td><c:out value="${site.nome}" /></td>
                                    <td class="text-center"><c:out value="${site.email}" /></td>
                                    <td><c:out value="${site.senha}" /></td>
                                    <td><c:out value="${site.url}" /></td>
                                    <td class="text-center"><c:out value="${site.telefone}" /></td>
                                    <td class="text-center">
                                    <a href="/DSW-T1/site/edicao?id=<c:out value='${site.id}' />"><span class="glyphicon glyphicon-pencil"></span></a>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <a href="/DSW-T1/site/remocao?id=<c:out value='${site.id}' />" 
                                        onclick="return confirm('<f:message key="remover.confirm" />');">
                                            <span class="glyphicon glyphicon-trash"></span>
                                    </a>  
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <a href="/DSW-T1/site/detalhes?id=<c:out value='${site.id}' />"><f:message key="listaSites.table.acoes.detalhes"/></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
</html>
</f:bundle>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<f:bundle basename="i18n.sistema">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/DSW-T1/css/bootstrap.css">
        <link href="https://fonts.googleapis.com/css?family=Questrial" rel="stylesheet"> 
        <link rel="stylesheet" type="text/css" href="/DSW-T1/css/glyphicon.css"> <!-- adicionado pra usar ícones-->
        <title><f:message key="listaPromocoes.title" /></title>
        <script src="/DSW-T1/js/ListaTeatroAJAX.js"></script>
    </head>
    <style>
        .bg{
            background-color: #8E2DE2;  /* fallback for old browsers */
            background: -webkit-linear-gradient(to bottom, #7700e0, #8E2DE2);  /* Chrome 10-25, Safari 5.1-6 */
            background: linear-gradient(to bottom, #7700e0, #8E2DE2); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
        }
        body{
            font-family: 'Questrial', sans-serif;
            color: white;
            height: 100%;
            margin: 0;
            padding: 0;
            background-color: #8E2DE2;
        }
        h1{
            font-size: 2.8em;
        }
        h2{
            font-size: 2.3em;
        }
        p{
            padding-left: 30px;
            color: #f7f7f7;
            font-size: 1.5em;
        }
    </style>
    <body>
        <div class="bg">
            <div class="container-fullwidth">
                <nav class="navbar navbar-expand-lg bg-light navbar-light">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <a href="/DSW-T1" class="btn btn-default btn-lg"><f:message key="index.pageTitle" /></a>
                            <a href="/DSW-T1/promocao/lista" class="btn btn-default btn-lg"><f:message key="index.promocoes" /></a>
                            <a href="/DSW-T1/site/lista" class="btn btn-default btn-lg"><f:message key="index.sites" /> </a>
                            <a href="/DSW-T1/teatro/lista" class="btn btn-default btn-lg"><f:message key="index.teatros" /></a>
                            <sec:authorize access="hasAnyRole('ADMIN', 'SITE', 'TEATRO')">
                                <a href="/DSW-T1/logout" class="btn btn-default btn-lg">Logout</a>
                            </sec:authorize>
                            <sec:authorize access="isAnonymous()">
                                <a href="/DSW-T1/login" class="btn btn-default btn-lg">Login</a>
                            </sec:authorize>
                        </div>
                    </div>
                </nav>
            </div>
            </br>
            <center>
                <h1><f:message key="listaPromocoes.bigTitle" /></h1>
                </br> </br>
                <div class="container">
                    <div class="row">
                        <sec:authorize access="hasAnyRole('ADMIN', 'TEATRO')">
                            <div class="col-lg-6">
                        </sec:authorize>
                        <sec:authorize access="isAnonymous() or hasAnyRole('SITE')">
                            <div class="col-lg-12">
                        </sec:authorize>
                                <p>
                                    Veja aqui a lista de promoções ofertadas no nosso sistema.
                                </p>
                            </div>
                        <sec:authorize access="hasAnyRole('ADMIN', 'TEATRO')">
                            <div class="col-lg-6">
                                <h2>
                                    <a href="/DSW-T1/promocao/cadastro" class="btn btn-success btn-lg"><f:message key="listaPromocoes.goToAdd" />&nbsp;&nbsp;<span class="glyphicon glyphicon-plus-sign"></span></a>
                                </h2>
                            </div>
                        </sec:authorize>
                    </div>
                </div>
            </center>
            </br> </br> 
            <div align="center">
                <h2><f:message key="listaPromocoes.pageTitle" /></h2>
                </br>
                <input class="form-control mb-4 col-md-2" type="number" name="busca" placeholder="<f:message key="listaPromocoes.busca" />" oninput='buscarPromocoes(this.value)'/>
                </br> </br>
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 col-md-offset-6">
                            <table class="table table-light table-bordered table-striped table-hover">
                                <thead class="thead-dark">
                                    <tr class="col-md-2">
                                        <th class="text-center"><f:message key="listaPromocoes.table.id" /></th>
                                        <th class="text-center"><f:message key="listaPromocoes.table.site" /></th>
                                        <th class="text-center"><f:message key="listaPromocoes.table.peca" /></th>
                                        <th class="text-center"><f:message key="listaPromocoes.table.data" /></th>
                                        <th class="text-center"><f:message key="listaPromocoes.table.hora" /></th>
                                        <th class="text-center"><f:message key="listaPromocoes.table.preco" /></th>
                                        <th class="text-center"><f:message key="listaPromocoes.table.cnpj" /></th>
                                        <sec:authorize access="hasAnyRole('ADMIN', 'TEATRO')">
                                            <th class="text-center"><f:message key="listaPromocoes.table.acoes" /></th>
                                        </sec:authorize>
                                    </tr>
                                </thead>
                                    <tbody id="tbodyresposta">
                                        <c:forEach var="promocao" items="${requestScope.listaPromocoes}">
                                            <tr>
                                                <td class="text-center"><c:out value="${promocao.id}" /></td>
                                                <td class="text-center"><c:out value="${promocao.url}" /></td>
                                                <td class="text-center"><c:out value="${promocao.nome_peca}" /></td>
                                                <td class="text-center"><c:out value="${promocao.dia}" /></td>
                                                <td class="text-center"><c:out value="${promocao.hora}" /></td>
                                                <td class="text-center"><c:out value="${promocao.preco}" /></td>
                                                <td class="text-center"><c:out value="${promocao.cnpj}" /></td>
                                                <sec:authorize access="hasAnyRole('ADMIN', 'TEATRO')">
                                                    <c:if test="${ADMIN == true || promocao.cnpj == cnpj_encontrado}">
                                                        <td class="text-center">
                                                            <a href="/DSW-T1/promocao/edicao?id=<c:out value='${promocao.id}' />">
                                                                <span class="glyphicon glyphicon-pencil"></span>
                                                            </a>
                                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                                            <a href="/DSW-T1/promocao/remocao?id=<c:out value='${promocao.id}' />" 
                                                               onclick="return confirm('<f:message key="remover.confirm" />');">
                                                               <span class="glyphicon glyphicon-trash" style="color:red"></span>
                                                            </a>
                                                        </td>
                                                    </c:if>
                                                    <c:if test="${ADMIN != true && promocao.cnpj != cnpj_encontrado}">
                                                        <td class="text-center"> -                	
                                                        </td>
                                                    </c:if>
                                                </sec:authorize>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
</html>
</f:bundle>

<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file ="lib/Conexao.asp"-->
<%
IF REQUEST("Operacao") = 1 THEN
call abreConexao
sql = "INSERT INTO GU_Arquivos(Titulo, Descricao, Arquivo) VALUES('"&request.form("txtTitulo")&"', '"&request.form("txtDescricao")&"', '"&request.form("upload")&"')"

conn.execute(sql)
response.Redirect("CadUpload.asp")
call fechaConexao 
END IF
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Cadastro de Upload</title>
<script type="text/javascript">
function validar() {
	if(document.frmUpload.txtTitulo.value == ""){
   		alert("Obrigatorio digitar o CPF!");
   		document.frmUpload.txtTitulo.focus();
		return false;
	}
	if(document.frmUpload.txtDescricao.value == ""){
         alert("Obrigatório digitar o Nome!");
         document.frmUpload.txtDescricao.focus();
         return false;
     }
     return true;
}
function cadastrar(){
    if(validar() == false)
    return false;
	alert("Oiiii")
	document.frmUpload.Operacao.value = 1;
	document.frmUpload.action = "CadUpload.asp";
	document.frmUpload.submit();
}
</script>
</head>
<body>
<h1>Anexar Documentos</h1>
<form name="frmUpload" id="frmUpload" method="post">
<input type="hidden" name="Operacao" id="Operacao" />
<p>Título: <br />
<input type="text" name="txtTitulo" id="txtTitulo" />
</p>
<p>Descrição: <br />
<input type="text" name="txtDescricao" id="txtDescricao" size="80"/>
</p>
<p>
<input type="file" name="upload" accept="application/pdf" ><br><br>
</p>
<input type="submit" name="btnCadastrar" value="Cadastrar" onclick="return cadastrar();"/>
</form>

</body>
<%
   call abreConexao
   sql = "SELECT titulo, Descricao, Arquivo FROM GU_Arquivos ORDER BY titulo;"
   set rs = conn.execute(sql)
%>

<table width="650" border="1" align="center">
  <%if rs.eof then%>
  <tr><td>Não Existe Nenhum Registro na base de Dados!</td></tr>
  <%else%>
  <tr>
  <th>Titulo</th>
  <th>Descrição</th>
  <th>Arquivo</th>
  <th>Ações</th>
  </tr>
  <%do while not rs.eof%>
  <tr>
  <td align="center"><%=rs("titulo")%></td>
  <td align="center"><%=rs("Descricao")%></td>
  <td align="center"><%=rs("Arquivo")%></td>
  <td align="center"><a href="#" onclick=""><img src="Imagens\download.png" width="30"/></a></td>
  </tr>
  <%
     rs.movenext
	 loop
  %>
  <%end if%>
</table>
<%call fechaConexao%>
</html>

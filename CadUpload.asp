<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file ="lib/Conexao.asp"-->
<!--#include file="upload.lib.asp"-->
<%

'IF REQUEST("Operacao") = 1 THEN
call abreConexao
 sql =  "SELECT * FROM GU_Arquivos"
  Set rs = conn.Execute(sql)
'sql = "INSERT INTO GU_Arquivos(Titulo, Descricao, Arquivo) VALUES('"&request.form("txtTitulo")&"', '"&request.form("txtDescricao")&"', "&request.form("upload")&"')"

'conn.execute(sql)
'response.Redirect("CadUpload.asp")
call fechaConexao 
'END IF
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="pt-br">
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
	document.frmUpload.Operacao.value = 1;
	document.frmUpload.action = "CrudUpload.asp?op=1";
	document.frmUpload.submit();
}
</script>
</head>
<body>
<h1>Anexar Documentos</h1>
<form name="frmUpload" enctype="multipart/form-data" method="POST" action="CrudUpload.asp?op=1">
<input type="hidden" name="Operacao" id="Operacao" />
<input type="text" name="idArquivo" id="idArquivo" value="<%=request("id")%>" hidden/>
<p>Título: <br />
<input type="text" name="txtTitulo" id="txtTitulo" />
</p>
<p>Descrição: <br />
<input type="text" name="txtDescricao" id="txtDescricao" size="80"/>
</p>
<input type="text" name="cpf" id="cpf" value="<%=Session("CPF_Usu")%>" hidden/>
<p>
<input type="file" name="upload" accept="application/pdf" ><br><br>
</p>
<input type="submit" name="btnCadastrar" value="Cadastrar" />
</form>

</body>
<%
   call abreConexao
   sql = "SELECT GU_Arquivos.Titulo, GU_Arquivos.Descricao, GU_CadPessoasUp.Nome, GU_Arquivos.Arquivo , FORMAT (getdate(), 'dd/MM/yyyy ') as data FROM GU_CadPessoasUp INNER JOIN GU_Arquivos ON GU_Arquivos.cpf = GU_CadPessoasUp.CPF ORDER BY titulo;"
   set rs = conn.execute(sql)
%>

<table width="650" border="1" align="center">
  <%if rs.eof then%>
  <tr><td>Não Existe Nenhum Registro na base de Dados!</td></tr>
  <%else%>
  <tr>
  <th>Titulo</th>
  <th>Descrição</th>
  <th>Nome Completo</th>
  <th>Arquivo</th>
  <th>Data</th>
  <th>Ações</th>
  </tr>
  <%do while not rs.eof%>
  <tr>
  <td align="center"><%=rs("titulo")%></td>
  <td align="center"><%=rs("Descricao")%></td>
  <td align="center"><%=rs("Nome")%></td>
  <td align="center"><a href="<%=rs("Arquivo")%>"><%=mid(rs("Arquivo"),10,100)&""%></a></td>
  <td align="center"><%=rs("data")%></td>
  <td align="center"><a href="<%=rs("Arquivo")%>" download><img src="Imagens\download.png" width="30"/></a></td>
  </tr>
  <%
     rs.movenext
	 loop
  %>
  <%end if%>
</table>
<%call fechaConexao%>
</html>

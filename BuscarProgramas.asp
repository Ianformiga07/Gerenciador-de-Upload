<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file ="lib/Conexao.asp"-->
<%


IF REQUEST("Operacao") = 2 THEN
call abreConexao
sql = "SELECT GU_Arquivos.Titulo, GU_Arquivos.Descricao, GU_CadPessoasUp.Nome, GU_Arquivos.Arquivo , FORMAT (getdate(), 'dd/MM/yyyy ') as data, GU_Programas.id, GU_Programas.Programas FROM GU_CadPessoasUp INNER JOIN GU_Arquivos ON GU_Arquivos.cpf = GU_CadPessoasUp.CPF INNER JOIN GU_Programas ON GU_Programas.id = GU_CadPessoasUp.CodPrograma WHERE GU_Programas.id ='"&request.form("programas")&"'"

set rs = conn.execute(sql)
	if not rs.eof then
	CodPrograma = rs("id")
	end if

END IF
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Buscar Programas</title>
<script type="text/javascript">
function visualizar()
{
	if(document.frmBusca.programas.value != ""){
	
	document.frmBusca.Operacao.value = 2;
	document.frmBusca.action = "BuscarProgramas.asp";
	document.frmBusca.submit();
	
	}

}
</script>
</head>
<body>
<form name="frmBusca" id="frmBusca" method="post">
<input type="hidden" name="Operacao" id="Operacao" />
<h4>Selecionar Programa</h4>
<p>Pastas: <br />
<% 
call abreConexao 
 sql = "SELECT id, Programas FROM GU_Programas order by Programas"
set rs1 = conn.execute(sql) 
%>
<select name="programas" id="programas">
<option value="">Selecionar</option>
<%do while not rs1.eof%>
<option value="<%=rs1("id")%>"<%IF rs1("id") = CodPrograma THEN%>selected<%END IF%>><%=rs1("Programas")%>
</option>
<% rs1.movenext 
			loop 
call fechaConexao
%>
</select>
</p>

<input type="submit" name="btnCadastrar" value="Buscar" onclick="return visualizar();"/>
</form>
</body>
<%IF REQUEST("Operacao") = 2 THEN%>
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
<%conn.nothing%>
<%END IF%>
</html>

<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>
<!--#include file ="lib/Conexao.asp"-->
<% 

IF REQUEST("OPERACAO") = 1 THEN 'CADASTRAR
	call abreConexao
 		sql="INSERT INTO GU_CadPessoasUp(CPF, Nome, idPerfil, CodPrograma, status, DataCadUsuario, cpfCad) VALUES('"&replace(replace(replace(request.form("txtCPF"),".",""),".", ""),"-","")&"', '"&request.form("txtNome")&"','"&request.form("perfil")&"', '"&request.form("programas")&"' , 1 , getdate(),'"&request.form("cpf")&"')"
	conn.execute(sql) 
	Session("CPF_Usu") = replace(replace(request.form("txtCPF"),".",""),"-","")
	response.Redirect("CadPessoaUp.asp?cpf="&Session("CPF_Usu")&"")
	call fechaConexao 
	
ELSEIF REQUEST("Operacao") = 2 THEN 'VISUALIZAR
	call abreConexao
	sql = "SELECT CPF, Nome, idPerfil, CodPrograma, status FROM GU_CadPessoasUp WHERE CPF = '"&replace(replace(request("CpfVisualizar"),".",""),"-","")&"'"
	set rs = conn.execute(sql)
	if not rs.eof then
	CPF = left(rs("CPF"),3)&"."&mid(rs("CPF"),4,3)&"."&mid(rs("CPF"),7,3)&"-"&right(rs("CPF"),2)
	Nome = rs("Nome")
	idPerfil = rs("idPerfil")
	CodPrograma = rs("CodPrograma")
	StatusUsuario = rs("status")
	Existe = 1
	else
	CPF = request.form("CpfVisualizar")
	Existe = 0 
	end if
	call fechaConexao
ELSEIF REQUEST("Operacao") = 3 THEN 'ALTERAR
	call abreConexao
	sql = "UPDATE GU_CadPessoasUp SET Nome = '"&request.Form("txtNome")&"', idPerfil = '"&request.form("perfil")&"', CodPrograma = '"&request.Form("programas")&"', status = '"&request.Form("status")&"' WHERE CPF = '"&replace(replace(replace(request.form("txtCPF"),".",""),".",""),"-","")&"'"
	RESPONSE.WRITE sql
	conn.execute(sql)
	call fechaConexao
	response.Redirect("CadPessoaUp.asp")
END IF

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="pt-br">
<title>Cadastro</title>
<script src="javascript/Mascara.js"></script>
<script type="text/javascript">
function validar() {
	if(document.frmCadastro.txtCPF.value == ""){
   		alert("Obrigatorio digitar o CPF!");
   		document.frmCadastro.txtCPF.focus();
		return false;
	}
	if(document.frmCadastro.txtNome.value == ""){
         alert("Obrigatório digitar o Nome!");
         document.frmCadastro.txtNome.focus();
         return false;
     }
     return true;
}
function cadastrar(){
    if(validar() == false)
    return false;

	document.frmCadastro.Operacao.value = 1;
	document.frmCadastro.action = "CadPessoaUp.asp";
	document.frmCadastro.submit();
}
function visualizar(cpf)
{	
	document.frmCadastro.Operacao.value = 2;
	document.frmCadastro.CpfVisualizar.value = cpf;
	document.frmCadastro.action = "CadPessoaUp.asp";
	document.frmCadastro.submit();
}
function verificar_cadastro()
{
	document.frmCadastro.Operacao.value = 2;
	document.frmCadastro.CpfVisualizar.value = document.frmCadastro.txtCPF.value;
	document.frmCadastro.action = "CadPessoaUp.asp";
	document.frmCadastro.submit();
}

function alterar()
{
	if(validar() == false)
	return false;
	
	document.frmCadastro.Operacao.value = 3;
	document.frmCadastro.action = "CadPessoaUp.asp";
	document.frmCadastro.submit();
}
function novo()
{
	document.frmCadastro.Operacao.value = 0;
	document.frmCadastro.txtCPF.value = '';
	document.frmCadastro.action = "CadPessoaUp.asp";
	document.frmCadastro.submit();
}
function upload(cpf)
{
	document.frmCadastro.Operacao.value = 5;
	document.frmCadastro.action = "CadUpload.asp?cpf="+cpf;
	document.frmCadastro.submit();
}

</script>
 </head>
<body>
<form id="frmCadastro" name="frmCadastro" method="post" onSubmit="return validar();">
<input type="hidden" name="Operacao" id="Operacao">
<input type="hidden" name="CpfVisualizar" id="CpfVisualizar">
<p><label>CPF: </label><br />
<input type="text" onKeyPress="MascaraCPF(txtCPF)"  name="txtCPF" id="txtCPF" value="<%IF Existe = 1 THEN Response.Write(CPF) ELSE Response.Write(Request("txtCPF")) END IF%>" maxlength="14" onBlur="MascaraCPF(txtCPF);verificar_cadastro();"<%IF REQUEST ("Operacao") = 2 AND Existe = 1 THEN%> readonly<%END IF%>/>
</p>
<p><label>Nome Completo: </label><br />
<input type="text" id="txtNome" name="txtNome" size="60" value="<%=Nome%>"/>
</p>
<p>Perfil: <br />
<% 
call abreConexao 
 sql="SELECT idPerfil, Perfil FROM GU_Perfil order by Perfil"
set rs=conn.execute(sql) 
%>
<select name="perfil" id="perfil">
<option value="">Selecionar</option>
<%do while not rs.eof%>
<option value="<%=rs("idPerfil")%>" <%if rs("idPerfil") = idPerfil then%>selected<%end if%>><%=rs("Perfil")%>
</option>
<% rs.movenext 
			loop 
call fechaConexao
%>
</select>
</p>
<p>Pastas: <br />
<% 
call abreConexao 
 sql="SELECT * FROM GU_Programas WHERE status = 1 order by Sigla"
set rs=conn.execute(sql) 
%>
<select name="programas" id="programas">
<option value="">Selecionar</option>
<%do while not rs.eof%>
<option value="<%=rs("id")%>" <%if rs("id") = CodPrograma then%>selected<%end if%>><%=rs("Sigla")%>
</option>
<% rs.movenext 
			loop 
call fechaConexao
%>
</select>
<%IF EXISTE = 1 THEN%>
<p>Status: <br />
<select name="status" id="status">
<option value="1" <%if StatusUsuario = true then%> selected <%end if%>> Ativo </option>
<option value="0" <%if StatusUsuario = false then%> selected <%end if%>> Desativo </option>
</select>
<%END IF%>
</p>
</p>
<input type="text" name="cpf" id="cpf" value="<%=Session("CPF_Usu")%>" hidden/>
<p>
<input type="submit" name="btnCadastro" value="<%IF Existe = 1 THEN%>Alterar<%ELSE%>Cadastrar<%END IF%>" onClick="return <%IF Existe = 1 THEN%>alterar();<%ELSE%>cadastrar();<%END IF%>" />
<%IF Existe = 1 THEN%>
<input type="button" name="btnNovo" value="Novo" onClick="return novo();" />

<%end if%>
</form>
</body>

<%
   call abreConexao
   sql = "SELECT GU_CadPessoasUp.CPF, GU_CadPessoasUp.Nome, GU_Perfil.Perfil, GU_Programas.Programas, FORMAT (getdate(), 'dd/MM/yyyy ') as DataCadUsuario,GU_CadPessoasUp.status AS statusUsuario FROM GU_CadPessoasUp INNER JOIN GU_Perfil ON GU_Perfil.idPerfil = GU_CadPessoasUp.idPerfil INNER JOIN GU_Programas ON GU_Programas.id = GU_CadPessoasUp.CodPrograma ORDER BY Nome;"
   set rs = conn.execute(sql)
%>

<table width="650" border="1" align="center">
  <%if rs.eof then%>
  <tr><td>Não Existe Nenhum Registro na base de Dados!</td></tr>
  <%else%>
  <tr>
  <th>CPF</th>
  <th>Nome Completo</th>
  <th>Perfil</th>
  <th>Pastas</th>
  <th>Data</th>
  <th>Status</th>
  <th>Operação</th>
  </tr>
  <%do while not rs.eof%>
  <tr>
  <td align="center"><%=rs("CPF")%></td>
  <td align="center"><%=rs("Nome")%></td>
  <td align="center"><%=rs("Perfil")%></td>
  <td align="center"><%=rs("Programas")%></td>
  <td align="center"><%=rs("DataCadUsuario")%></td>
  <td align="center"><%IF  rs("statusUsuario") = TRUE THEN%>
  <font color="#009933"> ATIVO </font>
  <%ELSE%>
  <font color="#FF0000"> DESATIVO </font>
  <%END IF%></td>
  <td align="center"><a href="#" onClick="visualizar(<%=rs("CPF")%>)"><img src="Imagens\editar.png" width="30"/></a></td>
  </tr>
  <%
     rs.movenext
	 loop
  %>
  <%end if%>
</table>
<%call fechaConexao%>

</html>
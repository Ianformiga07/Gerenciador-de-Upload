<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file ="lib/Conexao.asp"-->
<%

resposta = 0
IF REQUEST("Operacao") = 1 THEN
call abreConexao
sql = "INSERT INTO GU_Programas(Sigla, Programas, status) VALUES('"&request.form("txtSigla")&"', '"&request.form("txtNome")&"', 1)"
conn.execute(sql)
resposta = 1
call fechaConexao
ELSEIF REQUEST("Operacao") = 2 THEN
call abreConexao
sql = "SELECT id, Sigla, Programas, status FROM GU_Programas WHERE id = '"&request("idVisualizar")&"'"
set rs = conn.execute(sql)
	if not rs.eof then
	id = rs("id")
	Sigla = rs("Sigla")
	programas = rs("Programas")
	statusPrograma = rs("status")
	Existe = 1

	end if
call fechaConexao
ELSEIF REQUEST("Operacao") = 3 THEN
call abreConexao
sql = "SELECT COUNT(*) as ExisteCad FROM GU_Arquivos where CodPrograma = '"&request.form("id")&"' and status = 1"
set rs = conn.execute(sql)

if rs("ExisteCad") = 0 then
sql = "UPDATE GU_Programas SET Sigla = '"&request.form("txtSigla")&"', Programas = '"&request.form("txtNome")&"', status = '"&request.Form("status")&"' WHERE id = '"&request.form("id")&"'"
conn.execute(sql)
resposta = 2
else
resposta = 3 'EXISTE CADASTRO
end if
call fechaConexao

END IF
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Cadastrar Pastas</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.10.1/dist/sweetalert2.all.min.js"></script>
<script src="javascript/Mascara.js"></script>
<script type="text/javascript">

function validar() {
	if(document.frmProgramas.txtSigla.value == ""){
   		alert("Obrigatorio digitar a Sigla!");
   		document.frmProgramas.txtSigla.focus();
		return false;
	}
	if(document.frmProgramas.txtNome.value == ""){
         alert("Obrigatório digitar o Nome da Sigla!");
         document.frmProgramas.txtNome.focus();
         return false;
     }
     return true;
}
function cadastrar(){
    if(validar() == false)
    return false;

	document.frmProgramas.Operacao.value = 1;
	document.frmProgramas.action = "CadProgramas.asp";
	document.frmProgramas.submit();
}
function verificar_cadastro()
{
	document.frmProgramas.Operacao.value = 2;
	document.frmProgramas.idVisualizar.value = document.frmProgramas.id.value;
	document.frmProgramas.action = "CadProgramas.asp";
	document.frmProgramas.submit();
}
function visualizar(id)
{	
	document.frmProgramas.Operacao.value = 2;
	document.frmProgramas.idVisualizar.value = id;
	document.frmProgramas.action = "CadProgramas.asp";
	document.frmProgramas.submit();
}
function alterar()
{
	if(validar() == false)
	return false;

	document.frmProgramas.Operacao.value = 3;
	document.frmProgramas.action = "CadProgramas.asp";
	document.frmProgramas.submit();
}

function mensagem(resp) {
if(resp == 1){
	Swal.fire({
      title: "Ótimo!!!",
      text: "Programa Cadastrado com Sucesso!",
      icon: "success",
      button: "Ok!",
      });
      return false;
}
else
if(resp == 2){
	 Swal.fire({
      title: "Ótimo!!!",
      text: "Programa Alterado com Sucesso!",
      icon: "success",
      button: "Ok!",
      });
      return false;
}
else	
if(resp == 3){
     Swal.fire({
      title: "Ops!!!",
      text: "Já Consta arquivos Cadastrados nesta pasta!",
      icon: "error",
      button: "Ok!",
      });
      return false;
}
}


</script>
</head>

<body>
<%if resposta = 3 or resposta = 1 or resposta = 2 then%>
<script>
  var resp = <%=resposta%>
  mensagem(resp)
</script>
<%end if%>
<h1>Cadastro de Programas</h1>
<form name="frmProgramas" id="frmProgramas" method="post">
<input type="hidden" name="Operacao" id="Operacao" />
<input type="hidden" name="idVisualizar" id="idVisualizar" />
<input type="text" name="id" id="id" value="<%=id%>" hidden/>
<p>Sigla<br />
<input type="text" name="txtSigla" id="txtSigla" value="<%=Sigla%>"/>
</p>
<p>Nome da Sigla<br />
<input type="text" name="txtNome" id="txtNome" value="<%=programas%>"/>
</p>
</select>
<%IF Existe = 1 then%>
<p>Status: <br />
<select name="status" id="status">
<option value="1"  <%if StatusPrograma = true then%> selected <%end if%>> Ativo </option>
<option value="0"  <%if StatusPrograma = false then%> selected <%end if%>> Desativo </option>
</select>
<%END IF%>
</p>
<input type="submit" name="btnCadastrar" value="<%IF Existe = 1 THEN%>Alterar<%ELSE%>Cadastrar<%END IF%>" onClick="return <%IF Existe = 1 THEN%>alterar();mensagem();<%ELSE%>cadastrar();<%END IF%>" />
</form>
</body>
<%
   call abreConexao
   sql = "SELECT * FROM GU_Programas ORDER BY id"
   set rs = conn.execute(sql)
%>

<table width="650" border="1" align="center">
  <%if rs.eof then%>
  <tr><td>Não Existe Nenhum Registro na base de Dados!</td></tr>
  <%else%>
  <tr>
  <th>Sigla</th>
  <th>Nome Sigla</th>
  <th>Status</th>
  <th>Operação</th>
  </tr>
  <%do while not rs.eof%>
  <tr>
  <td align="center"><%=rs("Sigla")%></td>
  <td align="center"><%=rs("Programas")%></td>
  <td align="center"><%IF  rs("status") = TRUE THEN%>
  <font color="#009933"> ATIVO </font>
  <%ELSE%>
  <font color="#FF0000"> DESATIVO </font>
  <%END IF%></td>
  <td align="center"><a href="#" onClick="visualizar(<%=rs("id")%>)"><img src="Imagens\editar.png" width="30"/></a></td>
  </tr>
  <%
     rs.movenext
	 loop
  %>
  <%end if%>
</table>
<%call fechaConexao%>

</html>

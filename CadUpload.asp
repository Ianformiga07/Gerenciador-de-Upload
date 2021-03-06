<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file ="lib/Conexao.asp"-->
<!--#include file="upload.lib.asp"-->
<%
call abreConexao
 sql =  "SELECT * FROM GU_Arquivos WHERE id = '"&request("id")&"'"
  Set rs = conn.Execute(sql)
call fechaConexao 

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="pt-br">
<title>Cadastro de Upload</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script type="text/javascript">

var url_string = window.location.href;
var url = new URL(url_string);
var resp = url.searchParams.get("resp");

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
function desativar(id)
{
	Swal.fire({
    title: 'Deseja continuar?',
    text: "O Arquivo será desativado e não será mais listado no sistema!",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',    
    cancelButtonText: 'Cancelar',
    confirmButtonText: 'Sim, prosseguir!'
  }).then((result) => {
    if (result.value) {
       window.location="CrudUpload.asp?id="+id+"&op=1"
    }
  })
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
<input type="text" name="codprograma" id="codprograma" value="<%=session("CodPrograma")%>" hidden/>
<p>
<input type="file" name="upload" accept="application/pdf" ><br><br>
</p>
<input type="submit" name="btnCadastrar" value="Cadastrar" />
</form>

</body>

<%
   call abreConexao
   sql = "SELECT GU_Arquivos.id, GU_Arquivos.Titulo, GU_Arquivos.Descricao, GU_CadPessoasUp.Nome, GU_Arquivos.Arquivo , FORMAT (dataArquivo, 'dd/MM/yyyy ') as data, GU_Arquivos.status FROM GU_CadPessoasUp INNER JOIN GU_Arquivos ON GU_Arquivos.cpf = GU_CadPessoasUp.CPF WHERE GU_Arquivos.status = 1 ORDER BY titulo;"
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
  <%do while not rs.eof
  cont =cont+1%>
  <tr>
  <td align="center"><%=rs("titulo")%></td>
  <td align="center"><%=rs("Descricao")%></td>
  <td align="center"><%=rs("Nome")%></td>
  <td align="center"><a href="<%=rs("Arquivo")%>"><%=mid(rs("Arquivo"),10,100)&""%></a></td>
  <td align="center"><%=rs("data")%></td>
  <td align="center"><a href="#" onClick="desativar(<%=rs("id")%>)"><img src="Imagens\lixeira.png" width="30"/></a></td>
  </tr>
  <%
     rs.movenext
	 loop
  %>
  <%end if%>
</table>
<%call fechaConexao%>

</html>

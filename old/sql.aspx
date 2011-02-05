<%@ Page Language="C#" Debug="true"%>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<script runat="server">
  protected void Page_Load(object sender, EventArgs e)
  {
      using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings[0].ToString()))
      {
          SqlCommand cmd = new SqlCommand("SELECT * FROM blogs_Post", cn);
          cn.Open();
          SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
          rdr.Read();
          Response.Write(rdr[3].ToString()); //read a value
      }
  }
</script>

<html  >
<head runat="server">
    <title>SQL Authentication</title>
</head>
<body/>
</html>

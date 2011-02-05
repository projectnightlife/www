<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MethodList.aspx.cs" Inherits="Documentation.MethodList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Repeater ID="ServiceListRepeater" runat="server">
            <ItemTemplate>
                <h3>
                    <%# DataBinder.Eval(Container.DataItem, "Key") %> Service
                </h3>
                <ul>
                    <asp:Repeater runat="server" DataSource='<%# DataBinder.Eval(Container.DataItem, "Value") %>'>
                        <ItemTemplate>
                            <li>
                                <a target="details" href="documentation/MethodDetails.aspx?Service=<%# DataBinder.Eval(Container.DataItem, "ServiceName") %>&Method=<%# DataBinder.Eval(Container.DataItem, "Name") %>"><%# DataBinder.Eval(Container.DataItem, "Name") %></a>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
                <hr />
            </ItemTemplate>
        </asp:Repeater>
    </div>
    </form>
</body>
</html>

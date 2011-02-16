<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MethodDetails.aspx.cs"
    Inherits="Documentation.MethodDetails" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Panel ID="NotSelected" runat="server">
        <h1>
            Please Select a method from the left list
        </h1>
    </asp:Panel>
    <asp:Panel ID="Selected" runat="server">
        <h1>
            <asp:Label ID="MethodNameLabel" runat="server" Text="{NAME}" />
            (
            <asp:Label ID="ParamListLabel" runat="server" Text="{ParamList}" />
            )
        </h1>
        <h4>Description:</h4>
        <asp:Label ID="DescriptionLabel" runat="server" Text="{DESC}" />
        <h4>Parameters</h4>
        <ul>
        <asp:Repeater ID="ParamRepeater" runat="server">
            <ItemTemplate>
            <li>
                <b><%# DataBinder.Eval(Container.DataItem, "Type") %></b> <%# DataBinder.Eval(Container.DataItem, "Name") %> - <%# DataBinder.Eval(Container.DataItem, "Description") %>
            </li>
            </ItemTemplate>
        </asp:Repeater>
        </ul>
        <h4>Example Result</h4>
        <div style="background-color: #DDDDDD">
            <asp:Xml runat="server" ID="ExampleXML" TransformSource="~/IE5Transform.xslt"></asp:Xml>
        </div>
    </asp:Panel>
    </form>
</body>
</html>

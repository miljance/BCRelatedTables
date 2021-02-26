pageextension 50100 SalesOrder extends "Sales Order"
{
    layout
    {
        addafter("No.")
        {
            field(JobNo; Rec."Job No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
pageextension 50101 SalesOrderList extends "Sales Order List"
{
    layout
    {
        addbefore("Sell-to Customer No.")
        {
            field(JobNo; Rec."Job No.")
            {
                ApplicationArea = All;
            }
        }
    }
}

pageextension 50100 SalesOrder extends "Sales Order"
{
    layout
    {
        addafter("No.")
        {
            field("Job No"; RelatedSalesHeader."Job No.")
            {
                ApplicationArea = All;
                TableRelation = Job;
                trigger OnValidate()
                begin
                    RelatedSalesHeader.ValidateField(Rec, RelatedSalesHeader.FieldNo("Job No."), RelatedSalesHeader."Job No.");
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        RelatedSalesHeader.FetchRec(Rec);
    end;

    var
        RelatedSalesHeader: Record RelatedSalesHeader;
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

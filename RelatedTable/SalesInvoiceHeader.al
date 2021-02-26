tableextension 50101 RelatedSalesInvoiceHeader extends "Sales Invoice Header"
{
    fields
    {
        field(50100; "Job No."; Code[20])
        {
            TableRelation = Job;
            FieldClass = FlowField;
            CalcFormula = lookup(RelatedSalesInvoiceHeader."Job No." where(Id = field(SystemId)));
        }
    }
}
table 50101 RelatedSalesInvoiceHeader
{
    fields
    {
        field(1; Id; Guid)
        {
        }
        field(3; "No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."No." where(SystemId = field(id)));
        }
        field(50100; "Job No."; Code[20])
        {
            TableRelation = Job;
        }
    }
    keys
    {
        key(PK; Id) { }
    }
    procedure FetchRec(SalesInvoiceHeader: Record "Sales Invoice Header"): Boolean;
    begin
        exit(Get(SalesInvoiceHeader.SystemId));
    end;

    procedure Delete(var SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        if SalesInvoiceHeader.IsTemporary then
            exit;
        if FetchRec(SalesInvoiceHeader) then
            Delete;
    end;
}
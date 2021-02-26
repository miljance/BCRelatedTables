tableextension 50100 SalesHeader extends "Sales Header"
{
    fields
    {
        field(50100; "Job No."; Code[20])
        {
            TableRelation = Job;
            FieldClass = FlowField;
            CalcFormula = lookup(RelatedSalesHeader."Job No." where(Id = field(SystemId)));
        }
    }
}
table 50100 RelatedSalesHeader
{
    fields
    {
        field(1; Id; Guid)
        {
        }
        field(2; "Document Type"; Enum "Sales Document Type")
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Document Type" where(SystemId = field(id)));
        }
        field(3; "No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."No." where(SystemId = field(id)));
        }
        field(50100; "Job No."; Code[20])
        {
            TableRelation = Job;
            trigger OnValidate()
            begin
                Message('Validation for Job No. has been run');
            end;
        }
    }
    keys
    {
        key(PK; Id) { }
    }
    procedure FetchRec(SalesHeader: Record "Sales Header"): Boolean;
    begin
        exit(Get(SalesHeader.SystemId));
    end;

    procedure Delete(var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader.IsTemporary then
            exit;
        if FetchRec(SalesHeader) then
            Delete;
    end;

    procedure ValidateField(SalesHeader: Record "Sales Header"; CalledByFieldNo: Integer; FieldValue: Variant)
    begin
        if not FetchRec(SalesHeader) then begin
            Init();
            "Document Type" := SalesHeader."Document Type";
            "No." := SalesHeader."No.";
            id := SalesHeader.SystemId;
            Insert();
        end;
        case CalledByFieldNo of
            Rec.FieldNo("Job No."):
                Validate("Job No.", FieldValue);
        end;
        Modify();
    end;

    procedure PostToInvoice(SalesHeader: Record "Sales Header"; SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        RelatedSalesInvoiceHeader: Record RelatedSalesInvoiceHeader;
    begin
        if not FetchRec(SalesHeader) then
            exit;
        RelatedSalesInvoiceHeader.Init();
        RelatedSalesInvoiceHeader.TransferFields(Rec);
        RelatedSalesInvoiceHeader.Id := SalesInvoiceHeader.SystemId;
        RelatedSalesInvoiceHeader."No." := SalesInvoiceHeader."No.";
        RelatedSalesInvoiceHeader.Insert();
        Delete;
    end;
}

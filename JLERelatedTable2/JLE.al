tableextension 50112 JLE2 extends "Job Ledger Entry"
{
    fields
    {
        field(50112; "Ext field 2"; Code[20])
        {
            TableRelation = Job;
            FieldClass = FlowField;
            CalcFormula = lookup(JLE2."Ext field 2" where(Id = field(SystemId)));
        }
    }
}
table 50112 JLE2
{
    fields
    {
        field(1; Id; Guid)
        {
        }
        field(2; "Entry No."; Integer)
        {
        }
        field(50112; "Ext field 2"; Code[20])
        {
        }
    }
    keys
    {
        key(PK; Id) { }
    }
    procedure FetchRec(JobLedgerEntry: Record "Job Ledger Entry"): Boolean;
    begin
        exit(Get(JobLedgerEntry.SystemId));
    end;

    procedure ValidateField(JobLedgerEntry: Record "Job Ledger Entry"; CalledByFieldNo: Integer; FieldValue: Variant)
    begin
        if not FetchRec(JobLedgerEntry) then begin
            Init();
            "Entry No." := JobLedgerEntry."Entry No.";
            id := JobLedgerEntry.SystemId;
            Insert();
        end;
        case CalledByFieldNo of
            Rec.FieldNo("Ext field 2"):
                Validate("Ext field 2", FieldValue);
        end;
        Modify();
    end;

}

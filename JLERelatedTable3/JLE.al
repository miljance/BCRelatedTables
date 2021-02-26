tableextension 50113 JLE3 extends "Job Ledger Entry"
{
    fields
    {
        field(50113; "Ext field 3"; Code[20])
        {
            TableRelation = Job;
            FieldClass = FlowField;
            CalcFormula = lookup(JLE3."Ext field 3" where(Id = field(SystemId)));
        }
    }
}
table 50113 JLE3
{
    fields
    {
        field(1; Id; Guid)
        {
        }
        field(2; "Entry No."; Integer)
        {
        }
        field(50113; "Ext field 3"; Code[20])
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
            Rec.FieldNo("Ext field 3"):
                Validate("Ext field 3", FieldValue);
        end;
        Modify();
    end;

}

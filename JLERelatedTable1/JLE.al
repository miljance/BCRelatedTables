tableextension 50111 JLE1 extends "Job Ledger Entry"
{
    fields
    {
        field(50111; "Ext field 1"; Code[20])
        {
            TableRelation = Job;
            FieldClass = FlowField;
            CalcFormula = lookup(JLE1."Ext field 1" where(Id = field(SystemId)));
        }
    }
}
table 50111 JLE1
{
    fields
    {
        field(1; Id; Guid)
        {
        }
        field(2; "Entry No."; Integer)
        {
        }
        field(50111; "Ext field 1"; Code[20])
        {
        }
    }
    keys
    {
        key(PK; Id) { }
        key("Ext field 1"; "Ext field 1")
        {

        }
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
            Rec.FieldNo("Ext field 1"):
                Validate("Ext field 1", FieldValue);
        end;
        Modify();
    end;

}

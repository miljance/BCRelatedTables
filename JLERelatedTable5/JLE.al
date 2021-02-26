tableextension 50115 JLE5 extends "Job Ledger Entry"
{
    fields
    {
        field(50115; "Ext field 5"; Code[20])
        {
            TableRelation = Job;
            FieldClass = FlowField;
            CalcFormula = lookup(JLE5."Ext field 5" where(Id = field(SystemId)));
        }
    }
}
table 50115 JLE5
{
    fields
    {
        field(1; Id; Guid)
        {
        }
        field(2; "Entry No."; Integer)
        {
        }
        field(50115; "Ext field 5"; Code[20])
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
            Rec.FieldNo("Ext field 5"):
                Validate("Ext field 5", FieldValue);
        end;
        Modify();
    end;

}

tableextension 50116 JLE6 extends "Job Ledger Entry"
{
    fields
    {
        field(50116; "Ext field 6"; Code[20])
        {
            TableRelation = Job;
            FieldClass = FlowField;
            CalcFormula = lookup(JLE6."Ext field 6" where(Id = field(SystemId)));
        }
    }
}
table 50116 JLE6
{
    fields
    {
        field(1; Id; Guid)
        {
        }
        field(2; "Entry No."; Integer)
        {
        }
        field(50116; "Ext field 6"; Code[20])
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
            Rec.FieldNo("Ext field 6"):
                Validate("Ext field 6", FieldValue);
        end;
        Modify();
    end;

}

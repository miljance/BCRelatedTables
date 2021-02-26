tableextension 50114 JLE4 extends "Job Ledger Entry"
{
    fields
    {
        field(50114; "Ext field 4"; Code[20])
        {
            TableRelation = Job;
            FieldClass = FlowField;
            CalcFormula = lookup(JLE4."Ext field 4" where(Id = field(SystemId)));
        }
    }
}
table 50114 JLE4
{
    fields
    {
        field(1; Id; Guid)
        {
        }
        field(2; "Entry No."; Integer)
        {
        }
        field(50114; "Ext field 4"; Code[20])
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
            Rec.FieldNo("Ext field 4"):
                Validate("Ext field 4", FieldValue);
        end;
        Modify();
    end;

}
